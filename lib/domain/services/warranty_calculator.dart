import '../../shared/constants/app_constants.dart';
import '../../shared/utils/date_utils.dart';
import '../models/enums.dart';

/// Pure warranty maths (Blueprint Section 3.6).
///
/// Every method is a pure function of its inputs and takes an explicit [today]
/// so the logic is fully deterministic and unit-testable (Section 6.5).
class WarrantyCalculator {
  WarrantyCalculator._();

  /// Auto-calculates the expiry date: purchase date + warranty months.
  ///
  /// The result is date-only. Expiry is never user-editable (Section 3.2).
  static DateTime computeExpiry({
    required DateTime purchaseDate,
    required int warrantyMonths,
  }) =>
      AppDates.addMonths(AppDates.dateOnly(purchaseDate), warrantyMonths);

  /// Whole days remaining until expiry. Negative for already-expired items
  /// (Section 3.6: "Can be negative for expired items").
  static int daysRemaining({
    required DateTime expiryDate,
    required DateTime today,
  }) =>
      AppDates.daysBetween(today, expiryDate);

  /// Derives the [WarrantyStatus] (Section 3.6).
  ///
  /// Precedence: claimed > expired > expiring_soon > active.
  static WarrantyStatus deriveStatus({
    required DateTime expiryDate,
    required DateTime today,
    required bool isClaimed,
  }) {
    if (isClaimed) return WarrantyStatus.claimed;

    final days = daysRemaining(expiryDate: expiryDate, today: today);
    if (days <= 0) return WarrantyStatus.expired;
    if (days <= StatusThresholds.activeDays) return WarrantyStatus.expiringSoon;
    return WarrantyStatus.active;
  }

  /// Health score — percentage of the warranty period still remaining
  /// (Section 3.6). Clamped to 0–100; returns 0 for expired items.
  ///
  /// Formula: (expiry - today) / (expiry - purchase) × 100.
  static double healthScore({
    required DateTime purchaseDate,
    required DateTime expiryDate,
    required DateTime today,
  }) {
    final remaining = daysRemaining(expiryDate: expiryDate, today: today);
    if (remaining <= 0) return 0;

    final totalDays = AppDates.daysBetween(purchaseDate, expiryDate);
    if (totalDays <= 0) return 0;

    final score = remaining / totalDays * 100;
    return score.clamp(0, 100).toDouble();
  }

  /// Returns the reminder offsets (days-before-expiry) that should still fire
  /// for an item, i.e. those whose scheduled moment is in the future.
  ///
  /// Reminders for already-expired warranties are never scheduled
  /// (Section 5.6: "no reminders will be scheduled" for expired items).
  static List<int> upcomingReminderOffsets({
    required DateTime expiryDate,
    required DateTime today,
    required List<int> reminderDays,
  }) {
    final result = <int>[];
    for (final offset in reminderDays) {
      final fireDate = expiryDate.subtract(Duration(days: offset));
      if (!AppDates.dateOnly(fireDate).isBefore(today)) {
        result.add(offset);
      }
    }
    result.sort((a, b) => b.compareTo(a)); // soonest schedule first: 30,15,7,1
    return result;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/domain/models/enums.dart';
import 'package:warranty_vault/domain/services/warranty_calculator.dart';

void main() {
  // Fixed "today" so every test is deterministic (Blueprint Section 6.5).
  final today = DateTime(2026, 6, 10);

  group('computeExpiry', () {
    test('adds whole months to the purchase date', () {
      final expiry = WarrantyCalculator.computeExpiry(
        purchaseDate: DateTime(2026, 1, 15),
        warrantyMonths: 24,
      );
      expect(expiry, DateTime(2028, 1, 15));
    });

    test('clamps to end of month (Jan 31 + 1 month => Feb 28)', () {
      final expiry = WarrantyCalculator.computeExpiry(
        purchaseDate: DateTime(2026, 1, 31),
        warrantyMonths: 1,
      );
      expect(expiry, DateTime(2026, 2, 28));
    });

    test('handles leap year (Jan 31 2028 + 1 month => Feb 29)', () {
      final expiry = WarrantyCalculator.computeExpiry(
        purchaseDate: DateTime(2028, 1, 31),
        warrantyMonths: 1,
      );
      expect(expiry, DateTime(2028, 2, 29));
    });

    test('strips the time component', () {
      final expiry = WarrantyCalculator.computeExpiry(
        purchaseDate: DateTime(2026, 1, 15, 13, 45, 12),
        warrantyMonths: 12,
      );
      expect(expiry, DateTime(2027, 1, 15));
    });
  });

  group('daysRemaining', () {
    test('positive when expiry is in the future', () {
      expect(
        WarrantyCalculator.daysRemaining(
          expiryDate: DateTime(2026, 6, 20),
          today: today,
        ),
        10,
      );
    });

    test('zero on the expiry day', () {
      expect(
        WarrantyCalculator.daysRemaining(
          expiryDate: today,
          today: today,
        ),
        0,
      );
    });

    test('negative when already expired', () {
      expect(
        WarrantyCalculator.daysRemaining(
          expiryDate: DateTime(2026, 6, 1),
          today: today,
        ),
        -9,
      );
    });
  });

  group('deriveStatus', () {
    test('claimed takes precedence over everything', () {
      expect(
        WarrantyCalculator.deriveStatus(
          expiryDate: DateTime(2020, 1, 1),
          today: today,
          isClaimed: true,
        ),
        WarrantyStatus.claimed,
      );
    });

    test('active when more than 30 days remain', () {
      expect(
        WarrantyCalculator.deriveStatus(
          expiryDate: DateTime(2026, 8, 1),
          today: today,
          isClaimed: false,
        ),
        WarrantyStatus.active,
      );
    });

    test('expiring soon at exactly 30 days', () {
      expect(
        WarrantyCalculator.deriveStatus(
          expiryDate: today.add(const Duration(days: 30)),
          today: today,
          isClaimed: false,
        ),
        WarrantyStatus.expiringSoon,
      );
    });

    test('active at exactly 31 days', () {
      expect(
        WarrantyCalculator.deriveStatus(
          expiryDate: today.add(const Duration(days: 31)),
          today: today,
          isClaimed: false,
        ),
        WarrantyStatus.active,
      );
    });

    test('expired when expiry is today (0 days remaining)', () {
      expect(
        WarrantyCalculator.deriveStatus(
          expiryDate: today,
          today: today,
          isClaimed: false,
        ),
        WarrantyStatus.expired,
      );
    });

    test('expired when expiry has passed', () {
      expect(
        WarrantyCalculator.deriveStatus(
          expiryDate: DateTime(2026, 1, 1),
          today: today,
          isClaimed: false,
        ),
        WarrantyStatus.expired,
      );
    });
  });

  group('healthScore', () {
    test('100% on the day of purchase', () {
      final score = WarrantyCalculator.healthScore(
        purchaseDate: today,
        expiryDate: today.add(const Duration(days: 365)),
        today: today,
      );
      expect(score, closeTo(100, 0.001));
    });

    test('~50% at the midpoint', () {
      final score = WarrantyCalculator.healthScore(
        purchaseDate: today.subtract(const Duration(days: 182)),
        expiryDate: today.add(const Duration(days: 183)),
        today: today,
      );
      expect(score, closeTo(50, 1));
    });

    test('returns 0 for expired items', () {
      final score = WarrantyCalculator.healthScore(
        purchaseDate: DateTime(2024, 1, 1),
        expiryDate: DateTime(2026, 1, 1),
        today: today,
      );
      expect(score, 0);
    });

    test('clamps to 0–100 and never throws on zero-length warranty', () {
      final score = WarrantyCalculator.healthScore(
        purchaseDate: today,
        expiryDate: today, // zero-length window
        today: today,
      );
      expect(score, 0);
    });
  });

  group('upcomingReminderOffsets', () {
    test('drops reminders whose fire date is already in the past', () {
      // Expiry in 10 days: the 30 and 15 day reminders are already overdue.
      final offsets = WarrantyCalculator.upcomingReminderOffsets(
        expiryDate: today.add(const Duration(days: 10)),
        today: today,
        reminderDays: const [30, 15, 7, 1],
      );
      expect(offsets, [7, 1]);
    });

    test('returns empty for an already-expired warranty', () {
      final offsets = WarrantyCalculator.upcomingReminderOffsets(
        expiryDate: today.subtract(const Duration(days: 1)),
        today: today,
        reminderDays: const [30, 15, 7, 1],
      );
      expect(offsets, isEmpty);
    });

    test('keeps a reminder firing exactly today', () {
      final offsets = WarrantyCalculator.upcomingReminderOffsets(
        expiryDate: today.add(const Duration(days: 7)),
        today: today,
        reminderDays: const [7],
      );
      expect(offsets, [7]);
    });
  });
}

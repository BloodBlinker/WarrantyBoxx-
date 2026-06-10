import '../../domain/models/enums.dart';
import '../../l10n/app_localizations.dart';

/// Formats the "days remaining / overdue" sub-line shown on cards and details.
class DaysFormat {
  DaysFormat._();

  /// Localised days-remaining text for an item, given its [status] and
  /// [daysRemaining] (negative when expired).
  static String forItem(
    AppLocalizations l10n, {
    required WarrantyStatus status,
    required int daysRemaining,
  }) {
    if (status == WarrantyStatus.claimed) return l10n.statusClaimed;
    if (daysRemaining < 0) return l10n.daysOverdue(daysRemaining.abs());
    return l10n.daysRemaining(daysRemaining);
  }
}

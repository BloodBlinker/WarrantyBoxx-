import '../../l10n/app_localizations.dart';
import '../../shared/utils/date_utils.dart';

/// A rendered notification (title + body).
class NotificationMessage {
  const NotificationMessage(this.title, this.body);

  final String title;
  final String body;
}

/// Builds reminder notification copy from the templates in Appendix C.
///
/// Rendered in the foreground (where localisations are available) and passed to
/// the background scheduler, so the background isolate needs no l10n context.
class NotificationMessages {
  NotificationMessages._();

  /// Returns the message for a reminder firing [offsetDays] before expiry.
  static NotificationMessage forOffset(
    AppLocalizations l10n, {
    required int offsetDays,
    required String itemName,
    required DateTime expiryDate,
  }) {
    switch (offsetDays) {
      case 30:
        return NotificationMessage(l10n.notif30Title, l10n.notif30Body(itemName));
      case 15:
        return NotificationMessage(
          l10n.notif15Title,
          l10n.notif15Body(itemName, AppDates.formatMedium(expiryDate)),
        );
      case 7:
        return NotificationMessage(l10n.notif7Title, l10n.notif7Body(itemName));
      case 1:
        return NotificationMessage(l10n.notif1Title, l10n.notif1Body(itemName));
      default:
        return NotificationMessage(
          l10n.notifGenericTitle,
          l10n.notifGenericBody(itemName, offsetDays),
        );
    }
  }
}

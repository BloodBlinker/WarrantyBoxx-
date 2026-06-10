/// App-wide constants (Blueprint Section 11.3: no magic numbers).
///
/// Every numeric or string constant that has meaning across more than one file
/// lives here so behaviour can be tuned in a single place.
library;

/// Constants governing item data limits (Blueprint Section 3.2).
class ItemLimits {
  ItemLimits._();

  /// Maximum length of an item name.
  static const int nameMaxLength = 200;

  /// Maximum length of the brand field.
  static const int brandMaxLength = 100;

  /// Maximum length of the retailer field.
  static const int retailerMaxLength = 150;

  /// Maximum length of serial and model numbers.
  static const int serialModelMaxLength = 100;

  /// Maximum length of free-text notes.
  static const int notesMaxLength = 1500;

  /// Maximum length of the claim fault description.
  static const int faultDescriptionMaxLength = 500;

  /// Maximum length of resolution notes recorded on a claim.
  static const int claimNotesMaxLength = 500;

  /// Maximum length of the manufacturer contact string.
  static const int manufacturerContactMaxLength = 300;

  /// Maximum number of photos that can be attached to one item.
  static const int maxPhotos = 5;

  /// Minimum allowed warranty duration in whole months.
  static const int minWarrantyMonths = 1;

  /// Maximum allowed warranty duration in whole months.
  static const int maxWarrantyMonths = 360;
}

/// Reminder scheduling constants (Blueprint Section 2.1).
class ReminderDefaults {
  ReminderDefaults._();

  /// Default reminder schedule: days before expiry to notify the user.
  static const List<int> defaultDays = [30, 15, 7, 1];
}

/// Thresholds (in days) used to derive warranty [status] and colour coding
/// (Blueprint Sections 2.1 and 3.6).
class StatusThresholds {
  StatusThresholds._();

  /// An item is "active" when more than this many days remain.
  static const int activeDays = 30;

  /// An item is "critical" (red) when this many days or fewer remain.
  static const int criticalDays = 7;
}

/// Photo import constants (Blueprint Section 2.1).
class PhotoConstants {
  PhotoConstants._();

  /// Longest edge, in pixels, that imported photos are resized to.
  static const int maxLongestEdge = 1024;

  /// JPEG quality used when compressing imported photos.
  static const int jpegQuality = 80;

  /// Sub-directory (under app documents) where photos are stored.
  static const String photosDirName = 'photos';
}

/// SharedPreferences keys (Blueprint Sections 7.1 and 7.3).
class PrefKeys {
  PrefKeys._();

  static const String onboardingShown = 'onboarding_shown';
  static const String defaultReminderDays = 'default_reminder_days';
  static const String itemsAddedCount = 'items_added_count';
  static const String claimsMadeCount = 'claims_made_count';
  static const String firstItemAddedDate = 'first_item_added_date';
  static const String lastExportDate = 'last_export_date';
  static const String fabPulseShown = 'fab_pulse_shown';
  static const String notificationRationaleShown = 'notification_rationale_shown';

  // home_widget data keys.
  static const String widgetExpiring30 = 'widget_expiring_30';
  static const String widgetExpiring7 = 'widget_expiring_7';
}

/// Local engagement milestones (Blueprint Section 7.3).
class Milestones {
  Milestones._();

  /// Item counts at which a milestone message is surfaced.
  static const List<int> itemCountMilestones = [5, 10, 25];

  /// Days after which a "back up your data" nudge appears in Settings.
  static const int backupNudgeDays = 90;
}

/// Notification channel and deep-link configuration.
class NotificationConfig {
  NotificationConfig._();

  /// System notification channel id for warranty reminders.
  static const String channelId = 'warranty_reminders';

  /// Deep-link scheme used by reminder notifications (Section 5.4).
  static const String deepLinkScheme = 'warrantyvault';

  /// WorkManager unique task name for the daily reminder scan.
  static const String reminderScanTask = 'warranty_vault_reminder_scan';

  /// WorkManager unique task name for the periodic widget refresh.
  static const String widgetRefreshTask = 'warranty_vault_widget_refresh';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'WarrantyBoxx';

  @override
  String get appTagline => 'Every warranty. Always remembered.';

  @override
  String get onboardingExplanation =>
      'Add your purchases. Get reminded before warranties expire.';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navArchive => 'Archive';

  @override
  String get navSettings => 'Settings';

  @override
  String get dashboardTitle => 'WarrantyBoxx';

  @override
  String get dashboardTotalItems => 'Total items';

  @override
  String get dashboardActiveWarranties => 'Active';

  @override
  String get dashboardExpiringSoon => 'Expiring soon';

  @override
  String dashboardHealthRingLabel(int percent) {
    return 'Warranty health: $percent% active';
  }

  @override
  String dashboardAssetCoverage(String amount) {
    return '$amount in active warranty coverage';
  }

  @override
  String dashboardAverageHealth(int percent) {
    return 'Average health $percent%';
  }

  @override
  String get dashboardExpiredSection => 'Expired';

  @override
  String get dashboardEmptyTitle => 'Your warranty vault is empty';

  @override
  String get dashboardEmptyBody =>
      'Add your first item to start protecting your purchases.';

  @override
  String get dashboardAddFirstItem => 'Add item';

  @override
  String get itemAddTitle => 'Add item';

  @override
  String get itemEditTitle => 'Edit item';

  @override
  String get itemFieldName => 'Item name';

  @override
  String get itemFieldBrand => 'Brand';

  @override
  String get itemFieldCategory => 'Category';

  @override
  String get itemFieldRetailer => 'Retailer';

  @override
  String get itemFieldPurchaseDate => 'Purchase date';

  @override
  String get itemFieldWarrantyMonths => 'Warranty duration (months)';

  @override
  String get itemFieldExpiryDate => 'Expiry date';

  @override
  String get itemFieldPurchasePrice => 'Purchase price';

  @override
  String get itemFieldSerialNumber => 'Serial number';

  @override
  String get itemFieldModelNumber => 'Model number';

  @override
  String get itemFieldNotes => 'Notes';

  @override
  String get itemFieldReminderSchedule => 'Reminder schedule';

  @override
  String get itemSectionPhotos => 'Photos';

  @override
  String get itemSectionDetails => 'Details';

  @override
  String get itemSectionReminders => 'Reminders';

  @override
  String get itemUseTemplate => 'Start from a template';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionExport => 'Export';

  @override
  String get actionShare => 'Share';

  @override
  String get actionClose => 'Close';

  @override
  String get actionClearFilters => 'Clear filters';

  @override
  String get actionPrepareClaim => 'Prepare claim';

  @override
  String get validationNameRequired => 'Please enter an item name';

  @override
  String get validationWarrantyRange =>
      'Warranty must be between 1 and 360 months';

  @override
  String get validationPurchaseDateFuture =>
      'Purchase date cannot be in the future';

  @override
  String get validationPriceInvalid => 'Enter a valid amount';

  @override
  String get warningAlreadyExpired =>
      'This warranty has already expired — no reminders will be scheduled.';

  @override
  String get deleteConfirmTitle => 'Delete item?';

  @override
  String deleteConfirmBody(String name) {
    return 'This will permanently delete \"$name\" and its photos.';
  }

  @override
  String get statusActive => 'Active';

  @override
  String get statusExpiringSoon => 'Expiring Soon';

  @override
  String get statusExpired => 'Expired';

  @override
  String get statusClaimed => 'Claimed';

  @override
  String daysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days left',
      one: '1 day left',
      zero: 'Expires today',
    );
    return '$_temp0';
  }

  @override
  String daysOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days ago',
      one: '1 day ago',
    );
    return 'Expired $_temp0';
  }

  @override
  String actNowDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days left to claim — act now',
      one: '1 day left to claim — act now',
    );
    return '$_temp0';
  }

  @override
  String healthScoreLabel(int percent) {
    return '$percent% of warranty remaining';
  }

  @override
  String get listSearchHint => 'Search items';

  @override
  String get listSortBy => 'Sort by';

  @override
  String get listFilter => 'Filter';

  @override
  String get sortExpiryDate => 'Expiry date';

  @override
  String get sortPurchaseDate => 'Purchase date';

  @override
  String get sortName => 'Name';

  @override
  String get sortPrice => 'Price';

  @override
  String get searchEmptyTitle => 'No items match your search';

  @override
  String get searchEmptyBody => 'Try a different name or clear your filters.';

  @override
  String get claimAssistantTitle => 'Claim Assistant';

  @override
  String get claimChecklistReceipt => 'Receipt photo attached?';

  @override
  String get claimChecklistSerial => 'Serial number noted?';

  @override
  String get claimChecklistContact => 'Manufacturer contact info saved?';

  @override
  String get claimChecklistFault => 'Fault description written?';

  @override
  String get claimChecklistProof => 'Proof of purchase ready?';

  @override
  String get claimFieldFault => 'Fault description';

  @override
  String get claimFieldContact => 'Manufacturer contact';

  @override
  String get claimMarkClaimed => 'Mark as claimed';

  @override
  String get claimReceiptPrompt => 'Add a receipt photo before proceeding.';

  @override
  String get claimDialogTitle => 'Mark as claimed';

  @override
  String get claimFieldResolution => 'Resolution';

  @override
  String get claimFieldResolutionNotes => 'Resolution notes';

  @override
  String get claimDate => 'Claim date';

  @override
  String get resolutionRepaired => 'Repaired';

  @override
  String get resolutionReplaced => 'Replaced';

  @override
  String get resolutionRefunded => 'Refunded';

  @override
  String get resolutionDenied => 'Denied';

  @override
  String get resolutionPending => 'Pending';

  @override
  String get claimSuccessTitle => 'Great — you\'ve protected your purchase';

  @override
  String get claimSuccessBody => 'Add more items to keep your vault complete.';

  @override
  String get archiveTitle => 'Archive';

  @override
  String get archiveEmptyTitle => 'No claimed items yet';

  @override
  String get archiveEmptyBody =>
      'When you mark a warranty as claimed, it will appear here.';

  @override
  String get archiveFilterResolution => 'Filter by resolution';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get categoryAdd => 'Add category';

  @override
  String get categoryRename => 'Rename';

  @override
  String categoryItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get categoryDeleteBlocked =>
      'Cannot delete a category that has items assigned.';

  @override
  String get categoryEmptyTitle => 'No items in this category yet.';

  @override
  String get templatesTitle => 'Templates';

  @override
  String get templateSaveFromItem => 'Save as template';

  @override
  String get templateAdd => 'New template';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsReminderDefaults => 'Default reminders';

  @override
  String get settingsReminderDefaultsBody => 'Days before expiry to remind you';

  @override
  String get settingsExportAll => 'Export all data';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsLicences => 'Open source licences';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String settingsProtectingFor(int days) {
    return 'Protecting your purchases for $days days';
  }

  @override
  String get settingsBackupNudge =>
      'You haven\'t backed up recently. Consider exporting your data.';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get exportTitle => 'Export';

  @override
  String get exportChooseFormat => 'Choose a format';

  @override
  String get exportCsv => 'CSV (spreadsheet)';

  @override
  String get exportPdf => 'PDF summary';

  @override
  String exportItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0 to export';
  }

  @override
  String get exportGenerate => 'Export and share';

  @override
  String get exportFailedSpace =>
      'Export failed. Your device may be low on storage. Free up space and try again.';

  @override
  String get photoTakePhoto => 'Take photo';

  @override
  String get photoChooseGallery => 'Choose from gallery';

  @override
  String get photoImportFailed => 'Could not import photo. Please try again.';

  @override
  String get photoAltTextHint => 'Describe this photo';

  @override
  String get photoMaxReached => 'You can attach up to 5 photos.';

  @override
  String get photoStorageRationale =>
      'WarrantyBoxx needs storage access to save receipt photos. You can still use the app without photos.';

  @override
  String get photoGrantPermission => 'Grant permission';

  @override
  String get photoSkip => 'Skip';

  @override
  String get notificationPermissionRationale =>
      'Allow reminders to get notified before your warranties expire.';

  @override
  String get notificationsDisabledNotice =>
      'Reminders are disabled. Enable notifications in Settings to be reminded before warranties expire.';

  @override
  String reminderSetSnackbar(String days) {
    return 'Reminder set for $days days before expiry.';
  }

  @override
  String get notifChannelName => 'Warranty Reminders';

  @override
  String get notifChannelDescription =>
      'Reminders before your warranties expire.';

  @override
  String get notif30Title => 'Warranty expiring soon';

  @override
  String notif30Body(String name) {
    return 'Your $name warranty expires in 30 days. Tap to review.';
  }

  @override
  String get notif15Title => 'Warranty expiring in 2 weeks';

  @override
  String notif15Body(String name, String date) {
    return 'Your $name warranty expires on $date. Start gathering your documents.';
  }

  @override
  String get notif7Title => 'Act now — 7 days left';

  @override
  String notif7Body(String name) {
    return 'Your $name warranty expires in 7 days. Open Claim Assistant to prepare.';
  }

  @override
  String get notif1Title => 'Last chance — warranty expires tomorrow';

  @override
  String notif1Body(String name) {
    return 'Your $name warranty expires tomorrow. Contact the manufacturer today.';
  }

  @override
  String get notifGenericTitle => 'Warranty reminder';

  @override
  String notifGenericBody(String name, int days) {
    return 'Your $name warranty expires in $days days.';
  }

  @override
  String get milestone5 => 'You have 5 items protected.';

  @override
  String get milestone10 => 'You have 10 items protected.';

  @override
  String get milestone25 =>
      'You have 25 items protected. Your vault is comprehensive!';

  @override
  String widgetExpiring30(int count) {
    return '$count expiring in 30 days';
  }

  @override
  String widgetExpiring7(int count) {
    return '$count expiring in 7 days';
  }
}

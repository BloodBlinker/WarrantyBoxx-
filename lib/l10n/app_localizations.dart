import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'WarrantyBoxx'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Every warranty. Always remembered.'**
  String get appTagline;

  /// No description provided for @onboardingExplanation.
  ///
  /// In en, this message translates to:
  /// **'Add your purchases. Get reminded before warranties expire.'**
  String get onboardingExplanation;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingGetStarted;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get navArchive;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'WarrantyBoxx'**
  String get dashboardTitle;

  /// No description provided for @dashboardTotalItems.
  ///
  /// In en, this message translates to:
  /// **'Total items'**
  String get dashboardTotalItems;

  /// No description provided for @dashboardActiveWarranties.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get dashboardActiveWarranties;

  /// No description provided for @dashboardExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring soon'**
  String get dashboardExpiringSoon;

  /// No description provided for @dashboardHealthRingLabel.
  ///
  /// In en, this message translates to:
  /// **'Warranty health: {percent}% active'**
  String dashboardHealthRingLabel(int percent);

  /// No description provided for @dashboardAssetCoverage.
  ///
  /// In en, this message translates to:
  /// **'{amount} in active warranty coverage'**
  String dashboardAssetCoverage(String amount);

  /// No description provided for @dashboardAverageHealth.
  ///
  /// In en, this message translates to:
  /// **'Average health {percent}%'**
  String dashboardAverageHealth(int percent);

  /// No description provided for @dashboardExpiredSection.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get dashboardExpiredSection;

  /// No description provided for @dashboardEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your warranty vault is empty'**
  String get dashboardEmptyTitle;

  /// No description provided for @dashboardEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first item to start protecting your purchases.'**
  String get dashboardEmptyBody;

  /// No description provided for @dashboardAddFirstItem.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get dashboardAddFirstItem;

  /// No description provided for @itemAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get itemAddTitle;

  /// No description provided for @itemEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit item'**
  String get itemEditTitle;

  /// No description provided for @itemFieldName.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get itemFieldName;

  /// No description provided for @itemFieldBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get itemFieldBrand;

  /// No description provided for @itemFieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get itemFieldCategory;

  /// No description provided for @itemFieldRetailer.
  ///
  /// In en, this message translates to:
  /// **'Retailer'**
  String get itemFieldRetailer;

  /// No description provided for @itemFieldPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get itemFieldPurchaseDate;

  /// No description provided for @itemFieldWarrantyMonths.
  ///
  /// In en, this message translates to:
  /// **'Warranty duration (months)'**
  String get itemFieldWarrantyMonths;

  /// No description provided for @itemFieldExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get itemFieldExpiryDate;

  /// No description provided for @itemFieldPurchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase price'**
  String get itemFieldPurchasePrice;

  /// No description provided for @itemFieldSerialNumber.
  ///
  /// In en, this message translates to:
  /// **'Serial number'**
  String get itemFieldSerialNumber;

  /// No description provided for @itemFieldModelNumber.
  ///
  /// In en, this message translates to:
  /// **'Model number'**
  String get itemFieldModelNumber;

  /// No description provided for @itemFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get itemFieldNotes;

  /// No description provided for @itemFieldReminderSchedule.
  ///
  /// In en, this message translates to:
  /// **'Reminder schedule'**
  String get itemFieldReminderSchedule;

  /// No description provided for @itemSectionPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get itemSectionPhotos;

  /// No description provided for @itemSectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get itemSectionDetails;

  /// No description provided for @itemSectionReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get itemSectionReminders;

  /// No description provided for @itemUseTemplate.
  ///
  /// In en, this message translates to:
  /// **'Start from a template'**
  String get itemUseTemplate;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get actionExport;

  /// No description provided for @actionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get actionShare;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @actionClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get actionClearFilters;

  /// No description provided for @actionPrepareClaim.
  ///
  /// In en, this message translates to:
  /// **'Prepare claim'**
  String get actionPrepareClaim;

  /// No description provided for @validationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an item name'**
  String get validationNameRequired;

  /// No description provided for @validationWarrantyRange.
  ///
  /// In en, this message translates to:
  /// **'Warranty must be between 1 and 360 months'**
  String get validationWarrantyRange;

  /// No description provided for @validationPurchaseDateFuture.
  ///
  /// In en, this message translates to:
  /// **'Purchase date cannot be in the future'**
  String get validationPurchaseDateFuture;

  /// No description provided for @validationPriceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get validationPriceInvalid;

  /// No description provided for @warningAlreadyExpired.
  ///
  /// In en, this message translates to:
  /// **'This warranty has already expired — no reminders will be scheduled.'**
  String get warningAlreadyExpired;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete item?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete \"{name}\" and its photos.'**
  String deleteConfirmBody(String name);

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get statusExpiringSoon;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// No description provided for @statusClaimed.
  ///
  /// In en, this message translates to:
  /// **'Claimed'**
  String get statusClaimed;

  /// No description provided for @daysRemaining.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{Expires today} =1{1 day left} other{{days} days left}}'**
  String daysRemaining(int days);

  /// No description provided for @daysOverdue.
  ///
  /// In en, this message translates to:
  /// **'Expired {days, plural, =1{1 day ago} other{{days} days ago}}'**
  String daysOverdue(int days);

  /// No description provided for @actNowDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day left to claim — act now} other{{days} days left to claim — act now}}'**
  String actNowDaysLeft(int days);

  /// No description provided for @healthScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of warranty remaining'**
  String healthScoreLabel(int percent);

  /// No description provided for @listSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search items'**
  String get listSearchHint;

  /// No description provided for @listSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get listSortBy;

  /// No description provided for @listFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get listFilter;

  /// No description provided for @sortExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get sortExpiryDate;

  /// No description provided for @sortPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get sortPurchaseDate;

  /// No description provided for @sortName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get sortName;

  /// No description provided for @sortPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get sortPrice;

  /// No description provided for @searchEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No items match your search'**
  String get searchEmptyTitle;

  /// No description provided for @searchEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Try a different name or clear your filters.'**
  String get searchEmptyBody;

  /// No description provided for @claimAssistantTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim Assistant'**
  String get claimAssistantTitle;

  /// No description provided for @claimChecklistReceipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt photo attached?'**
  String get claimChecklistReceipt;

  /// No description provided for @claimChecklistSerial.
  ///
  /// In en, this message translates to:
  /// **'Serial number noted?'**
  String get claimChecklistSerial;

  /// No description provided for @claimChecklistContact.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer contact info saved?'**
  String get claimChecklistContact;

  /// No description provided for @claimChecklistFault.
  ///
  /// In en, this message translates to:
  /// **'Fault description written?'**
  String get claimChecklistFault;

  /// No description provided for @claimChecklistProof.
  ///
  /// In en, this message translates to:
  /// **'Proof of purchase ready?'**
  String get claimChecklistProof;

  /// No description provided for @claimFieldFault.
  ///
  /// In en, this message translates to:
  /// **'Fault description'**
  String get claimFieldFault;

  /// No description provided for @claimFieldContact.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer contact'**
  String get claimFieldContact;

  /// No description provided for @claimMarkClaimed.
  ///
  /// In en, this message translates to:
  /// **'Mark as claimed'**
  String get claimMarkClaimed;

  /// No description provided for @claimReceiptPrompt.
  ///
  /// In en, this message translates to:
  /// **'Add a receipt photo before proceeding.'**
  String get claimReceiptPrompt;

  /// No description provided for @claimDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as claimed'**
  String get claimDialogTitle;

  /// No description provided for @claimFieldResolution.
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get claimFieldResolution;

  /// No description provided for @claimFieldResolutionNotes.
  ///
  /// In en, this message translates to:
  /// **'Resolution notes'**
  String get claimFieldResolutionNotes;

  /// No description provided for @claimDate.
  ///
  /// In en, this message translates to:
  /// **'Claim date'**
  String get claimDate;

  /// No description provided for @resolutionRepaired.
  ///
  /// In en, this message translates to:
  /// **'Repaired'**
  String get resolutionRepaired;

  /// No description provided for @resolutionReplaced.
  ///
  /// In en, this message translates to:
  /// **'Replaced'**
  String get resolutionReplaced;

  /// No description provided for @resolutionRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get resolutionRefunded;

  /// No description provided for @resolutionDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get resolutionDenied;

  /// No description provided for @resolutionPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get resolutionPending;

  /// No description provided for @claimSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Great — you\'ve protected your purchase'**
  String get claimSuccessTitle;

  /// No description provided for @claimSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Add more items to keep your vault complete.'**
  String get claimSuccessBody;

  /// No description provided for @archiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveTitle;

  /// No description provided for @archiveEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No claimed items yet'**
  String get archiveEmptyTitle;

  /// No description provided for @archiveEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'When you mark a warranty as claimed, it will appear here.'**
  String get archiveEmptyBody;

  /// No description provided for @archiveFilterResolution.
  ///
  /// In en, this message translates to:
  /// **'Filter by resolution'**
  String get archiveFilterResolution;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @categoryAdd.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get categoryAdd;

  /// No description provided for @categoryRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get categoryRename;

  /// No description provided for @categoryItemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String categoryItemCount(int count);

  /// No description provided for @categoryDeleteBlocked.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete a category that has items assigned.'**
  String get categoryDeleteBlocked;

  /// No description provided for @categoryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No items in this category yet.'**
  String get categoryEmptyTitle;

  /// No description provided for @templatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get templatesTitle;

  /// No description provided for @templateSaveFromItem.
  ///
  /// In en, this message translates to:
  /// **'Save as template'**
  String get templateSaveFromItem;

  /// No description provided for @templateAdd.
  ///
  /// In en, this message translates to:
  /// **'New template'**
  String get templateAdd;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsReminderDefaults.
  ///
  /// In en, this message translates to:
  /// **'Default reminders'**
  String get settingsReminderDefaults;

  /// No description provided for @settingsReminderDefaultsBody.
  ///
  /// In en, this message translates to:
  /// **'Days before expiry to remind you'**
  String get settingsReminderDefaultsBody;

  /// No description provided for @settingsExportAll.
  ///
  /// In en, this message translates to:
  /// **'Export all data'**
  String get settingsExportAll;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsLicences.
  ///
  /// In en, this message translates to:
  /// **'Open source licences'**
  String get settingsLicences;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsProtectingFor.
  ///
  /// In en, this message translates to:
  /// **'Protecting your purchases for {days} days'**
  String settingsProtectingFor(int days);

  /// No description provided for @settingsBackupNudge.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t backed up recently. Consider exporting your data.'**
  String get settingsBackupNudge;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(String version);

  /// No description provided for @exportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportTitle;

  /// No description provided for @exportChooseFormat.
  ///
  /// In en, this message translates to:
  /// **'Choose a format'**
  String get exportChooseFormat;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'CSV (spreadsheet)'**
  String get exportCsv;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'PDF summary'**
  String get exportPdf;

  /// No description provided for @exportItemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}} to export'**
  String exportItemCount(int count);

  /// No description provided for @exportGenerate.
  ///
  /// In en, this message translates to:
  /// **'Export and share'**
  String get exportGenerate;

  /// No description provided for @exportFailedSpace.
  ///
  /// In en, this message translates to:
  /// **'Export failed. Your device may be low on storage. Free up space and try again.'**
  String get exportFailedSpace;

  /// No description provided for @photoTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get photoTakePhoto;

  /// No description provided for @photoChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get photoChooseGallery;

  /// No description provided for @photoImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not import photo. Please try again.'**
  String get photoImportFailed;

  /// No description provided for @photoAltTextHint.
  ///
  /// In en, this message translates to:
  /// **'Describe this photo'**
  String get photoAltTextHint;

  /// No description provided for @photoMaxReached.
  ///
  /// In en, this message translates to:
  /// **'You can attach up to 5 photos.'**
  String get photoMaxReached;

  /// No description provided for @photoStorageRationale.
  ///
  /// In en, this message translates to:
  /// **'WarrantyBoxx needs storage access to save receipt photos. You can still use the app without photos.'**
  String get photoStorageRationale;

  /// No description provided for @photoGrantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant permission'**
  String get photoGrantPermission;

  /// No description provided for @photoSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get photoSkip;

  /// No description provided for @notificationPermissionRationale.
  ///
  /// In en, this message translates to:
  /// **'Allow reminders to get notified before your warranties expire.'**
  String get notificationPermissionRationale;

  /// No description provided for @notificationsDisabledNotice.
  ///
  /// In en, this message translates to:
  /// **'Reminders are disabled. Enable notifications in Settings to be reminded before warranties expire.'**
  String get notificationsDisabledNotice;

  /// No description provided for @reminderSetSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Reminder set for {days} days before expiry.'**
  String reminderSetSnackbar(String days);

  /// No description provided for @notifChannelName.
  ///
  /// In en, this message translates to:
  /// **'Warranty Reminders'**
  String get notifChannelName;

  /// No description provided for @notifChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Reminders before your warranties expire.'**
  String get notifChannelDescription;

  /// No description provided for @notif30Title.
  ///
  /// In en, this message translates to:
  /// **'Warranty expiring soon'**
  String get notif30Title;

  /// No description provided for @notif30Body.
  ///
  /// In en, this message translates to:
  /// **'Your {name} warranty expires in 30 days. Tap to review.'**
  String notif30Body(String name);

  /// No description provided for @notif15Title.
  ///
  /// In en, this message translates to:
  /// **'Warranty expiring in 2 weeks'**
  String get notif15Title;

  /// No description provided for @notif15Body.
  ///
  /// In en, this message translates to:
  /// **'Your {name} warranty expires on {date}. Start gathering your documents.'**
  String notif15Body(String name, String date);

  /// No description provided for @notif7Title.
  ///
  /// In en, this message translates to:
  /// **'Act now — 7 days left'**
  String get notif7Title;

  /// No description provided for @notif7Body.
  ///
  /// In en, this message translates to:
  /// **'Your {name} warranty expires in 7 days. Open Claim Assistant to prepare.'**
  String notif7Body(String name);

  /// No description provided for @notif1Title.
  ///
  /// In en, this message translates to:
  /// **'Last chance — warranty expires tomorrow'**
  String get notif1Title;

  /// No description provided for @notif1Body.
  ///
  /// In en, this message translates to:
  /// **'Your {name} warranty expires tomorrow. Contact the manufacturer today.'**
  String notif1Body(String name);

  /// No description provided for @notifGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Warranty reminder'**
  String get notifGenericTitle;

  /// No description provided for @notifGenericBody.
  ///
  /// In en, this message translates to:
  /// **'Your {name} warranty expires in {days} days.'**
  String notifGenericBody(String name, int days);

  /// No description provided for @milestone5.
  ///
  /// In en, this message translates to:
  /// **'You have 5 items protected.'**
  String get milestone5;

  /// No description provided for @milestone10.
  ///
  /// In en, this message translates to:
  /// **'You have 10 items protected.'**
  String get milestone10;

  /// No description provided for @milestone25.
  ///
  /// In en, this message translates to:
  /// **'You have 25 items protected. Your vault is comprehensive!'**
  String get milestone25;

  /// No description provided for @widgetExpiring30.
  ///
  /// In en, this message translates to:
  /// **'{count} expiring in 30 days'**
  String widgetExpiring30(int count);

  /// No description provided for @widgetExpiring7.
  ///
  /// In en, this message translates to:
  /// **'{count} expiring in 7 days'**
  String widgetExpiring7(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

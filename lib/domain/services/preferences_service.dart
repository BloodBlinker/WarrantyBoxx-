import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/constants/app_constants.dart';

/// Wraps [SharedPreferences] for app flags and local engagement counters
/// (Blueprint Sections 7.1 and 7.3). No data ever leaves the device.
class PreferencesService {
  /// Creates a service over an initialised [SharedPreferences] instance.
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  // --- Onboarding (Section 7.1) ---

  /// Whether the one-time onboarding screen has been shown.
  bool get onboardingShown => _prefs.getBool(PrefKeys.onboardingShown) ?? false;

  /// Marks onboarding as shown (never shown again).
  Future<void> setOnboardingShown() =>
      _prefs.setBool(PrefKeys.onboardingShown, true);

  /// Whether the one-time pulsing-FAB hint has already played.
  bool get fabPulseShown => _prefs.getBool(PrefKeys.fabPulseShown) ?? false;

  /// Marks the FAB pulse hint as shown.
  Future<void> setFabPulseShown() =>
      _prefs.setBool(PrefKeys.fabPulseShown, true);

  /// Whether the notification-permission rationale has been shown once.
  bool get notificationRationaleShown =>
      _prefs.getBool(PrefKeys.notificationRationaleShown) ?? false;

  /// Marks the notification rationale as shown.
  Future<void> setNotificationRationaleShown() =>
      _prefs.setBool(PrefKeys.notificationRationaleShown, true);

  // --- Default reminder schedule (Section 7.1) ---

  /// Global default reminder offsets, falling back to the app default.
  List<int> get defaultReminderDays {
    final stored = _prefs.getStringList(PrefKeys.defaultReminderDays);
    if (stored == null || stored.isEmpty) return ReminderDefaults.defaultDays;
    return stored.map(int.parse).toList();
  }

  /// Updates the global default reminder offsets.
  Future<void> setDefaultReminderDays(List<int> days) => _prefs.setStringList(
        PrefKeys.defaultReminderDays,
        days.map((d) => d.toString()).toList(),
      );

  // --- Engagement counters (Section 7.3) ---

  /// Number of items ever added.
  int get itemsAddedCount => _prefs.getInt(PrefKeys.itemsAddedCount) ?? 0;

  /// Increments [itemsAddedCount] and records the first-item date if unset.
  /// Returns the new count.
  Future<int> incrementItemsAdded() async {
    final next = itemsAddedCount + 1;
    await _prefs.setInt(PrefKeys.itemsAddedCount, next);
    if (_prefs.getString(PrefKeys.firstItemAddedDate) == null) {
      await _prefs.setString(
        PrefKeys.firstItemAddedDate,
        DateTime.now().toIso8601String(),
      );
    }
    return next;
  }

  /// Number of items marked claimed.
  int get claimsMadeCount => _prefs.getInt(PrefKeys.claimsMadeCount) ?? 0;

  /// Increments [claimsMadeCount]. Returns the new count.
  Future<int> incrementClaimsMade() async {
    final next = claimsMadeCount + 1;
    await _prefs.setInt(PrefKeys.claimsMadeCount, next);
    return next;
  }

  /// Date the first item was added, or null if none yet.
  DateTime? get firstItemAddedDate {
    final raw = _prefs.getString(PrefKeys.firstItemAddedDate);
    return raw == null ? null : DateTime.tryParse(raw);
  }

  /// Date of the most recent export, or null if never exported.
  DateTime? get lastExportDate {
    final raw = _prefs.getString(PrefKeys.lastExportDate);
    return raw == null ? null : DateTime.tryParse(raw);
  }

  /// Records that an export just happened.
  Future<void> setLastExportNow() => _prefs.setString(
        PrefKeys.lastExportDate,
        DateTime.now().toIso8601String(),
      );
}

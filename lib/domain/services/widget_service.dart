import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';

import '../../shared/constants/app_constants.dart';
import '../../shared/utils/date_utils.dart';
import '../models/item.dart';

/// Pushes warranty counts to the Android home screen widget (Blueprint Section
/// 2.1 "Home Screen Widget"). No Google services involved.
class WidgetService {
  /// Android provider class name (matches the manifest receiver).
  static const String _androidProvider = 'WarrantyWidgetProvider';

  /// Recomputes the widget counts from [items] and refreshes the widget.
  ///
  /// Shows the number of unclaimed warranties expiring within the next 30 and 7
  /// days (Section 2.1).
  Future<void> refresh(List<Item> items) async {
    final today = AppDates.today();
    var within30 = 0;
    var within7 = 0;
    for (final item in items) {
      if (item.isClaimed) continue;
      final days = item.daysRemainingAsOf(today);
      if (days >= 0 && days <= StatusThresholds.activeDays) within30++;
      if (days >= 0 && days <= StatusThresholds.criticalDays) within7++;
    }

    await HomeWidget.saveWidgetData<int>(PrefKeys.widgetExpiring30, within30);
    await HomeWidget.saveWidgetData<int>(PrefKeys.widgetExpiring7, within7);
    await HomeWidget.updateWidget(androidName: _androidProvider);
  }

  /// Registers a WorkManager job that refreshes the widget every 6 hours, so the
  /// counts stay correct as days roll over even without data changes (Section
  /// 2.1). Idempotent — replaces any existing schedule.
  Future<void> schedulePeriodicRefresh() {
    return Workmanager().registerPeriodicTask(
      NotificationConfig.widgetRefreshTask,
      NotificationConfig.widgetRefreshTask,
      frequency: const Duration(hours: 6),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }
}

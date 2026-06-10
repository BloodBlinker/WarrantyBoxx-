import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import '../../data/database/database.dart';
import '../../data/repositories/item_repository.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/app_localizations_en.dart';
import '../../shared/constants/app_constants.dart';
import '../models/item.dart';
import '../services/warranty_calculator.dart';
import 'notification_messages.dart';
import 'widget_service.dart';

/// WorkManager task name for a single reminder firing.
const String _reminderTaskName = 'warranty_reminder';

/// Keys used in the WorkManager input data payload.
const String _kNotifId = 'notif_id';
const String _kTitle = 'title';
const String _kBody = 'body';
const String _kPayload = 'payload';

/// Manages local warranty-expiry reminders entirely on-device, with no Firebase
/// or Google services (Blueprint Sections 2.1, 4.1, 4.3).
///
/// Each reminder is a WorkManager one-off task scheduled with an `initialDelay`;
/// the task posts a local notification. WorkManager persists pending work across
/// reboots, which satisfies the "missed notifications delivered on next boot"
/// requirement without a custom BOOT_COMPLETED receiver. Reminders for one item
/// share a tag (`item_<id>`) so they can be cancelled and rescheduled atomically
/// on every create/update (Section 4.3).
class NotificationService {
  /// Creates a notification service over [_plugin].
  NotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  /// English localisations used to render copy (English-only at launch — when
  /// i18n expands, resolve the active locale here). See Section 2.2.
  final AppLocalizations _l10n = AppLocalizationsEn();

  /// Initialises the notification channel and WorkManager. Call once at startup.
  Future<void> init({void Function(String payload)? onTapPayload}) async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && onTapPayload != null) onTapPayload(payload);
      },
    );

    // Create the "Warranty Reminders" channel (Section 2.1).
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            NotificationConfig.channelId,
            _l10n.notifChannelName,
            description: _l10n.notifChannelDescription,
            importance: Importance.high,
          ),
        );

    await Workmanager().initialize(notificationCallbackDispatcher);
  }

  /// Requests notification permission (Android 13+). Returns whether granted.
  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final granted = await android?.requestNotificationsPermission();
    return granted ?? true;
  }

  /// Returns the payload that launched the app from a notification, if any.
  Future<String?> launchPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      return details?.notificationResponse?.payload;
    }
    return null;
  }

  /// Deterministic notification id for an item + offset (Section 4.3).
  static int notificationId(String itemId, int offsetDays) =>
      (itemId.hashCode ^ (offsetDays * 31)) & 0x7fffffff;

  /// Cancels any pending reminders for [itemId], then schedules fresh ones for
  /// every offset whose fire time is still in the future (Section 4.3).
  Future<void> scheduleForItem(Item item) async {
    await cancelForItem(item.id);

    final offsets = WarrantyCalculator.upcomingReminderOffsets(
      expiryDate: item.expiryDate,
      today: DateTime.now(),
      reminderDays: item.reminderDays,
    );

    final now = DateTime.now();
    for (final offset in offsets) {
      final fireDate = item.expiryDate.subtract(Duration(days: offset));
      final delay = fireDate.difference(now);
      if (delay.isNegative) continue;

      final message = NotificationMessages.forOffset(
        _l10n,
        offsetDays: offset,
        itemName: item.name,
        expiryDate: item.expiryDate,
      );

      await Workmanager().registerOneOffTask(
        _uniqueName(item.id, offset),
        _reminderTaskName,
        initialDelay: delay,
        tag: _itemTag(item.id),
        existingWorkPolicy: ExistingWorkPolicy.replace,
        inputData: {
          _kNotifId: notificationId(item.id, offset),
          _kTitle: message.title,
          _kBody: message.body,
          _kPayload: '${NotificationConfig.deepLinkScheme}://item/${item.id}',
        },
      );
    }
  }

  /// Cancels all pending reminders for [itemId].
  Future<void> cancelForItem(String itemId) =>
      Workmanager().cancelByTag(_itemTag(itemId));

  static String _uniqueName(String itemId, int offset) => 'rmd_${itemId}_$offset';
  static String _itemTag(String itemId) => 'item_$itemId';
}

/// WorkManager background entry point. Runs in a separate isolate, so it
/// reinitialises the notifications plugin and posts the notification carried in
/// the task's input data. Must be a top-level function (Section 4.1).
@pragma('vm:entry-point')
void notificationCallbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    // Periodic widget refresh: recompute counts from the database (Section 2.1).
    if (taskName == NotificationConfig.widgetRefreshTask) {
      final db = AppDatabase();
      try {
        final items = await ItemRepository(db).getAll();
        await WidgetService().refresh(items);
      } finally {
        await db.close();
      }
      return true;
    }

    if (taskName != _reminderTaskName || inputData == null) return true;

    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        NotificationConfig.channelId,
        'Warranty Reminders',
        channelDescription: 'Reminders before your warranties expire.',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await plugin.show(
      inputData[_kNotifId] as int,
      inputData[_kTitle] as String,
      inputData[_kBody] as String,
      details,
      payload: inputData[_kPayload] as String?,
    );
    return true;
  });
}

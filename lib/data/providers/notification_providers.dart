import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/notification_service.dart';

/// Provides the shared [FlutterLocalNotificationsPlugin] instance.
final localNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>(
  (ref) => FlutterLocalNotificationsPlugin(),
);

/// Provides the [NotificationService].
final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(ref.watch(localNotificationsPluginProvider)),
);

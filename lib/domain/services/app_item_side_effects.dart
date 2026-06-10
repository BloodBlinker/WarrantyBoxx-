import '../models/item.dart';
import 'item_service.dart';
import 'notification_service.dart';
import 'photo_service.dart';

/// Concrete [ItemSideEffects] wiring reminders, photo cleanup and (later) the
/// home-screen widget into item mutations (Blueprint Section 4.3).
class AppItemSideEffects implements ItemSideEffects {
  /// Creates the side-effects coordinator.
  AppItemSideEffects({
    required this.notifications,
    required this.photos,
    this.onRefreshWidget,
  });

  /// Reminder scheduler.
  final NotificationService notifications;

  /// Photo file manager.
  final PhotoService photos;

  /// Optional home-screen widget refresh hook (wired in Phase 8).
  final Future<void> Function()? onRefreshWidget;

  @override
  Future<void> scheduleReminders(Item item) =>
      notifications.scheduleForItem(item);

  @override
  Future<void> cancelReminders(String itemId) =>
      notifications.cancelForItem(itemId);

  @override
  Future<void> deletePhotos(Item item) => photos.deleteForItem(item.id);

  @override
  Future<void> refreshWidget() async {
    await onRefreshWidget?.call();
  }
}

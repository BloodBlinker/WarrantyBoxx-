import '../../data/repositories/item_repository.dart';
import '../models/enums.dart';
import '../models/item.dart';
import 'preferences_service.dart';

/// Result of saving a new item, carrying the running item count so the UI can
/// surface milestone messages (Blueprint Section 7.3).
class SaveResult {
  const SaveResult({required this.itemsAddedCount});

  /// Total items added so far (after this save).
  final int itemsAddedCount;
}

/// Coordinates the side effects of mutating an item: persistence, engagement
/// counters, reminder (re)scheduling, photo cleanup and widget refresh.
///
/// Notification, photo and widget hooks are injected so each can be developed in
/// its own phase without changing call sites (Blueprint Section 11.1).
class ItemService {
  /// Creates the service.
  ItemService({
    required ItemRepository itemRepository,
    required PreferencesService preferences,
    ItemSideEffects? sideEffects,
  })  : _items = itemRepository,
        _prefs = preferences,
        _effects = sideEffects ?? const _NoopSideEffects();

  final ItemRepository _items;
  final PreferencesService _prefs;
  final ItemSideEffects _effects;

  /// Saves a brand-new item, increments the added counter and schedules
  /// reminders. Returns the running count for milestone messaging.
  Future<SaveResult> createItem(Item item) async {
    await _items.save(item);
    await _effects.scheduleReminders(item);
    await _effects.refreshWidget();
    final count = await _prefs.incrementItemsAdded();
    return SaveResult(itemsAddedCount: count);
  }

  /// Updates an existing item and reschedules reminders from scratch
  /// (Section 4.3: cancel then schedule fresh).
  Future<void> updateItem(Item item) async {
    await _items.save(item);
    await _effects.cancelReminders(item.id);
    await _effects.scheduleReminders(item);
    await _effects.refreshWidget();
  }

  /// Deletes an item: removes its photos, cancels its reminders, then deletes
  /// the row (Section 4.3 ordering).
  Future<void> deleteItem(Item item) async {
    await _effects.deletePhotos(item);
    await _effects.cancelReminders(item.id);
    await _items.delete(item.id);
    await _effects.refreshWidget();
  }

  /// Marks an item claimed, increments the claims counter and cancels its
  /// pending reminders. Returns the running claims count.
  Future<int> markClaimed(
    Item item, {
    required ClaimResolution resolution,
    String? notes,
  }) async {
    await _items.markClaimed(item, resolution: resolution, notes: notes);
    await _effects.cancelReminders(item.id);
    await _effects.refreshWidget();
    return _prefs.incrementClaimsMade();
  }
}

/// Side effects an [ItemService] mutation triggers. Implemented by the
/// notification/photo/widget services in their respective phases.
abstract class ItemSideEffects {
  /// Schedules reminders for [item] based on its expiry and reminder schedule.
  Future<void> scheduleReminders(Item item);

  /// Cancels all reminders for the item with [itemId].
  Future<void> cancelReminders(String itemId);

  /// Deletes all photo files for [item].
  Future<void> deletePhotos(Item item);

  /// Refreshes the home screen widget data.
  Future<void> refreshWidget();
}

/// Default no-op side effects (used until the real services are wired in).
class _NoopSideEffects implements ItemSideEffects {
  const _NoopSideEffects();

  @override
  Future<void> scheduleReminders(Item item) async {}

  @override
  Future<void> cancelReminders(String itemId) async {}

  @override
  Future<void> deletePhotos(Item item) async {}

  @override
  Future<void> refreshWidget() async {}
}

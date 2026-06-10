import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warranty_vault/data/database/database.dart';
import 'package:warranty_vault/data/repositories/item_repository.dart';
import 'package:warranty_vault/domain/models/enums.dart';
import 'package:warranty_vault/domain/models/item.dart';
import 'package:warranty_vault/domain/services/item_service.dart';
import 'package:warranty_vault/domain/services/preferences_service.dart';

import '../support/item_factory.dart';

/// Records the side effects an [ItemService] triggers, standing in for the real
/// WorkManager/photo services (Blueprint Section 6.5 "Notification tests").
class _SpyEffects implements ItemSideEffects {
  final List<String> log = [];

  @override
  Future<void> scheduleReminders(Item item) async =>
      log.add('schedule:${item.id}');

  @override
  Future<void> cancelReminders(String itemId) async =>
      log.add('cancel:$itemId');

  @override
  Future<void> deletePhotos(Item item) async => log.add('photos:${item.id}');

  @override
  Future<void> refreshWidget() async => log.add('widget');
}

void main() {
  late AppDatabase db;
  late ItemService service;
  late _SpyEffects effects;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    effects = _SpyEffects();
    service = ItemService(
      itemRepository: ItemRepository(db),
      preferences: PreferencesService(prefs),
      sideEffects: effects,
    );
  });

  tearDown(() async => db.close());

  test('createItem schedules reminders and counts the item', () async {
    final result = await service.createItem(makeItem(id: 'x'));
    expect(result.itemsAddedCount, 1);
    expect(effects.log, contains('schedule:x'));
    expect(effects.log, contains('widget'));
  });

  test('updateItem cancels then reschedules reminders', () async {
    await service.createItem(makeItem(id: 'x'));
    effects.log.clear();
    await service.updateItem(makeItem(id: 'x', name: 'Renamed'));
    // Cancel must happen before the fresh schedule (Section 4.3).
    expect(effects.log.indexOf('cancel:x'),
        lessThan(effects.log.indexOf('schedule:x')));
  });

  test('deleteItem removes photos, cancels reminders, then deletes the row',
      () async {
    final item = makeItem(id: 'x');
    await service.createItem(item);
    effects.log.clear();
    await service.deleteItem(item);
    expect(effects.log, containsAllInOrder(['photos:x', 'cancel:x']));
    expect(await ItemRepository(db).getById('x'), isNull);
  });

  test('markClaimed cancels reminders and increments the claims count',
      () async {
    final item = makeItem(id: 'x');
    await service.createItem(item);
    effects.log.clear();
    final count = await service.markClaimed(item,
        resolution: ClaimResolution.repaired);
    expect(count, 1);
    expect(effects.log, contains('cancel:x'));
    final reloaded = await ItemRepository(db).getById('x');
    expect(reloaded!.isClaimed, isTrue);
  });
}

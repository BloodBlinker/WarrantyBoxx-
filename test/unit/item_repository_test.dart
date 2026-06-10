import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/data/database/database.dart';
import 'package:warranty_vault/data/repositories/item_repository.dart';
import 'package:warranty_vault/domain/models/enums.dart';
import 'package:warranty_vault/domain/models/item.dart';
import 'package:warranty_vault/domain/services/warranty_calculator.dart';

void main() {
  late AppDatabase db;
  late ItemRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ItemRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  Item buildItem({
    String id = 'item-1',
    String name = 'Test Item',
    String categoryId = 'electronics',
    int warrantyMonths = 24,
  }) {
    final purchase = DateTime.utc(2026, 1, 1);
    return Item(
      id: id,
      name: name,
      categoryId: categoryId,
      purchaseDate: purchase,
      warrantyMonths: warrantyMonths,
      expiryDate: WarrantyCalculator.computeExpiry(
        purchaseDate: purchase,
        warrantyMonths: warrantyMonths,
      ),
      reminderDays: const [30, 15, 7, 1],
      photoPaths: const [],
      createdAt: DateTime.utc(2026, 1, 1),
      updatedAt: DateTime.utc(2026, 1, 1),
    );
  }

  group('migration / seeding', () {
    test('onCreate seeds 7 system categories', () async {
      final categories = await db.categoryDao.getAll();
      expect(categories.length, 7);
      expect(categories.where((c) => c.isSystem).length, 7);
      expect(categories.map((c) => c.id), contains('other'));
    });

    test('onCreate seeds 8 system templates', () async {
      final templates = await db.templateDao.getAll();
      expect(templates.length, 8);
      expect(templates.firstWhere((t) => t.id == 'tpl_power_tool').warrantyMonths,
          12);
    });

    test('schema version is 1 at MVP launch', () {
      expect(db.schemaVersion, 1);
    });
  });

  group('ItemRepository CRUD', () {
    test('save then getById round-trips all fields', () async {
      final item = buildItem().copyWith(
        brand: 'Acme',
        purchasePrice: 199.99,
        notes: 'Test notes',
      );
      await repo.save(item);

      final loaded = await repo.getById('item-1');
      expect(loaded, isNotNull);
      expect(loaded!.name, 'Test Item');
      expect(loaded.brand, 'Acme');
      expect(loaded.purchasePrice, 199.99);
      expect(loaded.notes, 'Test notes');
      expect(loaded.reminderDays, [30, 15, 7, 1]);
    });

    test('save stamps updatedAt', () async {
      final item = buildItem();
      await repo.save(item);
      final loaded = await repo.getById('item-1');
      expect(loaded!.updatedAt.isAfter(item.createdAt), isTrue);
    });

    test('delete removes the row', () async {
      await repo.save(buildItem());
      await repo.delete('item-1');
      expect(await repo.getById('item-1'), isNull);
    });

    test('watchActive excludes claimed items', () async {
      await repo.save(buildItem(id: 'a', name: 'Active'));
      await repo.save(buildItem(id: 'b', name: 'Claimed'));
      final claimed = (await repo.getById('b'))!;
      await repo.markClaimed(claimed, resolution: ClaimResolution.repaired);

      final active = await repo.watchActive().first;
      expect(active.map((i) => i.id), ['a']);

      final archived = await repo.watchClaimed().first;
      expect(archived.map((i) => i.id), ['b']);
      expect(archived.single.claimResolution, ClaimResolution.repaired);
    });

    test('watchAll orders by expiry ascending', () async {
      await repo.save(buildItem(id: 'long', warrantyMonths: 60));
      await repo.save(buildItem(id: 'short', warrantyMonths: 1));
      final all = await repo.watchAll().first;
      expect(all.first.id, 'short');
      expect(all.last.id, 'long');
    });
  });
}

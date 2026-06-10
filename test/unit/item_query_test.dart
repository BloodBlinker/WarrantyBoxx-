import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/domain/models/enums.dart';
import 'package:warranty_vault/domain/models/item_query.dart';

import '../support/item_factory.dart';

void main() {
  final today = DateTime(2026, 6, 10);

  final laptop = makeItem(
    id: 'laptop',
    name: 'Dell Laptop',
    categoryId: 'electronics',
    brand: 'Dell',
    serialNumber: 'SN-12345',
    purchaseDate: DateTime(2026, 1, 1),
    purchasePrice: 1200,
  );
  final drill = makeItem(
    id: 'drill',
    name: 'Cordless Drill',
    categoryId: 'tools',
    retailer: 'ToolShop',
    purchaseDate: DateTime(2025, 6, 1),
    warrantyMonths: 12,
    purchasePrice: 99,
  );
  final fridge = makeItem(
    id: 'fridge',
    name: 'Refrigerator',
    categoryId: 'appliances',
    notes: 'kitchen appliance',
    purchaseDate: DateTime(2024, 1, 1),
    purchasePrice: 600,
  );

  final all = [laptop, drill, fridge];

  test('default query returns all, expiry ascending', () {
    // Expiry: fridge 2026-01-01, drill 2026-06-01, laptop 2028-01-01.
    final result = const ItemQuery().apply(all, today: today);
    expect(result.map((i) => i.id), ['fridge', 'drill', 'laptop']);
  });

  test('search matches name, brand, serial, retailer and notes', () {
    expect(
      const ItemQuery(searchText: 'dell').apply(all, today: today).map((i) => i.id),
      ['laptop'],
    );
    expect(
      const ItemQuery(searchText: 'SN-123').apply(all, today: today).map((i) => i.id),
      ['laptop'],
    );
    expect(
      const ItemQuery(searchText: 'toolshop').apply(all, today: today).map((i) => i.id),
      ['drill'],
    );
    expect(
      const ItemQuery(searchText: 'kitchen').apply(all, today: today).map((i) => i.id),
      ['fridge'],
    );
  });

  test('category filter restricts results', () {
    final result = ItemQuery(categoryIds: const {'tools', 'appliances'})
        .apply(all, today: today)
        .map((i) => i.id)
        .toSet();
    expect(result, {'drill', 'fridge'});
  });

  test('sort by name ascending and descending', () {
    final asc = const ItemQuery(sortField: ItemSortField.name)
        .apply(all, today: today)
        .map((i) => i.id);
    expect(asc, ['drill', 'laptop', 'fridge']);

    final desc =
        const ItemQuery(sortField: ItemSortField.name, ascending: false)
            .apply(all, today: today)
            .map((i) => i.id);
    expect(desc, ['fridge', 'laptop', 'drill']);
  });

  test('sort by price descending', () {
    final result =
        const ItemQuery(sortField: ItemSortField.purchasePrice, ascending: false)
            .apply(all, today: today)
            .map((i) => i.id);
    expect(result, ['laptop', 'fridge', 'drill']);
  });

  test('purchase date range filter is inclusive', () {
    final result = ItemQuery(
      from: DateTime(2025, 1, 1),
      to: DateTime(2026, 12, 31),
    ).apply(all, today: today).map((i) => i.id).toSet();
    expect(result, {'laptop', 'drill'});
  });

  test('status filter uses derived status', () {
    // Both fridge (expiry 2026-01-01) and drill (expiry 2026-06-01) are expired
    // as of 2026-06-10; returned in expiry-ascending order.
    final expired = ItemQuery(statuses: const {WarrantyStatus.expired})
        .apply(all, today: today)
        .map((i) => i.id);
    expect(expired, ['fridge', 'drill']);
  });

  test('hasActiveFilters reflects state', () {
    expect(const ItemQuery().hasActiveFilters, isFalse);
    expect(const ItemQuery(searchText: 'x').hasActiveFilters, isTrue);
  });
}

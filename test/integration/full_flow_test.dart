import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warranty_vault/data/database/database.dart';
import 'package:warranty_vault/data/providers/catalog_providers.dart';
import 'package:warranty_vault/data/providers/item_providers.dart';
import 'package:warranty_vault/data/providers/preferences_providers.dart';
import 'package:warranty_vault/data/providers/repository_providers.dart';
import 'package:warranty_vault/data/providers/service_providers.dart';
import 'package:warranty_vault/domain/models/enums.dart';
import 'package:warranty_vault/features/export/csv_exporter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warranty_vault/shared/utils/date_utils.dart';

import '../support/item_factory.dart';

/// End-to-end flow over the real provider graph with an in-memory database
/// (Blueprint Section 6.5 "Integration tests").
void main() {
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWith(
          (ref) => AppDatabase.forTesting(NativeDatabase.memory()),
        ),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('add item → appears in dashboard → exports to CSV → claim → archive',
      () async {
    final service = container.read(itemServiceProvider);

    // Add an item.
    final item = makeItem(
      id: 'flow-1',
      name: 'Integration Laptop',
      purchaseDate: AppDates.today(),
      purchasePrice: 999,
    );
    final result = await service.createItem(item);
    expect(result.itemsAddedCount, 1);

    // Appears in the active item stream (dashboard source).
    final active = await container.read(activeItemsProvider.future);
    expect(active.map((i) => i.name), contains('Integration Laptop'));

    // Exports to CSV with the item's data.
    final categories = container.read(categoriesByIdProvider);
    final csv = CsvExporter.toCsv(
      await container.read(allItemsProvider.future),
      categoriesById: categories,
      today: AppDates.today(),
    );
    expect(csv, contains('Integration Laptop'));
    expect(csv, contains('999.00'));

    // Mark claimed → moves to the archive stream.
    await service.markClaimed(item, resolution: ClaimResolution.replaced);
    final claimed = await container.read(claimedItemsProvider.future);
    expect(claimed.map((i) => i.id), contains('flow-1'));
    expect(claimed.single.claimResolution, ClaimResolution.replaced);

    // And is no longer active.
    final activeAfter = await container.read(activeItemsProvider.future);
    expect(activeAfter.where((i) => i.id == 'flow-1'), isEmpty);
  });
}

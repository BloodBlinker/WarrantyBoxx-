@Tags(['performance'])
library;

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/data/database/database.dart';
import 'package:warranty_vault/data/repositories/item_repository.dart';
import 'package:warranty_vault/domain/models/dashboard_summary.dart';
import 'package:warranty_vault/domain/models/item_query.dart';
import 'package:warranty_vault/shared/utils/date_utils.dart';

import '../support/item_factory.dart';

/// Verifies the dashboard data path stays well under the 500ms budget with 1000
/// items (Blueprint Section 6.1). Run via `flutter test --tags performance`.
void main() {
  test('dashboard loads under 500ms with 1000 seeded items', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = ItemRepository(db);

    // Seed 1000 items.
    for (var i = 0; i < 1000; i++) {
      await repo.save(makeItem(
        id: 'perf-$i',
        name: 'Item $i',
        purchaseDate: DateTime(2025, 1, 1).add(Duration(days: i)),
        purchasePrice: (i % 50).toDouble(),
      ));
    }

    final today = AppDates.today();
    final stopwatch = Stopwatch()..start();

    // Read all + derive summary + apply the default query (the dashboard path).
    final items = await repo.getAll();
    final summary = DashboardSummary.from(items, today: today);
    final filtered = const ItemQuery().apply(items, today: today);

    stopwatch.stop();

    expect(items.length, 1000);
    expect(summary.totalItems, 1000);
    expect(filtered.length, 1000);
    expect(
      stopwatch.elapsedMilliseconds,
      lessThan(500),
      reason: 'Dashboard derivation took ${stopwatch.elapsedMilliseconds}ms',
    );
  });
}

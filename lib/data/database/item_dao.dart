import 'package:drift/drift.dart';

import 'database.dart';
import 'tables.dart';

part 'item_dao.g.dart';

/// Data access for [Items] (Blueprint Section 3.2).
///
/// DAOs are the only layer that touches Drift directly; repositories sit on top
/// and features never see this class (Section 4.3).
@DriftAccessor(tables: [Items])
class ItemDao extends DatabaseAccessor<AppDatabase> with _$ItemDaoMixin {
  ItemDao(super.db);

  /// Watches all items ordered by expiry date ascending (soonest first) —
  /// the dashboard's default sort (Section 2.1).
  Stream<List<ItemRow>> watchAllByExpiry() {
    return (select(items)
          ..orderBy([(t) => OrderingTerm.asc(t.expiryDate)]))
        .watch();
  }

  /// One-shot read of all items ordered by expiry ascending.
  Future<List<ItemRow>> getAllByExpiry() {
    return (select(items)..orderBy([(t) => OrderingTerm.asc(t.expiryDate)]))
        .get();
  }

  /// Watches a single item by id (null once deleted).
  Stream<ItemRow?> watchById(String id) {
    return (select(items)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// One-shot read of a single item by id.
  Future<ItemRow?> getById(String id) {
    return (select(items)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Watches active (unclaimed) items only, ordered by expiry ascending.
  Stream<List<ItemRow>> watchActive() {
    return (select(items)
          ..where((t) => t.claimDate.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.expiryDate)]))
        .watch();
  }

  /// Watches claimed/archived items, most recently claimed first.
  Stream<List<ItemRow>> watchClaimed() {
    return (select(items)
          ..where((t) => t.claimDate.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.claimDate)]))
        .watch();
  }

  /// Inserts or replaces an item.
  Future<void> upsert(ItemsCompanion item) =>
      into(items).insertOnConflictUpdate(item);

  /// Deletes an item by id. Returns the number of rows removed.
  Future<int> deleteById(String id) =>
      (delete(items)..where((t) => t.id.equals(id))).go();

  /// Counts items assigned to a given category — used to block deletion of a
  /// non-empty category (Section 2.1).
  Future<int> countByCategory(String categoryId) async {
    final count = items.id.count();
    final query = selectOnly(items)
      ..addColumns([count])
      ..where(items.categoryId.equals(categoryId));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}

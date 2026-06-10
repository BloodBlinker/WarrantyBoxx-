import 'package:drift/drift.dart';

import 'database.dart';
import 'tables.dart';

part 'category_dao.g.dart';

/// Data access for [Categories] (Blueprint Section 3.3).
@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(super.db);

  /// Watches all categories ordered by [Categories.sortOrder].
  Stream<List<CategoryRow>> watchAll() {
    return (select(categories)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  /// One-shot read of all categories ordered by sort order.
  Future<List<CategoryRow>> getAll() {
    return (select(categories)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  /// Reads a single category by id.
  Future<CategoryRow?> getById(String id) =>
      (select(categories)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts or replaces a category.
  Future<void> upsert(CategoriesCompanion category) =>
      into(categories).insertOnConflictUpdate(category);

  /// Deletes a category by id.
  Future<int> deleteById(String id) =>
      (delete(categories)..where((t) => t.id.equals(id))).go();
}

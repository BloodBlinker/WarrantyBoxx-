import '../../domain/models/category.dart';
import '../database/database.dart';
import 'mappers.dart';

/// Thrown when an operation on a category is not permitted (Blueprint 2.1/3.3).
class CategoryOperationException implements Exception {
  CategoryOperationException(this.message);

  /// Human-readable reason, suitable for surfacing to the user.
  final String message;

  @override
  String toString() => 'CategoryOperationException: $message';
}

/// Repository for categories (Blueprint Section 4.3).
class CategoryRepository {
  /// Creates a repository backed by [_db].
  CategoryRepository(this._db);

  final AppDatabase _db;

  /// Reactive stream of all categories, sorted by display order.
  Stream<List<Category>> watchAll() => _db.categoryDao
      .watchAll()
      .map((rows) => rows.map(Mappers.categoryToDomain).toList());

  /// One-shot read of all categories.
  Future<List<Category>> getAll() async =>
      (await _db.categoryDao.getAll()).map(Mappers.categoryToDomain).toList();

  /// Number of items assigned to [categoryId].
  Future<int> itemCount(String categoryId) =>
      _db.itemDao.countByCategory(categoryId);

  /// Inserts or updates a user category. System categories cannot be edited.
  Future<void> save(Category category) async {
    final existing = await _db.categoryDao.getById(category.id);
    if (existing != null && existing.isSystem) {
      throw CategoryOperationException('System categories cannot be modified.');
    }
    await _db.categoryDao.upsert(Mappers.categoryToCompanion(category));
  }

  /// Deletes a user category. Fails if it is a system category or has items
  /// assigned (Section 2.1).
  Future<void> delete(String id) async {
    final existing = await _db.categoryDao.getById(id);
    if (existing == null) return;
    if (existing.isSystem) {
      throw CategoryOperationException('System categories cannot be deleted.');
    }
    final count = await _db.itemDao.countByCategory(id);
    if (count > 0) {
      throw CategoryOperationException(
        'Cannot delete a category that has items assigned.',
      );
    }
    await _db.categoryDao.deleteById(id);
  }
}

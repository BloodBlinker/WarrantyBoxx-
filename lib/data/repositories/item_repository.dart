import '../../domain/models/enums.dart';
import '../../domain/models/item.dart';
import '../../shared/utils/date_utils.dart';
import '../database/database.dart';
import 'mappers.dart';

/// Repository for warranty items (Blueprint Section 4.3).
///
/// All business logic that needs item data goes through this class; it owns the
/// mapping to/from domain models so features never see Drift.
class ItemRepository {
  /// Creates a repository backed by [_db].
  ItemRepository(this._db);

  final AppDatabase _db;

  /// Reactive stream of all items, expiry-ascending (dashboard default sort).
  Stream<List<Item>> watchAll() => _db.itemDao
      .watchAllByExpiry()
      .map((rows) => rows.map(Mappers.itemToDomain).toList());

  /// Reactive stream of active (unclaimed) items only.
  Stream<List<Item>> watchActive() => _db.itemDao
      .watchActive()
      .map((rows) => rows.map(Mappers.itemToDomain).toList());

  /// Reactive stream of claimed/archived items.
  Stream<List<Item>> watchClaimed() => _db.itemDao
      .watchClaimed()
      .map((rows) => rows.map(Mappers.itemToDomain).toList());

  /// Reactive stream of a single item by id.
  Stream<Item?> watchById(String id) => _db.itemDao
      .watchById(id)
      .map((row) => row == null ? null : Mappers.itemToDomain(row));

  /// One-shot read of all items.
  Future<List<Item>> getAll() async =>
      (await _db.itemDao.getAllByExpiry()).map(Mappers.itemToDomain).toList();

  /// One-shot read of a single item.
  Future<Item?> getById(String id) async {
    final row = await _db.itemDao.getById(id);
    return row == null ? null : Mappers.itemToDomain(row);
  }

  /// Inserts or updates [item], stamping [Item.updatedAt].
  Future<void> save(Item item) {
    final stamped = item.copyWith(updatedAt: DateTime.now().toUtc());
    return _db.itemDao.upsert(Mappers.itemToCompanion(stamped));
  }

  /// Deletes the item row. Photo files are removed separately by the caller
  /// (PhotoService) before this is invoked (Section 4.3).
  Future<void> delete(String id) => _db.itemDao.deleteById(id);

  /// Marks [item] as claimed with the given resolution (Section 2.1).
  Future<void> markClaimed(
    Item item, {
    required ClaimResolution resolution,
    String? notes,
    DateTime? claimDate,
  }) {
    final claimed = item.copyWith(
      claimDate: claimDate ?? AppDates.today(),
      claimResolution: resolution,
      claimNotes: notes,
      updatedAt: DateTime.now().toUtc(),
    );
    return _db.itemDao.upsert(Mappers.itemToCompanion(claimed));
  }
}

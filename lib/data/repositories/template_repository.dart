import '../../domain/models/item.dart';
import '../../domain/models/template.dart';
import '../database/database.dart';
import 'mappers.dart';

/// Repository for item templates (Blueprint Section 4.3).
class TemplateRepository {
  /// Creates a repository backed by [_db].
  TemplateRepository(this._db);

  final AppDatabase _db;

  /// Reactive stream of all templates.
  Stream<List<Template>> watchAll() => _db.templateDao
      .watchAll()
      .map((rows) => rows.map(Mappers.templateToDomain).toList());

  /// One-shot read of all templates.
  Future<List<Template>> getAll() async =>
      (await _db.templateDao.getAll()).map(Mappers.templateToDomain).toList();

  /// Reads a single template by id.
  Future<Template?> getById(String id) async {
    final row = await _db.templateDao.getById(id);
    return row == null ? null : Mappers.templateToDomain(row);
  }

  /// Inserts or updates a user template.
  Future<void> save(Template template) =>
      _db.templateDao.upsert(Mappers.templateToCompanion(template));

  /// Deletes a user template. System templates cannot be deleted (Section 3.4).
  Future<void> delete(String id) async {
    final existing = await _db.templateDao.getById(id);
    if (existing != null && existing.isSystem) return;
    await _db.templateDao.deleteById(id);
  }

  /// Builds a user template from an existing [item] ("Save as template",
  /// Section 2.1). The caller supplies a fresh [id] and [name].
  Template fromItem({
    required String id,
    required String name,
    required Item item,
  }) =>
      Template(
        id: id,
        name: name,
        categoryId: item.categoryId,
        warrantyMonths: item.warrantyMonths,
        reminderDays: item.reminderDays,
        isSystem: false,
      );
}

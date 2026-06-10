import 'package:drift/drift.dart';

import 'database.dart';
import 'tables.dart';

part 'template_dao.g.dart';

/// Data access for [Templates] (Blueprint Section 3.4).
@DriftAccessor(tables: [Templates])
class TemplateDao extends DatabaseAccessor<AppDatabase> with _$TemplateDaoMixin {
  TemplateDao(super.db);

  /// Watches all templates ordered by name.
  Stream<List<TemplateRow>> watchAll() {
    return (select(templates)..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  /// One-shot read of all templates.
  Future<List<TemplateRow>> getAll() => select(templates).get();

  /// Reads a single template by id.
  Future<TemplateRow?> getById(String id) =>
      (select(templates)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts or replaces a template.
  Future<void> upsert(TemplatesCompanion template) =>
      into(templates).insertOnConflictUpdate(template);

  /// Deletes a template by id.
  Future<int> deleteById(String id) =>
      (delete(templates)..where((t) => t.id.equals(id))).go();
}

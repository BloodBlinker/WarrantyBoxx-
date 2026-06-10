import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'category_dao.dart';
import 'converters.dart';
import 'item_dao.dart';
import 'seed_data.dart';
import 'tables.dart';
import 'template_dao.dart';

part 'database.g.dart';

/// The Drift database for WarrantyBoxx (Blueprint Section 3.1).
///
/// Stored at `getApplicationDocumentsDirectory()/warranty_vault.db`. All access
/// goes through DAOs; repositories sit on top so features never touch Drift.
@DriftDatabase(
  tables: [Items, Categories, Templates],
  daos: [ItemDao, CategoryDao, TemplateDao],
)
class AppDatabase extends _$AppDatabase {
  /// Opens the on-device database in the app documents directory.
  AppDatabase() : super(_openConnection());

  /// Test constructor — pass an in-memory or custom [executor].
  AppDatabase.forTesting(super.executor);

  /// Current schema version (Blueprint Section 3.5: version 1 at MVP launch).
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _seed();
        },
        // Blueprint Section 3.5: as the schema evolves, add a step-by-step
        // migration for each version increment here. None required at version 1.
        onUpgrade: (Migrator m, int from, int to) async {},
      );

  /// Inserts the predefined categories and templates exactly once.
  Future<void> _seed() async {
    await batch((batch) {
      batch.insertAll(categories, SeedData.categories());
      batch.insertAll(templates, SeedData.templates());
    });
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'warranty_vault',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }
}

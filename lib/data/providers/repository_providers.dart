import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../repositories/category_repository.dart';
import '../repositories/item_repository.dart';
import '../repositories/template_repository.dart';

/// Provides the singleton [AppDatabase] (Blueprint Section 4.1 — Riverpod is the
/// DI container).
///
/// Overridden in tests with an in-memory database.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Provides the [ItemRepository].
final itemRepositoryProvider = Provider<ItemRepository>(
  (ref) => ItemRepository(ref.watch(databaseProvider)),
);

/// Provides the [CategoryRepository].
final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(ref.watch(databaseProvider)),
);

/// Provides the [TemplateRepository].
final templateRepositoryProvider = Provider<TemplateRepository>(
  (ref) => TemplateRepository(ref.watch(databaseProvider)),
);

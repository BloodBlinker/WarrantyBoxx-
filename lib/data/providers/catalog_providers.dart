import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/category.dart';
import '../../domain/models/template.dart';
import 'repository_providers.dart';

/// Reactive stream of all categories, sorted by display order.
final categoriesProvider = StreamProvider<List<Category>>(
  (ref) => ref.watch(categoryRepositoryProvider).watchAll(),
);

/// Convenience map of category id -> [Category] for fast look-ups in lists.
final categoriesByIdProvider = Provider<Map<String, Category>>((ref) {
  final categories = ref.watch(categoriesProvider).valueOrNull ?? const [];
  return {for (final category in categories) category.id: category};
});

/// Reactive stream of all templates.
final templatesProvider = StreamProvider<List<Template>>(
  (ref) => ref.watch(templateRepositoryProvider).watchAll(),
);

/// Item count for a given category (used to gate category deletion).
final categoryItemCountProvider = FutureProvider.family<int, String>(
  (ref, categoryId) {
    // Re-evaluate whenever items change.
    ref.watch(categoryRepositoryProvider);
    return ref.read(categoryRepositoryProvider).itemCount(categoryId);
  },
);

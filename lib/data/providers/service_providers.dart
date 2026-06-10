import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/item_service.dart';
import 'preferences_providers.dart';
import 'repository_providers.dart';

/// Holds the [ItemSideEffects] implementation. Overridden once the notification,
/// photo and widget services are initialised (Phases 5, 6, 8). Until then the
/// service uses its built-in no-op effects.
final itemSideEffectsProvider = Provider<ItemSideEffects?>((ref) => null);

/// Provides the [ItemService] use-case.
final itemServiceProvider = Provider<ItemService>(
  (ref) => ItemService(
    itemRepository: ref.watch(itemRepositoryProvider),
    preferences: ref.watch(preferencesServiceProvider),
    sideEffects: ref.watch(itemSideEffectsProvider),
  ),
);

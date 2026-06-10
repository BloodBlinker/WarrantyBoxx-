import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/dashboard_summary.dart';
import '../../domain/models/item.dart';
import '../../domain/models/item_query.dart';
import '../../shared/utils/date_utils.dart';
import 'repository_providers.dart';

/// Reactive stream of all items, expiry-ascending (Blueprint Section 4.3).
final allItemsProvider = StreamProvider<List<Item>>(
  (ref) => ref.watch(itemRepositoryProvider).watchAll(),
);

/// Reactive stream of active (unclaimed) items.
final activeItemsProvider = StreamProvider<List<Item>>(
  (ref) => ref.watch(itemRepositoryProvider).watchActive(),
);

/// Reactive stream of claimed/archived items.
final claimedItemsProvider = StreamProvider<List<Item>>(
  (ref) => ref.watch(itemRepositoryProvider).watchClaimed(),
);

/// Reactive stream of a single item by id.
final itemByIdProvider = StreamProvider.family<Item?, String>(
  (ref, id) => ref.watch(itemRepositoryProvider).watchById(id),
);

/// Aggregate dashboard statistics derived reactively from all items.
final dashboardSummaryProvider = Provider<AsyncValue<DashboardSummary>>((ref) {
  final items = ref.watch(allItemsProvider);
  return items.whenData(
    (list) => DashboardSummary.from(list, today: AppDates.today()),
  );
});

/// Transient UI state holding the current list search/filter/sort query
/// (Section 2.1: "Search state preserved across app restores within same
/// session"). A [StateProvider] keeps this in memory for the session.
final itemQueryProvider = StateProvider<ItemQuery>((ref) => const ItemQuery());

/// The filtered, sorted item list the list screen renders.
final filteredItemsProvider = Provider<AsyncValue<List<Item>>>((ref) {
  final query = ref.watch(itemQueryProvider);
  final items = ref.watch(allItemsProvider);
  return items.whenData(
    (list) => query.apply(list, today: AppDates.today()),
  );
});

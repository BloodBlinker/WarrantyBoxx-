import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/catalog_providers.dart';
import '../../data/providers/item_providers.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/item_query.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/status_format.dart';

/// Opens the filter bottom sheet (Blueprint Section 2.1 "Search and Filter").
Future<void> showFilterSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const FilterSheet(),
  );
}

/// Filter controls: category (multi-select) and status (multi-select).
class FilterSheet extends ConsumerWidget {
  /// Creates the filter sheet.
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final query = ref.watch(itemQueryProvider);
    final categories = ref.watch(categoriesProvider).valueOrNull ?? const [];
    final notifier = ref.read(itemQueryProvider.notifier);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.listFilter,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(l10n.itemFieldCategory,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final category in categories)
                  FilterChip(
                    label: Text(category.name),
                    selected: query.categoryIds.contains(category.id),
                    onSelected: (selected) {
                      final next = {...query.categoryIds};
                      selected ? next.add(category.id) : next.remove(category.id);
                      notifier.state = query.copyWith(categoryIds: next);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.listFilter,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final status in WarrantyStatus.values)
                  FilterChip(
                    label: Text(StatusFormat.status(l10n, status)),
                    selected: query.statuses.contains(status),
                    onSelected: (selected) {
                      final next = {...query.statuses};
                      selected ? next.add(status) : next.remove(status);
                      notifier.state = query.copyWith(statuses: next);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => notifier.state = const ItemQuery(),
                    child: Text(l10n.actionClearFilters),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.actionClose),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Sort dropdown for the item list (Blueprint Section 2.1).
class SortMenu extends ConsumerWidget {
  /// Creates the sort menu.
  const SortMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final query = ref.watch(itemQueryProvider);
    final notifier = ref.read(itemQueryProvider.notifier);

    String labelFor(ItemSortField field) => switch (field) {
          ItemSortField.expiryDate => l10n.sortExpiryDate,
          ItemSortField.purchaseDate => l10n.sortPurchaseDate,
          ItemSortField.name => l10n.sortName,
          ItemSortField.purchasePrice => l10n.sortPrice,
        };

    return PopupMenuButton<ItemSortField>(
      tooltip: l10n.listSortBy,
      onSelected: (field) {
        // Toggle direction when re-selecting the active field.
        final ascending =
            field == query.sortField ? !query.ascending : query.ascending;
        notifier.state =
            query.copyWith(sortField: field, ascending: ascending);
      },
      itemBuilder: (context) => [
        for (final field in ItemSortField.values)
          PopupMenuItem(
            value: field,
            child: Row(
              children: [
                Icon(
                  field == query.sortField
                      ? (query.ascending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward)
                      : Icons.sort,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(labelFor(field)),
              ],
            ),
          ),
      ],
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            const Icon(Icons.sort, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${l10n.listSortBy}: ${labelFor(query.sortField)}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              query.ascending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

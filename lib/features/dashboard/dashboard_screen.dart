import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../data/providers/item_providers.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/item.dart';
import '../../domain/models/item_query.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/empty_state.dart';
import '../item_list/filter_sheet.dart';
import '../item_list/item_card.dart';
import '../item_list/search_bar.dart';
import 'asset_tracker_card.dart';
import 'summary_strip.dart';

/// The default home screen: summary + searchable item list (Blueprint Sections
/// 5.3 "Dashboard" and "Item List / Search" — the same tab).
class DashboardScreen extends ConsumerWidget {
  /// Creates the dashboard screen.
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final allItems = ref.watch(allItemsProvider);
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final filtered = ref.watch(filteredItemsProvider);
    final query = ref.watch(itemQueryProvider);

    return allItems.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (items) {
        if (items.isEmpty) {
          return EmptyState(
            icon: Icons.shield_outlined,
            title: l10n.dashboardEmptyTitle,
            body: l10n.dashboardEmptyBody,
            actionLabel: l10n.dashboardAddFirstItem,
            onAction: () => context.push(Routes.itemNew),
          );
        }

        final summary = summaryAsync.valueOrNull;
        final visible = filtered.valueOrNull ?? const <Item>[];
        // Expired (unclaimed) items render in a collapsed section at the bottom
        // (Section 2.1). Claimed items live in the Archive tab, not here.
        final live = visible
            .where((i) =>
                i.status == WarrantyStatus.active ||
                i.status == WarrantyStatus.expiringSoon)
            .toList();
        final expired =
            visible.where((i) => i.status == WarrantyStatus.expired).toList();

        return CustomScrollView(
          slivers: [
            if (summary != null)
              SliverToBoxAdapter(
                child: SummaryStrip(
                  summary: summary,
                  onChipTap: (status) {
                    final notifier = ref.read(itemQueryProvider.notifier);
                    notifier.state = notifier.state.copyWith(
                      statuses: status == null ? <WarrantyStatus>{} : {status},
                    );
                  },
                ),
              ),
            if (summary != null)
              SliverToBoxAdapter(child: AssetTrackerCard(summary: summary)),
            const SliverToBoxAdapter(child: ItemSearchBar()),
            SliverToBoxAdapter(child: _FilterSortRow(query: query)),
            if (visible.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.search_off,
                  title: l10n.searchEmptyTitle,
                  body: l10n.searchEmptyBody,
                  actionLabel: l10n.actionClearFilters,
                  onAction: () => ref.read(itemQueryProvider.notifier).state =
                      const ItemQuery(),
                ),
              )
            else ...[
              SliverList.builder(
                itemCount: live.length,
                itemBuilder: (context, index) => ItemCard(
                  item: live[index],
                  onTap: () =>
                      context.push(Routes.itemDetailPath(live[index].id)),
                ),
              ),
              if (expired.isNotEmpty)
                SliverToBoxAdapter(
                  child: _ExpiredSection(items: expired),
                ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 88)),
          ],
        );
      },
    );
  }
}

/// Filter and sort controls row.
class _FilterSortRow extends ConsumerWidget {
  const _FilterSortRow({required this.query});

  final ItemQuery query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: () => showFilterSheet(context, ref),
            icon: Icon(
              query.hasActiveFilters
                  ? Icons.filter_alt
                  : Icons.filter_alt_outlined,
            ),
            label: Text(l10n.listFilter),
          ),
          const SizedBox(width: 8),
          const Expanded(child: SortMenu()),
        ],
      ),
    );
  }
}

/// Collapsible "Expired" section pinned at the bottom of the list.
class _ExpiredSection extends StatelessWidget {
  const _ExpiredSection({required this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text('${l10n.dashboardExpiredSection} (${items.length})'),
        leading: const Icon(Icons.history),
        childrenPadding: EdgeInsets.zero,
        children: [
          for (final item in items)
            Builder(
              builder: (context) => ItemCard(
                item: item,
                onTap: () => GoRouter.of(context)
                    .push(Routes.itemDetailPath(item.id)),
              ),
            ),
        ],
      ),
    );
  }
}

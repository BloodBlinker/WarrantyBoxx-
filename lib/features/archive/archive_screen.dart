import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../data/providers/item_providers.dart';
import '../../domain/models/enums.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/status_format.dart';
import '../../shared/widgets/empty_state.dart';
import '../item_list/item_card.dart';

/// Archive of claimed items, filterable by resolution (Blueprint Section 5.3
/// "Archive Screen").
class ArchiveScreen extends ConsumerStatefulWidget {
  /// Creates the archive screen.
  const ArchiveScreen({super.key});

  @override
  ConsumerState<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends ConsumerState<ArchiveScreen> {
  ClaimResolution? _filter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final claimed = ref.watch(claimedItemsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.archiveTitle)),
      body: claimed.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.inventory_2_outlined,
              title: l10n.archiveEmptyTitle,
              body: l10n.archiveEmptyBody,
            );
          }
          final filtered = _filter == null
              ? items
              : items.where((i) => i.claimResolution == _filter).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: Text(l10n.archiveTitle),
                        selected: _filter == null,
                        onSelected: (_) => setState(() => _filter = null),
                      ),
                      const SizedBox(width: 8),
                      for (final r in ClaimResolution.values) ...[
                        ChoiceChip(
                          label: Text(StatusFormat.resolution(l10n, r)),
                          selected: _filter == r,
                          onSelected: (_) => setState(() => _filter = r),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) => ItemCard(
                    item: filtered[index],
                    onTap: () => context
                        .push(Routes.itemDetailPath(filtered[index].id)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

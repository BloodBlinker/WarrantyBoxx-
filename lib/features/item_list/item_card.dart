import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/catalog_providers.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/item.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/category_icons.dart';
import '../../shared/utils/days_format.dart';
import '../../shared/widgets/health_arc.dart';
import '../../shared/widgets/status_badge.dart';

/// A single warranty item row on the dashboard / list (Blueprint Section 2.1).
class ItemCard extends ConsumerWidget {
  /// Creates an item card.
  const ItemCard({super.key, required this.item, required this.onTap});

  /// The item to render.
  final Item item;

  /// Tap handler — opens the item detail screen.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final category = ref.watch(categoriesByIdProvider)[item.categoryId];
    final status = item.status;
    final days = item.daysRemaining;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.secondaryContainer,
                child: Icon(
                  CategoryIcons.resolve(category?.iconName ?? 'category'),
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (item.brand != null && item.brand!.isNotEmpty)
                      Text(
                        item.brand!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        StatusBadge(status: status, daysRemaining: days),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            DaysFormat.forItem(
                              l10n,
                              status: status,
                              daysRemaining: days,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Small health indicator on the card (Section 2.1).
              if (status != WarrantyStatus.expired &&
                  status != WarrantyStatus.claimed)
                HealthArc(percent: item.healthScore, size: 40),
            ],
          ),
        ),
      ),
    );
  }
}

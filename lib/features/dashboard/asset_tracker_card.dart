import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../domain/models/dashboard_summary.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/currency_utils.dart';

/// "£X,XXX in active warranty coverage" card (Blueprint Section 2.1 "Lifetime
/// Asset Tracker"). Only shown when at least two active items have a price.
class AssetTrackerCard extends StatelessWidget {
  /// Creates the asset tracker card.
  const AssetTrackerCard({super.key, required this.summary});

  /// The aggregate statistics (must satisfy [DashboardSummary.showAssetTracker]).
  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    if (!summary.showAssetTracker) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final amount = AppCurrency.format(summary.assetValueSum);
    final accent = AppColors.brandSecondary(Theme.of(context).brightness);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: accent.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.savings_outlined, color: accent),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.dashboardAssetCoverage(amount),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

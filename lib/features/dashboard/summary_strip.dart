import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../domain/models/dashboard_summary.dart';
import '../../domain/models/enums.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/health_ring.dart';

/// The dashboard summary: health ring plus tappable status chips
/// (Blueprint Section 2.1 "Dashboard").
class SummaryStrip extends StatelessWidget {
  /// Creates the summary strip.
  const SummaryStrip({
    super.key,
    required this.summary,
    required this.onChipTap,
  });

  /// The aggregate statistics to display.
  final DashboardSummary summary;

  /// Called with the status a chip represents (null = "total", shows all).
  final void Function(WarrantyStatus? status) onChipTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;
    final ringPercent = (summary.healthRingRatio * 100).round();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              HealthRing(
                ratio: summary.healthRingRatio,
                centerLabel: '$ringPercent%',
                subLabel: l10n.dashboardActiveWarranties,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _SummaryChip(
                      icon: Icons.inventory_2_outlined,
                      label: l10n.dashboardTotalItems,
                      value: summary.totalItems,
                      color: AppColors.brandPrimary(brightness),
                      onTap: () => onChipTap(null),
                    ),
                    const SizedBox(height: 8),
                    _SummaryChip(
                      icon: Icons.check_circle_outline,
                      label: l10n.dashboardActiveWarranties,
                      value: summary.activeCount,
                      color: AppColors.active(brightness),
                      onTap: () => onChipTap(WarrantyStatus.active),
                    ),
                    const SizedBox(height: 8),
                    _SummaryChip(
                      icon: Icons.schedule,
                      label: l10n.dashboardExpiringSoon,
                      value: summary.expiringSoonCount,
                      color: AppColors.warning(brightness),
                      onTap: () => onChipTap(WarrantyStatus.expiringSoon),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (summary.activeCount + summary.expiringSoonCount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l10n.dashboardAverageHealth(summary.averageHealthScore.round()),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label: $value',
      child: Material(
        color: color.withValues(alpha: 0.10),
        borderRadius: const BorderRadius.all(AppRadii.chip),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(AppRadii.chip),
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 10),
                Expanded(child: Text(label)),
                Text(
                  '$value',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

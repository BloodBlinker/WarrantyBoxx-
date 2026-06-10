import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../domain/models/enums.dart';
import '../../l10n/app_localizations.dart';
import '../utils/status_format.dart';

/// A pill showing warranty status with both colour and icon+text, so status is
/// never communicated by colour alone (Blueprint Section 6.3).
class StatusBadge extends StatelessWidget {
  /// Creates a status badge.
  const StatusBadge({
    super.key,
    required this.status,
    this.daysRemaining = 0,
    this.compact = false,
  });

  /// The warranty status to display.
  final WarrantyStatus status;

  /// Days remaining, used to pick the critical vs warning shade.
  final int daysRemaining;

  /// Whether to render the icon-only compact form.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final visuals = StatusVisuals.of(
      status,
      daysRemaining: daysRemaining,
      brightness: Theme.of(context).brightness,
    );
    final label = StatusFormat.status(l10n, status);

    return Semantics(
      label: label,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 10,
          vertical: compact ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: visuals.color.withValues(alpha: 0.12),
          borderRadius: const BorderRadius.all(AppRadii.chip),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(visuals.icon, size: 16, color: visuals.color),
            if (!compact) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: visuals.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

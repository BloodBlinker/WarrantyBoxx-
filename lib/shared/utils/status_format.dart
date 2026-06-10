import '../../domain/models/enums.dart';
import '../../l10n/app_localizations.dart';

/// Maps domain enums to localised, human-readable labels.
///
/// Keeps all user-facing status text in the ARB file (Blueprint Section 11.3).
class StatusFormat {
  StatusFormat._();

  /// Localised label for a [WarrantyStatus].
  static String status(AppLocalizations l10n, WarrantyStatus status) =>
      switch (status) {
        WarrantyStatus.active => l10n.statusActive,
        WarrantyStatus.expiringSoon => l10n.statusExpiringSoon,
        WarrantyStatus.expired => l10n.statusExpired,
        WarrantyStatus.claimed => l10n.statusClaimed,
      };

  /// Localised label for a [ClaimResolution].
  static String resolution(AppLocalizations l10n, ClaimResolution resolution) =>
      switch (resolution) {
        ClaimResolution.repaired => l10n.resolutionRepaired,
        ClaimResolution.replaced => l10n.resolutionReplaced,
        ClaimResolution.refunded => l10n.resolutionRefunded,
        ClaimResolution.denied => l10n.resolutionDenied,
        ClaimResolution.pending => l10n.resolutionPending,
      };

  /// Human-readable status for CSV export (Appendix D: "Active, Expiring Soon,
  /// Expired, Claimed") — not localised, stable across locales.
  static String csvStatus(WarrantyStatus status) => switch (status) {
        WarrantyStatus.active => 'Active',
        WarrantyStatus.expiringSoon => 'Expiring Soon',
        WarrantyStatus.expired => 'Expired',
        WarrantyStatus.claimed => 'Claimed',
      };
}

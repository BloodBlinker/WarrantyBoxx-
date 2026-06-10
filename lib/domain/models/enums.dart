/// Domain enumerations shared across the data and UI layers.
///
/// These are pure Dart with no Flutter dependency (Blueprint Section 4.2).
library;

/// Derived warranty status of an item (Blueprint Sections 2.1, 3.6).
///
/// This is a *computed* value — it is never persisted (Section 3.2).
enum WarrantyStatus {
  /// More than 30 days of warranty remain.
  active,

  /// Warranty expires within the next 30 days (and is not yet expired).
  expiringSoon,

  /// Expiry date has passed and the item has not been claimed.
  expired,

  /// The user has marked the item as claimed.
  claimed;

  /// Stable string used for filtering and CSV serialisation.
  String get key => switch (this) {
        WarrantyStatus.active => 'active',
        WarrantyStatus.expiringSoon => 'expiring_soon',
        WarrantyStatus.expired => 'expired',
        WarrantyStatus.claimed => 'claimed',
      };
}

/// Resolution recorded when an item is claimed (Blueprint Sections 2.1, 3.2).
enum ClaimResolution {
  repaired,
  replaced,
  refunded,
  denied,
  pending;

  /// Stable persistence key.
  String get key => name;

  /// Parses a stored key back into a [ClaimResolution], or null if unknown.
  static ClaimResolution? fromKey(String? key) {
    if (key == null) return null;
    for (final value in ClaimResolution.values) {
      if (value.name == key) return value;
    }
    return null;
  }
}

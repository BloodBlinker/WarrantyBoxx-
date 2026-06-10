import 'enums.dart';
import 'item.dart';

/// Aggregate dashboard statistics derived from the full item list
/// (Blueprint Sections 2.1 "Dashboard" and 2.1 "Lifetime Asset Tracker").
class DashboardSummary {
  /// Creates a summary. Prefer [DashboardSummary.from] to compute one.
  const DashboardSummary({
    required this.totalItems,
    required this.activeCount,
    required this.expiringSoonCount,
    required this.expiredCount,
    required this.claimedCount,
    required this.healthRingRatio,
    required this.averageHealthScore,
    required this.assetValueSum,
    required this.pricedItemCount,
  });

  /// Total number of items (all statuses).
  final int totalItems;

  /// Count of active items (>30 days remaining, unclaimed).
  final int activeCount;

  /// Count of items expiring within 30 days (unclaimed).
  final int expiringSoonCount;

  /// Count of expired (unclaimed) items.
  final int expiredCount;

  /// Count of claimed/archived items.
  final int claimedCount;

  /// Ratio (0–1) of active to non-claimed items, for the health ring
  /// (Section 2.1 "Warranty Health Ring").
  final double healthRingRatio;

  /// Average health score across active items (0–100).
  final double averageHealthScore;

  /// Sum of purchase prices across active-warranty items (Section 2.1).
  final double assetValueSum;

  /// Number of active items that have a purchase price entered. The asset
  /// tracker is only shown when this is at least 2.
  final int pricedItemCount;

  /// Whether the lifetime asset tracker should be shown (Section 2.1: "Only
  /// shown when at least 2 items have a purchase price entered").
  bool get showAssetTracker => pricedItemCount >= 2;

  /// An empty summary (no items).
  static const empty = DashboardSummary(
    totalItems: 0,
    activeCount: 0,
    expiringSoonCount: 0,
    expiredCount: 0,
    claimedCount: 0,
    healthRingRatio: 0,
    averageHealthScore: 0,
    assetValueSum: 0,
    pricedItemCount: 0,
  );

  /// Computes a summary from [items] as of [today].
  factory DashboardSummary.from(List<Item> items, {required DateTime today}) {
    var active = 0;
    var expiringSoon = 0;
    var expired = 0;
    var claimed = 0;
    var assetSum = 0.0;
    var priced = 0;
    var healthSum = 0.0;

    for (final item in items) {
      switch (item.statusAsOf(today)) {
        case WarrantyStatus.active:
          active++;
          healthSum += item.healthScoreAsOf(today);
          if (item.purchasePrice != null) {
            assetSum += item.purchasePrice!;
            priced++;
          }
        case WarrantyStatus.expiringSoon:
          expiringSoon++;
          healthSum += item.healthScoreAsOf(today);
          if (item.purchasePrice != null) {
            assetSum += item.purchasePrice!;
            priced++;
          }
        case WarrantyStatus.expired:
          expired++;
        case WarrantyStatus.claimed:
          claimed++;
      }
    }

    final nonClaimed = active + expiringSoon + expired;
    final liveCount = active + expiringSoon;

    return DashboardSummary(
      totalItems: items.length,
      activeCount: active,
      expiringSoonCount: expiringSoon,
      expiredCount: expired,
      claimedCount: claimed,
      healthRingRatio: nonClaimed == 0 ? 0 : (active + expiringSoon) / nonClaimed,
      averageHealthScore: liveCount == 0 ? 0 : healthSum / liveCount,
      assetValueSum: assetSum,
      pricedItemCount: priced,
    );
  }
}

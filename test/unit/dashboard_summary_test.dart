import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/domain/models/dashboard_summary.dart';
import 'package:warranty_vault/domain/models/enums.dart';

import '../support/item_factory.dart';

void main() {
  final today = DateTime(2026, 6, 10);

  test('empty list yields the empty summary', () {
    final summary = DashboardSummary.from(const [], today: today);
    expect(summary.totalItems, 0);
    expect(summary.healthRingRatio, 0);
    expect(summary.showAssetTracker, isFalse);
  });

  test('counts each status correctly', () {
    final items = [
      // active: bought today, 24 months
      makeItem(id: 'a', purchaseDate: today, warrantyMonths: 24),
      // expiring soon: expires in ~20 days
      makeItem(
        id: 'b',
        purchaseDate: today.subtract(const Duration(days: 710)),
        warrantyMonths: 24,
      ),
      // expired
      makeItem(
        id: 'c',
        purchaseDate: today.subtract(const Duration(days: 800)),
        warrantyMonths: 12,
      ),
      // claimed
      makeItem(
        id: 'd',
        claimDate: today,
        claimResolution: ClaimResolution.repaired,
      ),
    ];

    final summary = DashboardSummary.from(items, today: today);
    expect(summary.totalItems, 4);
    expect(summary.activeCount, 1);
    expect(summary.expiringSoonCount, 1);
    expect(summary.expiredCount, 1);
    expect(summary.claimedCount, 1);
  });

  test('health ring ratio = live / non-claimed', () {
    final items = [
      makeItem(id: 'a', purchaseDate: today, warrantyMonths: 24), // active
      makeItem(
        id: 'b',
        purchaseDate: today.subtract(const Duration(days: 800)),
        warrantyMonths: 12,
      ), // expired
    ];
    final summary = DashboardSummary.from(items, today: today);
    // 1 live of 2 non-claimed.
    expect(summary.healthRingRatio, closeTo(0.5, 0.001));
  });

  test('asset tracker shown only with >= 2 priced active items', () {
    final one = DashboardSummary.from(
      [makeItem(id: 'a', purchaseDate: today, purchasePrice: 100)],
      today: today,
    );
    expect(one.showAssetTracker, isFalse);

    final two = DashboardSummary.from(
      [
        makeItem(id: 'a', purchaseDate: today, purchasePrice: 100),
        makeItem(id: 'b', purchaseDate: today, purchasePrice: 250),
      ],
      today: today,
    );
    expect(two.showAssetTracker, isTrue);
    expect(two.assetValueSum, 350);
  });

  test('expired items are excluded from asset value', () {
    final summary = DashboardSummary.from(
      [
        makeItem(id: 'a', purchaseDate: today, purchasePrice: 100),
        makeItem(id: 'b', purchaseDate: today, purchasePrice: 200),
        makeItem(
          id: 'c',
          purchaseDate: today.subtract(const Duration(days: 800)),
          warrantyMonths: 12,
          purchasePrice: 999,
        ),
      ],
      today: today,
    );
    expect(summary.assetValueSum, 300);
    expect(summary.pricedItemCount, 2);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/data/providers/catalog_providers.dart';
import 'package:warranty_vault/domain/models/category.dart';
import 'package:warranty_vault/domain/models/enums.dart';
import 'package:warranty_vault/features/item_list/item_card.dart';

import '../support/item_factory.dart';
import '../support/widget_harness.dart';

void main() {
  final today = DateTime.now();

  final categoryOverride = categoriesProvider.overrideWith(
    (ref) => Stream.value(const [
      Category(
        id: 'electronics',
        name: 'Electronics',
        iconName: 'devices',
        isSystem: true,
        sortOrder: 0,
      ),
    ]),
  );

  Future<void> pumpCard(WidgetTester tester, item) async {
    await tester.pumpWidget(
      harness(
        overrides: [categoryOverride],
        child: Scaffold(body: ItemCard(item: item, onTap: () {})),
      ),
    );
    await tester.pump();
  }

  testWidgets('renders active status', (tester) async {
    await pumpCard(
      tester,
      makeItem(name: 'Active Laptop', purchaseDate: today, warrantyMonths: 24),
    );
    expect(find.text('Active Laptop'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
  });

  testWidgets('renders expiring soon status', (tester) async {
    await pumpCard(
      tester,
      makeItem(
        name: 'Soon Item',
        purchaseDate: today.subtract(const Duration(days: 700)),
        warrantyMonths: 24,
      ),
    );
    expect(find.text('Expiring Soon'), findsOneWidget);
  });

  testWidgets('renders expired status', (tester) async {
    await pumpCard(
      tester,
      makeItem(
        name: 'Old Item',
        purchaseDate: today.subtract(const Duration(days: 1000)),
        warrantyMonths: 12,
      ),
    );
    expect(find.text('Expired'), findsOneWidget);
  });

  testWidgets('renders claimed status', (tester) async {
    await pumpCard(
      tester,
      makeItem(
        name: 'Claimed Item',
        claimDate: today,
        claimResolution: ClaimResolution.repaired,
      ),
    );
    expect(find.text('Claimed'), findsWidgets);
  });
}

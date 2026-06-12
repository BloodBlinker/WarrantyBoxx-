import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/data/providers/catalog_providers.dart';
import 'package:warranty_vault/data/providers/item_providers.dart';
import 'package:warranty_vault/domain/models/item.dart';
import 'package:warranty_vault/features/dashboard/dashboard_screen.dart';

import '../support/widget_harness.dart';

void main() {
  testWidgets('dashboard shows empty state when there are no items',
      (tester) async {
    await tester.pumpWidget(
      harness(
        overrides: [
          allItemsProvider.overrideWith((ref) => Stream.value(const <Item>[])),
          categoriesProvider.overrideWith((ref) => Stream.value(const [])),
        ],
        child: const Scaffold(body: DashboardScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Your WarrantyBoxx is empty'), findsOneWidget);
    expect(find.text('Add item'), findsOneWidget);
  });
}

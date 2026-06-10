import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warranty_vault/data/providers/catalog_providers.dart';
import 'package:warranty_vault/data/providers/preferences_providers.dart';
import 'package:warranty_vault/features/item_add_edit/add_edit_item_screen.dart';

import '../support/widget_harness.dart';

void main() {
  testWidgets('add-item form blocks save and shows error when name is empty',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      harness(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          categoriesProvider.overrideWith((ref) => Stream.value(const [])),
        ],
        child: const AddEditItemScreen(),
      ),
    );
    await tester.pump();

    // Tap Save without entering a name or warranty duration.
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Please enter an item name'), findsOneWidget);
    expect(
      find.text('Warranty must be between 1 and 360 months'),
      findsOneWidget,
    );
  });
}

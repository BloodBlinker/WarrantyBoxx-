import 'package:uuid/uuid.dart';

import '../../domain/models/enums.dart';
import '../../domain/models/item.dart';
import '../../domain/services/warranty_calculator.dart';
import '../../shared/utils/date_utils.dart';
import '../repositories/item_repository.dart';

/// Inserts a handful of representative items for local development only
/// (Blueprint Section 11.1, Phase 2). Never invoked in release builds.
class DebugSeeder {
  DebugSeeder._();

  static const _uuid = Uuid();

  /// Seeds five items spanning every status (active, expiring soon, critical,
  /// expired, claimed) so all UI states are exercisable without manual entry.
  static Future<void> seed(ItemRepository repository) async {
    final existing = await repository.getAll();
    if (existing.isNotEmpty) return; // never double-seed.

    final now = DateTime.now().toUtc();
    final today = AppDates.today();

    Item build({
      required String name,
      required String categoryId,
      required DateTime purchaseDate,
      required int warrantyMonths,
      String? brand,
      double? price,
      DateTime? claimDate,
      ClaimResolution? resolution,
    }) {
      final expiry = WarrantyCalculator.computeExpiry(
        purchaseDate: purchaseDate,
        warrantyMonths: warrantyMonths,
      );
      return Item(
        id: _uuid.v4(),
        name: name,
        categoryId: categoryId,
        purchaseDate: purchaseDate,
        warrantyMonths: warrantyMonths,
        expiryDate: expiry,
        reminderDays: const [30, 15, 7, 1],
        photoPaths: const [],
        brand: brand,
        purchasePrice: price,
        claimDate: claimDate,
        claimResolution: resolution,
        createdAt: now,
        updatedAt: now,
      );
    }

    final samples = <Item>[
      // Active: plenty of time left.
      build(
        name: 'Dell XPS 13 Laptop',
        categoryId: 'electronics',
        purchaseDate: AppDates.addMonths(today, -3),
        warrantyMonths: 24,
        brand: 'Dell',
        price: 1299.00,
      ),
      // Expiring soon (~20 days).
      build(
        name: 'Bosch Dishwasher',
        categoryId: 'appliances',
        purchaseDate: today.subtract(const Duration(days: 710)),
        warrantyMonths: 24,
        brand: 'Bosch',
        price: 499.99,
      ),
      // Critical (~4 days).
      build(
        name: 'DeWalt Drill',
        categoryId: 'tools',
        purchaseDate: today.subtract(const Duration(days: 361)),
        warrantyMonths: 12,
        brand: 'DeWalt',
        price: 129.50,
      ),
      // Expired.
      build(
        name: 'Old Microwave',
        categoryId: 'appliances',
        purchaseDate: AppDates.addMonths(today, -30),
        warrantyMonths: 12,
        brand: 'Panasonic',
        price: 89.00,
      ),
      // Claimed / archived.
      build(
        name: 'Samsung TV',
        categoryId: 'electronics',
        purchaseDate: AppDates.addMonths(today, -10),
        warrantyMonths: 24,
        brand: 'Samsung',
        price: 749.00,
        claimDate: today.subtract(const Duration(days: 5)),
        resolution: ClaimResolution.repaired,
      ),
    ];

    for (final item in samples) {
      await repository.save(item);
    }
  }
}

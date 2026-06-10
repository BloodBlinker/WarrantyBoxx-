import 'package:warranty_vault/domain/models/enums.dart';
import 'package:warranty_vault/domain/models/item.dart';
import 'package:warranty_vault/domain/services/warranty_calculator.dart';

/// Test helper for building [Item]s with sensible defaults.
Item makeItem({
  String id = 'id',
  String name = 'Item',
  String categoryId = 'electronics',
  DateTime? purchaseDate,
  int warrantyMonths = 24,
  double? purchasePrice,
  String? brand,
  String? retailer,
  String? serialNumber,
  String? notes,
  DateTime? claimDate,
  ClaimResolution? claimResolution,
}) {
  final purchase = purchaseDate ?? DateTime(2026, 1, 1);
  return Item(
    id: id,
    name: name,
    categoryId: categoryId,
    purchaseDate: purchase,
    warrantyMonths: warrantyMonths,
    expiryDate: WarrantyCalculator.computeExpiry(
      purchaseDate: purchase,
      warrantyMonths: warrantyMonths,
    ),
    reminderDays: const [30, 15, 7, 1],
    photoPaths: const [],
    purchasePrice: purchasePrice,
    brand: brand,
    retailer: retailer,
    serialNumber: serialNumber,
    notes: notes,
    claimDate: claimDate,
    claimResolution: claimResolution,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );
}

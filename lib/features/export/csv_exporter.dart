import 'package:csv/csv.dart';

import '../../domain/models/category.dart';
import '../../domain/models/item.dart';
import '../../shared/utils/currency_utils.dart';
import '../../shared/utils/date_utils.dart';
import '../../shared/utils/status_format.dart';

/// Serialises items to CSV in the exact column order of Appendix D.
///
/// Pure and fully testable: takes [today] and a category lookup so output is
/// deterministic (Blueprint Sections 6.5, Appendix D).
class CsvExporter {
  CsvExporter._();

  /// Header row (Appendix D column order).
  static const List<String> header = [
    'id',
    'name',
    'brand',
    'category',
    'purchase_date',
    'warranty_months',
    'expiry_date',
    'days_remaining',
    'status',
    'purchase_price',
    'retailer',
    'serial_number',
    'model_number',
    'notes',
    'photo_count',
    'claim_date',
    'claim_resolution',
    'fault_description',
    'manufacturer_contact',
    'created_at',
  ];

  /// Builds UTF-8 CSV text for [items].
  static String toCsv(
    List<Item> items, {
    required Map<String, Category> categoriesById,
    required DateTime today,
  }) {
    String s(String? v) => v ?? ''; // empty string for nulls (Appendix D).

    final rows = <List<String>>[header];
    for (final item in items) {
      rows.add([
        item.id,
        item.name,
        s(item.brand),
        s(categoriesById[item.categoryId]?.name),
        AppDates.iso.format(item.purchaseDate),
        '${item.warrantyMonths}',
        AppDates.iso.format(item.expiryDate),
        '${item.daysRemainingAsOf(today)}',
        StatusFormat.csvStatus(item.statusAsOf(today)),
        item.purchasePrice == null
            ? ''
            : AppCurrency.plainDecimal(item.purchasePrice!),
        s(item.retailer),
        s(item.serialNumber),
        s(item.modelNumber),
        s(item.notes),
        '${item.photoPaths.length}',
        item.claimDate == null ? '' : AppDates.iso.format(item.claimDate!),
        s(item.claimResolution?.key),
        s(item.faultDescription),
        s(item.manufacturerContact),
        AppDates.iso.format(item.createdAt),
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }
}

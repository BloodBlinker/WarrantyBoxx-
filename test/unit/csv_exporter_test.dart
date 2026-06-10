import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/domain/models/category.dart';
import 'package:warranty_vault/features/export/csv_exporter.dart';

import '../support/item_factory.dart';

void main() {
  final today = DateTime(2026, 6, 10);
  const categories = {
    'electronics': Category(
      id: 'electronics',
      name: 'Electronics',
      iconName: 'devices',
      isSystem: true,
      sortOrder: 0,
    ),
  };

  test('header matches Appendix D column order exactly', () {
    expect(CsvExporter.header, [
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
    ]);
  });

  test('row formats dates ISO 8601, price 2dp, status human-readable', () {
    final item = makeItem(
      id: 'i1',
      name: 'Laptop',
      brand: 'Dell',
      purchaseDate: DateTime(2026, 1, 1),
      warrantyMonths: 24,
      purchasePrice: 1200,
    );
    final csv = CsvExporter.toCsv([item],
        categoriesById: categories, today: today);
    final rows = const CsvToListConverter(eol: '\r\n', shouldParseNumbers: false)
        .convert(csv);

    expect(rows.length, 2); // header + 1
    final row = rows[1];
    expect(row[0], 'i1');
    expect(row[1], 'Laptop');
    expect(row[2], 'Dell');
    expect(row[3], 'Electronics');
    expect(row[4], '2026-01-01'); // ISO purchase date
    expect(row[5], '24');
    expect(row[6], '2028-01-01'); // ISO expiry
    expect(row[8], 'Active'); // human-readable status
    expect(row[9], '1200.00'); // 2 decimals, no symbol
  });

  test('empty optional fields are empty strings, not null', () {
    final item = makeItem(id: 'i2', name: 'Bare', purchaseDate: today);
    final csv = CsvExporter.toCsv([item],
        categoriesById: categories, today: today);
    final rows = const CsvToListConverter(eol: '\r\n', shouldParseNumbers: false)
        .convert(csv);
    final row = rows[1];
    expect(row[2], ''); // brand
    expect(row[9], ''); // price
    expect(row[10], ''); // retailer
    expect(row[15], ''); // claim_date
  });
}

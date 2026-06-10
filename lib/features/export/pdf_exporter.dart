import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../domain/models/category.dart';
import '../../domain/models/item.dart';
import '../../shared/utils/currency_utils.dart';
import '../../shared/utils/date_utils.dart';
import '../../shared/utils/status_format.dart';

/// Builds a formatted PDF summary report (Blueprint Section 2.1 "Data Export").
class PdfExporter {
  PdfExporter._();

  /// Generates PDF bytes listing [items] with status badges and a timestamp.
  static Future<Uint8List> build(
    List<Item> items, {
    required Map<String, Category> categoriesById,
    required DateTime today,
  }) async {
    final doc = pw.Document();
    final generated = DateTime.now();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text('WarrantyBoxx — Summary',
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Text('Generated: ${AppDates.iso.format(generated)}'),
          pw.Text('Items: ${items.length}'),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headers: const [
              'Item',
              'Category',
              'Expiry',
              'Status',
              'Price',
            ],
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration:
                const pw.BoxDecoration(color: PdfColor.fromInt(0xFF1E3A5F)),
            headerStyle: const pw.TextStyle(color: PdfColors.white),
            data: [
              for (final item in items)
                [
                  item.name,
                  categoriesById[item.categoryId]?.name ?? '',
                  AppDates.iso.format(item.expiryDate),
                  StatusFormat.csvStatus(item.statusAsOf(today)),
                  item.purchasePrice == null
                      ? ''
                      : AppCurrency.plainDecimal(item.purchasePrice!),
                ],
            ],
          ),
        ],
      ),
    );

    return doc.save();
  }
}

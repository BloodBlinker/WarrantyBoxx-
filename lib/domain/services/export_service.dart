import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/export/csv_exporter.dart';
import '../../features/export/pdf_exporter.dart';
import '../models/category.dart';
import '../models/item.dart';
import '../../shared/utils/date_utils.dart';

/// The available export formats (Blueprint Section 2.1 "Data Export").
enum ExportFormat { csv, pdf }

/// Generates export files and hands them to the system share sheet.
///
/// All exports are explicitly user-initiated and written to the app cache before
/// sharing — no automatic backup to any external service (Section 6.2).
class ExportService {
  /// Generates an export in [format] for [items] and opens the share sheet.
  Future<void> share(
    ExportFormat format,
    List<Item> items, {
    required Map<String, Category> categoriesById,
    required DateTime today,
  }) async {
    final dir = await getTemporaryDirectory();
    final stamp = AppDates.iso.format(DateTime.now());

    final XFile file;
    switch (format) {
      case ExportFormat.csv:
        final csv = CsvExporter.toCsv(items,
            categoriesById: categoriesById, today: today);
        final path = p.join(dir.path, 'warrantyboxx_$stamp.csv');
        await File(path).writeAsString(csv, encoding: utf8);
        file = XFile(path, mimeType: 'text/csv');
      case ExportFormat.pdf:
        final bytes = await PdfExporter.build(items,
            categoriesById: categoriesById, today: today);
        final path = p.join(dir.path, 'warrantyboxx_$stamp.pdf');
        await File(path).writeAsBytes(bytes);
        file = XFile(path, mimeType: 'application/pdf');
    }

    await Share.shareXFiles([file], subject: 'WarrantyBoxx export');
  }
}

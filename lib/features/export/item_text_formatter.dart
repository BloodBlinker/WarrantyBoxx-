import '../../domain/models/category.dart';
import '../../domain/models/item.dart';
import '../../shared/utils/currency_utils.dart';
import '../../shared/utils/date_utils.dart';

/// Formats a single item as plain text for sharing a claim reference
/// (Blueprint Section 2.1 "Data Export — Single-item share").
class ItemTextFormatter {
  ItemTextFormatter._();

  /// Builds a human-readable summary of [item] suitable for an email body.
  static String format(Item item, {Category? category}) {
    final buffer = StringBuffer()
      ..writeln('Warranty: ${item.name}')
      ..writeln('—————————————');
    if (item.brand != null) buffer.writeln('Brand: ${item.brand}');
    if (category != null) buffer.writeln('Category: ${category.name}');
    buffer
      ..writeln('Purchased: ${AppDates.iso.format(item.purchaseDate)}')
      ..writeln('Warranty: ${item.warrantyMonths} months')
      ..writeln('Expires: ${AppDates.iso.format(item.expiryDate)}');
    if (item.purchasePrice != null) {
      buffer.writeln('Price: ${AppCurrency.plainDecimal(item.purchasePrice!)}');
    }
    if (item.retailer != null) buffer.writeln('Retailer: ${item.retailer}');
    if (item.serialNumber != null) {
      buffer.writeln('Serial: ${item.serialNumber}');
    }
    if (item.modelNumber != null) buffer.writeln('Model: ${item.modelNumber}');
    if (item.manufacturerContact != null) {
      buffer.writeln('Manufacturer contact: ${item.manufacturerContact}');
    }
    if (item.faultDescription != null) {
      buffer.writeln('Fault: ${item.faultDescription}');
    }
    if (item.notes != null) buffer.writeln('Notes: ${item.notes}');
    return buffer.toString().trimRight();
  }
}

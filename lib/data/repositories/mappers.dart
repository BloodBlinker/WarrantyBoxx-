import 'package:drift/drift.dart';

import '../../domain/models/category.dart' as domain;
import '../../domain/models/claim_checklist.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/item.dart' as domain;
import '../../domain/models/template.dart' as domain;
import '../database/database.dart';

/// Converts between Drift data classes and pure domain models.
///
/// Keeping mapping in one place ensures the domain layer stays free of any
/// Drift dependency (Blueprint Section 4.2).
class Mappers {
  Mappers._();

  /// Drift item row -> domain [Item].
  static domain.Item itemToDomain(ItemRow row) => domain.Item(
        id: row.id,
        name: row.name,
        categoryId: row.categoryId,
        templateId: row.templateId,
        purchaseDate: row.purchaseDate,
        warrantyMonths: row.warrantyMonths,
        expiryDate: row.expiryDate,
        purchasePrice: row.purchasePrice,
        brand: row.brand,
        retailer: row.retailer,
        serialNumber: row.serialNumber,
        modelNumber: row.modelNumber,
        notes: row.notes,
        photoPaths: row.photoPaths,
        reminderDays: row.reminderDays,
        claimDate: row.claimDate,
        claimResolution: ClaimResolution.fromKey(row.claimResolution),
        claimNotes: row.claimNotes,
        faultDescription: row.faultDescription,
        manufacturerContact: row.manufacturerContact,
        claimChecklist: ClaimChecklist.fromJson(row.claimChecklist),
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  /// Domain [Item] -> Drift companion for insert/update. All columns are set so
  /// updates fully overwrite the row (claim fields are cleared by passing null).
  static ItemsCompanion itemToCompanion(domain.Item item) => ItemsCompanion(
        id: Value(item.id),
        name: Value(item.name),
        categoryId: Value(item.categoryId),
        templateId: Value(item.templateId),
        purchaseDate: Value(item.purchaseDate),
        warrantyMonths: Value(item.warrantyMonths),
        expiryDate: Value(item.expiryDate),
        purchasePrice: Value(item.purchasePrice),
        brand: Value(item.brand),
        retailer: Value(item.retailer),
        serialNumber: Value(item.serialNumber),
        modelNumber: Value(item.modelNumber),
        notes: Value(item.notes),
        photoPaths: Value(item.photoPaths),
        reminderDays: Value(item.reminderDays),
        claimDate: Value(item.claimDate),
        claimResolution: Value(item.claimResolution?.key),
        claimNotes: Value(item.claimNotes),
        faultDescription: Value(item.faultDescription),
        manufacturerContact: Value(item.manufacturerContact),
        claimChecklist: Value(item.claimChecklist.toJson()),
        createdAt: Value(item.createdAt),
        updatedAt: Value(item.updatedAt),
      );

  /// Drift category row -> domain [Category].
  static domain.Category categoryToDomain(CategoryRow row) => domain.Category(
        id: row.id,
        name: row.name,
        iconName: row.iconName,
        isSystem: row.isSystem,
        sortOrder: row.sortOrder,
      );

  /// Domain [Category] -> Drift companion.
  static CategoriesCompanion categoryToCompanion(domain.Category category) =>
      CategoriesCompanion(
        id: Value(category.id),
        name: Value(category.name),
        iconName: Value(category.iconName),
        isSystem: Value(category.isSystem),
        sortOrder: Value(category.sortOrder),
      );

  /// Drift template row -> domain [Template].
  static domain.Template templateToDomain(TemplateRow row) => domain.Template(
        id: row.id,
        name: row.name,
        categoryId: row.categoryId,
        warrantyMonths: row.warrantyMonths,
        reminderDays: row.reminderDays,
        isSystem: row.isSystem,
      );

  /// Domain [Template] -> Drift companion.
  static TemplatesCompanion templateToCompanion(domain.Template template) =>
      TemplatesCompanion(
        id: Value(template.id),
        name: Value(template.name),
        categoryId: Value(template.categoryId),
        warrantyMonths: Value(template.warrantyMonths),
        reminderDays: Value(template.reminderDays),
        isSystem: Value(template.isSystem),
      );
}

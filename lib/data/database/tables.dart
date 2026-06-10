import 'package:drift/drift.dart';

import 'converters.dart';

/// Category table (Blueprint Section 3.3).
@DataClassName('CategoryRow')
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get iconName => text()();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Template table (Blueprint Section 3.4).
@DataClassName('TemplateRow')
class Templates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get categoryId => text().references(Categories, #id)();
  IntColumn get warrantyMonths => integer()();
  TextColumn get reminderDays => text().map(const IntListConverter())();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Item table (Blueprint Section 3.2).
///
/// Indexed on [expiryDate] (primary sort) and [categoryId] (filter) per the
/// performance requirements (Section 6.1).
@TableIndex(name: 'idx_items_expiry', columns: {#expiryDate})
@TableIndex(name: 'idx_items_category', columns: {#categoryId})
@TableIndex(name: 'idx_items_claim_date', columns: {#claimDate})
@DataClassName('ItemRow')
class Items extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get categoryId =>
      text().references(Categories, #id).withDefault(const Constant('other'))();
  TextColumn get templateId => text().nullable()();

  DateTimeColumn get purchaseDate => dateTime()();
  IntColumn get warrantyMonths => integer()();
  DateTimeColumn get expiryDate => dateTime()();

  RealColumn get purchasePrice => real().nullable()();
  TextColumn get brand => text().nullable().withLength(max: 100)();
  TextColumn get retailer => text().nullable().withLength(max: 150)();
  TextColumn get serialNumber => text().nullable().withLength(max: 100)();
  TextColumn get modelNumber => text().nullable().withLength(max: 100)();
  TextColumn get notes => text().nullable().withLength(max: 1500)();

  TextColumn get photoPaths => text()
      .map(const StringListConverter())
      .withDefault(const Constant('[]'))();
  TextColumn get reminderDays => text().map(const IntListConverter())();

  // Claim / archive fields.
  DateTimeColumn get claimDate => dateTime().nullable()();
  TextColumn get claimResolution => text().nullable()();
  TextColumn get claimNotes => text().nullable().withLength(max: 500)();
  TextColumn get faultDescription => text().nullable().withLength(max: 500)();
  TextColumn get manufacturerContact => text().nullable().withLength(max: 300)();
  TextColumn get claimChecklist => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

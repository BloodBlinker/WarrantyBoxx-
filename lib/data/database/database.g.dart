// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconName,
    isSystem,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    } else if (isInserting) {
      context.missing(_iconNameMeta);
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final String id;
  final String name;
  final String iconName;
  final bool isSystem;
  final int sortOrder;
  const CategoryRow({
    required this.id,
    required this.name,
    required this.iconName,
    required this.isSystem,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon_name'] = Variable<String>(iconName);
    map['is_system'] = Variable<bool>(isSystem);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconName: Value(iconName),
      isSystem: Value(isSystem),
      sortOrder: Value(sortOrder),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String>(json['iconName']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String>(iconName),
      'isSystem': serializer.toJson<bool>(isSystem),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CategoryRow copyWith({
    String? id,
    String? name,
    String? iconName,
    bool? isSystem,
    int? sortOrder,
  }) => CategoryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    iconName: iconName ?? this.iconName,
    isSystem: isSystem ?? this.isSystem,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('isSystem: $isSystem, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconName, isSystem, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.isSystem == this.isSystem &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> iconName;
  final Value<bool> isSystem;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String iconName,
    this.isSystem = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       iconName = Value(iconName);
  static Insertable<CategoryRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? iconName,
    Expression<bool>? isSystem,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
      if (isSystem != null) 'is_system': isSystem,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? iconName,
    Value<bool>? isSystem,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      isSystem: isSystem ?? this.isSystem,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('isSystem: $isSystem, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, ItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warrantyMonthsMeta = const VerificationMeta(
    'warrantyMonths',
  );
  @override
  late final GeneratedColumn<int> warrantyMonths = GeneratedColumn<int>(
    'warranty_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retailerMeta = const VerificationMeta(
    'retailer',
  );
  @override
  late final GeneratedColumn<String> retailer = GeneratedColumn<String>(
    'retailer',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 150),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
    'serial_number',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelNumberMeta = const VerificationMeta(
    'modelNumber',
  );
  @override
  late final GeneratedColumn<String> modelNumber = GeneratedColumn<String>(
    'model_number',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> photoPaths =
      GeneratedColumn<String>(
        'photo_paths',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<String>>($ItemsTable.$converterphotoPaths);
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> reminderDays =
      GeneratedColumn<String>(
        'reminder_days',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<int>>($ItemsTable.$converterreminderDays);
  static const VerificationMeta _claimDateMeta = const VerificationMeta(
    'claimDate',
  );
  @override
  late final GeneratedColumn<DateTime> claimDate = GeneratedColumn<DateTime>(
    'claim_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _claimResolutionMeta = const VerificationMeta(
    'claimResolution',
  );
  @override
  late final GeneratedColumn<String> claimResolution = GeneratedColumn<String>(
    'claim_resolution',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _claimNotesMeta = const VerificationMeta(
    'claimNotes',
  );
  @override
  late final GeneratedColumn<String> claimNotes = GeneratedColumn<String>(
    'claim_notes',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _faultDescriptionMeta = const VerificationMeta(
    'faultDescription',
  );
  @override
  late final GeneratedColumn<String> faultDescription = GeneratedColumn<String>(
    'fault_description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufacturerContactMeta =
      const VerificationMeta('manufacturerContact');
  @override
  late final GeneratedColumn<String> manufacturerContact =
      GeneratedColumn<String>(
        'manufacturer_contact',
        aliasedName,
        true,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 300),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _claimChecklistMeta = const VerificationMeta(
    'claimChecklist',
  );
  @override
  late final GeneratedColumn<String> claimChecklist = GeneratedColumn<String>(
    'claim_checklist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    categoryId,
    templateId,
    purchaseDate,
    warrantyMonths,
    expiryDate,
    purchasePrice,
    brand,
    retailer,
    serialNumber,
    modelNumber,
    notes,
    photoPaths,
    reminderDays,
    claimDate,
    claimResolution,
    claimNotes,
    faultDescription,
    manufacturerContact,
    claimChecklist,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('warranty_months')) {
      context.handle(
        _warrantyMonthsMeta,
        warrantyMonths.isAcceptableOrUnknown(
          data['warranty_months']!,
          _warrantyMonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warrantyMonthsMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expiryDateMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('retailer')) {
      context.handle(
        _retailerMeta,
        retailer.isAcceptableOrUnknown(data['retailer']!, _retailerMeta),
      );
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    }
    if (data.containsKey('model_number')) {
      context.handle(
        _modelNumberMeta,
        modelNumber.isAcceptableOrUnknown(
          data['model_number']!,
          _modelNumberMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('claim_date')) {
      context.handle(
        _claimDateMeta,
        claimDate.isAcceptableOrUnknown(data['claim_date']!, _claimDateMeta),
      );
    }
    if (data.containsKey('claim_resolution')) {
      context.handle(
        _claimResolutionMeta,
        claimResolution.isAcceptableOrUnknown(
          data['claim_resolution']!,
          _claimResolutionMeta,
        ),
      );
    }
    if (data.containsKey('claim_notes')) {
      context.handle(
        _claimNotesMeta,
        claimNotes.isAcceptableOrUnknown(data['claim_notes']!, _claimNotesMeta),
      );
    }
    if (data.containsKey('fault_description')) {
      context.handle(
        _faultDescriptionMeta,
        faultDescription.isAcceptableOrUnknown(
          data['fault_description']!,
          _faultDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('manufacturer_contact')) {
      context.handle(
        _manufacturerContactMeta,
        manufacturerContact.isAcceptableOrUnknown(
          data['manufacturer_contact']!,
          _manufacturerContactMeta,
        ),
      );
    }
    if (data.containsKey('claim_checklist')) {
      context.handle(
        _claimChecklistMeta,
        claimChecklist.isAcceptableOrUnknown(
          data['claim_checklist']!,
          _claimChecklistMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
      warrantyMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warranty_months'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      ),
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      retailer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}retailer'],
      ),
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_number'],
      ),
      modelNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_number'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoPaths: $ItemsTable.$converterphotoPaths.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}photo_paths'],
        )!,
      ),
      reminderDays: $ItemsTable.$converterreminderDays.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminder_days'],
        )!,
      ),
      claimDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}claim_date'],
      ),
      claimResolution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}claim_resolution'],
      ),
      claimNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}claim_notes'],
      ),
      faultDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fault_description'],
      ),
      manufacturerContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer_contact'],
      ),
      claimChecklist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}claim_checklist'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterphotoPaths =
      const StringListConverter();
  static TypeConverter<List<int>, String> $converterreminderDays =
      const IntListConverter();
}

class ItemRow extends DataClass implements Insertable<ItemRow> {
  final String id;
  final String name;
  final String categoryId;
  final String? templateId;
  final DateTime purchaseDate;
  final int warrantyMonths;
  final DateTime expiryDate;
  final double? purchasePrice;
  final String? brand;
  final String? retailer;
  final String? serialNumber;
  final String? modelNumber;
  final String? notes;
  final List<String> photoPaths;
  final List<int> reminderDays;
  final DateTime? claimDate;
  final String? claimResolution;
  final String? claimNotes;
  final String? faultDescription;
  final String? manufacturerContact;
  final String? claimChecklist;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ItemRow({
    required this.id,
    required this.name,
    required this.categoryId,
    this.templateId,
    required this.purchaseDate,
    required this.warrantyMonths,
    required this.expiryDate,
    this.purchasePrice,
    this.brand,
    this.retailer,
    this.serialNumber,
    this.modelNumber,
    this.notes,
    required this.photoPaths,
    required this.reminderDays,
    this.claimDate,
    this.claimResolution,
    this.claimNotes,
    this.faultDescription,
    this.manufacturerContact,
    this.claimChecklist,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    map['warranty_months'] = Variable<int>(warrantyMonths);
    map['expiry_date'] = Variable<DateTime>(expiryDate);
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || retailer != null) {
      map['retailer'] = Variable<String>(retailer);
    }
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    if (!nullToAbsent || modelNumber != null) {
      map['model_number'] = Variable<String>(modelNumber);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['photo_paths'] = Variable<String>(
        $ItemsTable.$converterphotoPaths.toSql(photoPaths),
      );
    }
    {
      map['reminder_days'] = Variable<String>(
        $ItemsTable.$converterreminderDays.toSql(reminderDays),
      );
    }
    if (!nullToAbsent || claimDate != null) {
      map['claim_date'] = Variable<DateTime>(claimDate);
    }
    if (!nullToAbsent || claimResolution != null) {
      map['claim_resolution'] = Variable<String>(claimResolution);
    }
    if (!nullToAbsent || claimNotes != null) {
      map['claim_notes'] = Variable<String>(claimNotes);
    }
    if (!nullToAbsent || faultDescription != null) {
      map['fault_description'] = Variable<String>(faultDescription);
    }
    if (!nullToAbsent || manufacturerContact != null) {
      map['manufacturer_contact'] = Variable<String>(manufacturerContact);
    }
    if (!nullToAbsent || claimChecklist != null) {
      map['claim_checklist'] = Variable<String>(claimChecklist);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: Value(categoryId),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      purchaseDate: Value(purchaseDate),
      warrantyMonths: Value(warrantyMonths),
      expiryDate: Value(expiryDate),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      retailer: retailer == null && nullToAbsent
          ? const Value.absent()
          : Value(retailer),
      serialNumber: serialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(serialNumber),
      modelNumber: modelNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(modelNumber),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoPaths: Value(photoPaths),
      reminderDays: Value(reminderDays),
      claimDate: claimDate == null && nullToAbsent
          ? const Value.absent()
          : Value(claimDate),
      claimResolution: claimResolution == null && nullToAbsent
          ? const Value.absent()
          : Value(claimResolution),
      claimNotes: claimNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(claimNotes),
      faultDescription: faultDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(faultDescription),
      manufacturerContact: manufacturerContact == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturerContact),
      claimChecklist: claimChecklist == null && nullToAbsent
          ? const Value.absent()
          : Value(claimChecklist),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      warrantyMonths: serializer.fromJson<int>(json['warrantyMonths']),
      expiryDate: serializer.fromJson<DateTime>(json['expiryDate']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      brand: serializer.fromJson<String?>(json['brand']),
      retailer: serializer.fromJson<String?>(json['retailer']),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      modelNumber: serializer.fromJson<String?>(json['modelNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPaths: serializer.fromJson<List<String>>(json['photoPaths']),
      reminderDays: serializer.fromJson<List<int>>(json['reminderDays']),
      claimDate: serializer.fromJson<DateTime?>(json['claimDate']),
      claimResolution: serializer.fromJson<String?>(json['claimResolution']),
      claimNotes: serializer.fromJson<String?>(json['claimNotes']),
      faultDescription: serializer.fromJson<String?>(json['faultDescription']),
      manufacturerContact: serializer.fromJson<String?>(
        json['manufacturerContact'],
      ),
      claimChecklist: serializer.fromJson<String?>(json['claimChecklist']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<String>(categoryId),
      'templateId': serializer.toJson<String?>(templateId),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'warrantyMonths': serializer.toJson<int>(warrantyMonths),
      'expiryDate': serializer.toJson<DateTime>(expiryDate),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'brand': serializer.toJson<String?>(brand),
      'retailer': serializer.toJson<String?>(retailer),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'modelNumber': serializer.toJson<String?>(modelNumber),
      'notes': serializer.toJson<String?>(notes),
      'photoPaths': serializer.toJson<List<String>>(photoPaths),
      'reminderDays': serializer.toJson<List<int>>(reminderDays),
      'claimDate': serializer.toJson<DateTime?>(claimDate),
      'claimResolution': serializer.toJson<String?>(claimResolution),
      'claimNotes': serializer.toJson<String?>(claimNotes),
      'faultDescription': serializer.toJson<String?>(faultDescription),
      'manufacturerContact': serializer.toJson<String?>(manufacturerContact),
      'claimChecklist': serializer.toJson<String?>(claimChecklist),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ItemRow copyWith({
    String? id,
    String? name,
    String? categoryId,
    Value<String?> templateId = const Value.absent(),
    DateTime? purchaseDate,
    int? warrantyMonths,
    DateTime? expiryDate,
    Value<double?> purchasePrice = const Value.absent(),
    Value<String?> brand = const Value.absent(),
    Value<String?> retailer = const Value.absent(),
    Value<String?> serialNumber = const Value.absent(),
    Value<String?> modelNumber = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    List<String>? photoPaths,
    List<int>? reminderDays,
    Value<DateTime?> claimDate = const Value.absent(),
    Value<String?> claimResolution = const Value.absent(),
    Value<String?> claimNotes = const Value.absent(),
    Value<String?> faultDescription = const Value.absent(),
    Value<String?> manufacturerContact = const Value.absent(),
    Value<String?> claimChecklist = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ItemRow(
    id: id ?? this.id,
    name: name ?? this.name,
    categoryId: categoryId ?? this.categoryId,
    templateId: templateId.present ? templateId.value : this.templateId,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    warrantyMonths: warrantyMonths ?? this.warrantyMonths,
    expiryDate: expiryDate ?? this.expiryDate,
    purchasePrice: purchasePrice.present
        ? purchasePrice.value
        : this.purchasePrice,
    brand: brand.present ? brand.value : this.brand,
    retailer: retailer.present ? retailer.value : this.retailer,
    serialNumber: serialNumber.present ? serialNumber.value : this.serialNumber,
    modelNumber: modelNumber.present ? modelNumber.value : this.modelNumber,
    notes: notes.present ? notes.value : this.notes,
    photoPaths: photoPaths ?? this.photoPaths,
    reminderDays: reminderDays ?? this.reminderDays,
    claimDate: claimDate.present ? claimDate.value : this.claimDate,
    claimResolution: claimResolution.present
        ? claimResolution.value
        : this.claimResolution,
    claimNotes: claimNotes.present ? claimNotes.value : this.claimNotes,
    faultDescription: faultDescription.present
        ? faultDescription.value
        : this.faultDescription,
    manufacturerContact: manufacturerContact.present
        ? manufacturerContact.value
        : this.manufacturerContact,
    claimChecklist: claimChecklist.present
        ? claimChecklist.value
        : this.claimChecklist,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ItemRow copyWithCompanion(ItemsCompanion data) {
    return ItemRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      warrantyMonths: data.warrantyMonths.present
          ? data.warrantyMonths.value
          : this.warrantyMonths,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      brand: data.brand.present ? data.brand.value : this.brand,
      retailer: data.retailer.present ? data.retailer.value : this.retailer,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      modelNumber: data.modelNumber.present
          ? data.modelNumber.value
          : this.modelNumber,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPaths: data.photoPaths.present
          ? data.photoPaths.value
          : this.photoPaths,
      reminderDays: data.reminderDays.present
          ? data.reminderDays.value
          : this.reminderDays,
      claimDate: data.claimDate.present ? data.claimDate.value : this.claimDate,
      claimResolution: data.claimResolution.present
          ? data.claimResolution.value
          : this.claimResolution,
      claimNotes: data.claimNotes.present
          ? data.claimNotes.value
          : this.claimNotes,
      faultDescription: data.faultDescription.present
          ? data.faultDescription.value
          : this.faultDescription,
      manufacturerContact: data.manufacturerContact.present
          ? data.manufacturerContact.value
          : this.manufacturerContact,
      claimChecklist: data.claimChecklist.present
          ? data.claimChecklist.value
          : this.claimChecklist,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('templateId: $templateId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('warrantyMonths: $warrantyMonths, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('brand: $brand, ')
          ..write('retailer: $retailer, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('modelNumber: $modelNumber, ')
          ..write('notes: $notes, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('claimDate: $claimDate, ')
          ..write('claimResolution: $claimResolution, ')
          ..write('claimNotes: $claimNotes, ')
          ..write('faultDescription: $faultDescription, ')
          ..write('manufacturerContact: $manufacturerContact, ')
          ..write('claimChecklist: $claimChecklist, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    categoryId,
    templateId,
    purchaseDate,
    warrantyMonths,
    expiryDate,
    purchasePrice,
    brand,
    retailer,
    serialNumber,
    modelNumber,
    notes,
    photoPaths,
    reminderDays,
    claimDate,
    claimResolution,
    claimNotes,
    faultDescription,
    manufacturerContact,
    claimChecklist,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.templateId == this.templateId &&
          other.purchaseDate == this.purchaseDate &&
          other.warrantyMonths == this.warrantyMonths &&
          other.expiryDate == this.expiryDate &&
          other.purchasePrice == this.purchasePrice &&
          other.brand == this.brand &&
          other.retailer == this.retailer &&
          other.serialNumber == this.serialNumber &&
          other.modelNumber == this.modelNumber &&
          other.notes == this.notes &&
          other.photoPaths == this.photoPaths &&
          other.reminderDays == this.reminderDays &&
          other.claimDate == this.claimDate &&
          other.claimResolution == this.claimResolution &&
          other.claimNotes == this.claimNotes &&
          other.faultDescription == this.faultDescription &&
          other.manufacturerContact == this.manufacturerContact &&
          other.claimChecklist == this.claimChecklist &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ItemsCompanion extends UpdateCompanion<ItemRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> categoryId;
  final Value<String?> templateId;
  final Value<DateTime> purchaseDate;
  final Value<int> warrantyMonths;
  final Value<DateTime> expiryDate;
  final Value<double?> purchasePrice;
  final Value<String?> brand;
  final Value<String?> retailer;
  final Value<String?> serialNumber;
  final Value<String?> modelNumber;
  final Value<String?> notes;
  final Value<List<String>> photoPaths;
  final Value<List<int>> reminderDays;
  final Value<DateTime?> claimDate;
  final Value<String?> claimResolution;
  final Value<String?> claimNotes;
  final Value<String?> faultDescription;
  final Value<String?> manufacturerContact;
  final Value<String?> claimChecklist;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.warrantyMonths = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.brand = const Value.absent(),
    this.retailer = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.modelNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.claimDate = const Value.absent(),
    this.claimResolution = const Value.absent(),
    this.claimNotes = const Value.absent(),
    this.faultDescription = const Value.absent(),
    this.manufacturerContact = const Value.absent(),
    this.claimChecklist = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsCompanion.insert({
    required String id,
    required String name,
    this.categoryId = const Value.absent(),
    this.templateId = const Value.absent(),
    required DateTime purchaseDate,
    required int warrantyMonths,
    required DateTime expiryDate,
    this.purchasePrice = const Value.absent(),
    this.brand = const Value.absent(),
    this.retailer = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.modelNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPaths = const Value.absent(),
    required List<int> reminderDays,
    this.claimDate = const Value.absent(),
    this.claimResolution = const Value.absent(),
    this.claimNotes = const Value.absent(),
    this.faultDescription = const Value.absent(),
    this.manufacturerContact = const Value.absent(),
    this.claimChecklist = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       purchaseDate = Value(purchaseDate),
       warrantyMonths = Value(warrantyMonths),
       expiryDate = Value(expiryDate),
       reminderDays = Value(reminderDays),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ItemRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? categoryId,
    Expression<String>? templateId,
    Expression<DateTime>? purchaseDate,
    Expression<int>? warrantyMonths,
    Expression<DateTime>? expiryDate,
    Expression<double>? purchasePrice,
    Expression<String>? brand,
    Expression<String>? retailer,
    Expression<String>? serialNumber,
    Expression<String>? modelNumber,
    Expression<String>? notes,
    Expression<String>? photoPaths,
    Expression<String>? reminderDays,
    Expression<DateTime>? claimDate,
    Expression<String>? claimResolution,
    Expression<String>? claimNotes,
    Expression<String>? faultDescription,
    Expression<String>? manufacturerContact,
    Expression<String>? claimChecklist,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (templateId != null) 'template_id': templateId,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (warrantyMonths != null) 'warranty_months': warrantyMonths,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (brand != null) 'brand': brand,
      if (retailer != null) 'retailer': retailer,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (modelNumber != null) 'model_number': modelNumber,
      if (notes != null) 'notes': notes,
      if (photoPaths != null) 'photo_paths': photoPaths,
      if (reminderDays != null) 'reminder_days': reminderDays,
      if (claimDate != null) 'claim_date': claimDate,
      if (claimResolution != null) 'claim_resolution': claimResolution,
      if (claimNotes != null) 'claim_notes': claimNotes,
      if (faultDescription != null) 'fault_description': faultDescription,
      if (manufacturerContact != null)
        'manufacturer_contact': manufacturerContact,
      if (claimChecklist != null) 'claim_checklist': claimChecklist,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? categoryId,
    Value<String?>? templateId,
    Value<DateTime>? purchaseDate,
    Value<int>? warrantyMonths,
    Value<DateTime>? expiryDate,
    Value<double?>? purchasePrice,
    Value<String?>? brand,
    Value<String?>? retailer,
    Value<String?>? serialNumber,
    Value<String?>? modelNumber,
    Value<String?>? notes,
    Value<List<String>>? photoPaths,
    Value<List<int>>? reminderDays,
    Value<DateTime?>? claimDate,
    Value<String?>? claimResolution,
    Value<String?>? claimNotes,
    Value<String?>? faultDescription,
    Value<String?>? manufacturerContact,
    Value<String?>? claimChecklist,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      templateId: templateId ?? this.templateId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      expiryDate: expiryDate ?? this.expiryDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      brand: brand ?? this.brand,
      retailer: retailer ?? this.retailer,
      serialNumber: serialNumber ?? this.serialNumber,
      modelNumber: modelNumber ?? this.modelNumber,
      notes: notes ?? this.notes,
      photoPaths: photoPaths ?? this.photoPaths,
      reminderDays: reminderDays ?? this.reminderDays,
      claimDate: claimDate ?? this.claimDate,
      claimResolution: claimResolution ?? this.claimResolution,
      claimNotes: claimNotes ?? this.claimNotes,
      faultDescription: faultDescription ?? this.faultDescription,
      manufacturerContact: manufacturerContact ?? this.manufacturerContact,
      claimChecklist: claimChecklist ?? this.claimChecklist,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (warrantyMonths.present) {
      map['warranty_months'] = Variable<int>(warrantyMonths.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (retailer.present) {
      map['retailer'] = Variable<String>(retailer.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (modelNumber.present) {
      map['model_number'] = Variable<String>(modelNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPaths.present) {
      map['photo_paths'] = Variable<String>(
        $ItemsTable.$converterphotoPaths.toSql(photoPaths.value),
      );
    }
    if (reminderDays.present) {
      map['reminder_days'] = Variable<String>(
        $ItemsTable.$converterreminderDays.toSql(reminderDays.value),
      );
    }
    if (claimDate.present) {
      map['claim_date'] = Variable<DateTime>(claimDate.value);
    }
    if (claimResolution.present) {
      map['claim_resolution'] = Variable<String>(claimResolution.value);
    }
    if (claimNotes.present) {
      map['claim_notes'] = Variable<String>(claimNotes.value);
    }
    if (faultDescription.present) {
      map['fault_description'] = Variable<String>(faultDescription.value);
    }
    if (manufacturerContact.present) {
      map['manufacturer_contact'] = Variable<String>(manufacturerContact.value);
    }
    if (claimChecklist.present) {
      map['claim_checklist'] = Variable<String>(claimChecklist.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('templateId: $templateId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('warrantyMonths: $warrantyMonths, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('brand: $brand, ')
          ..write('retailer: $retailer, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('modelNumber: $modelNumber, ')
          ..write('notes: $notes, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('claimDate: $claimDate, ')
          ..write('claimResolution: $claimResolution, ')
          ..write('claimNotes: $claimNotes, ')
          ..write('faultDescription: $faultDescription, ')
          ..write('manufacturerContact: $manufacturerContact, ')
          ..write('claimChecklist: $claimChecklist, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemplatesTable extends Templates
    with TableInfo<$TemplatesTable, TemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _warrantyMonthsMeta = const VerificationMeta(
    'warrantyMonths',
  );
  @override
  late final GeneratedColumn<int> warrantyMonths = GeneratedColumn<int>(
    'warranty_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> reminderDays =
      GeneratedColumn<String>(
        'reminder_days',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<int>>($TemplatesTable.$converterreminderDays);
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    categoryId,
    warrantyMonths,
    reminderDays,
    isSystem,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('warranty_months')) {
      context.handle(
        _warrantyMonthsMeta,
        warrantyMonths.isAcceptableOrUnknown(
          data['warranty_months']!,
          _warrantyMonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warrantyMonthsMeta);
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      warrantyMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warranty_months'],
      )!,
      reminderDays: $TemplatesTable.$converterreminderDays.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminder_days'],
        )!,
      ),
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
    );
  }

  @override
  $TemplatesTable createAlias(String alias) {
    return $TemplatesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converterreminderDays =
      const IntListConverter();
}

class TemplateRow extends DataClass implements Insertable<TemplateRow> {
  final String id;
  final String name;
  final String categoryId;
  final int warrantyMonths;
  final List<int> reminderDays;
  final bool isSystem;
  const TemplateRow({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.warrantyMonths,
    required this.reminderDays,
    required this.isSystem,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<String>(categoryId);
    map['warranty_months'] = Variable<int>(warrantyMonths);
    {
      map['reminder_days'] = Variable<String>(
        $TemplatesTable.$converterreminderDays.toSql(reminderDays),
      );
    }
    map['is_system'] = Variable<bool>(isSystem);
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: Value(categoryId),
      warrantyMonths: Value(warrantyMonths),
      reminderDays: Value(reminderDays),
      isSystem: Value(isSystem),
    );
  }

  factory TemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      warrantyMonths: serializer.fromJson<int>(json['warrantyMonths']),
      reminderDays: serializer.fromJson<List<int>>(json['reminderDays']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<String>(categoryId),
      'warrantyMonths': serializer.toJson<int>(warrantyMonths),
      'reminderDays': serializer.toJson<List<int>>(reminderDays),
      'isSystem': serializer.toJson<bool>(isSystem),
    };
  }

  TemplateRow copyWith({
    String? id,
    String? name,
    String? categoryId,
    int? warrantyMonths,
    List<int>? reminderDays,
    bool? isSystem,
  }) => TemplateRow(
    id: id ?? this.id,
    name: name ?? this.name,
    categoryId: categoryId ?? this.categoryId,
    warrantyMonths: warrantyMonths ?? this.warrantyMonths,
    reminderDays: reminderDays ?? this.reminderDays,
    isSystem: isSystem ?? this.isSystem,
  );
  TemplateRow copyWithCompanion(TemplatesCompanion data) {
    return TemplateRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      warrantyMonths: data.warrantyMonths.present
          ? data.warrantyMonths.value
          : this.warrantyMonths,
      reminderDays: data.reminderDays.present
          ? data.reminderDays.value
          : this.reminderDays,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('warrantyMonths: $warrantyMonths, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('isSystem: $isSystem')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, categoryId, warrantyMonths, reminderDays, isSystem);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.warrantyMonths == this.warrantyMonths &&
          other.reminderDays == this.reminderDays &&
          other.isSystem == this.isSystem);
}

class TemplatesCompanion extends UpdateCompanion<TemplateRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> categoryId;
  final Value<int> warrantyMonths;
  final Value<List<int>> reminderDays;
  final Value<bool> isSystem;
  final Value<int> rowid;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.warrantyMonths = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemplatesCompanion.insert({
    required String id,
    required String name,
    required String categoryId,
    required int warrantyMonths,
    required List<int> reminderDays,
    this.isSystem = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       categoryId = Value(categoryId),
       warrantyMonths = Value(warrantyMonths),
       reminderDays = Value(reminderDays);
  static Insertable<TemplateRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? categoryId,
    Expression<int>? warrantyMonths,
    Expression<String>? reminderDays,
    Expression<bool>? isSystem,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (warrantyMonths != null) 'warranty_months': warrantyMonths,
      if (reminderDays != null) 'reminder_days': reminderDays,
      if (isSystem != null) 'is_system': isSystem,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? categoryId,
    Value<int>? warrantyMonths,
    Value<List<int>>? reminderDays,
    Value<bool>? isSystem,
    Value<int>? rowid,
  }) {
    return TemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      reminderDays: reminderDays ?? this.reminderDays,
      isSystem: isSystem ?? this.isSystem,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (warrantyMonths.present) {
      map['warranty_months'] = Variable<int>(warrantyMonths.value);
    }
    if (reminderDays.present) {
      map['reminder_days'] = Variable<String>(
        $TemplatesTable.$converterreminderDays.toSql(reminderDays.value),
      );
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('warrantyMonths: $warrantyMonths, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('isSystem: $isSystem, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $TemplatesTable templates = $TemplatesTable(this);
  late final Index idxItemsExpiry = Index(
    'idx_items_expiry',
    'CREATE INDEX idx_items_expiry ON items (expiry_date)',
  );
  late final Index idxItemsCategory = Index(
    'idx_items_category',
    'CREATE INDEX idx_items_category ON items (category_id)',
  );
  late final Index idxItemsClaimDate = Index(
    'idx_items_claim_date',
    'CREATE INDEX idx_items_claim_date ON items (claim_date)',
  );
  late final ItemDao itemDao = ItemDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final TemplateDao templateDao = TemplateDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    items,
    templates,
    idxItemsExpiry,
    idxItemsCategory,
    idxItemsClaimDate,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String name,
      required String iconName,
      Value<bool> isSystem,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> iconName,
      Value<bool> isSystem,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemsTable, List<ItemRow>> _itemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.items,
    aliasName: $_aliasNameGenerator(db.categories.id, db.items.categoryId),
  );

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TemplatesTable, List<TemplateRow>>
  _templatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templates,
    aliasName: $_aliasNameGenerator(db.categories.id, db.templates.categoryId),
  );

  $$TemplatesTableProcessedTableManager get templatesRefs {
    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_templatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> itemsRefs(
    Expression<bool> Function($$ItemsTableFilterComposer f) f,
  ) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> templatesRefs(
    Expression<bool> Function($$TemplatesTableFilterComposer f) f,
  ) {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> itemsRefs<T extends Object>(
    Expression<T> Function($$ItemsTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> templatesRefs<T extends Object>(
    Expression<T> Function($$TemplatesTableAnnotationComposer a) f,
  ) {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (CategoryRow, $$CategoriesTableReferences),
          CategoryRow,
          PrefetchHooks Function({bool itemsRefs, bool templatesRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                iconName: iconName,
                isSystem: isSystem,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String iconName,
                Value<bool> isSystem = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                iconName: iconName,
                isSystem: isSystem,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemsRefs = false, templatesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemsRefs) db.items,
                if (templatesRefs) db.templates,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemsRefs)
                    await $_getPrefetchedData<
                      CategoryRow,
                      $CategoriesTable,
                      ItemRow
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._itemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(db, table, p0).itemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                  if (templatesRefs)
                    await $_getPrefetchedData<
                      CategoryRow,
                      $CategoriesTable,
                      TemplateRow
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._templatesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).templatesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (CategoryRow, $$CategoriesTableReferences),
      CategoryRow,
      PrefetchHooks Function({bool itemsRefs, bool templatesRefs})
    >;
typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      required String id,
      required String name,
      Value<String> categoryId,
      Value<String?> templateId,
      required DateTime purchaseDate,
      required int warrantyMonths,
      required DateTime expiryDate,
      Value<double?> purchasePrice,
      Value<String?> brand,
      Value<String?> retailer,
      Value<String?> serialNumber,
      Value<String?> modelNumber,
      Value<String?> notes,
      Value<List<String>> photoPaths,
      required List<int> reminderDays,
      Value<DateTime?> claimDate,
      Value<String?> claimResolution,
      Value<String?> claimNotes,
      Value<String?> faultDescription,
      Value<String?> manufacturerContact,
      Value<String?> claimChecklist,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> categoryId,
      Value<String?> templateId,
      Value<DateTime> purchaseDate,
      Value<int> warrantyMonths,
      Value<DateTime> expiryDate,
      Value<double?> purchasePrice,
      Value<String?> brand,
      Value<String?> retailer,
      Value<String?> serialNumber,
      Value<String?> modelNumber,
      Value<String?> notes,
      Value<List<String>> photoPaths,
      Value<List<int>> reminderDays,
      Value<DateTime?> claimDate,
      Value<String?> claimResolution,
      Value<String?> claimNotes,
      Value<String?> faultDescription,
      Value<String?> manufacturerContact,
      Value<String?> claimChecklist,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, ItemRow> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias($_aliasNameGenerator(db.items.categoryId, db.categories.id));

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get warrantyMonths => $composableBuilder(
    column: $table.warrantyMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get retailer => $composableBuilder(
    column: $table.retailer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
  get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get claimDate => $composableBuilder(
    column: $table.claimDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get claimResolution => $composableBuilder(
    column: $table.claimResolution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get claimNotes => $composableBuilder(
    column: $table.claimNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get faultDescription => $composableBuilder(
    column: $table.faultDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturerContact => $composableBuilder(
    column: $table.manufacturerContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get claimChecklist => $composableBuilder(
    column: $table.claimChecklist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get warrantyMonths => $composableBuilder(
    column: $table.warrantyMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get retailer => $composableBuilder(
    column: $table.retailer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get claimDate => $composableBuilder(
    column: $table.claimDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get claimResolution => $composableBuilder(
    column: $table.claimResolution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get claimNotes => $composableBuilder(
    column: $table.claimNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get faultDescription => $composableBuilder(
    column: $table.faultDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturerContact => $composableBuilder(
    column: $table.manufacturerContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get claimChecklist => $composableBuilder(
    column: $table.claimChecklist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get warrantyMonths => $composableBuilder(
    column: $table.warrantyMonths,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get retailer =>
      $composableBuilder(column: $table.retailer, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get photoPaths =>
      $composableBuilder(
        column: $table.photoPaths,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<int>, String> get reminderDays =>
      $composableBuilder(
        column: $table.reminderDays,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get claimDate =>
      $composableBuilder(column: $table.claimDate, builder: (column) => column);

  GeneratedColumn<String> get claimResolution => $composableBuilder(
    column: $table.claimResolution,
    builder: (column) => column,
  );

  GeneratedColumn<String> get claimNotes => $composableBuilder(
    column: $table.claimNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get faultDescription => $composableBuilder(
    column: $table.faultDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get manufacturerContact => $composableBuilder(
    column: $table.manufacturerContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get claimChecklist => $composableBuilder(
    column: $table.claimChecklist,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          ItemRow,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (ItemRow, $$ItemsTableReferences),
          ItemRow,
          PrefetchHooks Function({bool categoryId})
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<int> warrantyMonths = const Value.absent(),
                Value<DateTime> expiryDate = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> retailer = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<String?> modelNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<List<String>> photoPaths = const Value.absent(),
                Value<List<int>> reminderDays = const Value.absent(),
                Value<DateTime?> claimDate = const Value.absent(),
                Value<String?> claimResolution = const Value.absent(),
                Value<String?> claimNotes = const Value.absent(),
                Value<String?> faultDescription = const Value.absent(),
                Value<String?> manufacturerContact = const Value.absent(),
                Value<String?> claimChecklist = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                name: name,
                categoryId: categoryId,
                templateId: templateId,
                purchaseDate: purchaseDate,
                warrantyMonths: warrantyMonths,
                expiryDate: expiryDate,
                purchasePrice: purchasePrice,
                brand: brand,
                retailer: retailer,
                serialNumber: serialNumber,
                modelNumber: modelNumber,
                notes: notes,
                photoPaths: photoPaths,
                reminderDays: reminderDays,
                claimDate: claimDate,
                claimResolution: claimResolution,
                claimNotes: claimNotes,
                faultDescription: faultDescription,
                manufacturerContact: manufacturerContact,
                claimChecklist: claimChecklist,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> categoryId = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                required DateTime purchaseDate,
                required int warrantyMonths,
                required DateTime expiryDate,
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> retailer = const Value.absent(),
                Value<String?> serialNumber = const Value.absent(),
                Value<String?> modelNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<List<String>> photoPaths = const Value.absent(),
                required List<int> reminderDays,
                Value<DateTime?> claimDate = const Value.absent(),
                Value<String?> claimResolution = const Value.absent(),
                Value<String?> claimNotes = const Value.absent(),
                Value<String?> faultDescription = const Value.absent(),
                Value<String?> manufacturerContact = const Value.absent(),
                Value<String?> claimChecklist = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion.insert(
                id: id,
                name: name,
                categoryId: categoryId,
                templateId: templateId,
                purchaseDate: purchaseDate,
                warrantyMonths: warrantyMonths,
                expiryDate: expiryDate,
                purchasePrice: purchasePrice,
                brand: brand,
                retailer: retailer,
                serialNumber: serialNumber,
                modelNumber: modelNumber,
                notes: notes,
                photoPaths: photoPaths,
                reminderDays: reminderDays,
                claimDate: claimDate,
                claimResolution: claimResolution,
                claimNotes: claimNotes,
                faultDescription: faultDescription,
                manufacturerContact: manufacturerContact,
                claimChecklist: claimChecklist,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ItemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$ItemsTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$ItemsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      ItemRow,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (ItemRow, $$ItemsTableReferences),
      ItemRow,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$TemplatesTableCreateCompanionBuilder =
    TemplatesCompanion Function({
      required String id,
      required String name,
      required String categoryId,
      required int warrantyMonths,
      required List<int> reminderDays,
      Value<bool> isSystem,
      Value<int> rowid,
    });
typedef $$TemplatesTableUpdateCompanionBuilder =
    TemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> categoryId,
      Value<int> warrantyMonths,
      Value<List<int>> reminderDays,
      Value<bool> isSystem,
      Value<int> rowid,
    });

final class $$TemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $TemplatesTable, TemplateRow> {
  $$TemplatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.templates.categoryId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get warrantyMonths => $composableBuilder(
    column: $table.warrantyMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
  get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get warrantyMonths => $composableBuilder(
    column: $table.warrantyMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get warrantyMonths => $composableBuilder(
    column: $table.warrantyMonths,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<int>, String> get reminderDays =>
      $composableBuilder(
        column: $table.reminderDays,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplatesTable,
          TemplateRow,
          $$TemplatesTableFilterComposer,
          $$TemplatesTableOrderingComposer,
          $$TemplatesTableAnnotationComposer,
          $$TemplatesTableCreateCompanionBuilder,
          $$TemplatesTableUpdateCompanionBuilder,
          (TemplateRow, $$TemplatesTableReferences),
          TemplateRow,
          PrefetchHooks Function({bool categoryId})
        > {
  $$TemplatesTableTableManager(_$AppDatabase db, $TemplatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> warrantyMonths = const Value.absent(),
                Value<List<int>> reminderDays = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemplatesCompanion(
                id: id,
                name: name,
                categoryId: categoryId,
                warrantyMonths: warrantyMonths,
                reminderDays: reminderDays,
                isSystem: isSystem,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String categoryId,
                required int warrantyMonths,
                required List<int> reminderDays,
                Value<bool> isSystem = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemplatesCompanion.insert(
                id: id,
                name: name,
                categoryId: categoryId,
                warrantyMonths: warrantyMonths,
                reminderDays: reminderDays,
                isSystem: isSystem,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$TemplatesTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$TemplatesTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplatesTable,
      TemplateRow,
      $$TemplatesTableFilterComposer,
      $$TemplatesTableOrderingComposer,
      $$TemplatesTableAnnotationComposer,
      $$TemplatesTableCreateCompanionBuilder,
      $$TemplatesTableUpdateCompanionBuilder,
      (TemplateRow, $$TemplatesTableReferences),
      TemplateRow,
      PrefetchHooks Function({bool categoryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$TemplatesTableTableManager get templates =>
      $$TemplatesTableTableManager(_db, _db.templates);
}

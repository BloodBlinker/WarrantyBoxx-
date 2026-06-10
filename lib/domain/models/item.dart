import '../../shared/utils/date_utils.dart';
import '../services/warranty_calculator.dart';
import 'claim_checklist.dart';
import 'enums.dart';

/// A warranty item — the central domain entity (Blueprint Section 3.2).
///
/// Pure value object with no Flutter or database dependency. Derived fields
/// ([status], [healthScore], [daysRemaining]) are computed on read and never
/// persisted (Section 3.6).
class Item {
  /// Creates an item. [expiryDate] should normally be obtained from
  /// [WarrantyCalculator.computeExpiry] rather than passed arbitrarily.
  const Item({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.purchaseDate,
    required this.warrantyMonths,
    required this.expiryDate,
    required this.reminderDays,
    required this.photoPaths,
    required this.createdAt,
    required this.updatedAt,
    this.brand,
    this.templateId,
    this.purchasePrice,
    this.retailer,
    this.serialNumber,
    this.modelNumber,
    this.notes,
    this.claimDate,
    this.claimResolution,
    this.claimNotes,
    this.faultDescription,
    this.manufacturerContact,
    this.claimChecklist = const ClaimChecklist(),
  });

  /// UUID v4 primary key.
  final String id;

  /// Item title. Max 200 chars.
  final String name;

  /// FK to [Category.id]. Defaults to "other".
  final String categoryId;

  /// FK to [Template.id] if created from a template. Nullable.
  final String? templateId;

  /// Purchase date (date-only, stored at 00:00:00).
  final DateTime purchaseDate;

  /// Warranty duration in whole months. 1–360.
  final int warrantyMonths;

  /// Auto-calculated expiry date. Never user-editable.
  final DateTime expiryDate;

  // --- Optional descriptive fields ---
  final String? brand;
  final double? purchasePrice;
  final String? retailer;
  final String? serialNumber;
  final String? modelNumber;
  final String? notes;

  /// Relative photo paths (max 5), relative to the photos base directory.
  final List<String> photoPaths;

  /// Reminder schedule: days before expiry to notify. Default [30, 15, 7, 1].
  final List<int> reminderDays;

  // --- Claim fields (Section 2.1, Claim Assistant) ---
  final DateTime? claimDate;
  final ClaimResolution? claimResolution;
  final String? claimNotes;
  final String? faultDescription;
  final String? manufacturerContact;
  final ClaimChecklist claimChecklist;

  // --- Audit timestamps (UTC) ---
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Whether the item has been claimed/archived.
  bool get isClaimed => claimDate != null;

  /// Derived [WarrantyStatus] as of [asOf] (defaults to today).
  WarrantyStatus statusAsOf([DateTime? asOf]) =>
      WarrantyCalculator.deriveStatus(
        expiryDate: expiryDate,
        today: asOf ?? AppDates.today(),
        isClaimed: isClaimed,
      );

  /// Derived [WarrantyStatus] as of today.
  WarrantyStatus get status => statusAsOf();

  /// Days until expiry as of [asOf] (negative if expired).
  int daysRemainingAsOf([DateTime? asOf]) => WarrantyCalculator.daysRemaining(
        expiryDate: expiryDate,
        today: asOf ?? AppDates.today(),
      );

  /// Days until expiry as of today (negative if expired).
  int get daysRemaining => daysRemainingAsOf();

  /// Health score (0–100) as of [asOf].
  double healthScoreAsOf([DateTime? asOf]) => WarrantyCalculator.healthScore(
        purchaseDate: purchaseDate,
        expiryDate: expiryDate,
        today: asOf ?? AppDates.today(),
      );

  /// Health score (0–100) as of today.
  double get healthScore => healthScoreAsOf();

  /// Returns a copy with the given fields replaced.
  ///
  /// Use the sentinel-free pattern: passing null keeps the existing value. To
  /// clear a nullable field, use the dedicated repository methods.
  Item copyWith({
    String? name,
    String? categoryId,
    String? templateId,
    DateTime? purchaseDate,
    int? warrantyMonths,
    DateTime? expiryDate,
    String? brand,
    double? purchasePrice,
    String? retailer,
    String? serialNumber,
    String? modelNumber,
    String? notes,
    List<String>? photoPaths,
    List<int>? reminderDays,
    DateTime? claimDate,
    ClaimResolution? claimResolution,
    String? claimNotes,
    String? faultDescription,
    String? manufacturerContact,
    ClaimChecklist? claimChecklist,
    DateTime? updatedAt,
  }) =>
      Item(
        id: id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        templateId: templateId ?? this.templateId,
        purchaseDate: purchaseDate ?? this.purchaseDate,
        warrantyMonths: warrantyMonths ?? this.warrantyMonths,
        expiryDate: expiryDate ?? this.expiryDate,
        brand: brand ?? this.brand,
        purchasePrice: purchasePrice ?? this.purchasePrice,
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
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}

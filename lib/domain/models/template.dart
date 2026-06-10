/// An item template that pre-fills the Add Item form (Blueprint Section 3.4).
class Template {
  /// Creates a template.
  const Template({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.warrantyMonths,
    required this.reminderDays,
    required this.isSystem,
  });

  /// UUID primary key.
  final String id;

  /// Template display name. Max 100 chars.
  final String name;

  /// FK to [Category.id] the template assigns.
  final String categoryId;

  /// Suggested warranty duration in whole months.
  final int warrantyMonths;

  /// Suggested reminder schedule (days before expiry).
  final List<int> reminderDays;

  /// True for built-in templates, which cannot be deleted.
  final bool isSystem;

  /// Returns a copy with the given fields replaced.
  Template copyWith({
    String? name,
    String? categoryId,
    int? warrantyMonths,
    List<int>? reminderDays,
  }) =>
      Template(
        id: id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        warrantyMonths: warrantyMonths ?? this.warrantyMonths,
        reminderDays: reminderDays ?? this.reminderDays,
        isSystem: isSystem,
      );
}

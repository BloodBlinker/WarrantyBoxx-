/// A warranty item category (Blueprint Section 3.3).
///
/// Pure value object — no Flutter or database dependency.
class Category {
  /// Creates a category.
  const Category({
    required this.id,
    required this.name,
    required this.iconName,
    required this.isSystem,
    required this.sortOrder,
  });

  /// UUID primary key. System categories use stable, human-readable ids.
  final String id;

  /// Display name. Max 80 chars, unique per user.
  final String name;

  /// Material icon name (e.g. "laptop"). No external assets (Section 3.3).
  final String iconName;

  /// True for predefined categories, which cannot be renamed or deleted.
  final bool isSystem;

  /// Display order in the category picker.
  final int sortOrder;

  /// Returns a copy with the given fields replaced.
  Category copyWith({
    String? name,
    String? iconName,
    int? sortOrder,
  }) =>
      Category(
        id: id,
        name: name ?? this.name,
        iconName: iconName ?? this.iconName,
        isSystem: isSystem,
        sortOrder: sortOrder ?? this.sortOrder,
      );
}

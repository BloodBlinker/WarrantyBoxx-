import '../../shared/utils/date_utils.dart';
import 'enums.dart';
import 'item.dart';

/// Fields the item list can be sorted by (Blueprint Section 2.1).
enum ItemSortField {
  expiryDate,
  purchaseDate,
  name,
  purchasePrice;

  /// Stable key for persistence (qualified to disambiguate the enum's `name`).
  String get key => this.name;
}

/// A search/filter/sort specification for the item list (Section 2.1).
///
/// Immutable; transient UI state holds the current value and applies it with
/// [apply].
class ItemQuery {
  /// Creates a query. Defaults: no filters, sort by expiry ascending.
  const ItemQuery({
    this.searchText = '',
    this.categoryIds = const {},
    this.statuses = const {},
    this.from,
    this.to,
    this.sortField = ItemSortField.expiryDate,
    this.ascending = true,
  });

  /// Free-text search across name, brand, retailer, serial number and notes.
  final String searchText;

  /// Selected category ids (empty = all categories).
  final Set<String> categoryIds;

  /// Selected statuses (empty = all statuses).
  final Set<WarrantyStatus> statuses;

  /// Inclusive lower bound on purchase date (null = unbounded).
  final DateTime? from;

  /// Inclusive upper bound on purchase date (null = unbounded).
  final DateTime? to;

  /// Field to sort by.
  final ItemSortField sortField;

  /// Sort direction.
  final bool ascending;

  /// Whether any filter (excluding default sort) is active.
  bool get hasActiveFilters =>
      searchText.isNotEmpty ||
      categoryIds.isNotEmpty ||
      statuses.isNotEmpty ||
      from != null ||
      to != null;

  /// Returns a copy with the given fields replaced.
  ItemQuery copyWith({
    String? searchText,
    Set<String>? categoryIds,
    Set<WarrantyStatus>? statuses,
    DateTime? from,
    DateTime? to,
    bool clearFrom = false,
    bool clearTo = false,
    ItemSortField? sortField,
    bool? ascending,
  }) =>
      ItemQuery(
        searchText: searchText ?? this.searchText,
        categoryIds: categoryIds ?? this.categoryIds,
        statuses: statuses ?? this.statuses,
        from: clearFrom ? null : (from ?? this.from),
        to: clearTo ? null : (to ?? this.to),
        sortField: sortField ?? this.sortField,
        ascending: ascending ?? this.ascending,
      );

  /// Applies this query to [items], returning a filtered, sorted list.
  ///
  /// Pure function — takes [today] explicitly so status filtering is testable.
  List<Item> apply(List<Item> items, {required DateTime today}) {
    final needle = searchText.trim().toLowerCase();

    final filtered = items.where((item) {
      if (needle.isNotEmpty) {
        final haystack = [
          item.name,
          item.brand ?? '',
          item.retailer ?? '',
          item.serialNumber ?? '',
          item.notes ?? '',
        ].join(' ').toLowerCase();
        if (!haystack.contains(needle)) return false;
      }

      if (categoryIds.isNotEmpty && !categoryIds.contains(item.categoryId)) {
        return false;
      }

      if (statuses.isNotEmpty && !statuses.contains(item.statusAsOf(today))) {
        return false;
      }

      if (from != null &&
          AppDates.dateOnly(item.purchaseDate).isBefore(AppDates.dateOnly(from!))) {
        return false;
      }
      if (to != null &&
          AppDates.dateOnly(item.purchaseDate).isAfter(AppDates.dateOnly(to!))) {
        return false;
      }

      return true;
    }).toList();

    filtered.sort((a, b) {
      final int cmp;
      switch (sortField) {
        case ItemSortField.expiryDate:
          cmp = a.expiryDate.compareTo(b.expiryDate);
        case ItemSortField.purchaseDate:
          cmp = a.purchaseDate.compareTo(b.purchaseDate);
        case ItemSortField.name:
          cmp = a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case ItemSortField.purchasePrice:
          cmp = (a.purchasePrice ?? 0).compareTo(b.purchasePrice ?? 0);
      }
      return ascending ? cmp : -cmp;
    });

    return filtered;
  }
}

import 'package:flutter/material.dart';

/// Maps stored category `icon_name` strings to Material [IconData]
/// (Blueprint Section 3.3 — no external icon assets).
class CategoryIcons {
  CategoryIcons._();

  static const Map<String, IconData> _icons = {
    'devices': Icons.devices,
    'kitchen': Icons.kitchen,
    'hardware': Icons.hardware,
    'chair': Icons.chair,
    'directions_car': Icons.directions_car,
    'sports': Icons.sports_tennis,
    'category': Icons.category,
    'laptop': Icons.laptop,
    'smartphone': Icons.smartphone,
    'tv': Icons.tv,
    'home': Icons.home,
    'build': Icons.build,
    'shopping_bag': Icons.shopping_bag,
    'star': Icons.star,
  };

  /// Icon names offered in the custom-category picker.
  static List<String> get selectableNames => _icons.keys.toList();

  /// Resolves [name] to an icon, falling back to a generic category icon.
  static IconData resolve(String name) => _icons[name] ?? Icons.category;
}

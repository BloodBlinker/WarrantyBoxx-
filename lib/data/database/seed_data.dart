import 'package:drift/drift.dart';

import 'database.dart';

/// Seed data for system categories and templates (Blueprint Appendices A & B).
///
/// These rows are inserted once, on database creation. System rows cannot be
/// deleted or renamed by the user.
class SeedData {
  SeedData._();

  /// Predefined categories (Appendix A). Stable ids double as FK targets.
  static List<CategoriesCompanion> categories() => const [
        CategoriesCompanion(
          id: Value('electronics'),
          name: Value('Electronics'),
          iconName: Value('devices'),
          isSystem: Value(true),
          sortOrder: Value(0),
        ),
        CategoriesCompanion(
          id: Value('appliances'),
          name: Value('Appliances'),
          iconName: Value('kitchen'),
          isSystem: Value(true),
          sortOrder: Value(1),
        ),
        CategoriesCompanion(
          id: Value('tools'),
          name: Value('Tools'),
          iconName: Value('hardware'),
          isSystem: Value(true),
          sortOrder: Value(2),
        ),
        CategoriesCompanion(
          id: Value('furniture'),
          name: Value('Furniture'),
          iconName: Value('chair'),
          isSystem: Value(true),
          sortOrder: Value(3),
        ),
        CategoriesCompanion(
          id: Value('vehicles'),
          name: Value('Vehicles'),
          iconName: Value('directions_car'),
          isSystem: Value(true),
          sortOrder: Value(4),
        ),
        CategoriesCompanion(
          id: Value('sports'),
          name: Value('Sports & Leisure'),
          iconName: Value('sports'),
          isSystem: Value(true),
          sortOrder: Value(5),
        ),
        CategoriesCompanion(
          id: Value('other'),
          name: Value('Other'),
          iconName: Value('category'),
          isSystem: Value(true),
          sortOrder: Value(99),
        ),
      ];

  /// Predefined templates (Appendix B).
  static List<TemplatesCompanion> templates() => const [
        TemplatesCompanion(
          id: Value('tpl_laptop'),
          name: Value('Laptop / PC'),
          categoryId: Value('electronics'),
          warrantyMonths: Value(24),
          reminderDays: Value([30, 7, 1]),
          isSystem: Value(true),
        ),
        TemplatesCompanion(
          id: Value('tpl_smartphone'),
          name: Value('Smartphone'),
          categoryId: Value('electronics'),
          warrantyMonths: Value(24),
          reminderDays: Value([30, 7, 1]),
          isSystem: Value(true),
        ),
        TemplatesCompanion(
          id: Value('tpl_tv'),
          name: Value('TV / Monitor'),
          categoryId: Value('electronics'),
          warrantyMonths: Value(24),
          reminderDays: Value([30, 15, 7, 1]),
          isSystem: Value(true),
        ),
        TemplatesCompanion(
          id: Value('tpl_washing_machine'),
          name: Value('Washing Machine'),
          categoryId: Value('appliances'),
          warrantyMonths: Value(24),
          reminderDays: Value([60, 30, 7]),
          isSystem: Value(true),
        ),
        TemplatesCompanion(
          id: Value('tpl_refrigerator'),
          name: Value('Refrigerator'),
          categoryId: Value('appliances'),
          warrantyMonths: Value(24),
          reminderDays: Value([60, 30, 7]),
          isSystem: Value(true),
        ),
        TemplatesCompanion(
          id: Value('tpl_dishwasher'),
          name: Value('Dishwasher'),
          categoryId: Value('appliances'),
          warrantyMonths: Value(24),
          reminderDays: Value([60, 30, 7]),
          isSystem: Value(true),
        ),
        TemplatesCompanion(
          id: Value('tpl_power_tool'),
          name: Value('Power Tool'),
          categoryId: Value('tools'),
          warrantyMonths: Value(12),
          reminderDays: Value([30, 7]),
          isSystem: Value(true),
        ),
        TemplatesCompanion(
          id: Value('tpl_vacuum'),
          name: Value('Vacuum Cleaner'),
          categoryId: Value('appliances'),
          warrantyMonths: Value(24),
          reminderDays: Value([30, 7]),
          isSystem: Value(true),
        ),
      ];
}

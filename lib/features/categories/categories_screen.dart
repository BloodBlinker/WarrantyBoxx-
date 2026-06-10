import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/providers/catalog_providers.dart';
import '../../data/providers/repository_providers.dart';
import '../../domain/models/category.dart';
import '../../data/repositories/category_repository.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/category_icons.dart';

/// Category management: list with counts, add/rename/delete (Blueprint Section
/// 2.1 "Categories"). System categories cannot be renamed or deleted.
class CategoriesScreen extends ConsumerWidget {
  /// Creates the categories screen.
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.categoriesTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCategoryEditor(context, ref, null),
        child: const Icon(Icons.add),
      ),
      body: categories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => ListView(
          children: [
            for (final category in list)
              _CategoryTile(category: category),
          ],
        ),
      ),
    );
  }

}

const _uuid = Uuid();

/// Opens the add/rename category dialog (top-level so list tiles can call it).
Future<void> showCategoryEditor(
  BuildContext context,
  WidgetRef ref,
  Category? existing,
) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController(text: existing?.name ?? '');
    var iconName = existing?.iconName ?? 'category';
    final messenger = ScaffoldMessenger.of(context);

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(existing == null ? l10n.categoryAdd : l10n.categoryRename),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                maxLength: 80,
                decoration: InputDecoration(labelText: l10n.itemFieldName),
              ),
              Wrap(
                spacing: 8,
                children: [
                  for (final name in CategoryIcons.selectableNames)
                    ChoiceChip(
                      label: Icon(CategoryIcons.resolve(name), size: 20),
                      selected: iconName == name,
                      onSelected: (_) => setState(() => iconName = name),
                    ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.actionSave),
            ),
          ],
        ),
      ),
    );

    if (saved != true || controller.text.trim().isEmpty) return;

    final repo = ref.read(categoryRepositoryProvider);
    final category = existing == null
        ? Category(
            id: _uuid.v4(),
            name: controller.text.trim(),
            iconName: iconName,
            isSystem: false,
            sortOrder: 50,
          )
        : existing.copyWith(name: controller.text.trim(), iconName: iconName);
    try {
      await repo.save(category);
    } on CategoryOperationException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
}

class _CategoryTile extends ConsumerWidget {
  const _CategoryTile({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final count = ref.watch(categoryItemCountProvider(category.id)).valueOrNull;

    return ListTile(
      leading: Icon(CategoryIcons.resolve(category.iconName)),
      title: Text(category.name),
      subtitle: count == null ? null : Text(l10n.categoryItemCount(count)),
      trailing: category.isSystem
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: l10n.categoryRename,
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => showCategoryEditor(context, ref, category),
                ),
                IconButton(
                  tooltip: l10n.actionDelete,
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _delete(context, ref, l10n),
                ),
              ],
            ),
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(categoryRepositoryProvider).delete(category.id);
    } on CategoryOperationException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

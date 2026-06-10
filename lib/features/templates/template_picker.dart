import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/catalog_providers.dart';
import '../../domain/models/template.dart';
import '../../l10n/app_localizations.dart';

/// Shows the template picker bottom sheet and returns the chosen [Template], or
/// null if dismissed (Blueprint Section 2.1 "Item Templates").
Future<Template?> showTemplatePicker(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<Template>(
    context: context,
    showDragHandle: true,
    builder: (_) => const _TemplatePickerSheet(),
  );
}

class _TemplatePickerSheet extends ConsumerWidget {
  const _TemplatePickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final templates = ref.watch(templatesProvider).valueOrNull ?? const [];
    final categories = ref.watch(categoriesByIdProvider);

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.templatesTitle,
                style: Theme.of(context).textTheme.titleLarge),
          ),
          for (final template in templates)
            ListTile(
              title: Text(template.name),
              subtitle: Text(
                '${categories[template.categoryId]?.name ?? ''} · '
                '${template.warrantyMonths} mo',
              ),
              onTap: () => Navigator.of(context).pop(template),
            ),
        ],
      ),
    );
  }
}

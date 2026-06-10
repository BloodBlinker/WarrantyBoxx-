import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/catalog_providers.dart';
import '../../data/providers/repository_providers.dart';
import '../../l10n/app_localizations.dart';

/// Template list with delete for user templates (Blueprint Section 5.3
/// "Templates Screen"). System templates cannot be deleted.
class TemplatesScreen extends ConsumerWidget {
  /// Creates the templates screen.
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final templates = ref.watch(templatesProvider);
    final categories = ref.watch(categoriesByIdProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.templatesTitle)),
      body: templates.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) => ListView(
          children: [
            for (final template in list)
              ListTile(
                leading: const Icon(Icons.dashboard_customize_outlined),
                title: Text(template.name),
                subtitle: Text(
                  '${categories[template.categoryId]?.name ?? ''} · '
                  '${template.warrantyMonths} mo · '
                  '${template.reminderDays.join(", ")}',
                ),
                trailing: template.isSystem
                    ? const Icon(Icons.lock_outline, size: 18)
                    : IconButton(
                        tooltip: l10n.actionDelete,
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => ref
                            .read(templateRepositoryProvider)
                            .delete(template.id),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}

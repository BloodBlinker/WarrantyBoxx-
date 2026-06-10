import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/catalog_providers.dart';
import '../../data/providers/export_providers.dart';
import '../../data/providers/item_providers.dart';
import '../../data/providers/preferences_providers.dart';
import '../../domain/services/export_service.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/date_utils.dart';

/// Export screen — choose CSV or PDF, preview the item count, export and share
/// (Blueprint Sections 2.1 "Data Export", 5.3 "Export Screen").
class ExportScreen extends ConsumerStatefulWidget {
  /// Creates the export screen.
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  ExportFormat _format = ExportFormat.csv;
  bool _busy = false;

  Future<void> _export() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await ref.read(exportServiceProvider).share(
            _format,
            ref.read(allItemsProvider).valueOrNull ?? const [],
            categoriesById: ref.read(categoriesByIdProvider),
            today: AppDates.today(),
          );
      await ref.read(preferencesServiceProvider).setLastExportNow();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.exportFailedSpace)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(allItemsProvider).valueOrNull ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.exportTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.exportChooseFormat,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          RadioGroup<ExportFormat>(
            groupValue: _format,
            onChanged: (v) => setState(() => _format = v ?? _format),
            child: Column(
              children: [
                RadioListTile<ExportFormat>(
                  value: ExportFormat.csv,
                  title: Text(l10n.exportCsv),
                ),
                RadioListTile<ExportFormat>(
                  value: ExportFormat.pdf,
                  title: Text(l10n.exportPdf),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(l10n.exportItemCount(items.length)),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _busy || items.isEmpty ? null : _export,
            icon: _busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.ios_share),
            label: Text(l10n.exportGenerate),
          ),
        ],
      ),
    );
  }
}

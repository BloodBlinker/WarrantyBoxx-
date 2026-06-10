import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../app/routes.dart';
import '../../data/providers/catalog_providers.dart';
import '../../data/providers/item_providers.dart';
import '../../data/providers/photo_providers.dart';
import '../../data/providers/repository_providers.dart';
import '../../data/providers/service_providers.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/item.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/currency_utils.dart';
import '../../shared/utils/date_utils.dart';
import '../../shared/utils/days_format.dart';
import '../../shared/widgets/health_arc.dart';
import '../../shared/widgets/status_badge.dart';
import '../export/item_text_formatter.dart';
import 'claim_assistant_sheet.dart';
import 'photo_viewer.dart';

/// Read-only item detail with actions (Blueprint Section 5.3 "Item Detail").
///
/// Opening an item with ≤30 days remaining auto-surfaces the Claim Assistant
/// (Section 2.1 "Claim Assistant Mode").
class ItemDetailScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const ItemDetailScreen({super.key, required this.itemId});

  /// The id of the item to show.
  final String itemId;

  @override
  ConsumerState<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen> {
  static const _uuid = Uuid();
  bool _autoClaimShown = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final itemAsync = ref.watch(itemByIdProvider(widget.itemId));

    return itemAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (item) {
        if (item == null) {
          return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
        }
        _maybeAutoShowClaim(item);
        return _buildDetail(context, l10n, item);
      },
    );
  }

  void _maybeAutoShowClaim(Item item) {
    final status = item.status;
    final eligible = status == WarrantyStatus.expiringSoon;
    if (eligible && !_autoClaimShown) {
      _autoClaimShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showClaimAssistant(context, ref, item);
      });
    }
  }

  Future<void> _confirmDelete(AppLocalizations l10n, Item item) async {
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteConfirmBody(item.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(itemServiceProvider).deleteItem(item);
      navigator.pop();
    }
  }

  Future<void> _share(Item item) async {
    final category = ref.read(categoriesByIdProvider)[item.categoryId];
    final text = ItemTextFormatter.format(item, category: category);
    await Share.share(text, subject: item.name);
  }

  Future<void> _saveAsTemplate(AppLocalizations l10n, Item item) async {
    final controller = TextEditingController(text: item.name);
    final messenger = ScaffoldMessenger.of(context);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.templateSaveFromItem),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 100,
          decoration: InputDecoration(labelText: l10n.itemFieldName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: Text(l10n.actionSave),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;

    final repo = ref.read(templateRepositoryProvider);
    await repo.save(repo.fromItem(id: _uuid.v4(), name: name, item: item));
    messenger.showSnackBar(SnackBar(content: Text(l10n.templatesTitle)));
  }

  Widget _buildDetail(BuildContext context, AppLocalizations l10n, Item item) {
    final theme = Theme.of(context);
    final category = ref.watch(categoriesByIdProvider)[item.categoryId];
    final status = item.status;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            tooltip: l10n.actionEdit,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push(Routes.itemEditPath(item.id)),
          ),
          IconButton(
            tooltip: l10n.actionShare,
            icon: const Icon(Icons.share_outlined),
            onPressed: () => _share(item),
          ),
          IconButton(
            tooltip: l10n.actionDelete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(l10n, item),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'template') _saveAsTemplate(l10n, item);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'template',
                child: Text(l10n.templateSaveFromItem),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              if (status != WarrantyStatus.expired &&
                  status != WarrantyStatus.claimed)
                HealthArc(percent: item.healthScore, size: 88),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusBadge(status: status, daysRemaining: item.daysRemaining),
                    const SizedBox(height: 8),
                    Text(
                      DaysFormat.forItem(
                        l10n,
                        status: status,
                        daysRemaining: item.daysRemaining,
                      ),
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (item.photoPaths.isNotEmpty) _PhotoGallery(item: item),
          const Divider(height: 32),
          _field(l10n.itemFieldCategory, category?.name),
          _field(l10n.itemFieldBrand, item.brand),
          _field(l10n.itemFieldPurchaseDate,
              AppDates.formatMedium(item.purchaseDate)),
          _field(l10n.itemFieldWarrantyMonths, '${item.warrantyMonths}'),
          _field(l10n.itemFieldExpiryDate,
              AppDates.formatMedium(item.expiryDate)),
          _field(
            l10n.itemFieldPurchasePrice,
            item.purchasePrice == null
                ? null
                : AppCurrency.format(item.purchasePrice!),
          ),
          _field(l10n.itemFieldRetailer, item.retailer),
          _field(l10n.itemFieldSerialNumber, item.serialNumber),
          _field(l10n.itemFieldModelNumber, item.modelNumber),
          _field(l10n.itemFieldNotes, item.notes),
          if (item.isClaimed) ...[
            const Divider(height: 32),
            _field(l10n.claimDate,
                item.claimDate == null ? null : AppDates.formatMedium(item.claimDate!)),
            _field(l10n.claimFieldResolution, item.claimResolution?.name),
            _field(l10n.claimFieldResolutionNotes, item.claimNotes),
          ],
          const SizedBox(height: 24),
          if (!item.isClaimed)
            FilledButton.icon(
              onPressed: () => showClaimAssistant(context, ref, item),
              icon: const Icon(Icons.assignment_turned_in_outlined),
              label: Text(l10n.actionPrepareClaim),
            ),
        ],
      ),
    );
  }

  Widget _field(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 2),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _PhotoGallery extends ConsumerWidget {
  const _PhotoGallery({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: item.photoPaths.length,
        itemBuilder: (context, index) {
          final path = item.photoPaths[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => PhotoViewer(
                    photoPaths: item.photoPaths,
                    altTexts: const [],
                    initialIndex: index,
                  ),
                ),
              ),
              child: FutureBuilder<File>(
                future: ref.read(photoServiceProvider).resolve(path),
                builder: (context, snapshot) {
                  final file = snapshot.data;
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: file != null && file.existsSync()
                        ? Image.file(file,
                            width: 88, height: 88, fit: BoxFit.cover)
                        : Container(
                            width: 88, height: 88, color: Colors.black12),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/providers/catalog_providers.dart';
import '../../data/providers/item_providers.dart';
import '../../data/providers/notification_providers.dart';
import '../../data/providers/preferences_providers.dart';
import '../../data/providers/service_providers.dart';
import '../../domain/models/item.dart';
import '../../domain/models/template.dart';
import '../../domain/services/warranty_calculator.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/utils/category_icons.dart';
import '../../shared/utils/date_utils.dart';
import '../../shared/utils/validators.dart';
import '../../shared/widgets/milestone.dart';
import '../templates/template_picker.dart';
import 'photo_section.dart';
import 'reminder_editor.dart';

/// Add or edit an item (Blueprint Section 5.3). [itemId] null => add mode.
class AddEditItemScreen extends ConsumerStatefulWidget {
  /// Creates the screen. Pass an existing [itemId] to edit.
  const AddEditItemScreen({super.key, this.itemId});

  /// The id of the item being edited, or null when adding.
  final String? itemId;

  @override
  ConsumerState<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends ConsumerState<AddEditItemScreen> {
  static const _uuid = Uuid();
  final _formKey = GlobalKey<FormState>();

  late String _id;
  final _name = TextEditingController();
  final _brand = TextEditingController();
  final _retailer = TextEditingController();
  final _serial = TextEditingController();
  final _model = TextEditingController();
  final _notes = TextEditingController();
  final _price = TextEditingController();
  final _warrantyMonths = TextEditingController();

  DateTime _purchaseDate = AppDates.today();
  String _categoryId = 'other';
  String? _templateId;
  List<int> _reminderDays = ReminderDefaults.defaultDays;
  List<String> _photoPaths = [];
  DateTime? _createdAt;
  bool _initialised = false;

  bool get _isEditing => widget.itemId != null;

  @override
  void initState() {
    super.initState();
    if (!_isEditing) {
      _id = _uuid.v4();
      _reminderDays = ref.read(preferencesServiceProvider).defaultReminderDays;
    }
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _brand,
      _retailer,
      _serial,
      _model,
      _notes,
      _price,
      _warrantyMonths,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _populateFrom(Item item) {
    _id = item.id;
    _name.text = item.name;
    _brand.text = item.brand ?? '';
    _retailer.text = item.retailer ?? '';
    _serial.text = item.serialNumber ?? '';
    _model.text = item.modelNumber ?? '';
    _notes.text = item.notes ?? '';
    _price.text = item.purchasePrice?.toString() ?? '';
    _warrantyMonths.text = item.warrantyMonths.toString();
    _purchaseDate = item.purchaseDate;
    _categoryId = item.categoryId;
    _templateId = item.templateId;
    _reminderDays = item.reminderDays;
    _photoPaths = [...item.photoPaths];
    _createdAt = item.createdAt;
  }

  void _applyTemplate(Template template) {
    setState(() {
      _templateId = template.id;
      _categoryId = template.categoryId;
      _warrantyMonths.text = template.warrantyMonths.toString();
      _reminderDays = [...template.reminderDays];
    });
  }

  DateTime? get _computedExpiry {
    final months = int.tryParse(_warrantyMonths.text.trim());
    if (months == null || months < 1) return null;
    return WarrantyCalculator.computeExpiry(
      purchaseDate: _purchaseDate,
      warrantyMonths: months,
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _purchaseDate,
      firstDate: DateTime(2000),
      lastDate: AppDates.today(),
    );
    if (picked != null) setState(() => _purchaseDate = AppDates.dateOnly(picked));
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;

    final months = int.parse(_warrantyMonths.text.trim());
    final expiry = WarrantyCalculator.computeExpiry(
      purchaseDate: _purchaseDate,
      warrantyMonths: months,
    );
    final price = _price.text.trim().isEmpty
        ? null
        : double.tryParse(_price.text.trim());

    String? orNull(String v) => v.trim().isEmpty ? null : v.trim();
    final now = DateTime.now().toUtc();

    final item = Item(
      id: _id,
      name: _name.text.trim(),
      categoryId: _categoryId,
      templateId: _templateId,
      purchaseDate: _purchaseDate,
      warrantyMonths: months,
      expiryDate: expiry,
      purchasePrice: price,
      brand: orNull(_brand.text),
      retailer: orNull(_retailer.text),
      serialNumber: orNull(_serial.text),
      modelNumber: orNull(_model.text),
      notes: orNull(_notes.text),
      photoPaths: _photoPaths,
      reminderDays: _reminderDays,
      createdAt: _createdAt ?? now,
      updatedAt: now,
    );

    final service = ref.read(itemServiceProvider);
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    if (_isEditing) {
      await service.updateItem(item);
      navigator.pop();
      return;
    }

    final result = await service.createItem(item);

    // Notification-permission rationale after the first item (Section 7.1).
    if (result.itemsAddedCount == 1 && mounted) {
      await _maybeRequestNotificationPermission(l10n);
    }

    navigator.pop();

    // First-item nudge / milestone messaging (Section 7.1, 7.3).
    if (item.expiryDate.isAfter(AppDates.today()) && _reminderDays.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.reminderSetSnackbar(_reminderDays.first.toString())),
        ),
      );
    }
    final milestone = milestoneMessage(l10n, result.itemsAddedCount);
    if (milestone != null) {
      messenger.showSnackBar(SnackBar(content: Text(milestone)));
    }
  }

  Future<void> _maybeRequestNotificationPermission(
      AppLocalizations l10n) async {
    final prefs = ref.read(preferencesServiceProvider);
    if (prefs.notificationRationaleShown) return;
    await prefs.setNotificationRationaleShown();
    if (!mounted) return;

    final proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(l10n.notificationPermissionRationale),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.photoSkip),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.photoGrantPermission),
          ),
        ],
      ),
    );
    if (proceed == true) {
      await ref.read(notificationServiceProvider).requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // In edit mode, load the item once and populate controllers.
    if (_isEditing && !_initialised) {
      final itemAsync = ref.watch(itemByIdProvider(widget.itemId!));
      return itemAsync.when(
        loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
        data: (item) {
          if (item == null) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: Text(l10n.itemEditTitle)),
            );
          }
          _populateFrom(item);
          _initialised = true;
          return _buildForm(context, l10n);
        },
      );
    }
    return _buildForm(context, l10n);
  }

  Widget _buildForm(BuildContext context, AppLocalizations l10n) {
    final categories = ref.watch(categoriesProvider).valueOrNull ?? const [];
    final expiry = _computedExpiry;
    final alreadyExpired =
        expiry != null && !expiry.isAfter(AppDates.today());

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.itemEditTitle : l10n.itemAddTitle),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(l10n.actionSave),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (!_isEditing)
              OutlinedButton.icon(
                onPressed: () async {
                  final template = await showTemplatePicker(context, ref);
                  if (template != null) _applyTemplate(template);
                },
                icon: const Icon(Icons.dashboard_customize_outlined),
                label: Text(l10n.itemUseTemplate),
              ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _name,
              maxLength: ItemLimits.nameMaxLength,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.itemFieldName),
              validator: (v) => Validators.itemName(l10n, v),
            ),
            DropdownButtonFormField<String>(
              initialValue: _categoryId,
              decoration: InputDecoration(labelText: l10n.itemFieldCategory),
              items: [
                for (final c in categories)
                  DropdownMenuItem(
                    value: c.id,
                    child: Row(
                      children: [
                        Icon(CategoryIcons.resolve(c.iconName), size: 18),
                        const SizedBox(width: 8),
                        Text(c.name),
                      ],
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _categoryId = v ?? 'other'),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.itemFieldPurchaseDate),
              subtitle: Text(AppDates.formatMedium(_purchaseDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            TextFormField(
              controller: _warrantyMonths,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: l10n.itemFieldWarrantyMonths),
              validator: (v) => Validators.warrantyMonths(l10n, v),
              onChanged: (_) => setState(() {}),
            ),
            if (expiry != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '${l10n.itemFieldExpiryDate}: ${AppDates.formatMedium(expiry)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            if (alreadyExpired)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l10n.warningAlreadyExpired,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            const Divider(height: 32),
            Text(l10n.itemSectionPhotos,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            PhotoSection(
              itemId: _id,
              photoPaths: _photoPaths,
              onChanged: (paths) => setState(() => _photoPaths = paths),
            ),
            const Divider(height: 32),
            Text(l10n.itemSectionDetails,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              controller: _brand,
              maxLength: ItemLimits.brandMaxLength,
              decoration: InputDecoration(labelText: l10n.itemFieldBrand),
            ),
            TextFormField(
              controller: _retailer,
              maxLength: ItemLimits.retailerMaxLength,
              decoration: InputDecoration(labelText: l10n.itemFieldRetailer),
            ),
            TextFormField(
              controller: _price,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: l10n.itemFieldPurchasePrice),
              validator: (v) => Validators.price(l10n, v),
            ),
            TextFormField(
              controller: _serial,
              maxLength: ItemLimits.serialModelMaxLength,
              decoration: InputDecoration(labelText: l10n.itemFieldSerialNumber),
            ),
            TextFormField(
              controller: _model,
              maxLength: ItemLimits.serialModelMaxLength,
              decoration: InputDecoration(labelText: l10n.itemFieldModelNumber),
            ),
            TextFormField(
              controller: _notes,
              maxLength: ItemLimits.notesMaxLength,
              maxLines: 3,
              decoration: InputDecoration(labelText: l10n.itemFieldNotes),
            ),
            const Divider(height: 32),
            Text(l10n.itemSectionReminders,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ReminderEditor(
              selectedDays: _reminderDays,
              onChanged: (days) => setState(() => _reminderDays = days),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

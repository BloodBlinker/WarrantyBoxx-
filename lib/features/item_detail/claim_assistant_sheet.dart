import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/service_providers.dart';
import '../../domain/models/claim_checklist.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/item.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/constants/app_constants.dart';

/// Opens the Claim Assistant bottom sheet for [item] (Blueprint Section 2.1
/// "Claim Assistant Mode").
Future<void> showClaimAssistant(
  BuildContext context,
  WidgetRef ref,
  Item item,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => ClaimAssistantSheet(item: item),
  );
}

/// The Claim Assistant: checklist, fault description, contact, mark-claimed.
class ClaimAssistantSheet extends ConsumerStatefulWidget {
  /// Creates the sheet.
  const ClaimAssistantSheet({super.key, required this.item});

  /// The item being prepared for a claim.
  final Item item;

  @override
  ConsumerState<ClaimAssistantSheet> createState() =>
      _ClaimAssistantSheetState();
}

class _ClaimAssistantSheetState extends ConsumerState<ClaimAssistantSheet> {
  late ClaimChecklist _checklist;
  late final TextEditingController _fault;
  late final TextEditingController _contact;

  @override
  void initState() {
    super.initState();
    _checklist = widget.item.claimChecklist;
    _fault = TextEditingController(text: widget.item.faultDescription ?? '');
    _contact =
        TextEditingController(text: widget.item.manufacturerContact ?? '');
  }

  @override
  void dispose() {
    _fault.dispose();
    _contact.dispose();
    super.dispose();
  }

  Item _currentItem() => widget.item.copyWith(
        claimChecklist: _checklist,
        faultDescription: _fault.text.trim().isEmpty ? null : _fault.text.trim(),
        manufacturerContact:
            _contact.text.trim().isEmpty ? null : _contact.text.trim(),
      );

  Future<void> _persist() async {
    await ref.read(itemServiceProvider).updateItem(_currentItem());
  }

  Future<void> _markClaimed() async {
    final l10n = AppLocalizations.of(context);
    // Receipt checklist gate (Section 5.6: prompt to add photo if none).
    if (!_checklist.receiptAttached && widget.item.photoPaths.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.claimReceiptPrompt)));
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final resolution = await _pickResolution(l10n);
    if (resolution == null) return;

    // Save claim fields first, then mark claimed.
    await _persist();
    await ref
        .read(itemServiceProvider)
        .markClaimed(_currentItem(), resolution: resolution.$1, notes: resolution.$2);
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.claimSuccessTitle)),
    );
  }

  Future<(ClaimResolution, String?)?> _pickResolution(
      AppLocalizations l10n) async {
    var resolution = ClaimResolution.repaired;
    final notes = TextEditingController();
    return showDialog<(ClaimResolution, String?)>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.claimDialogTitle),
          content: RadioGroup<ClaimResolution>(
            groupValue: resolution,
            onChanged: (v) => setState(() => resolution = v ?? resolution),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final r in ClaimResolution.values)
                  RadioListTile<ClaimResolution>(
                    value: r,
                    title: Text(_resolutionLabel(l10n, r)),
                  ),
                TextField(
                  controller: notes,
                  maxLength: ItemLimits.claimNotesMaxLength,
                  decoration: InputDecoration(
                      labelText: l10n.claimFieldResolutionNotes),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(
                (resolution, notes.text.trim().isEmpty ? null : notes.text.trim()),
              ),
              child: Text(l10n.claimMarkClaimed),
            ),
          ],
        ),
      ),
    );
  }

  String _resolutionLabel(AppLocalizations l10n, ClaimResolution r) =>
      switch (r) {
        ClaimResolution.repaired => l10n.resolutionRepaired,
        ClaimResolution.replaced => l10n.resolutionReplaced,
        ClaimResolution.refunded => l10n.resolutionRefunded,
        ClaimResolution.denied => l10n.resolutionDenied,
        ClaimResolution.pending => l10n.resolutionPending,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = widget.item.daysRemaining;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.claimAssistantTitle,
                style: Theme.of(context).textTheme.titleLarge),
            if (days <= 7 && days >= 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Chip(
                  avatar: const Icon(Icons.timer_outlined, size: 18),
                  label: Text(l10n.actNowDaysLeft(days)),
                ),
              ),
            const SizedBox(height: 8),
            _check(l10n.claimChecklistReceipt, _checklist.receiptAttached,
                (v) => _checklist = _checklist.copyWith(receiptAttached: v)),
            _check(l10n.claimChecklistSerial, _checklist.serialNoted,
                (v) => _checklist = _checklist.copyWith(serialNoted: v)),
            _check(l10n.claimChecklistContact, _checklist.contactSaved,
                (v) => _checklist = _checklist.copyWith(contactSaved: v)),
            _check(l10n.claimChecklistFault, _checklist.faultWritten,
                (v) => _checklist = _checklist.copyWith(faultWritten: v)),
            _check(l10n.claimChecklistProof, _checklist.proofReady,
                (v) => _checklist = _checklist.copyWith(proofReady: v)),
            const SizedBox(height: 8),
            TextField(
              controller: _fault,
              maxLength: ItemLimits.faultDescriptionMaxLength,
              maxLines: 3,
              decoration: InputDecoration(labelText: l10n.claimFieldFault),
            ),
            TextField(
              controller: _contact,
              maxLength: ItemLimits.manufacturerContactMaxLength,
              decoration: InputDecoration(labelText: l10n.claimFieldContact),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await _persist();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Text(l10n.actionSave),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _markClaimed,
                    child: Text(l10n.claimMarkClaimed),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _check(String label, bool value, void Function(bool) apply) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      title: Text(label),
      onChanged: (v) => setState(() => apply(v ?? false)),
    );
  }
}

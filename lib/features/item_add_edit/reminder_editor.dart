import 'package:flutter/material.dart';

/// Editor for an item's per-item reminder schedule (Blueprint Section 2.1 —
/// "Per-item override").
class ReminderEditor extends StatelessWidget {
  /// Creates the reminder editor.
  const ReminderEditor({
    super.key,
    required this.selectedDays,
    required this.onChanged,
  });

  /// Currently selected reminder offsets (days before expiry).
  final List<int> selectedDays;

  /// Called with the updated, sorted list when the selection changes.
  final ValueChanged<List<int>> onChanged;

  /// Common offsets offered as quick toggles.
  static const _presets = [60, 30, 15, 7, 1];

  void _toggle(int day) {
    final next = [...selectedDays];
    next.contains(day) ? next.remove(day) : next.add(day);
    next.sort((a, b) => b.compareTo(a));
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final day in _presets)
          FilterChip(
            label: Text('$day d'),
            selected: selectedDays.contains(day),
            onSelected: (_) => _toggle(day),
          ),
      ],
    );
  }
}

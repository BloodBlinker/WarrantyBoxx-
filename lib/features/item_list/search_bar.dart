import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/item_providers.dart';
import '../../l10n/app_localizations.dart';

/// Always-visible search field that updates [itemQueryProvider] with a 100ms
/// debounce (Blueprint Section 6.1: "Under 100ms debounce").
class ItemSearchBar extends ConsumerStatefulWidget {
  /// Creates the search bar.
  const ItemSearchBar({super.key});

  @override
  ConsumerState<ItemSearchBar> createState() => _ItemSearchBarState();
}

class _ItemSearchBarState extends ConsumerState<ItemSearchBar> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Restore any session search text (Section 2.1: state preserved in session).
    _controller =
        TextEditingController(text: ref.read(itemQueryProvider).searchText);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      final notifier = ref.read(itemQueryProvider.notifier);
      notifier.state = notifier.state.copyWith(searchText: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: l10n.listSearchHint,
          prefixIcon: const Icon(Icons.search),
          isDense: true,
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: l10n.actionClearFilters,
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _onChanged('');
                    setState(() {});
                  },
                ),
        ),
      ),
    );
  }
}

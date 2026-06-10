import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/photo_providers.dart';
import '../../l10n/app_localizations.dart';

/// Full-screen photo viewer with pinch-to-zoom and swipe between photos
/// (Blueprint Section 2.1 "Photo Attachment and Viewer").
class PhotoViewer extends ConsumerStatefulWidget {
  /// Creates the viewer.
  const PhotoViewer({
    super.key,
    required this.photoPaths,
    required this.altTexts,
    this.initialIndex = 0,
  });

  /// Relative photo paths to display.
  final List<String> photoPaths;

  /// Optional alt text per photo, read aloud by screen readers (Section 6.3).
  final List<String> altTexts;

  /// Index of the first photo to show.
  final int initialIndex;

  @override
  ConsumerState<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends ConsumerState<PhotoViewer> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_index + 1} / ${widget.photoPaths.length}'),
        actions: [
          IconButton(
            tooltip: l10n.actionClose,
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.photoPaths.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, index) {
          final alt = index < widget.altTexts.length
              ? widget.altTexts[index]
              : widget.photoPaths[index];
          return Semantics(
            label: alt,
            image: true,
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: Center(
                child: FutureBuilder<File>(
                  future:
                      ref.read(photoServiceProvider).resolve(widget.photoPaths[index]),
                  builder: (context, snapshot) {
                    final file = snapshot.data;
                    if (file == null || !file.existsSync()) {
                      return const SizedBox.shrink();
                    }
                    return Image.file(file, fit: BoxFit.contain);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

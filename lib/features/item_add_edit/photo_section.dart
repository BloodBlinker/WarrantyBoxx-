import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/photo_providers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/constants/app_constants.dart';

/// Photo attach/remove section used in the Add/Edit form (Blueprint Section 2.1
/// "Photo Attachment"). Up to 5 photos; camera or gallery.
class PhotoSection extends ConsumerWidget {
  /// Creates the photo section.
  const PhotoSection({
    super.key,
    required this.itemId,
    required this.photoPaths,
    required this.onChanged,
  });

  /// The id of the item the photos belong to (used as the storage sub-folder).
  final String itemId;

  /// Current relative photo paths.
  final List<String> photoPaths;

  /// Called with the new list when a photo is added or removed.
  final ValueChanged<List<String>> onChanged;

  Future<void> _add(BuildContext context, WidgetRef ref, bool fromCamera) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final service = ref.read(photoServiceProvider);
    try {
      final path = fromCamera
          ? await service.importFromCamera(itemId)
          : await service.importFromGallery(itemId);
      if (path != null) onChanged([...photoPaths, path]);
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.photoImportFailed)),
      );
    }
  }

  Future<void> _remove(WidgetRef ref, String path) async {
    await ref.read(photoServiceProvider).deletePhoto(path);
    onChanged([...photoPaths]..remove(path));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final atLimit = photoPaths.length >= ItemLimits.maxPhotos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 96,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final path in photoPaths)
                _Thumbnail(
                  relativePath: path,
                  onRemove: () => _remove(ref, path),
                ),
              if (!atLimit)
                Row(
                  children: [
                    _AddButton(
                      icon: Icons.photo_camera_outlined,
                      label: l10n.photoTakePhoto,
                      onTap: () => _add(context, ref, true),
                    ),
                    _AddButton(
                      icon: Icons.photo_library_outlined,
                      label: l10n.photoChooseGallery,
                      onTap: () => _add(context, ref, false),
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (atLimit)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              l10n.photoMaxReached,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

class _Thumbnail extends ConsumerWidget {
  const _Thumbnail({required this.relativePath, required this.onRemove});

  final String relativePath;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<File>(
      future: ref.read(photoServiceProvider).resolve(relativePath),
      builder: (context, snapshot) {
        final file = snapshot.data;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: file != null && file.existsSync()
                    ? Image.file(file, width: 88, height: 88, fit: BoxFit.cover)
                    : Container(width: 88, height: 88, color: Colors.black12),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onRemove,
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(icon, semanticLabel: label),
          ),
        ),
      ),
    );
  }
}

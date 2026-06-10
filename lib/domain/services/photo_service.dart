import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../shared/constants/app_constants.dart';

/// Manages photo import, compression, storage and deletion (Blueprint Sections
/// 2.1 "Photo Attachment" and 4.3 "Photo Storage").
///
/// Photos are stored in app-private storage as relative paths; image bytes are
/// never stored in SQLite. Imported photos are compressed to a max 1024px edge
/// at JPEG quality 80; originals are not retained.
class PhotoService {
  /// Creates a photo service.
  PhotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;
  static const _uuid = Uuid();

  /// Base directory for all photos: `<app documents>/photos`.
  Future<Directory> _baseDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, PhotoConstants.photosDirName));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  /// Resolves an absolute file for a stored relative photo [path].
  Future<File> resolve(String relativePath) async {
    final base = await _baseDir();
    return File(p.join(base.path, relativePath));
  }

  /// Captures a photo with the camera and imports it for [itemId]. Returns the
  /// stored relative path, or null if the user cancelled.
  Future<String?> importFromCamera(String itemId) =>
      _import(itemId, ImageSource.camera);

  /// Picks a photo from the gallery and imports it for [itemId]. Returns the
  /// stored relative path, or null if the user cancelled.
  Future<String?> importFromGallery(String itemId) =>
      _import(itemId, ImageSource.gallery);

  Future<String?> _import(String itemId, ImageSource source) async {
    final picked = await _picker.pickImage(source: source);
    if (picked == null) return null;

    final base = await _baseDir();
    final itemDir = Directory(p.join(base.path, itemId));
    if (!await itemDir.exists()) await itemDir.create(recursive: true);

    final filename = '${_uuid.v4()}.jpg';
    final targetPath = p.join(itemDir.path, filename);

    // Compress on a background isolate (the plugin runs natively, off the UI
    // thread) to a max 1024px edge at quality 80 (Section 2.1).
    final result = await FlutterImageCompress.compressAndGetFile(
      picked.path,
      targetPath,
      quality: PhotoConstants.jpegQuality,
      minWidth: PhotoConstants.maxLongestEdge,
      minHeight: PhotoConstants.maxLongestEdge,
      format: CompressFormat.jpeg,
    );

    if (result == null) {
      // Fall back to copying the original if compression failed.
      await File(picked.path).copy(targetPath);
    }

    // Relative path is `<itemId>/<filename>` (Section 3.1).
    return p.join(itemId, filename);
  }

  /// Deletes a single photo file by its relative [path]. Safe if absent.
  Future<void> deletePhoto(String path) async {
    final file = await resolve(path);
    if (await file.exists()) await file.delete();
  }

  /// Deletes all photo files for [itemId] (called before the row is removed).
  Future<void> deleteForItem(String itemId) async {
    final base = await _baseDir();
    final itemDir = Directory(p.join(base.path, itemId));
    if (await itemDir.exists()) await itemDir.delete(recursive: true);
  }
}

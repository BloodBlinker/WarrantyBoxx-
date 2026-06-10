import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/export_service.dart';

/// Provides the [ExportService].
final exportServiceProvider = Provider<ExportService>((ref) => ExportService());

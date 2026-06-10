import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/photo_service.dart';

/// Provides the singleton [PhotoService].
final photoServiceProvider = Provider<PhotoService>((ref) => PhotoService());

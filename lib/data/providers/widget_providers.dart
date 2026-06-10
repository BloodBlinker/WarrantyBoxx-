import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/widget_service.dart';

/// Provides the [WidgetService].
final widgetServiceProvider = Provider<WidgetService>((ref) => WidgetService());

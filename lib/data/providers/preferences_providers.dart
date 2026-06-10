import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/services/preferences_service.dart';

/// Provides the initialised [SharedPreferences] instance.
///
/// Overridden in [main] with the value resolved at startup so the rest of the
/// app can read it synchronously.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main()',
  ),
);

/// Provides the [PreferencesService] for flags and engagement counters.
final preferencesServiceProvider = Provider<PreferencesService>(
  (ref) => PreferencesService(ref.watch(sharedPreferencesProvider)),
);

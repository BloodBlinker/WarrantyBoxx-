import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/router.dart';
import 'app/routes.dart';
import 'app/theme.dart';
import 'data/database/debug_seeder.dart';
import 'data/providers/notification_providers.dart';
import 'data/providers/photo_providers.dart';
import 'data/providers/preferences_providers.dart';
import 'data/providers/repository_providers.dart';
import 'data/providers/service_providers.dart';
import 'data/providers/widget_providers.dart';
import 'domain/services/app_item_side_effects.dart';
import 'l10n/app_localizations.dart';

/// App entry point (Blueprint Section 4.2).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences is resolved once and injected so the rest of the app can
  // read flags synchronously.
  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      // Wire real reminder + photo side effects into item mutations.
      itemSideEffectsProvider.overrideWith(
        (ref) => AppItemSideEffects(
          notifications: ref.watch(notificationServiceProvider),
          photos: ref.watch(photoServiceProvider),
          onRefreshWidget: () async {
            final items = await ref.read(itemRepositoryProvider).getAll();
            await ref.read(widgetServiceProvider).refresh(items);
          },
        ),
      ),
    ],
  );

  // Initialise notifications (channel + WorkManager) and route taps to the item.
  final notifications = container.read(notificationServiceProvider);
  await notifications.init(
    onTapPayload: (payload) => _handleDeepLink(container, payload),
  );

  // Keep the home-screen widget counts fresh as days roll over (Section 2.1).
  await container.read(widgetServiceProvider).schedulePeriodicRefresh();

  // Seed sample data for local development only (Section 11.1, Phase 2).
  if (kDebugMode) {
    await DebugSeeder.seed(container.read(itemRepositoryProvider));
  }

  // Honour a notification that cold-started the app.
  final launchPayload = await notifications.launchPayload();
  if (launchPayload != null) {
    _handleDeepLink(container, launchPayload);
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const WarrantyBoxxApp(),
    ),
  );
}

/// Routes a notification/widget deep link.
///
/// `warrantyvault://item/{id}` opens the item; the widget's
/// `warrantyvault://item/expiring` opens the dashboard (Section 5.4).
void _handleDeepLink(ProviderContainer container, String payload) {
  final uri = Uri.tryParse(payload);
  if (uri == null || uri.host != 'item') return;
  final id = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
  if (id == null) return;
  final router = container.read(routerProvider);
  if (id == 'expiring') {
    router.go(Routes.dashboard);
  } else {
    router.push(Routes.itemDetailPath(id));
  }
}

/// Root application widget.
class WarrantyBoxxApp extends ConsumerWidget {
  /// Creates the root app widget.
  const WarrantyBoxxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // System theme only — no manual toggle (Section 5.2).
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}

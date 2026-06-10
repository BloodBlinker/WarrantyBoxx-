import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/providers/preferences_providers.dart';
import '../features/archive/archive_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/export/export_screen.dart';
import '../features/item_add_edit/add_edit_item_screen.dart';
import '../features/item_detail/item_detail_screen.dart';
import '../features/settings/onboarding_screen.dart';
import '../features/settings/privacy_policy_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/templates/templates_screen.dart';
import 'app_shell.dart';
import 'routes.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _dashboardKey = GlobalKey<NavigatorState>();
final _archiveKey = GlobalKey<NavigatorState>();
final _settingsKey = GlobalKey<NavigatorState>();

/// Provides the app's [GoRouter] (Blueprint Section 4.1 / 5.4).
///
/// Deep links arrive as `warrantyvault://item/{id}` and resolve to `/item/:id`.
final routerProvider = Provider<GoRouter>((ref) {
  final prefs = ref.read(preferencesServiceProvider);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.dashboard,
    redirect: (context, state) {
      // Show onboarding exactly once (Section 7.1).
      if (!prefs.onboardingShown && state.matchedLocation != Routes.onboarding) {
        return Routes.onboarding;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.onboarding,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const OnboardingScreen(),
      ),
      // Stateful shell hosting the three bottom-nav branches.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashboardKey,
            routes: [
              GoRoute(
                path: Routes.dashboard,
                builder: (context, state) =>
                    const DashboardTab(child: DashboardScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _archiveKey,
            routes: [
              GoRoute(
                path: Routes.archive,
                builder: (context, state) => const ArchiveScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsKey,
            routes: [
              GoRoute(
                path: Routes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.itemNew,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const AddEditItemScreen(),
      ),
      GoRoute(
        path: Routes.itemDetail,
        parentNavigatorKey: _rootKey,
        builder: (context, state) =>
            ItemDetailScreen(itemId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.itemEdit,
        parentNavigatorKey: _rootKey,
        builder: (context, state) =>
            AddEditItemScreen(itemId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.categories,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: Routes.templates,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const TemplatesScreen(),
      ),
      GoRoute(
        path: Routes.export,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const ExportScreen(),
      ),
      GoRoute(
        path: Routes.privacyPolicy,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
    ],
  );
});

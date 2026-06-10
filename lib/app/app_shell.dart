import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import 'routes.dart';

/// Scaffold hosting the bottom navigation and shared FAB (Blueprint Section
/// 5.4). Three tabs: Dashboard/Items, Archive, Settings. No drawer.
class AppShell extends StatelessWidget {
  /// Creates the shell around [navigationShell].
  const AppShell({super.key, required this.navigationShell});

  /// The go_router stateful shell controlling the active branch.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final onDashboard = navigationShell.currentIndex == 0;

    return Scaffold(
      body: navigationShell,
      // FAB only on the Dashboard tab (Section 5.4).
      floatingActionButton: onDashboard
          ? FloatingActionButton.extended(
              onPressed: () => context.push(Routes.itemNew),
              icon: const Icon(Icons.add),
              label: Text(l10n.dashboardAddFirstItem),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.navDashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.archive_outlined),
            selectedIcon: const Icon(Icons.archive),
            label: l10n.navArchive,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}

/// Simple scaffold wrapper giving the Dashboard branch its own app bar title.
class DashboardTab extends StatelessWidget {
  /// Creates the dashboard tab wrapper.
  const DashboardTab({super.key, required this.child});

  /// The dashboard body.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dashboardTitle)),
      body: child,
    );
  }
}

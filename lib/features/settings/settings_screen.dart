import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../data/providers/preferences_providers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/utils/date_utils.dart';
import '../item_add_edit/reminder_editor.dart';

/// Settings: reminder defaults, export, categories, templates, about
/// (Blueprint Section 5.3 "Settings Screen").
class SettingsScreen extends ConsumerWidget {
  /// Creates the settings screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prefs = ref.watch(preferencesServiceProvider);
    final firstAdded = prefs.firstItemAddedDate;
    final lastExport = prefs.lastExportDate;
    final showBackupNudge = lastExport == null
        ? false
        : AppDates.daysBetween(lastExport, DateTime.now()) >
            Milestones.backupNudgeDays;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          if (firstAdded != null)
            ListTile(
              leading: const Icon(Icons.verified_user_outlined),
              title: Text(l10n.settingsProtectingFor(
                  AppDates.daysBetween(firstAdded, DateTime.now()))),
            ),
          if (showBackupNudge)
            Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: const Icon(Icons.backup_outlined),
                title: Text(l10n.settingsBackupNudge),
                onTap: () => context.push(Routes.export),
              ),
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(l10n.settingsReminderDefaults,
                style: Theme.of(context).textTheme.titleSmall),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: StatefulBuilder(
              builder: (context, setState) => ReminderEditor(
                selectedDays: prefs.defaultReminderDays,
                onChanged: (days) {
                  // Persist new defaults and reflect the selection locally.
                  prefs.setDefaultReminderDays(days);
                  setState(() {});
                },
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: Text(l10n.categoriesTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.categories),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_customize_outlined),
            title: Text(l10n.templatesTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.templates),
          ),
          ListTile(
            leading: const Icon(Icons.ios_share),
            title: Text(l10n.settingsExportAll),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.export),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.settingsPrivacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.privacyPolicy),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.settingsLicences),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showLicensePage(
              context: context,
              applicationName: l10n.appName,
              applicationVersion: '1.0.0',
            ),
          ),
          const AboutListTileVersion(),
        ],
      ),
    );
  }
}

/// Shows the app version pulled from the build, kept separate for clarity.
class AboutListTileVersion extends StatelessWidget {
  /// Creates the version tile.
  const AboutListTileVersion({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: Text(l10n.settingsAbout),
      subtitle: Text(l10n.settingsVersion('1.0.0')),
    );
  }
}

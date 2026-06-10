import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../l10n/app_localizations.dart';

/// Displays the bundled privacy policy (Blueprint Section 6.2 — stored in
/// `assets/privacy_policy.md`).
class PrivacyPolicyScreen extends StatelessWidget {
  /// Creates the privacy policy screen.
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsPrivacyPolicy)),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/privacy_policy.md'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Text(snapshot.data!),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../data/providers/preferences_providers.dart';
import '../../l10n/app_localizations.dart';

/// One-time onboarding splash (Blueprint Section 7.1). Single screen, no
/// carousel, no permission prompts.
class OnboardingScreen extends ConsumerWidget {
  /// Creates the onboarding screen.
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Icon(Icons.shield_outlined,
                  size: 72, color: Colors.white),
              const SizedBox(height: 24),
              Text(
                l10n.appName,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.appTagline,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.onboardingExplanation,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    minimumSize: const Size.fromHeight(52),
                  ),
                  onPressed: () async {
                    await ref
                        .read(preferencesServiceProvider)
                        .setOnboardingShown();
                    if (context.mounted) context.go(Routes.dashboard);
                  },
                  child: Text(l10n.onboardingGetStarted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

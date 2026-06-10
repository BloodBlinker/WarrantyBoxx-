# WarrantyBoxx

**Every warranty. Always remembered.**

WarrantyBoxx is a dedicated, fully offline, open-source warranty tracker for
Android. Add your purchases, get reminded before warranties expire, and prepare
successful claims — all without an account, a server, or a single network call.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

## Highlights

- 📋 Track items with photos, prices, serials, categories and notes
- 🔔 Local expiry reminders (30/15/7/1 days) via Android WorkManager — no Google services
- 🟢 Dashboard with a warranty health ring and honest status colours
- 🔍 Full-text search, filtering and sorting
- 🧰 Claim Assistant checklist for when a warranty is about to expire
- 💷 Lifetime asset tracker and item templates
- 📤 CSV / PDF export and single-item share via the system share sheet
- 🏠 Home screen widget; claimed-items archive
- 🔒 100% offline. No accounts, no tracking, no telemetry.

## Tech stack

Flutter · Riverpod · Drift (SQLite) · go_router · flutter_local_notifications ·
WorkManager · home_widget. See the build blueprint for the full specification.

## Architecture

Strict feature-first layering (`lib/features/**`) over a data layer
(`lib/data/**` — Drift database, DAOs, repositories, Riverpod providers) and a
pure-Dart domain layer (`lib/domain/**`). Features never touch Drift directly;
all access goes through repositories. Warranty maths lives in pure, fully tested
functions.

```
lib/
  app/         router, theme, shell, route constants
  features/    one folder per screen/feature
  data/        database, repositories, providers
  domain/      models + services (pure Dart, no Flutter)
  shared/      reusable widgets, utils, constants
  l10n/        ARB strings (English at launch, i18n-ready)
```

## Building

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run                                  # debug
flutter build apk --release --flavor fdroid  # release
```

Requires Flutter 3.44+, JDK 21, Android SDK (minSdk 26 / Android 8.0).

## Testing

```bash
flutter analyze                   # zero issues expected
flutter test                      # unit + widget + integration
flutter test --tags performance   # 1000-item dashboard budget
python3 tool/fdroid_verify.py build/app/outputs/flutter-apk/app-fdroid-release.apk
```

## Privacy

WarrantyBoxx collects nothing and makes no network calls. See
[the privacy policy](assets/privacy_policy.md). F-Droid compliance is enforced in
CI by [`tool/fdroid_verify.py`](tool/fdroid_verify.py), which fails the build if
any proprietary SDK, tracker domain, or outbound network API is detected.

## Licence

GPL-3.0-or-later. See [LICENSE](LICENSE) and [NOTICE](NOTICE).

# Phone screenshots

F-Droid requires **at least 3 screenshots** here (Blueprint Section 9.3), named
e.g. `1.png`, `2.png`, `3.png`. These must be captured from the running app, so
they are added as a manual release step:

1. Run the app on an emulator or device: `flutter run --release --flavor fdroid`.
2. Capture the Dashboard, Add Item form, and Item Detail / Claim Assistant.
3. Save them here as `1.png`, `2.png`, `3.png` (PNG, phone aspect ratio).

Alternatively, generate them deterministically with an `integration_test` driver
using `flutter test integration_test --flavor fdroid` and a screenshot callback.

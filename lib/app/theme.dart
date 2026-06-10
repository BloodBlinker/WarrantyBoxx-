import 'package:flutter/material.dart';

import '../domain/models/enums.dart';

/// The WarrantyBoxx design system (Blueprint Section 5.2).
///
/// Colours are used honestly: the status palette is reserved exclusively for
/// warranty status and never for decoration (Section 5.1).
class AppColors {
  AppColors._();

  // --- Canonical brand/status colours (Blueprint Section 5.2, light mode) ---

  /// Deep navy — headers, primary actions, active states.
  static const Color primary = Color(0xFF1E3A5F);

  /// Teal — secondary actions, health indicators, category accents.
  static const Color secondary = Color(0xFF0D7377);

  /// Status: active (>30 days remaining).
  static const Color statusActive = Color(0xFF1B6B3A);

  /// Status: warning (expiring within 30 days).
  static const Color statusWarning = Color(0xFFB8560A);

  /// Status: critical (expiring within 7 days).
  static const Color statusCritical = Color(0xFFA32D2D);

  /// Status: expired (past expiry, unclaimed).
  static const Color statusExpired = Color(0xFF444441);

  /// Status: claimed (successfully claimed).
  static const Color statusClaimed = Color(0xFF0D7377);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1A1A);

  // --- Dark-mode variants ---
  //
  // The canonical colours above are deep/near-black tones designed for white
  // surfaces. Used as foreground on a dark surface they are unreadable, so dark
  // mode uses lighter tints of the same hues for adequate contrast (Section 6.3
  // — WCAG AA in both themes).

  static const Color _primaryDark = Color(0xFF7BA7D9);
  static const Color _secondaryDark = Color(0xFF3FB6BA);
  static const Color _statusActiveDark = Color(0xFF5BBE83);
  static const Color _statusWarningDark = Color(0xFFE59A4D);
  static const Color _statusCriticalDark = Color(0xFFE47C7C);
  static const Color _statusExpiredDark = Color(0xFFADADA8);
  static const Color _statusClaimedDark = Color(0xFF3FB6BA);

  static Color _pick(Brightness b, Color light, Color dark) =>
      b == Brightness.dark ? dark : light;

  /// Brand primary suitable as foreground for [brightness].
  static Color brandPrimary(Brightness b) => _pick(b, primary, _primaryDark);

  /// Brand secondary suitable as foreground for [brightness].
  static Color brandSecondary(Brightness b) =>
      _pick(b, secondary, _secondaryDark);

  /// Active status colour for [brightness].
  static Color active(Brightness b) => _pick(b, statusActive, _statusActiveDark);

  /// Warning status colour for [brightness].
  static Color warning(Brightness b) =>
      _pick(b, statusWarning, _statusWarningDark);

  /// Critical status colour for [brightness].
  static Color critical(Brightness b) =>
      _pick(b, statusCritical, _statusCriticalDark);

  /// Expired status colour for [brightness].
  static Color expired(Brightness b) =>
      _pick(b, statusExpired, _statusExpiredDark);

  /// Claimed status colour for [brightness].
  static Color claimed(Brightness b) =>
      _pick(b, statusClaimed, _statusClaimedDark);
}

/// Border radii (Blueprint Section 5.2).
class AppRadii {
  AppRadii._();

  /// 12dp for cards.
  static const Radius card = Radius.circular(12);

  /// 8dp for chips/badges.
  static const Radius chip = Radius.circular(8);

  /// 4dp for small elements.
  static const Radius small = Radius.circular(4);
}

/// Resolves the colour and a non-colour cue (icon) for a [WarrantyStatus].
///
/// Status is communicated by colour AND icon/text, never colour alone
/// (Blueprint Section 6.3).
class StatusVisuals {
  const StatusVisuals(this.color, this.icon);

  final Color color;
  final IconData icon;

  /// Returns the visuals for [status], resolving the colour for [brightness] so
  /// it stays readable in both light and dark themes. [daysRemaining]
  /// distinguishes the critical (≤7 days) shade from the general warning shade.
  factory StatusVisuals.of(
    WarrantyStatus status, {
    int daysRemaining = 0,
    Brightness brightness = Brightness.light,
  }) {
    switch (status) {
      case WarrantyStatus.active:
        return StatusVisuals(AppColors.active(brightness), Icons.check_circle);
      case WarrantyStatus.expiringSoon:
        final critical = daysRemaining <= 7;
        return StatusVisuals(
          critical
              ? AppColors.critical(brightness)
              : AppColors.warning(brightness),
          critical ? Icons.warning_amber_rounded : Icons.schedule,
        );
      case WarrantyStatus.expired:
        return StatusVisuals(AppColors.expired(brightness), Icons.cancel);
      case WarrantyStatus.claimed:
        return StatusVisuals(
          AppColors.claimed(brightness),
          Icons.verified_outlined,
        );
    }
  }
}

/// Builds the light and dark [ThemeData] (system theme only — Section 5.2).
class AppTheme {
  AppTheme._();

  /// Light theme.
  static ThemeData light() => _build(Brightness.light);

  /// Dark theme.
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final base = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    );

    // In light mode the exact brand colours read well against white (white
    // on-colours). In dark mode forcing the deep navy/teal would make primary
    // text and buttons unreadable, so we keep the tonally-correct colours that
    // fromSeed derives for a dark surface.
    final colorScheme = brightness == Brightness.light
        ? base.copyWith(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.surfaceLight,
          )
        : base.copyWith(surface: AppColors.surfaceDark);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Roboto system font — no bundled fonts (Section 5.2).
      cardTheme: const CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(AppRadii.card),
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(AppRadii.chip),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(elevation: 4),
      dialogTheme: const DialogThemeData(elevation: 8),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(AppRadii.chip),
        ),
      ),
    );
  }
}

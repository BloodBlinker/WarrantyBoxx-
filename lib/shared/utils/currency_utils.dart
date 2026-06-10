import 'package:intl/intl.dart';

/// Currency formatting derived from the device locale (Blueprint Section 2.1).
///
/// No currency conversion is ever performed — the symbol is purely cosmetic and
/// follows the device locale.
class AppCurrency {
  AppCurrency._();

  /// Formats [amount] using the device-locale currency symbol.
  ///
  /// [locale] defaults to the current default locale; pass an explicit value in
  /// tests for determinism.
  static String format(double amount, {String? locale}) {
    final format = NumberFormat.simpleCurrency(
      locale: locale ?? Intl.getCurrentLocale(),
    );
    return format.format(amount);
  }

  /// Plain decimal with exactly two places and no currency symbol — used for
  /// CSV export (Appendix D: "decimal with 2 places, no currency symbol").
  static String plainDecimal(double amount) => amount.toStringAsFixed(2);
}

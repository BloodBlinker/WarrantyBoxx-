import 'package:intl/intl.dart';

/// Date helpers used across the app.
///
/// Warranty maths is date-only: time-of-day must never affect whether an item
/// is "expired" or how many days remain (Blueprint Section 3.2 — purchase dates
/// are stored at 00:00:00 UTC).
class AppDates {
  AppDates._();

  /// ISO 8601 date format (YYYY-MM-DD) used for CSV export (Appendix D).
  static final DateFormat iso = DateFormat('yyyy-MM-dd');

  /// Strips the time component, returning the date at local midnight.
  static DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  /// Today at local midnight. The single source of "now" for warranty maths.
  static DateTime today() => dateOnly(DateTime.now());

  /// Adds [months] whole months to [date], clamping the day to the end of the
  /// target month (e.g. Jan 31 + 1 month => Feb 28/29).
  static DateTime addMonths(DateTime date, int months) {
    final totalMonths = date.month - 1 + months;
    final year = date.year + (totalMonths ~/ 12);
    final month = totalMonths % 12 + 1;
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;
    final day = date.day < lastDayOfMonth ? date.day : lastDayOfMonth;
    return DateTime(year, month, day);
  }

  /// Whole days between two dates (date-only). Positive when [to] is after [from].
  static int daysBetween(DateTime from, DateTime to) =>
      dateOnly(to).difference(dateOnly(from)).inDays;

  /// Human-friendly medium date (e.g. "10 Jun 2026"), locale-aware.
  static String formatMedium(DateTime value) =>
      DateFormat.yMMMd().format(value);
}

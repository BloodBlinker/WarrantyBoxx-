import '../../l10n/app_localizations.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/utils/date_utils.dart';

/// Form field validators (Blueprint Section 5.6 edge cases).
///
/// Each returns a localised error string, or null when valid.
class Validators {
  Validators._();

  /// Item name: required, trimmed non-empty.
  static String? itemName(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationNameRequired;
    }
    return null;
  }

  /// Warranty months: required, integer within 1–360 (Section 5.6:
  /// "warranty_months = 0 not allowed").
  static String? warrantyMonths(AppLocalizations l10n, String? value) {
    final parsed = int.tryParse((value ?? '').trim());
    if (parsed == null ||
        parsed < ItemLimits.minWarrantyMonths ||
        parsed > ItemLimits.maxWarrantyMonths) {
      return l10n.validationWarrantyRange;
    }
    return null;
  }

  /// Purchase date: must not be in the future (Section 5.6).
  static String? purchaseDate(AppLocalizations l10n, DateTime? value) {
    if (value == null) return null;
    if (AppDates.dateOnly(value).isAfter(AppDates.today())) {
      return l10n.validationPurchaseDateFuture;
    }
    return null;
  }

  /// Optional price: when present, must parse to a non-negative number.
  static String? price(AppLocalizations l10n, String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return null;
    final parsed = double.tryParse(trimmed);
    if (parsed == null || parsed < 0) return l10n.validationPriceInvalid;
    return null;
  }
}

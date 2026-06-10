import '../../l10n/app_localizations.dart';
import '../constants/app_constants.dart';

/// Returns a localised milestone message when [itemCount] hits a milestone
/// (Blueprint Section 7.3: at 5, 10 and 25 items), otherwise null.
String? milestoneMessage(AppLocalizations l10n, int itemCount) {
  if (!Milestones.itemCountMilestones.contains(itemCount)) return null;
  return switch (itemCount) {
    5 => l10n.milestone5,
    10 => l10n.milestone10,
    25 => l10n.milestone25,
    _ => null,
  };
}

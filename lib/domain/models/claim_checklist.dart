import 'dart:convert';

/// The Claim Assistant checklist state (Blueprint Section 2.1, 3.2).
///
/// Persisted as a JSON object string in the `claim_checklist` column.
class ClaimChecklist {
  /// Creates a checklist with all items defaulting to unchecked.
  const ClaimChecklist({
    this.receiptAttached = false,
    this.serialNoted = false,
    this.contactSaved = false,
    this.faultWritten = false,
    this.proofReady = false,
  });

  final bool receiptAttached;
  final bool serialNoted;
  final bool contactSaved;
  final bool faultWritten;
  final bool proofReady;

  /// Number of completed checklist items (0–5).
  int get completedCount => [
        receiptAttached,
        serialNoted,
        contactSaved,
        faultWritten,
        proofReady,
      ].where((checked) => checked).length;

  /// Total number of checklist items.
  static const int totalItems = 5;

  /// Returns a copy with the given fields replaced.
  ClaimChecklist copyWith({
    bool? receiptAttached,
    bool? serialNoted,
    bool? contactSaved,
    bool? faultWritten,
    bool? proofReady,
  }) =>
      ClaimChecklist(
        receiptAttached: receiptAttached ?? this.receiptAttached,
        serialNoted: serialNoted ?? this.serialNoted,
        contactSaved: contactSaved ?? this.contactSaved,
        faultWritten: faultWritten ?? this.faultWritten,
        proofReady: proofReady ?? this.proofReady,
      );

  /// Serialises to the JSON object string stored in the database.
  String toJson() => jsonEncode({
        'receipt_attached': receiptAttached,
        'serial_noted': serialNoted,
        'contact_saved': contactSaved,
        'fault_written': faultWritten,
        'proof_ready': proofReady,
      });

  /// Parses the stored JSON object string. Null or malformed input yields an
  /// all-unchecked checklist.
  static ClaimChecklist fromJson(String? raw) {
    if (raw == null || raw.isEmpty) return const ClaimChecklist();
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return ClaimChecklist(
        receiptAttached: map['receipt_attached'] as bool? ?? false,
        serialNoted: map['serial_noted'] as bool? ?? false,
        contactSaved: map['contact_saved'] as bool? ?? false,
        faultWritten: map['fault_written'] as bool? ?? false,
        proofReady: map['proof_ready'] as bool? ?? false,
      );
    } catch (_) {
      return const ClaimChecklist();
    }
  }
}

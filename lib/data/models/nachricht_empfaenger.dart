/// NachrichtEmpfänger — Read-only View-Modell für den Lesestatus einer Nachricht pro Empfänger.
/// Kein toSupabase()/copyWith(), da Schreibzugriffe über NachrichtRepository laufen.
class NachrichtEmpfaenger {
  final String nachrichtId;
  final String empfaengerId;
  final bool gelesen;
  final DateTime? gelesenAm;

  const NachrichtEmpfaenger({
    required this.nachrichtId,
    required this.empfaengerId,
    required this.gelesen,
    this.gelesenAm,
  });

  /// Factory from Supabase nachricht_empfaenger table (snake_case).
  factory NachrichtEmpfaenger.fromSupabase(Map<String, dynamic> map) {
    return NachrichtEmpfaenger(
      nachrichtId: map['nachricht_id'] as String? ?? '',
      empfaengerId: map['empfaenger_id'] as String? ?? '',
      gelesen: map['gelesen'] as bool? ?? false,
      gelesenAm: map['gelesen_am'] != null
          ? DateTime.parse(map['gelesen_am'] as String)
          : null,
    );
  }
}

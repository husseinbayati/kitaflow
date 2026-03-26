import '../../core/constants/enums.dart';

/// NachrichtUngelesen — Read-only View-Modell aus v_nachrichten_ungelesen.
/// Kein toSupabase()/copyWith(), da dies ein leichtgewichtiges Lesemodell für ungelesene Nachrichten ist.
class NachrichtUngelesen {
  final String empfaengerId;
  final String nachrichtId;
  final String betreff;
  final MessageType typ;
  final bool wichtig;
  final DateTime erstelltAm;
  final String absenderVorname;
  final String absenderNachname;

  const NachrichtUngelesen({
    required this.empfaengerId,
    required this.nachrichtId,
    required this.betreff,
    required this.typ,
    required this.wichtig,
    required this.erstelltAm,
    required this.absenderVorname,
    required this.absenderNachname,
  });

  /// Vollständiger Absendername.
  String get absenderName {
    final name = '$absenderVorname $absenderNachname'.trim();
    return name.isNotEmpty ? name : 'Unbekannt';
  }

  /// Factory from Supabase v_nachrichten_ungelesen view (snake_case).
  factory NachrichtUngelesen.fromSupabase(Map<String, dynamic> map) {
    return NachrichtUngelesen(
      empfaengerId: map['empfaenger_id'] as String? ?? '',
      nachrichtId: map['nachricht_id'] as String? ?? '',
      betreff: map['betreff'] as String? ?? '',
      typ: MessageType.values.firstWhere(
        (t) => t.name == (map['typ'] as String? ?? 'nachricht'),
        orElse: () => MessageType.nachricht,
      ),
      wichtig: map['wichtig'] as bool? ?? false,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
      absenderVorname: map['absender_vorname'] as String? ?? '',
      absenderNachname: map['absender_nachname'] as String? ?? '',
    );
  }
}

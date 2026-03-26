import '../../core/constants/enums.dart';

/// Modell für eine Termin-Rückmeldung (RSVP).
/// Bildet die Supabase-Tabelle `termin_rueckmeldungen` ab.
class TerminRueckmeldung {
  final String id;
  final String terminId;
  final String elternId;
  final RsvpStatus status;
  final DateTime erstelltAm;
  final DateTime aktualisiertAm;

  const TerminRueckmeldung({
    required this.id,
    required this.terminId,
    required this.elternId,
    required this.status,
    required this.erstelltAm,
    required this.aktualisiertAm,
  });

  /// Factory from Supabase termin_rueckmeldungen table (snake_case)
  factory TerminRueckmeldung.fromSupabase(Map<String, dynamic> map) {
    return TerminRueckmeldung(
      id: map['id'] as String,
      terminId: map['termin_id'] as String? ?? '',
      elternId: map['eltern_id'] as String? ?? '',
      status: RsvpStatus.values.firstWhere(
        (s) => s.name == (map['status'] as String? ?? 'vielleicht'),
        orElse: () => RsvpStatus.vielleicht,
      ),
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
      aktualisiertAm: DateTime.parse(
        map['aktualisiert_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'termin_id': terminId,
      'eltern_id': elternId,
      'status': status.name,
    };
  }

  TerminRueckmeldung copyWith({
    String? id,
    String? terminId,
    String? elternId,
    RsvpStatus? status,
    DateTime? erstelltAm,
    DateTime? aktualisiertAm,
  }) {
    return TerminRueckmeldung(
      id: id ?? this.id,
      terminId: terminId ?? this.terminId,
      elternId: elternId ?? this.elternId,
      status: status ?? this.status,
      erstelltAm: erstelltAm ?? this.erstelltAm,
      aktualisiertAm: aktualisiertAm ?? this.aktualisiertAm,
    );
  }
}

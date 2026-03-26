import '../../core/constants/enums.dart';

/// Modell für einen Termin/Kalender-Eintrag.
/// Bildet die Supabase-Tabelle `termine` ab.
class Termin {
  final String id;
  final String einrichtungId;
  final String titel;
  final String? beschreibung;
  final DateTime datum;
  final String? uhrzeitVon;
  final String? uhrzeitBis;
  final TerminTyp typ;
  final String? gruppeId;
  final String erstelltVon;
  final DateTime erstelltAm;
  final DateTime aktualisiertAm;

  const Termin({
    required this.id,
    required this.einrichtungId,
    required this.titel,
    this.beschreibung,
    required this.datum,
    this.uhrzeitVon,
    this.uhrzeitBis,
    this.typ = TerminTyp.allgemein,
    this.gruppeId,
    required this.erstelltVon,
    required this.erstelltAm,
    required this.aktualisiertAm,
  });

  /// Factory from Supabase termine table (snake_case)
  factory Termin.fromSupabase(Map<String, dynamic> map) {
    return Termin(
      id: map['id'] as String,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      titel: map['titel'] as String? ?? '',
      beschreibung: map['beschreibung'] as String?,
      datum: DateTime.parse(
        map['datum'] as String? ?? DateTime.now().toIso8601String(),
      ),
      uhrzeitVon: map['uhrzeit_von'] as String?,
      uhrzeitBis: map['uhrzeit_bis'] as String?,
      typ: TerminTyp.values.firstWhere(
        (t) => t.name == (map['typ'] as String? ?? 'allgemein'),
        orElse: () => TerminTyp.allgemein,
      ),
      gruppeId: map['gruppe_id'] as String?,
      erstelltVon: map['erstellt_von'] as String? ?? '',
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
      'einrichtung_id': einrichtungId,
      'titel': titel,
      'beschreibung': beschreibung,
      'datum': datum.toIso8601String(),
      'uhrzeit_von': uhrzeitVon,
      'uhrzeit_bis': uhrzeitBis,
      'typ': typ.name,
      'gruppe_id': gruppeId,
      'erstellt_von': erstelltVon,
    };
  }

  Termin copyWith({
    String? id,
    String? einrichtungId,
    String? titel,
    String? beschreibung,
    DateTime? datum,
    String? uhrzeitVon,
    String? uhrzeitBis,
    TerminTyp? typ,
    String? gruppeId,
    String? erstelltVon,
    DateTime? erstelltAm,
    DateTime? aktualisiertAm,
  }) {
    return Termin(
      id: id ?? this.id,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      titel: titel ?? this.titel,
      beschreibung: beschreibung ?? this.beschreibung,
      datum: datum ?? this.datum,
      uhrzeitVon: uhrzeitVon ?? this.uhrzeitVon,
      uhrzeitBis: uhrzeitBis ?? this.uhrzeitBis,
      typ: typ ?? this.typ,
      gruppeId: gruppeId ?? this.gruppeId,
      erstelltVon: erstelltVon ?? this.erstelltVon,
      erstelltAm: erstelltAm ?? this.erstelltAm,
      aktualisiertAm: aktualisiertAm ?? this.aktualisiertAm,
    );
  }
}

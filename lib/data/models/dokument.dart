import '../../core/constants/enums.dart';
import '../../core/extensions/datetime_extensions.dart';

/// Modell für ein Dokument.
/// Bildet die Supabase-Tabelle `dokumente` ab.
class Dokument {
  final String id;
  final String einrichtungId;
  final String? kindId;
  final DocumentType typ;
  final String titel;
  final String? beschreibung;
  final String? dateipfad;
  final bool unterschrieben;
  final DateTime? unterschriebenAm;
  final String? unterschriebenVon;
  final DateTime? gueltigBis;
  final String? erstelltVon;
  final DateTime erstelltAm;

  const Dokument({
    required this.id,
    required this.einrichtungId,
    this.kindId,
    required this.typ,
    required this.titel,
    this.beschreibung,
    this.dateipfad,
    this.unterschrieben = false,
    this.unterschriebenAm,
    this.unterschriebenVon,
    this.gueltigBis,
    this.erstelltVon,
    required this.erstelltAm,
  });

  /// Ob das Dokument abgelaufen ist.
  bool get istAbgelaufen =>
      gueltigBis != null && gueltigBis!.isBefore(DateTime.now());

  /// Factory from Supabase dokumente table (snake_case)
  factory Dokument.fromSupabase(Map<String, dynamic> map) {
    return Dokument(
      id: map['id'] as String,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      kindId: map['kind_id'] as String?,
      typ: DocumentType.values.firstWhere(
        (t) => t.name == (map['typ'] as String? ?? 'sonstiges'),
        orElse: () => DocumentType.sonstiges,
      ),
      titel: map['titel'] as String? ?? '',
      beschreibung: map['beschreibung'] as String?,
      dateipfad: map['dateipfad'] as String?,
      unterschrieben: map['unterschrieben'] as bool? ?? false,
      unterschriebenAm: map['unterschrieben_am'] != null
          ? DateTime.parse(map['unterschrieben_am'] as String)
          : null,
      unterschriebenVon: map['unterschrieben_von'] as String?,
      gueltigBis: map['gueltig_bis'] != null
          ? DateTime.parse(map['gueltig_bis'] as String)
          : null,
      erstelltVon: map['erstellt_von'] as String?,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'einrichtung_id': einrichtungId,
      'kind_id': kindId,
      'typ': typ.name,
      'titel': titel,
      'beschreibung': beschreibung,
      'dateipfad': dateipfad,
      'unterschrieben': unterschrieben,
      if (unterschriebenAm != null)
        'unterschrieben_am': unterschriebenAm!.toIso8601String(),
      'unterschrieben_von': unterschriebenVon,
      if (gueltigBis != null)
        'gueltig_bis': gueltigBis!.toSupabaseDateString(),
      'erstellt_von': erstelltVon,
    };
  }

  Dokument copyWith({
    String? id,
    String? einrichtungId,
    String? kindId,
    DocumentType? typ,
    String? titel,
    String? beschreibung,
    String? dateipfad,
    bool? unterschrieben,
    DateTime? unterschriebenAm,
    String? unterschriebenVon,
    DateTime? gueltigBis,
    String? erstelltVon,
    DateTime? erstelltAm,
  }) {
    return Dokument(
      id: id ?? this.id,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      kindId: kindId ?? this.kindId,
      typ: typ ?? this.typ,
      titel: titel ?? this.titel,
      beschreibung: beschreibung ?? this.beschreibung,
      dateipfad: dateipfad ?? this.dateipfad,
      unterschrieben: unterschrieben ?? this.unterschrieben,
      unterschriebenAm: unterschriebenAm ?? this.unterschriebenAm,
      unterschriebenVon: unterschriebenVon ?? this.unterschriebenVon,
      gueltigBis: gueltigBis ?? this.gueltigBis,
      erstelltVon: erstelltVon ?? this.erstelltVon,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

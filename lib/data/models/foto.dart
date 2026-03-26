import '../../core/extensions/datetime_extensions.dart';

/// Modell für ein Foto in der Galerie.
/// Bildet die Supabase-Tabelle `fotos` ab.
class Foto {
  final String id;
  final String einrichtungId;
  final String? gruppeId;
  final String hochgeladenVon;
  final String storagePfad;
  final String? beschreibung;
  final DateTime datum;
  final bool sichtbarFuerEltern;
  final DateTime erstelltAm;

  const Foto({
    required this.id,
    required this.einrichtungId,
    this.gruppeId,
    required this.hochgeladenVon,
    required this.storagePfad,
    this.beschreibung,
    required this.datum,
    this.sichtbarFuerEltern = true,
    required this.erstelltAm,
  });

  /// Factory from Supabase fotos table (snake_case)
  factory Foto.fromSupabase(Map<String, dynamic> map) {
    return Foto(
      id: map['id'] as String,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      gruppeId: map['gruppe_id'] as String?,
      hochgeladenVon: map['hochgeladen_von'] as String? ?? '',
      storagePfad: map['storage_pfad'] as String? ?? '',
      beschreibung: map['beschreibung'] as String?,
      datum: DateTime.parse(
        map['datum'] as String? ?? DateTime.now().toIso8601String(),
      ),
      sichtbarFuerEltern: map['sichtbar_fuer_eltern'] as bool? ?? true,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'einrichtung_id': einrichtungId,
      'gruppe_id': gruppeId,
      'hochgeladen_von': hochgeladenVon,
      'storage_pfad': storagePfad,
      'beschreibung': beschreibung,
      'datum': datum.toSupabaseDateString(),
      'sichtbar_fuer_eltern': sichtbarFuerEltern,
    };
  }

  Foto copyWith({
    String? id,
    String? einrichtungId,
    String? gruppeId,
    String? hochgeladenVon,
    String? storagePfad,
    String? beschreibung,
    DateTime? datum,
    bool? sichtbarFuerEltern,
    DateTime? erstelltAm,
  }) {
    return Foto(
      id: id ?? this.id,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      gruppeId: gruppeId ?? this.gruppeId,
      hochgeladenVon: hochgeladenVon ?? this.hochgeladenVon,
      storagePfad: storagePfad ?? this.storagePfad,
      beschreibung: beschreibung ?? this.beschreibung,
      datum: datum ?? this.datum,
      sichtbarFuerEltern: sichtbarFuerEltern ?? this.sichtbarFuerEltern,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

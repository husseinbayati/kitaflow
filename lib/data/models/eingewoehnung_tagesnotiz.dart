import '../../core/constants/enums.dart';

/// Modell für eine Eingewöhnungs-Tagesnotiz.
/// Bildet die Supabase-Tabelle `eingewoehnung_tagesnotizen` ab.
class EingewoehnungTagesnotiz {
  final String id;
  final String eingewoehnungId;
  final DateTime datum;
  final int? dauerMinuten;
  final int? trennungsverhalten;
  final String? trennungsverhaltenText;
  final String? essen;
  final String? schlaf;
  final String? spiel;
  final Stimmung? stimmung;
  final String? notizenIntern;
  final String? notizenEltern;
  final String? erstelltVon;
  final DateTime erstelltAm;

  const EingewoehnungTagesnotiz({
    required this.id,
    required this.eingewoehnungId,
    required this.datum,
    this.dauerMinuten,
    this.trennungsverhalten,
    this.trennungsverhaltenText,
    this.essen,
    this.schlaf,
    this.spiel,
    this.stimmung,
    this.notizenIntern,
    this.notizenEltern,
    this.erstelltVon,
    required this.erstelltAm,
  });

  factory EingewoehnungTagesnotiz.fromSupabase(Map<String, dynamic> map) {
    return EingewoehnungTagesnotiz(
      id: map['id'] as String,
      eingewoehnungId: map['eingewoehnung_id'] as String? ?? '',
      datum: DateTime.parse(map['datum'] as String),
      dauerMinuten: map['dauer_minuten'] as int?,
      trennungsverhalten: map['trennungsverhalten'] as int?,
      trennungsverhaltenText: map['trennungsverhalten_text'] as String?,
      essen: map['essen'] as String?,
      schlaf: map['schlaf'] as String?,
      spiel: map['spiel'] as String?,
      stimmung: map['stimmung'] != null
          ? Stimmung.values.firstWhere(
              (s) => s.name == (map['stimmung'] as String),
              orElse: () => Stimmung.neutral,
            )
          : null,
      notizenIntern: map['notizen_intern'] as String?,
      notizenEltern: map['notizen_eltern'] as String?,
      erstelltVon: map['erstellt_von'] as String?,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'eingewoehnung_id': eingewoehnungId,
      'datum': '${datum.year.toString().padLeft(4, '0')}-${datum.month.toString().padLeft(2, '0')}-${datum.day.toString().padLeft(2, '0')}',
      'dauer_minuten': dauerMinuten,
      'trennungsverhalten': trennungsverhalten,
      'trennungsverhalten_text': trennungsverhaltenText,
      'essen': essen,
      'schlaf': schlaf,
      'spiel': spiel,
      'stimmung': stimmung?.name,
      'notizen_intern': notizenIntern,
      'notizen_eltern': notizenEltern,
      'erstellt_von': erstelltVon,
    };
  }

  EingewoehnungTagesnotiz copyWith({
    String? id,
    String? eingewoehnungId,
    DateTime? datum,
    int? dauerMinuten,
    int? trennungsverhalten,
    String? trennungsverhaltenText,
    String? essen,
    String? schlaf,
    String? spiel,
    Stimmung? stimmung,
    String? notizenIntern,
    String? notizenEltern,
    String? erstelltVon,
    DateTime? erstelltAm,
  }) {
    return EingewoehnungTagesnotiz(
      id: id ?? this.id,
      eingewoehnungId: eingewoehnungId ?? this.eingewoehnungId,
      datum: datum ?? this.datum,
      dauerMinuten: dauerMinuten ?? this.dauerMinuten,
      trennungsverhalten: trennungsverhalten ?? this.trennungsverhalten,
      trennungsverhaltenText: trennungsverhaltenText ?? this.trennungsverhaltenText,
      essen: essen ?? this.essen,
      schlaf: schlaf ?? this.schlaf,
      spiel: spiel ?? this.spiel,
      stimmung: stimmung ?? this.stimmung,
      notizenIntern: notizenIntern ?? this.notizenIntern,
      notizenEltern: notizenEltern ?? this.notizenEltern,
      erstelltVon: erstelltVon ?? this.erstelltVon,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

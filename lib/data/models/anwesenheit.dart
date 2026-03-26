import '../../core/constants/enums.dart';
import '../../core/extensions/datetime_extensions.dart';

class Anwesenheit {
  final String id;
  final String kindId;
  final DateTime datum;
  final String? ankunftZeit;
  final String? abgeholtZeit;
  final AttendanceStatus status;
  final String? abgeholtVon;
  final String? gebrachtVon;
  final String? notiz;
  final String? erfasstVon;
  final String einrichtungId;
  final DateTime erstelltAm;

  const Anwesenheit({
    required this.id,
    required this.kindId,
    required this.datum,
    this.ankunftZeit,
    this.abgeholtZeit,
    required this.status,
    this.abgeholtVon,
    this.gebrachtVon,
    this.notiz,
    this.erfasstVon,
    required this.einrichtungId,
    required this.erstelltAm,
  });

  /// Ob das Kind aktuell anwesend ist (Status anwesend und noch nicht abgeholt).
  bool get istAnwesend =>
      status == AttendanceStatus.anwesend && abgeholtZeit == null;

  /// Ob das Kind bereits abgeholt wurde.
  bool get istAbgeholt => abgeholtZeit != null;

  /// Factory from Supabase anwesenheit table (snake_case)
  factory Anwesenheit.fromSupabase(Map<String, dynamic> map) {
    return Anwesenheit(
      id: map['id'] as String,
      kindId: map['kind_id'] as String? ?? '',
      datum: DateTime.parse(
        map['datum'] as String? ?? DateTime.now().toIso8601String(),
      ),
      ankunftZeit: map['ankunft_zeit'] as String?,
      abgeholtZeit: map['abgeholt_zeit'] as String?,
      status: AttendanceStatus.values.firstWhere(
        (s) => s.name == (map['status'] as String? ?? 'anwesend'),
        orElse: () => AttendanceStatus.anwesend,
      ),
      abgeholtVon: map['abgeholt_von'] as String?,
      gebrachtVon: map['gebracht_von'] as String?,
      notiz: map['notiz'] as String?,
      erfasstVon: map['erfasst_von'] as String?,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'kind_id': kindId,
      'datum': datum.toSupabaseDateString(),
      'ankunft_zeit': ankunftZeit,
      'abgeholt_zeit': abgeholtZeit,
      'status': status.name,
      'abgeholt_von': abgeholtVon,
      'gebracht_von': gebrachtVon,
      'notiz': notiz,
      'erfasst_von': erfasstVon,
      'einrichtung_id': einrichtungId,
    };
  }

  Anwesenheit copyWith({
    String? id,
    String? kindId,
    DateTime? datum,
    String? ankunftZeit,
    String? abgeholtZeit,
    AttendanceStatus? status,
    String? abgeholtVon,
    String? gebrachtVon,
    String? notiz,
    String? erfasstVon,
    String? einrichtungId,
    DateTime? erstelltAm,
  }) {
    return Anwesenheit(
      id: id ?? this.id,
      kindId: kindId ?? this.kindId,
      datum: datum ?? this.datum,
      ankunftZeit: ankunftZeit ?? this.ankunftZeit,
      abgeholtZeit: abgeholtZeit ?? this.abgeholtZeit,
      status: status ?? this.status,
      abgeholtVon: abgeholtVon ?? this.abgeholtVon,
      gebrachtVon: gebrachtVon ?? this.gebrachtVon,
      notiz: notiz ?? this.notiz,
      erfasstVon: erfasstVon ?? this.erfasstVon,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

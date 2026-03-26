import '../../core/constants/enums.dart';

/// AnwesenheitHeute — Read-only View-Modell aus v_anwesenheit_heute.
/// Kein toSupabase()/copyWith(), da Schreibzugriffe über AnwesenheitRepository laufen.
class AnwesenheitHeute {
  final String? id;
  final String kindId;
  final String vorname;
  final String nachname;
  final String? gruppeId;
  final String? gruppeName;
  final AttendanceStatus? status;
  final String? ankunftZeit;
  final String? abgeholtZeit;
  final String? notiz;
  final String einrichtungId;

  const AnwesenheitHeute({
    this.id,
    required this.kindId,
    required this.vorname,
    required this.nachname,
    this.gruppeId,
    this.gruppeName,
    this.status,
    this.ankunftZeit,
    this.abgeholtZeit,
    this.notiz,
    required this.einrichtungId,
  });

  /// Vollständiger Name des Kindes.
  String get vollstaendigerName => '$vorname $nachname';

  /// Initialen des Kindes (Großbuchstaben).
  String get initialen =>
      '${vorname.isNotEmpty ? vorname[0] : ''}${nachname.isNotEmpty ? nachname[0] : ''}'
          .toUpperCase();

  /// Ob für heute bereits ein Eintrag erfasst wurde.
  bool get istErfasst => status != null;

  /// Ob das Kind aktuell anwesend ist (Status anwesend und noch nicht abgeholt).
  bool get istAnwesend =>
      status == AttendanceStatus.anwesend && abgeholtZeit == null;

  /// Factory from Supabase v_anwesenheit_heute view (snake_case)
  factory AnwesenheitHeute.fromSupabase(Map<String, dynamic> map) {
    return AnwesenheitHeute(
      id: map['id'] as String?,
      kindId: map['kind_id'] as String? ?? '',
      vorname: map['vorname'] as String? ?? '',
      nachname: map['nachname'] as String? ?? '',
      gruppeId: map['gruppe_id'] as String?,
      gruppeName: map['gruppe_name'] as String?,
      status: map['status'] != null
          ? AttendanceStatus.values.firstWhere(
              (s) => s.name == (map['status'] as String),
              orElse: () => AttendanceStatus.anwesend,
            )
          : null,
      ankunftZeit: map['ankunft_zeit'] as String?,
      abgeholtZeit: map['abgeholt_zeit'] as String?,
      notiz: map['notiz'] as String?,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
    );
  }
}

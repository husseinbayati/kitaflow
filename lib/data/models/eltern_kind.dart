import '../../core/constants/enums.dart';

/// Modell für die Eltern-Kind-Zuordnung.
/// Bildet die Supabase-Tabelle `eltern_kind` ab.
class ElternKind {
  final String id;
  final String elternId;
  final String kindId;
  final ElternBeziehung beziehung;
  final bool istHauptkontakt;
  final DateTime erstelltAm;

  const ElternKind({
    required this.id,
    required this.elternId,
    required this.kindId,
    required this.beziehung,
    this.istHauptkontakt = false,
    required this.erstelltAm,
  });

  /// Factory from Supabase eltern_kind table (snake_case)
  factory ElternKind.fromSupabase(Map<String, dynamic> map) {
    return ElternKind(
      id: map['id'] as String,
      elternId: map['eltern_id'] as String? ?? '',
      kindId: map['kind_id'] as String? ?? '',
      beziehung: ElternBeziehung.values.firstWhere(
        (b) => b.name == (map['beziehung'] as String? ?? 'sorgeberechtigt'),
        orElse: () => ElternBeziehung.sorgeberechtigt,
      ),
      istHauptkontakt: map['ist_hauptkontakt'] as bool? ?? false,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'eltern_id': elternId,
      'kind_id': kindId,
      'beziehung': beziehung.name,
      'ist_hauptkontakt': istHauptkontakt,
    };
  }

  ElternKind copyWith({
    String? id,
    String? elternId,
    String? kindId,
    ElternBeziehung? beziehung,
    bool? istHauptkontakt,
    DateTime? erstelltAm,
  }) {
    return ElternKind(
      id: id ?? this.id,
      elternId: elternId ?? this.elternId,
      kindId: kindId ?? this.kindId,
      beziehung: beziehung ?? this.beziehung,
      istHauptkontakt: istHauptkontakt ?? this.istHauptkontakt,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

import '../../core/constants/enums.dart';

/// Modell für eine Eingewöhnung.
/// Bildet die Supabase-Tabelle `eingewoehnung` ab.
class Eingewoehnung {
  final String id;
  final String kindId;
  final DateTime startdatum;
  final DateTime? enddatum;
  final EingewoehnungPhase phase;
  final String? bezugspersonId;
  final String? notizen;
  final String? elternFeedback;
  final DateTime erstelltAm;

  const Eingewoehnung({
    required this.id,
    required this.kindId,
    required this.startdatum,
    this.enddatum,
    this.phase = EingewoehnungPhase.grundphase,
    this.bezugspersonId,
    this.notizen,
    this.elternFeedback,
    required this.erstelltAm,
  });

  /// Ob die Eingewöhnung abgeschlossen ist.
  bool get istAbgeschlossen => phase == EingewoehnungPhase.abgeschlossen;

  /// Anzahl Tage seit Beginn der Eingewöhnung.
  int get tageInEingewoehnung =>
      DateTime.now().difference(startdatum).inDays;

  factory Eingewoehnung.fromSupabase(Map<String, dynamic> map) {
    return Eingewoehnung(
      id: map['id'] as String,
      kindId: map['kind_id'] as String? ?? '',
      startdatum: DateTime.parse(map['startdatum'] as String),
      enddatum: map['enddatum'] != null
          ? DateTime.parse(map['enddatum'] as String)
          : null,
      phase: EingewoehnungPhase.values.firstWhere(
        (p) => p.name == (map['phase'] as String? ?? 'grundphase'),
        orElse: () => EingewoehnungPhase.grundphase,
      ),
      bezugspersonId: map['bezugsperson_id'] as String?,
      notizen: map['notizen'] as String?,
      elternFeedback: map['eltern_feedback'] as String?,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'kind_id': kindId,
      'startdatum': '${startdatum.year.toString().padLeft(4, '0')}-${startdatum.month.toString().padLeft(2, '0')}-${startdatum.day.toString().padLeft(2, '0')}',
      if (enddatum != null)
        'enddatum': '${enddatum!.year.toString().padLeft(4, '0')}-${enddatum!.month.toString().padLeft(2, '0')}-${enddatum!.day.toString().padLeft(2, '0')}',
      'phase': phase.name,
      'bezugsperson_id': bezugspersonId,
      'notizen': notizen,
      'eltern_feedback': elternFeedback,
    };
  }

  Eingewoehnung copyWith({
    String? id,
    String? kindId,
    DateTime? startdatum,
    DateTime? enddatum,
    EingewoehnungPhase? phase,
    String? bezugspersonId,
    String? notizen,
    String? elternFeedback,
    DateTime? erstelltAm,
  }) {
    return Eingewoehnung(
      id: id ?? this.id,
      kindId: kindId ?? this.kindId,
      startdatum: startdatum ?? this.startdatum,
      enddatum: enddatum ?? this.enddatum,
      phase: phase ?? this.phase,
      bezugspersonId: bezugspersonId ?? this.bezugspersonId,
      notizen: notizen ?? this.notizen,
      elternFeedback: elternFeedback ?? this.elternFeedback,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

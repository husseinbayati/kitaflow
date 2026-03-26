/// Modell für eine Einladung (Eltern-Onboarding-Code).
/// Bildet die Supabase-Tabelle `einladungen` ab.
class Einladung {
  final String id;
  final String einrichtungId;
  final String kindId;
  final String code;
  final String erstelltVon;
  final String? eingeloestVon;
  final DateTime? eingeloestAm;
  final DateTime gueltigBis;
  final bool aktiv;
  final DateTime erstelltAm;

  const Einladung({
    required this.id,
    required this.einrichtungId,
    required this.kindId,
    required this.code,
    required this.erstelltVon,
    this.eingeloestVon,
    this.eingeloestAm,
    required this.gueltigBis,
    this.aktiv = true,
    required this.erstelltAm,
  });

  /// Ob der Einladungscode abgelaufen ist.
  bool get istAbgelaufen => DateTime.now().isAfter(gueltigBis);

  /// Ob der Einladungscode bereits eingelöst wurde.
  bool get istEingeloest => eingeloestVon != null;

  /// Ob der Einladungscode noch gültig ist.
  bool get istGueltig => aktiv && !istAbgelaufen && !istEingeloest;

  /// Factory from Supabase einladungen table (snake_case)
  factory Einladung.fromSupabase(Map<String, dynamic> map) {
    return Einladung(
      id: map['id'] as String,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      kindId: map['kind_id'] as String? ?? '',
      code: map['code'] as String? ?? '',
      erstelltVon: map['erstellt_von'] as String? ?? '',
      eingeloestVon: map['eingeloest_von'] as String?,
      eingeloestAm: map['eingeloest_am'] != null
          ? DateTime.parse(map['eingeloest_am'] as String)
          : null,
      gueltigBis: DateTime.parse(
        map['gueltig_bis'] as String? ?? DateTime.now().toIso8601String(),
      ),
      aktiv: map['aktiv'] as bool? ?? true,
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
      'kind_id': kindId,
      'code': code,
      'erstellt_von': erstelltVon,
      'eingeloest_von': eingeloestVon,
      'eingeloest_am': eingeloestAm?.toIso8601String(),
      'gueltig_bis': gueltigBis.toIso8601String(),
      'aktiv': aktiv,
    };
  }

  Einladung copyWith({
    String? id,
    String? einrichtungId,
    String? kindId,
    String? code,
    String? erstelltVon,
    String? eingeloestVon,
    DateTime? eingeloestAm,
    DateTime? gueltigBis,
    bool? aktiv,
    DateTime? erstelltAm,
  }) {
    return Einladung(
      id: id ?? this.id,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      kindId: kindId ?? this.kindId,
      code: code ?? this.code,
      erstelltVon: erstelltVon ?? this.erstelltVon,
      eingeloestVon: eingeloestVon ?? this.eingeloestVon,
      eingeloestAm: eingeloestAm ?? this.eingeloestAm,
      gueltigBis: gueltigBis ?? this.gueltigBis,
      aktiv: aktiv ?? this.aktiv,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

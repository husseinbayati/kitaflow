class MitarbeiterEinrichtung {
  final String id;
  final String mitarbeiterId;
  final String einrichtungId;
  final String rolleInEinrichtung;
  final String? gruppeId;
  final DateTime? aktivSeit;
  final DateTime? aktivBis;

  const MitarbeiterEinrichtung({
    required this.id,
    required this.mitarbeiterId,
    required this.einrichtungId,
    required this.rolleInEinrichtung,
    this.gruppeId,
    this.aktivSeit,
    this.aktivBis,
  });

  /// Factory from Supabase mitarbeiter_einrichtung table (snake_case)
  factory MitarbeiterEinrichtung.fromSupabase(Map<String, dynamic> map) {
    return MitarbeiterEinrichtung(
      id: map['id'] as String,
      mitarbeiterId: map['mitarbeiter_id'] as String? ?? '',
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      rolleInEinrichtung: map['rolle_in_einrichtung'] as String? ?? '',
      gruppeId: map['gruppe_id'] as String?,
      aktivSeit: map['aktiv_seit'] != null
          ? DateTime.parse(map['aktiv_seit'] as String)
          : null,
      aktivBis: map['aktiv_bis'] != null
          ? DateTime.parse(map['aktiv_bis'] as String)
          : null,
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'mitarbeiter_id': mitarbeiterId,
      'einrichtung_id': einrichtungId,
      'rolle_in_einrichtung': rolleInEinrichtung,
      'gruppe_id': gruppeId,
      'aktiv_seit': aktivSeit?.toIso8601String().split('T').first,
      'aktiv_bis': aktivBis?.toIso8601String().split('T').first,
    };
  }

  MitarbeiterEinrichtung copyWith({
    String? id,
    String? mitarbeiterId,
    String? einrichtungId,
    String? rolleInEinrichtung,
    String? gruppeId,
    DateTime? aktivSeit,
    DateTime? aktivBis,
  }) {
    return MitarbeiterEinrichtung(
      id: id ?? this.id,
      mitarbeiterId: mitarbeiterId ?? this.mitarbeiterId,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      rolleInEinrichtung: rolleInEinrichtung ?? this.rolleInEinrichtung,
      gruppeId: gruppeId ?? this.gruppeId,
      aktivSeit: aktivSeit ?? this.aktivSeit,
      aktivBis: aktivBis ?? this.aktivBis,
    );
  }
}

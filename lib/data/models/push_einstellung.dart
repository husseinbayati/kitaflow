/// Modell für Push-Benachrichtigungs-Einstellungen eines Nutzers.
/// Bildet die Supabase-Tabelle `push_einstellungen` ab.
class PushEinstellung {
  final String id;
  final String userId;
  final bool nachrichten;
  final bool anwesenheit;
  final bool termine;
  final bool essensplan;
  final bool notfall;
  final String? ruhezeitVon;
  final String? ruhezeitBis;
  final DateTime erstelltAm;
  final DateTime aktualisiertAm;

  const PushEinstellung({
    required this.id,
    required this.userId,
    this.nachrichten = true,
    this.anwesenheit = true,
    this.termine = true,
    this.essensplan = false,
    this.notfall = true,
    this.ruhezeitVon,
    this.ruhezeitBis,
    required this.erstelltAm,
    required this.aktualisiertAm,
  });

  /// Factory from Supabase push_einstellungen table (snake_case)
  factory PushEinstellung.fromSupabase(Map<String, dynamic> map) {
    return PushEinstellung(
      id: map['id'] as String,
      userId: map['user_id'] as String? ?? '',
      nachrichten: map['nachrichten'] as bool? ?? true,
      anwesenheit: map['anwesenheit'] as bool? ?? true,
      termine: map['termine'] as bool? ?? true,
      essensplan: map['essensplan'] as bool? ?? false,
      notfall: map['notfall'] as bool? ?? true,
      ruhezeitVon: map['ruhezeit_von'] as String?,
      ruhezeitBis: map['ruhezeit_bis'] as String?,
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
      'user_id': userId,
      'nachrichten': nachrichten,
      'anwesenheit': anwesenheit,
      'termine': termine,
      'essensplan': essensplan,
      'notfall': notfall,
      'ruhezeit_von': ruhezeitVon,
      'ruhezeit_bis': ruhezeitBis,
    };
  }

  PushEinstellung copyWith({
    String? id,
    String? userId,
    bool? nachrichten,
    bool? anwesenheit,
    bool? termine,
    bool? essensplan,
    bool? notfall,
    String? ruhezeitVon,
    String? ruhezeitBis,
    DateTime? erstelltAm,
    DateTime? aktualisiertAm,
  }) {
    return PushEinstellung(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nachrichten: nachrichten ?? this.nachrichten,
      anwesenheit: anwesenheit ?? this.anwesenheit,
      termine: termine ?? this.termine,
      essensplan: essensplan ?? this.essensplan,
      notfall: notfall ?? this.notfall,
      ruhezeitVon: ruhezeitVon ?? this.ruhezeitVon,
      ruhezeitBis: ruhezeitBis ?? this.ruhezeitBis,
      erstelltAm: erstelltAm ?? this.erstelltAm,
      aktualisiertAm: aktualisiertAm ?? this.aktualisiertAm,
    );
  }
}

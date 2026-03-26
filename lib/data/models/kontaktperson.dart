class Kontaktperson {
  final String id;
  final String kindId;
  final String name;
  final String beziehung;
  final String? telefon;
  final String? email;
  final bool istAbholberechtigt;
  final bool istNotfallkontakt;
  final int prioritaet;
  final DateTime erstelltAm;

  const Kontaktperson({
    required this.id,
    required this.kindId,
    required this.name,
    required this.beziehung,
    this.telefon,
    this.email,
    this.istAbholberechtigt = false,
    this.istNotfallkontakt = false,
    this.prioritaet = 0,
    required this.erstelltAm,
  });

  /// Factory from Supabase kontaktpersonen table (snake_case)
  factory Kontaktperson.fromSupabase(Map<String, dynamic> map) {
    return Kontaktperson(
      id: map['id'] as String,
      kindId: map['kind_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      beziehung: map['beziehung'] as String? ?? '',
      telefon: map['telefon'] as String?,
      email: map['email'] as String?,
      istAbholberechtigt: map['ist_abholberechtigt'] as bool? ?? false,
      istNotfallkontakt: map['ist_notfallkontakt'] as bool? ?? false,
      prioritaet: map['prioritaet'] as int? ?? 0,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'kind_id': kindId,
      'name': name,
      'beziehung': beziehung,
      'telefon': telefon,
      'email': email,
      'ist_abholberechtigt': istAbholberechtigt,
      'ist_notfallkontakt': istNotfallkontakt,
      'prioritaet': prioritaet,
    };
  }

  Kontaktperson copyWith({
    String? id,
    String? kindId,
    String? name,
    String? beziehung,
    String? telefon,
    String? email,
    bool? istAbholberechtigt,
    bool? istNotfallkontakt,
    int? prioritaet,
    DateTime? erstelltAm,
  }) {
    return Kontaktperson(
      id: id ?? this.id,
      kindId: kindId ?? this.kindId,
      name: name ?? this.name,
      beziehung: beziehung ?? this.beziehung,
      telefon: telefon ?? this.telefon,
      email: email ?? this.email,
      istAbholberechtigt: istAbholberechtigt ?? this.istAbholberechtigt,
      istNotfallkontakt: istNotfallkontakt ?? this.istNotfallkontakt,
      prioritaet: prioritaet ?? this.prioritaet,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

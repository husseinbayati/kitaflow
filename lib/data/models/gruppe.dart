class Gruppe {
  final String id;
  final String einrichtungId;
  final String name;
  final String typ;
  final int? maxKinder;
  final int? altersspanneVon;
  final int? altersspanneBis;
  final String? farbe;
  final bool aktiv;
  final String? schuljahr;
  final DateTime erstelltAm;

  const Gruppe({
    required this.id,
    required this.einrichtungId,
    required this.name,
    required this.typ,
    this.maxKinder,
    this.altersspanneVon,
    this.altersspanneBis,
    this.farbe,
    this.aktiv = true,
    this.schuljahr,
    required this.erstelltAm,
  });

  /// Factory from Supabase gruppen table (snake_case)
  factory Gruppe.fromSupabase(Map<String, dynamic> map) {
    return Gruppe(
      id: map['id'] as String,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      typ: map['typ'] as String? ?? '',
      maxKinder: map['max_kinder'] as int?,
      altersspanneVon: map['altersspanne_von'] as int?,
      altersspanneBis: map['altersspanne_bis'] as int?,
      farbe: map['farbe'] as String?,
      aktiv: map['aktiv'] as bool? ?? true,
      schuljahr: map['schuljahr'] as String?,
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
      'name': name,
      'typ': typ,
      'max_kinder': maxKinder,
      'altersspanne_von': altersspanneVon,
      'altersspanne_bis': altersspanneBis,
      'farbe': farbe,
      'aktiv': aktiv,
      'schuljahr': schuljahr,
    };
  }

  Gruppe copyWith({
    String? id,
    String? einrichtungId,
    String? name,
    String? typ,
    int? maxKinder,
    int? altersspanneVon,
    int? altersspanneBis,
    String? farbe,
    bool? aktiv,
    String? schuljahr,
    DateTime? erstelltAm,
  }) {
    return Gruppe(
      id: id ?? this.id,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      name: name ?? this.name,
      typ: typ ?? this.typ,
      maxKinder: maxKinder ?? this.maxKinder,
      altersspanneVon: altersspanneVon ?? this.altersspanneVon,
      altersspanneBis: altersspanneBis ?? this.altersspanneBis,
      farbe: farbe ?? this.farbe,
      aktiv: aktiv ?? this.aktiv,
      schuljahr: schuljahr ?? this.schuljahr,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

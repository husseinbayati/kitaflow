import '../../core/constants/enums.dart';

/// Modell für eine Einrichtung (Kita, Krippe, Grundschule etc.).
/// Bildet die Supabase-Tabelle `einrichtungen` ab.
class Einrichtung {
  final String id;
  final String name;
  final InstitutionType typ;
  final String? adresseStrasse;
  final String? adressePlz;
  final String? adresseOrt;
  final String? adresseBundesland;
  final String? telefon;
  final String? email;
  final String? website;
  final String? traegerId;
  final Map<String, dynamic> einstellungen;
  final bool aktiv;
  final DateTime erstelltAm;
  final DateTime aktualisiertAm;

  const Einrichtung({
    required this.id,
    required this.name,
    required this.typ,
    this.adresseStrasse,
    this.adressePlz,
    this.adresseOrt,
    this.adresseBundesland,
    this.telefon,
    this.email,
    this.website,
    this.traegerId,
    this.einstellungen = const {},
    this.aktiv = true,
    required this.erstelltAm,
    required this.aktualisiertAm,
  });

  /// Vollständige Adresse aus Straße, PLZ und Ort (Nullwerte werden übersprungen).
  String get vollstaendigeAdresse {
    final teile = <String>[
      if (adresseStrasse != null) adresseStrasse!,
      if (adressePlz != null && adresseOrt != null)
        '$adressePlz $adresseOrt'
      else if (adressePlz != null)
        adressePlz!
      else if (adresseOrt != null)
        adresseOrt!,
    ];
    return teile.join(', ');
  }

  /// Factory from Supabase einrichtungen table (snake_case)
  factory Einrichtung.fromSupabase(Map<String, dynamic> map) {
    return Einrichtung(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      typ: InstitutionType.values.firstWhere(
        (t) => t.name == (map['typ'] as String? ?? 'kita'),
        orElse: () => InstitutionType.kita,
      ),
      adresseStrasse: map['adresse_strasse'] as String?,
      adressePlz: map['adresse_plz'] as String?,
      adresseOrt: map['adresse_ort'] as String?,
      adresseBundesland: map['adresse_bundesland'] as String?,
      telefon: map['telefon'] as String?,
      email: map['email'] as String?,
      website: map['website'] as String?,
      traegerId: map['traeger_id'] as String?,
      einstellungen:
          (map['einstellungen'] as Map<String, dynamic>?) ?? const {},
      aktiv: map['aktiv'] as bool? ?? true,
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
      'name': name,
      'typ': typ.name,
      'adresse_strasse': adresseStrasse,
      'adresse_plz': adressePlz,
      'adresse_ort': adresseOrt,
      'adresse_bundesland': adresseBundesland,
      'telefon': telefon,
      'email': email,
      'website': website,
      'traeger_id': traegerId,
      'einstellungen': einstellungen,
      'aktiv': aktiv,
    };
  }

  Einrichtung copyWith({
    String? id,
    String? name,
    InstitutionType? typ,
    String? adresseStrasse,
    String? adressePlz,
    String? adresseOrt,
    String? adresseBundesland,
    String? telefon,
    String? email,
    String? website,
    String? traegerId,
    Map<String, dynamic>? einstellungen,
    bool? aktiv,
    DateTime? erstelltAm,
    DateTime? aktualisiertAm,
  }) {
    return Einrichtung(
      id: id ?? this.id,
      name: name ?? this.name,
      typ: typ ?? this.typ,
      adresseStrasse: adresseStrasse ?? this.adresseStrasse,
      adressePlz: adressePlz ?? this.adressePlz,
      adresseOrt: adresseOrt ?? this.adresseOrt,
      adresseBundesland: adresseBundesland ?? this.adresseBundesland,
      telefon: telefon ?? this.telefon,
      email: email ?? this.email,
      website: website ?? this.website,
      traegerId: traegerId ?? this.traegerId,
      einstellungen: einstellungen ?? this.einstellungen,
      aktiv: aktiv ?? this.aktiv,
      erstelltAm: erstelltAm ?? this.erstelltAm,
      aktualisiertAm: aktualisiertAm ?? this.aktualisiertAm,
    );
  }
}

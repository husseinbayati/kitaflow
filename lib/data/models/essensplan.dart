import '../../core/constants/enums.dart';
import '../../core/extensions/datetime_extensions.dart';

/// Modell für einen Essensplan-Eintrag einer Einrichtung.
/// Bildet die Supabase-Tabelle `essensplaene` ab.
class Essensplan {
  final String id;
  final String einrichtungId;
  final DateTime datum;
  final MealType mahlzeitTyp;
  final String gerichtName;
  final String? beschreibung;
  final List<String> allergene;
  final bool vegetarisch;
  final bool vegan;
  final String? bildUrl;
  final String? erstelltVon;
  final DateTime erstelltAm;

  const Essensplan({
    required this.id,
    required this.einrichtungId,
    required this.datum,
    required this.mahlzeitTyp,
    required this.gerichtName,
    this.beschreibung,
    this.allergene = const [],
    this.vegetarisch = false,
    this.vegan = false,
    this.bildUrl,
    this.erstelltVon,
    required this.erstelltAm,
  });

  /// Ob der Essensplan Allergene enthält.
  bool get hatAllergene => allergene.isNotEmpty;

  /// Allergene als typisierte Enum-Liste (unbekannte Werte werden übersprungen).
  List<Allergen> get allergenEnums {
    return allergene
        .map((name) {
          try {
            return Allergen.values.firstWhere((a) => a.name == name);
          } catch (_) {
            return null;
          }
        })
        .whereType<Allergen>()
        .toList();
  }

  /// Ob das Gericht vegetarisch ist.
  bool get istVegetarisch => vegetarisch;

  /// Ob das Gericht vegan ist.
  bool get istVegan => vegan;

  /// Factory from Supabase essensplaene table (snake_case)
  factory Essensplan.fromSupabase(Map<String, dynamic> map) {
    return Essensplan(
      id: map['id'] as String,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      datum: DateTime.parse(
        map['datum'] as String? ?? DateTime.now().toIso8601String(),
      ),
      mahlzeitTyp: MealType.values.firstWhere(
        (m) => m.name == (map['mahlzeit_typ'] as String? ?? 'mittagessen'),
        orElse: () => MealType.mittagessen,
      ),
      gerichtName: map['gericht_name'] as String? ?? '',
      beschreibung: map['beschreibung'] as String?,
      allergene: (map['allergene'] as List?)?.cast<String>() ?? [],
      vegetarisch: map['vegetarisch'] as bool? ?? false,
      vegan: map['vegan'] as bool? ?? false,
      bildUrl: map['bild_url'] as String?,
      erstelltVon: map['erstellt_von'] as String?,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case)
  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'einrichtung_id': einrichtungId,
      'datum': datum.toSupabaseDateString(),
      'mahlzeit_typ': mahlzeitTyp.name,
      'gericht_name': gerichtName,
      'beschreibung': beschreibung,
      'allergene': allergene,
      'vegetarisch': vegetarisch,
      'vegan': vegan,
      'bild_url': bildUrl,
      'erstellt_von': erstelltVon,
    };
  }

  Essensplan copyWith({
    String? id,
    String? einrichtungId,
    DateTime? datum,
    MealType? mahlzeitTyp,
    String? gerichtName,
    String? beschreibung,
    List<String>? allergene,
    bool? vegetarisch,
    bool? vegan,
    String? bildUrl,
    String? erstelltVon,
    DateTime? erstelltAm,
  }) {
    return Essensplan(
      id: id ?? this.id,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      datum: datum ?? this.datum,
      mahlzeitTyp: mahlzeitTyp ?? this.mahlzeitTyp,
      gerichtName: gerichtName ?? this.gerichtName,
      beschreibung: beschreibung ?? this.beschreibung,
      allergene: allergene ?? this.allergene,
      vegetarisch: vegetarisch ?? this.vegetarisch,
      vegan: vegan ?? this.vegan,
      bildUrl: bildUrl ?? this.bildUrl,
      erstelltVon: erstelltVon ?? this.erstelltVon,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

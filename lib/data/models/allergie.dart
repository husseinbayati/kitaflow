import '../../core/constants/enums.dart';

class Allergie {
  final String id;
  final String kindId;
  final Allergen allergen;
  final AllergySeverity schweregrad;
  final String? hinweise;
  final DateTime erstelltAm;

  const Allergie({
    required this.id,
    required this.kindId,
    required this.allergen,
    required this.schweregrad,
    this.hinweise,
    required this.erstelltAm,
  });

  /// Factory from Supabase allergien table (snake_case)
  factory Allergie.fromSupabase(Map<String, dynamic> map) {
    return Allergie(
      id: map['id'] as String,
      kindId: map['kind_id'] as String? ?? '',
      allergen: Allergen.values.firstWhere(
        (a) => a.name == (map['allergen'] as String? ?? 'sonstiges'),
        orElse: () => Allergen.gluten,
      ),
      schweregrad: AllergySeverity.values.firstWhere(
        (s) => s.name == (map['schweregrad'] as String? ?? 'mittel'),
        orElse: () => AllergySeverity.mittel,
      ),
      hinweise: map['hinweise'] as String?,
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
      'allergen': allergen.name,
      'schweregrad': schweregrad.name,
      'hinweise': hinweise,
    };
  }

  Allergie copyWith({
    String? id,
    String? kindId,
    Allergen? allergen,
    AllergySeverity? schweregrad,
    String? hinweise,
    DateTime? erstelltAm,
  }) {
    return Allergie(
      id: id ?? this.id,
      kindId: kindId ?? this.kindId,
      allergen: allergen ?? this.allergen,
      schweregrad: schweregrad ?? this.schweregrad,
      hinweise: hinweise ?? this.hinweise,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

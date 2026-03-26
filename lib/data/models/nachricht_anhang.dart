/// NachrichtAnhang — Dateianhang zu einer Nachricht.
class NachrichtAnhang {
  final String id;
  final String nachrichtId;
  final String dateiname;
  final String dateipfad;
  final String? dateityp;
  final int? dateigroesse;
  final DateTime erstelltAm;

  const NachrichtAnhang({
    required this.id,
    required this.nachrichtId,
    required this.dateiname,
    required this.dateipfad,
    this.dateityp,
    this.dateigroesse,
    required this.erstelltAm,
  });

  /// Ob der Anhang ein Bild ist (anhand des MIME-Typs).
  bool get istBild => dateityp?.startsWith('image/') ?? false;

  /// Factory from Supabase nachricht_anhaenge table (snake_case).
  factory NachrichtAnhang.fromSupabase(Map<String, dynamic> map) {
    return NachrichtAnhang(
      id: map['id'] as String,
      nachrichtId: map['nachricht_id'] as String? ?? '',
      dateiname: map['dateiname'] as String? ?? '',
      dateipfad: map['dateipfad'] as String? ?? '',
      dateityp: map['dateityp'] as String?,
      dateigroesse: map['dateigroesse'] as int?,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Convert to Supabase-compatible map (snake_case, für INSERT).
  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'nachricht_id': nachrichtId,
      'dateiname': dateiname,
      'dateipfad': dateipfad,
      'dateityp': dateityp,
      'dateigroesse': dateigroesse,
    };
  }

  /// Kopie mit optional geänderten Feldern erstellen.
  NachrichtAnhang copyWith({
    String? id,
    String? nachrichtId,
    String? dateiname,
    String? dateipfad,
    String? dateityp,
    int? dateigroesse,
    DateTime? erstelltAm,
  }) {
    return NachrichtAnhang(
      id: id ?? this.id,
      nachrichtId: nachrichtId ?? this.nachrichtId,
      dateiname: dateiname ?? this.dateiname,
      dateipfad: dateipfad ?? this.dateipfad,
      dateityp: dateityp ?? this.dateityp,
      dateigroesse: dateigroesse ?? this.dateigroesse,
      erstelltAm: erstelltAm ?? this.erstelltAm,
    );
  }
}

import '../../core/constants/enums.dart';

class Kind {
  final String id;
  final String vorname;
  final String nachname;
  final DateTime geburtsdatum;
  final String geschlecht;
  final String? avatarUrl;
  final String einrichtungId;
  final String? gruppeId;
  final ChildStatus status;
  final DateTime? eintrittsdatum;
  final DateTime? austrittsdatum;
  final String? notizen;
  final DateTime erstelltAm;
  final DateTime aktualisiertAm;

  const Kind({
    required this.id,
    required this.vorname,
    required this.nachname,
    required this.geburtsdatum,
    required this.geschlecht,
    this.avatarUrl,
    required this.einrichtungId,
    this.gruppeId,
    this.status = ChildStatus.aktiv,
    this.eintrittsdatum,
    this.austrittsdatum,
    this.notizen,
    required this.erstelltAm,
    required this.aktualisiertAm,
  });

  String get vollstaendigerName => '$vorname $nachname';

  String get initialen =>
      '${vorname.isNotEmpty ? vorname[0] : ''}${nachname.isNotEmpty ? nachname[0] : ''}'
          .toUpperCase();

  /// Alter in Jahren berechnet vom Geburtsdatum.
  int get alter {
    final heute = DateTime.now();
    int jahre = heute.year - geburtsdatum.year;
    if (heute.month < geburtsdatum.month ||
        (heute.month == geburtsdatum.month && heute.day < geburtsdatum.day)) {
      jahre--;
    }
    return jahre;
  }

  /// Factory from Supabase kinder table (snake_case)
  factory Kind.fromSupabase(Map<String, dynamic> map) {
    return Kind(
      id: map['id'] as String,
      vorname: map['vorname'] as String? ?? '',
      nachname: map['nachname'] as String? ?? '',
      geburtsdatum: DateTime.parse(
        map['geburtsdatum'] as String? ?? DateTime.now().toIso8601String(),
      ),
      geschlecht: map['geschlecht'] as String? ?? '',
      avatarUrl: map['avatar_url'] as String?,
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      gruppeId: map['gruppe_id'] as String?,
      status: ChildStatus.values.firstWhere(
        (s) => s.name == (map['status'] as String? ?? 'aktiv'),
        orElse: () => ChildStatus.aktiv,
      ),
      eintrittsdatum: map['eintrittsdatum'] != null
          ? DateTime.parse(map['eintrittsdatum'] as String)
          : null,
      austrittsdatum: map['austrittsdatum'] != null
          ? DateTime.parse(map['austrittsdatum'] as String)
          : null,
      notizen: map['notizen'] as String?,
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
      'vorname': vorname,
      'nachname': nachname,
      'geburtsdatum': geburtsdatum.toIso8601String(),
      'geschlecht': geschlecht,
      'avatar_url': avatarUrl,
      'einrichtung_id': einrichtungId,
      'gruppe_id': gruppeId,
      'status': status.name,
      'eintrittsdatum': eintrittsdatum?.toIso8601String(),
      'austrittsdatum': austrittsdatum?.toIso8601String(),
      'notizen': notizen,
    };
  }

  Kind copyWith({
    String? id,
    String? vorname,
    String? nachname,
    DateTime? geburtsdatum,
    String? geschlecht,
    String? avatarUrl,
    String? einrichtungId,
    String? gruppeId,
    ChildStatus? status,
    DateTime? eintrittsdatum,
    DateTime? austrittsdatum,
    String? notizen,
    DateTime? erstelltAm,
    DateTime? aktualisiertAm,
  }) {
    return Kind(
      id: id ?? this.id,
      vorname: vorname ?? this.vorname,
      nachname: nachname ?? this.nachname,
      geburtsdatum: geburtsdatum ?? this.geburtsdatum,
      geschlecht: geschlecht ?? this.geschlecht,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      gruppeId: gruppeId ?? this.gruppeId,
      status: status ?? this.status,
      eintrittsdatum: eintrittsdatum ?? this.eintrittsdatum,
      austrittsdatum: austrittsdatum ?? this.austrittsdatum,
      notizen: notizen ?? this.notizen,
      erstelltAm: erstelltAm ?? this.erstelltAm,
      aktualisiertAm: aktualisiertAm ?? this.aktualisiertAm,
    );
  }
}

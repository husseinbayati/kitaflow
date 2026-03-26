import '../../core/constants/enums.dart';

/// Nachricht — Hauptmodell für Nachrichten (Elternbriefe, Ankündigungen etc.)
class Nachricht {
  final String id;
  final String absenderId;
  final String einrichtungId;
  final MessageType typ;
  final String betreff;
  final String inhalt;
  final String empfaengerTyp;
  final String? gruppeId;
  final bool wichtig;
  final DateTime erstelltAm;

  /// Optionale Felder aus JOIN mit profiles-Tabelle
  final String? absenderVorname;
  final String? absenderNachname;

  const Nachricht({
    required this.id,
    required this.absenderId,
    required this.einrichtungId,
    required this.typ,
    required this.betreff,
    required this.inhalt,
    required this.empfaengerTyp,
    this.gruppeId,
    required this.wichtig,
    required this.erstelltAm,
    this.absenderVorname,
    this.absenderNachname,
  });

  /// Vollständiger Absendername oder 'Unbekannt'.
  String get absenderName {
    final vorname = absenderVorname ?? '';
    final nachname = absenderNachname ?? '';
    final name = '$vorname $nachname'.trim();
    return name.isNotEmpty ? name : 'Unbekannt';
  }

  /// Ob es sich um eine Notfall-Nachricht handelt.
  bool get istNotfall => typ == MessageType.notfall;

  /// Ob es sich um einen Elternbrief handelt.
  bool get istElternbrief => typ == MessageType.elternbrief;

  /// Factory from Supabase nachrichten table (snake_case).
  /// Unterstützt optionalen JOIN mit profiles (als 'profiles'-Key).
  factory Nachricht.fromSupabase(Map<String, dynamic> map) {
    // Joined profiles-Daten extrahieren
    final profiles = map['profiles'] as Map<String, dynamic>?;

    return Nachricht(
      id: map['id'] as String,
      absenderId: map['absender_id'] as String? ?? '',
      einrichtungId: map['einrichtung_id'] as String? ?? '',
      typ: MessageType.values.firstWhere(
        (t) => t.name == (map['typ'] as String? ?? 'nachricht'),
        orElse: () => MessageType.nachricht,
      ),
      betreff: map['betreff'] as String? ?? '',
      inhalt: map['inhalt'] as String? ?? '',
      empfaengerTyp: map['empfaenger_typ'] as String? ?? 'alle',
      gruppeId: map['gruppe_id'] as String?,
      wichtig: map['wichtig'] as bool? ?? false,
      erstelltAm: DateTime.parse(
        map['erstellt_am'] as String? ?? DateTime.now().toIso8601String(),
      ),
      absenderVorname: profiles?['vorname'] as String?,
      absenderNachname: profiles?['nachname'] as String?,
    );
  }

  /// Convert to Supabase-compatible map (snake_case, für INSERT).
  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'absender_id': absenderId,
      'einrichtung_id': einrichtungId,
      'typ': typ.name,
      'betreff': betreff,
      'inhalt': inhalt,
      'empfaenger_typ': empfaengerTyp,
      'gruppe_id': gruppeId,
      'wichtig': wichtig,
    };
  }

  Nachricht copyWith({
    String? id,
    String? absenderId,
    String? einrichtungId,
    MessageType? typ,
    String? betreff,
    String? inhalt,
    String? empfaengerTyp,
    String? gruppeId,
    bool? wichtig,
    DateTime? erstelltAm,
    String? absenderVorname,
    String? absenderNachname,
  }) {
    return Nachricht(
      id: id ?? this.id,
      absenderId: absenderId ?? this.absenderId,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      typ: typ ?? this.typ,
      betreff: betreff ?? this.betreff,
      inhalt: inhalt ?? this.inhalt,
      empfaengerTyp: empfaengerTyp ?? this.empfaengerTyp,
      gruppeId: gruppeId ?? this.gruppeId,
      wichtig: wichtig ?? this.wichtig,
      erstelltAm: erstelltAm ?? this.erstelltAm,
      absenderVorname: absenderVorname ?? this.absenderVorname,
      absenderNachname: absenderNachname ?? this.absenderNachname,
    );
  }
}

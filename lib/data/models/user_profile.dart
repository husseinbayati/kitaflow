import '../../core/constants/enums.dart';

class UserProfile {
  final String id;
  final String email;
  final String vorname;
  final String nachname;
  final UserRole rolle;
  final String? einrichtungId;
  final String? gruppeId;
  final String? avatarUrl;
  final String? telefon;
  final String sprache;
  final String? pushToken;
  final bool aktiv;
  final bool emailVerifiziert;
  final DateTime erstelltAm;
  final DateTime aktualisiertAm;

  const UserProfile({
    required this.id,
    required this.email,
    required this.vorname,
    required this.nachname,
    required this.rolle,
    this.einrichtungId,
    this.gruppeId,
    this.avatarUrl,
    this.telefon,
    this.sprache = 'de',
    this.pushToken,
    this.aktiv = true,
    this.emailVerifiziert = false,
    required this.erstelltAm,
    required this.aktualisiertAm,
  });

  String get vollstaendigerName => '$vorname $nachname';
  String get initialen =>
      '${vorname.isNotEmpty ? vorname[0] : ''}${nachname.isNotEmpty ? nachname[0] : ''}'
          .toUpperCase();

  /// Factory from Supabase profiles table (snake_case)
  factory UserProfile.fromSupabase(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      email: map['email'] as String? ?? '',
      vorname: map['vorname'] as String? ?? '',
      nachname: map['nachname'] as String? ?? '',
      rolle: UserRole.values.firstWhere(
        (r) => r.name == (map['rolle'] as String? ?? 'erzieher'),
        orElse: () => UserRole.erzieher,
      ),
      einrichtungId: map['einrichtung_id'] as String?,
      gruppeId: map['gruppe_id'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      telefon: map['telefon'] as String?,
      sprache: map['sprache'] as String? ?? 'de',
      pushToken: map['push_token'] as String?,
      aktiv: map['aktiv'] as bool? ?? true,
      emailVerifiziert: map['email_verifiziert'] as bool? ?? false,
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
      'email': email,
      'vorname': vorname,
      'nachname': nachname,
      'rolle': rolle.name,
      'einrichtung_id': einrichtungId,
      'gruppe_id': gruppeId,
      'avatar_url': avatarUrl,
      'telefon': telefon,
      'sprache': sprache,
      'push_token': pushToken,
      'aktiv': aktiv,
      'email_verifiziert': emailVerifiziert,
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? vorname,
    String? nachname,
    UserRole? rolle,
    String? einrichtungId,
    String? gruppeId,
    String? avatarUrl,
    String? telefon,
    String? sprache,
    String? pushToken,
    bool? aktiv,
    bool? emailVerifiziert,
    DateTime? erstelltAm,
    DateTime? aktualisiertAm,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      vorname: vorname ?? this.vorname,
      nachname: nachname ?? this.nachname,
      rolle: rolle ?? this.rolle,
      einrichtungId: einrichtungId ?? this.einrichtungId,
      gruppeId: gruppeId ?? this.gruppeId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      telefon: telefon ?? this.telefon,
      sprache: sprache ?? this.sprache,
      pushToken: pushToken ?? this.pushToken,
      aktiv: aktiv ?? this.aktiv,
      emailVerifiziert: emailVerifiziert ?? this.emailVerifiziert,
      erstelltAm: erstelltAm ?? this.erstelltAm,
      aktualisiertAm: aktualisiertAm ?? this.aktualisiertAm,
    );
  }
}

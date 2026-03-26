import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/user_profile.dart';
import '../../core/constants/enums.dart';

/// Repository für Authentifizierung und Benutzerverwaltung.
/// Kapselt alle Supabase GoTrue und Profil-Operationen.
class AuthRepository {
  GoTrueClient get _auth => SupabaseConfig.auth;
  SupabaseClient get _client => SupabaseConfig.client;

  /// Login mit Email und Passwort.
  Future<UserProfile> signInWithEmail(String email, String password) async {
    final response = await _auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Anmeldung fehlgeschlagen');
    }

    return _fetchProfile(response.user!.id);
  }

  /// Registrierung mit Email, Passwort und Profildaten.
  Future<UserProfile> signUpWithEmail({
    required String email,
    required String password,
    required String vorname,
    required String nachname,
    required UserRole rolle,
  }) async {
    final response = await _auth.signUp(
      email: email,
      password: password,
      data: {
        'vorname': vorname,
        'nachname': nachname,
        'rolle': rolle.name,
      },
    );

    if (response.user == null) {
      throw Exception('Registrierung fehlgeschlagen');
    }

    // Profil in profiles-Tabelle erstellen
    await _createProfile(
      userId: response.user!.id,
      email: email,
      vorname: vorname,
      nachname: nachname,
      rolle: rolle,
    );

    return _fetchProfile(response.user!.id);
  }

  /// Abmelden.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Passwort-Reset E-Mail senden.
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.resetPasswordForEmail(email);
  }

  /// Aktuellen Benutzer laden.
  Future<UserProfile?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      return await _fetchProfile(user.id);
    } catch (_) {
      return null;
    }
  }

  /// Profil aktualisieren.
  Future<void> updateProfile(UserProfile profile) async {
    await _client
        .from('profiles')
        .update(profile.toSupabase())
        .eq('id', profile.id);
  }

  /// Auth-Status Stream (für AuthProvider).
  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;

  /// Prüfe ob aktuell authentifiziert.
  bool isAuthenticated() => SupabaseConfig.isAuthenticated;

  /// Session erneuern.
  Future<void> refreshSession() async {
    await _auth.refreshSession();
  }

  /// Konto löschen (DSGVO: Recht auf Löschung).
  /// Löscht Profil und Auth-User.
  Future<void> deleteAccount() async {
    final userId = _auth.currentUser?.id;
    if (userId == null) return;

    // Profil löschen (Cascade löscht verknüpfte Daten via DB)
    await _client.from('profiles').delete().eq('id', userId);

    // Auth signout (User-Löschung muss serverseitig erfolgen)
    await _auth.signOut();
  }

  // --- Private Helper ---

  /// Profil aus profiles-Tabelle laden.
  Future<UserProfile> _fetchProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return UserProfile.fromSupabase(response);
  }

  /// Profil in profiles-Tabelle erstellen.
  Future<void> _createProfile({
    required String userId,
    required String email,
    required String vorname,
    required String nachname,
    required UserRole rolle,
  }) async {
    await _client.from('profiles').insert({
      'id': userId,
      'email': email,
      'vorname': vorname,
      'nachname': nachname,
      'rolle': rolle.name,
      'sprache': 'de',
      'aktiv': true,
      'email_verifiziert': false,
      'erstellt_am': DateTime.now().toIso8601String(),
      'aktualisiert_am': DateTime.now().toIso8601String(),
    });
  }

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('invalid login credentials')) {
      return 'Ungültige Anmeldedaten. Bitte überprüfe E-Mail und Passwort.';
    } else if (errorString.contains('user already registered') ||
        errorString.contains('already exists')) {
      return 'Diese E-Mail-Adresse ist bereits registriert.';
    } else if (errorString.contains('email not confirmed')) {
      return 'Bitte bestätige zuerst deine E-Mail-Adresse.';
    } else if (errorString.contains('password should be')) {
      return 'Das Passwort muss mindestens 8 Zeichen lang sein.';
    } else if (errorString.contains('rate limit') ||
        errorString.contains('too many requests')) {
      return 'Zu viele Versuche. Bitte warte einen Moment.';
    } else if (errorString.contains('network') ||
        errorString.contains('socketexception') ||
        errorString.contains('connection')) {
      return 'Keine Internetverbindung. Bitte prüfe dein Netzwerk.';
    }

    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
  }
}

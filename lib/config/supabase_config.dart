import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase-Konfiguration für KitaFlow.
/// URL und Key MÜSSEN über --dart-define gesetzt werden.
/// Beispiel: flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
class SupabaseConfig {
  static const String _url = String.fromEnvironment('SUPABASE_URL');
  static const String _anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Prüft ob die Konfiguration vollständig ist.
  /// Muss vor Supabase.initialize() aufgerufen werden.
  static void validate() {
    if (_url.isEmpty) {
      throw StateError(
        'SUPABASE_URL nicht gesetzt. '
        'Starte mit: flutter run --dart-define=SUPABASE_URL=https://...',
      );
    }
    if (_anonKey.isEmpty) {
      throw StateError(
        'SUPABASE_ANON_KEY nicht gesetzt. '
        'Starte mit: flutter run --dart-define=SUPABASE_ANON_KEY=...',
      );
    }
  }

  static String get url => _url;
  static String get anonKey => _anonKey;

  static bool get isInitialized {
    try {
      Supabase.instance;
      return true;
    } catch (_) {
      return false;
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
  static GoTrueClient get auth => client.auth;
  static SupabaseStorageClient get storage => client.storage;

  static User? get currentUser => auth.currentUser;
  static bool get isAuthenticated => currentUser != null;
  static Session? get currentSession => auth.currentSession;
}

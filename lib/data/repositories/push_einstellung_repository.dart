import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/push_einstellung.dart';

/// Repository für Push-Einstellungen.
/// Kapselt alle Supabase-Operationen für Benachrichtigungs-Präferenzen
/// eines Nutzers (Ruhezeiten, Kategorien).
class PushEinstellungRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Einstellungen laden
  // ---------------------------------------------------------------------------

  /// Push-Einstellungen eines Nutzers laden.
  /// Gibt `null` zurück, wenn noch keine Einstellungen vorhanden sind.
  Future<PushEinstellung?> fetch(String userId) async {
    final response = await _client
        .from('push_einstellungen')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return PushEinstellung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Einstellungen speichern (Upsert)
  // ---------------------------------------------------------------------------

  /// Push-Einstellungen erstellen oder aktualisieren (Upsert).
  Future<PushEinstellung> upsert(PushEinstellung einstellung) async {
    final response = await _client
        .from('push_einstellungen')
        .upsert(
          einstellung.toSupabase(),
          onConflict: 'user_id',
        )
        .select()
        .single();

    return PushEinstellung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Die Push-Einstellungen wurden nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Die Push-Einstellungen existieren bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Die Einstellungen können nicht gespeichert werden, da verknüpfte Daten fehlen.';
    } else if (errorString.contains('network') ||
        errorString.contains('socketexception') ||
        errorString.contains('connection')) {
      return 'Keine Internetverbindung. Bitte prüfe dein Netzwerk.';
    } else if (errorString.contains('rate limit') ||
        errorString.contains('too many requests')) {
      return 'Zu viele Anfragen. Bitte warte einen Moment.';
    }

    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
  }
}

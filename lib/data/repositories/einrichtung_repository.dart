import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/einrichtung.dart';

/// Repository für Einrichtungs-Verwaltung.
/// Kapselt alle Supabase-Operationen für Einrichtungen.
class EinrichtungRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Einzelne Einrichtung laden
  // ---------------------------------------------------------------------------

  /// Einrichtung anhand der ID laden.
  /// Gibt `null` zurück, falls keine Einrichtung gefunden wird.
  Future<Einrichtung?> fetchById(String id) async {
    final response = await _client
        .from('einrichtungen')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return Einrichtung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Aktualisieren
  // ---------------------------------------------------------------------------

  /// Bestehende Einrichtung aktualisieren.
  Future<Einrichtung> updateEinrichtung(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from('einrichtungen')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

    return Einrichtung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Einstellungen aktualisieren
  // ---------------------------------------------------------------------------

  /// Nur die Einstellungen (JSONB) einer Einrichtung aktualisieren.
  Future<Einrichtung> updateEinstellungen(
    String id,
    Map<String, dynamic> einstellungen,
  ) async {
    final response = await _client
        .from('einrichtungen')
        .update({'einstellungen': einstellungen})
        .eq('id', id)
        .select()
        .single();

    return Einrichtung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Die Einrichtung wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Eine Einrichtung mit diesem Namen existiert bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Diese Einrichtung kann nicht geändert werden, da sie mit anderen Daten verknüpft ist.';
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

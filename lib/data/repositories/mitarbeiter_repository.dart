import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/mitarbeiter_einrichtung.dart';

/// Repository für Mitarbeiter-Verwaltung.
/// Kapselt alle Supabase-Operationen für Mitarbeiter-Einrichtung-Zuordnungen
/// und Profil-Updates.
class MitarbeiterRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Mitarbeiter laden
  // ---------------------------------------------------------------------------

  /// Alle Mitarbeiter einer Einrichtung laden (inkl. Profil-Daten).
  /// Gibt Roh-Maps zurück, da sowohl Profil- als auch Zuordnungsdaten benötigt werden.
  Future<List<Map<String, dynamic>>> fetchMitarbeiter(
    String einrichtungId,
  ) async {
    final response = await _client
        .from('mitarbeiter_einrichtung')
        .select('*, profiles(*)')
        .eq('einrichtung_id', einrichtungId);

    return (response as List).cast<Map<String, dynamic>>();
  }

  // ---------------------------------------------------------------------------
  // Mitarbeiter hinzufügen
  // ---------------------------------------------------------------------------

  /// Neuen Mitarbeiter-Einrichtung-Eintrag erstellen.
  Future<MitarbeiterEinrichtung> addMitarbeiter(
    MitarbeiterEinrichtung me,
  ) async {
    final response = await _client
        .from('mitarbeiter_einrichtung')
        .insert(me.toSupabase())
        .select()
        .single();

    return MitarbeiterEinrichtung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Mitarbeiter aktualisieren
  // ---------------------------------------------------------------------------

  /// Bestehenden Mitarbeiter-Einrichtung-Eintrag aktualisieren.
  Future<MitarbeiterEinrichtung> updateMitarbeiter(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from('mitarbeiter_einrichtung')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

    return MitarbeiterEinrichtung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Mitarbeiter entfernen
  // ---------------------------------------------------------------------------

  /// Mitarbeiter-Einrichtung-Zuordnung löschen.
  Future<void> removeMitarbeiter(String id) async {
    await _client.from('mitarbeiter_einrichtung').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Rolle aktualisieren
  // ---------------------------------------------------------------------------

  /// Rolle eines Mitarbeiters im Profil aktualisieren.
  Future<void> updateRolle(String mitarbeiterId, String rolle) async {
    await _client
        .from('profiles')
        .update({'rolle': rolle})
        .eq('id', mitarbeiterId);
  }

  // ---------------------------------------------------------------------------
  // Gruppe zuweisen
  // ---------------------------------------------------------------------------

  /// Mitarbeiter einer Gruppe zuweisen (oder Zuordnung entfernen).
  Future<void> assignGruppe(String meId, String? gruppeId) async {
    await _client
        .from('mitarbeiter_einrichtung')
        .update({'gruppe_id': gruppeId})
        .eq('id', meId);
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Der Mitarbeiter wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Dieser Mitarbeiter ist bereits dieser Einrichtung zugeordnet.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Dieser Eintrag kann nicht geändert werden, da er mit anderen Daten verknüpft ist.';
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

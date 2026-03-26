import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/gruppe.dart';

/// Repository für Gruppen-Verwaltung.
/// Kapselt alle Supabase-Operationen für Gruppen (gruppen_klassen),
/// inklusive Belegungsabfragen.
class GruppeRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Gruppen laden
  // ---------------------------------------------------------------------------

  /// Alle Gruppen einer Einrichtung laden, sortiert nach Name.
  Future<List<Gruppe>> fetchGruppen(String einrichtungId) async {
    final response = await _client
        .from('gruppen_klassen')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .order('name');

    return (response as List)
        .map((item) => Gruppe.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Einzelne Gruppe laden
  // ---------------------------------------------------------------------------

  /// Gruppe anhand der ID laden.
  Future<Gruppe?> fetchById(String id) async {
    final response = await _client
        .from('gruppen_klassen')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return Gruppe.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Erstellen
  // ---------------------------------------------------------------------------

  /// Neue Gruppe erstellen.
  Future<Gruppe> createGruppe(Gruppe gruppe) async {
    final response = await _client
        .from('gruppen_klassen')
        .insert(gruppe.toSupabase())
        .select()
        .single();

    return Gruppe.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Aktualisieren
  // ---------------------------------------------------------------------------

  /// Bestehende Gruppe aktualisieren.
  Future<Gruppe> updateGruppe(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from('gruppen_klassen')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

    return Gruppe.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Löschen
  // ---------------------------------------------------------------------------

  /// Gruppe löschen.
  Future<void> deleteGruppe(String id) async {
    await _client.from('gruppen_klassen').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Belegung
  // ---------------------------------------------------------------------------

  /// Aktuelle Belegung einer einzelnen Gruppe (Anzahl aktiver Kinder).
  Future<int> fetchBelegung(String gruppeId) async {
    final response = await _client
        .from('kinder')
        .select('id')
        .eq('gruppe_id', gruppeId)
        .eq('status', 'aktiv');

    return (response as List).length;
  }

  /// Belegung aller Gruppen einer Einrichtung als Map (gruppeId → Anzahl).
  /// Lädt alle aktiven Kinder der Einrichtung und gruppiert client-seitig.
  Future<Map<String, int>> fetchBelegungMap(String einrichtungId) async {
    final response = await _client
        .from('kinder')
        .select('gruppe_id')
        .eq('einrichtung_id', einrichtungId)
        .eq('status', 'aktiv');

    final belegung = <String, int>{};
    for (final row in (response as List)) {
      final gruppeId = (row as Map<String, dynamic>)['gruppe_id'] as String?;
      if (gruppeId != null) {
        belegung[gruppeId] = (belegung[gruppeId] ?? 0) + 1;
      }
    }
    return belegung;
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Die Gruppe wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Eine Gruppe mit diesem Namen existiert bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Diese Gruppe kann nicht gelöscht werden, da ihr noch Kinder oder Mitarbeiter zugeordnet sind.';
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

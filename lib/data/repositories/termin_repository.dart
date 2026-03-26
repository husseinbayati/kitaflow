import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../../core/extensions/datetime_extensions.dart';
import '../models/termin.dart';
import '../models/termin_rueckmeldung.dart';

/// Repository für Termin-Verwaltung.
/// Kapselt alle Supabase-Operationen für Termine, Kalender-Einträge,
/// Rückmeldungen (RSVP) und Eltern-spezifische Abfragen.
class TerminRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Termine nach Einrichtung
  // ---------------------------------------------------------------------------

  /// Termine einer Einrichtung laden, optional nach Datumsbereich gefiltert.
  Future<List<Termin>> fetchTermine(
    String einrichtungId, {
    DateTime? vonDatum,
    DateTime? bisDatum,
  }) async {
    var query = _client
        .from('termine')
        .select()
        .eq('einrichtung_id', einrichtungId);

    if (vonDatum != null) {
      query = query.gte('datum', vonDatum.toSupabaseDateString());
    }
    if (bisDatum != null) {
      query = query.lte('datum', bisDatum.toSupabaseDateString());
    }

    final response = await query.order('datum');

    return (response as List)
        .map((item) =>
            Termin.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Termine für Eltern
  // ---------------------------------------------------------------------------

  /// Termine aller Einrichtungen der eigenen Kinder laden (Eltern-Ansicht).
  /// Schritt 1: Kind-IDs über eltern_kind ermitteln.
  /// Schritt 2: Einrichtungs-IDs der Kinder ermitteln.
  /// Schritt 3: Termine dieser Einrichtungen laden.
  Future<List<Termin>> fetchTermineForEltern(String elternId) async {
    // Schritt 1: Kinder mit Einrichtungs-IDs laden
    final kinderResponse = await _client
        .from('eltern_kind')
        .select('kinder(einrichtung_id)')
        .eq('eltern_id', elternId);

    final einrichtungIds = (kinderResponse as List)
        .map((item) {
          final kinder = item['kinder'] as Map<String, dynamic>;
          return kinder['einrichtung_id'] as String;
        })
        .toSet()
        .toList();

    if (einrichtungIds.isEmpty) return [];

    // Schritt 2: Termine dieser Einrichtungen laden
    final response = await _client
        .from('termine')
        .select()
        .inFilter('einrichtung_id', einrichtungIds)
        .gte('datum', DateTime.now().toSupabaseDateString())
        .order('datum');

    return (response as List)
        .map((item) =>
            Termin.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Erstellen
  // ---------------------------------------------------------------------------

  /// Neuen Termin erstellen.
  Future<Termin> createTermin(Termin termin) async {
    final response = await _client
        .from('termine')
        .insert(termin.toSupabase())
        .select()
        .single();

    return Termin.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Aktualisieren
  // ---------------------------------------------------------------------------

  /// Bestehenden Termin aktualisieren.
  Future<Termin> updateTermin(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from('termine')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

    return Termin.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Löschen
  // ---------------------------------------------------------------------------

  /// Termin löschen.
  Future<void> deleteTermin(String id) async {
    await _client.from('termine').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Rückmeldungen (RSVP)
  // ---------------------------------------------------------------------------

  /// Alle Rückmeldungen für einen Termin laden.
  Future<List<TerminRueckmeldung>> fetchRueckmeldungen(
    String terminId,
  ) async {
    final response = await _client
        .from('termin_rueckmeldungen')
        .select()
        .eq('termin_id', terminId);

    return (response as List)
        .map((item) =>
            TerminRueckmeldung.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Rückmeldung erstellen oder aktualisieren (Upsert).
  Future<TerminRueckmeldung> upsertRueckmeldung(
    TerminRueckmeldung rueckmeldung,
  ) async {
    final response = await _client
        .from('termin_rueckmeldungen')
        .upsert(
          rueckmeldung.toSupabase(),
          onConflict: 'termin_id,eltern_id',
        )
        .select()
        .single();

    return TerminRueckmeldung.fromSupabase(response);
  }

  /// Alle Rückmeldungen eines Elternteils laden.
  Future<List<TerminRueckmeldung>> fetchMeineRueckmeldungen(
    String elternId,
  ) async {
    final response = await _client
        .from('termin_rueckmeldungen')
        .select()
        .eq('eltern_id', elternId);

    return (response as List)
        .map((item) =>
            TerminRueckmeldung.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Der Termin wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Dieser Termin existiert bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Der Termin kann nicht geändert werden, da er mit anderen Daten verknüpft ist.';
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

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../../core/constants/enums.dart';
import '../../core/extensions/datetime_extensions.dart';
import '../models/anwesenheit.dart';
import '../models/anwesenheit_heute.dart';

/// Repository für Anwesenheits-Verwaltung.
/// Kapselt alle Supabase-Operationen für Check-in, Check-out,
/// Statusänderungen und Statistiken.
class AnwesenheitRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Heutige Anwesenheit (View)
  // ---------------------------------------------------------------------------

  /// Heutige Anwesenheit aller Kinder einer Einrichtung laden.
  /// Verwendet die View `v_anwesenheit_heute`, die bereits auf heute filtert.
  Future<List<AnwesenheitHeute>> fetchAnwesenheitHeute(
    String einrichtungId,
  ) async {
    final response = await _client
        .from('v_anwesenheit_heute')
        .select()
        .eq('einrichtung_id', einrichtungId);

    return (response as List)
        .map((item) =>
            AnwesenheitHeute.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Anwesenheit nach Datum
  // ---------------------------------------------------------------------------

  /// Anwesenheit einer Einrichtung für ein bestimmtes Datum laden.
  Future<List<Anwesenheit>> fetchAnwesenheitByDate(
    String einrichtungId,
    DateTime datum,
  ) async {
    final datumStr = datum.toIso8601String().split('T')[0];

    final response = await _client
        .from('anwesenheit')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .eq('datum', datumStr)
        .order('erstellt_am', ascending: true);

    return (response as List)
        .map((item) =>
            Anwesenheit.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Check-in
  // ---------------------------------------------------------------------------

  /// Kind einchecken (als anwesend markieren mit Ankunftszeit).
  /// Verwendet upsert, um bei erneutem Check-in den bestehenden Eintrag
  /// zu aktualisieren statt einen Fehler zu werfen.
  Future<Anwesenheit> checkIn(
    String kindId,
    String einrichtungId, {
    String? gebrachtVon,
  }) async {
    final now = DateTime.now();
    final zeitStr = now.toSupabaseTimeString();
    final datumStr = now.toSupabaseDateString();

    final response = await _client.from('anwesenheit').upsert(
      {
        'kind_id': kindId,
        'einrichtung_id': einrichtungId,
        'datum': datumStr,
        'ankunft_zeit': zeitStr,
        'status': 'anwesend',
        'gebracht_von': gebrachtVon,
      },
      onConflict: 'kind_id,datum',
    ).select().single();

    return Anwesenheit.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Check-out
  // ---------------------------------------------------------------------------

  /// Kind auschecken (Abholzeit und optional Abholer erfassen).
  Future<Anwesenheit> checkOut(
    String anwesenheitId, {
    String? abgeholtVon,
  }) async {
    final now = DateTime.now();
    final zeitStr = now.toSupabaseTimeString();

    final response = await _client
        .from('anwesenheit')
        .update({
          'abgeholt_zeit': zeitStr,
          'abgeholt_von': abgeholtVon,
        })
        .eq('id', anwesenheitId)
        .select()
        .single();

    return Anwesenheit.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Status ändern
  // ---------------------------------------------------------------------------

  /// Status eines bestehenden Anwesenheitseintrags ändern.
  Future<Anwesenheit> updateStatus(
    String anwesenheitId,
    AttendanceStatus status, {
    String? notiz,
  }) async {
    final response = await _client
        .from('anwesenheit')
        .update({
          'status': status.name,
          'notiz': notiz,
        })
        .eq('id', anwesenheitId)
        .select()
        .single();

    return Anwesenheit.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Abwesend melden
  // ---------------------------------------------------------------------------

  /// Kind als abwesend (krank, Urlaub, etc.) markieren — ohne Zeitfelder.
  /// Verwendet upsert, um bei bereits bestehendem Eintrag zu aktualisieren.
  Future<Anwesenheit> markAbwesend(
    String kindId,
    String einrichtungId,
    AttendanceStatus status, {
    String? notiz,
  }) async {
    final today = DateTime.now();
    final datumStr = today.toSupabaseDateString();

    final response = await _client.from('anwesenheit').upsert(
      {
        'kind_id': kindId,
        'einrichtung_id': einrichtungId,
        'datum': datumStr,
        'status': status.name,
        'notiz': notiz,
      },
      onConflict: 'kind_id,datum',
    ).select().single();

    return Anwesenheit.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Monatsstatistik
  // ---------------------------------------------------------------------------

  /// Alle Anwesenheitseinträge einer Einrichtung für einen Monat laden.
  Future<List<Anwesenheit>> fetchMonatsStatistik(
    String einrichtungId,
    int jahr,
    int monat,
  ) async {
    final startDate = DateTime(jahr, monat, 1).toSupabaseDateString();
    final endDate = DateTime(jahr, monat + 1, 0).toSupabaseDateString();

    final response = await _client
        .from('anwesenheit')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .gte('datum', startDate)
        .lte('datum', endDate)
        .order('datum', ascending: true);

    return (response as List)
        .map((item) =>
            Anwesenheit.fromSupabase(item as Map<String, dynamic>))
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
      return 'Der Anwesenheitseintrag wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Anwesenheit wurde bereits erfasst.';
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

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/nachricht.dart';
import '../models/nachricht_anhang.dart';
import '../models/nachricht_empfaenger.dart';

/// Repository für Nachrichten-Verwaltung.
/// Kapselt alle Supabase-Operationen für Senden, Empfangen,
/// Lesebestätigungen, Anhänge und Echtzeit-Streams.
class NachrichtRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Nachrichten abrufen
  // ---------------------------------------------------------------------------

  /// Alle Nachrichten einer Einrichtung laden (mit Absender-Profildaten).
  Future<List<Nachricht>> fetchNachrichten(String einrichtungId) async {
    final response = await _client
        .from('nachrichten')
        .select('*, profiles!absender_id(vorname, nachname)')
        .eq('einrichtung_id', einrichtungId)
        .order('erstellt_am', ascending: false);

    return (response as List)
        .map((item) =>
            Nachricht.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Empfangene Nachrichten eines Benutzers laden.
  /// Holt zuerst die Nachricht-IDs aus nachricht_empfaenger,
  /// dann die vollständigen Nachrichten mit Absenderdaten.
  Future<List<Nachricht>> fetchEmpfangeneNachrichten(String userId) async {
    // Schritt 1: Nachricht-IDs des Empfängers holen
    final empfaengerResponse = await _client
        .from('nachricht_empfaenger')
        .select('nachricht_id')
        .eq('empfaenger_id', userId);

    final nachrichtIds = (empfaengerResponse as List)
        .map((item) => (item as Map<String, dynamic>)['nachricht_id'] as String)
        .toList();

    if (nachrichtIds.isEmpty) return [];

    // Schritt 2: Nachrichten mit Absenderdaten laden
    final response = await _client
        .from('nachrichten')
        .select('*, profiles!absender_id(vorname, nachname)')
        .inFilter('id', nachrichtIds)
        .order('erstellt_am', ascending: false);

    return (response as List)
        .map((item) =>
            Nachricht.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Einzelne Nachricht per ID laden (mit Absenderdaten).
  Future<Nachricht> fetchNachrichtById(String id) async {
    final response = await _client
        .from('nachrichten')
        .select('*, profiles!absender_id(vorname, nachname)')
        .eq('id', id)
        .single();

    return Nachricht.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Empfänger & Anhänge
  // ---------------------------------------------------------------------------

  /// Alle Empfänger einer Nachricht laden.
  Future<List<NachrichtEmpfaenger>> fetchEmpfaenger(
    String nachrichtId,
  ) async {
    final response = await _client
        .from('nachricht_empfaenger')
        .select()
        .eq('nachricht_id', nachrichtId);

    return (response as List)
        .map((item) =>
            NachrichtEmpfaenger.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Alle Anhänge einer Nachricht laden.
  Future<List<NachrichtAnhang>> fetchAnhaenge(String nachrichtId) async {
    final response = await _client
        .from('nachricht_anhaenge')
        .select()
        .eq('nachricht_id', nachrichtId);

    return (response as List)
        .map((item) =>
            NachrichtAnhang.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Nachricht senden
  // ---------------------------------------------------------------------------

  /// Neue Nachricht senden und Empfänger zuweisen.
  /// Schritt 1: Nachricht in nachrichten-Tabelle einfügen.
  /// Schritt 2: Empfänger-Einträge in nachricht_empfaenger batch-einfügen.
  Future<Nachricht> sendNachricht(
    Nachricht nachricht,
    List<String> empfaengerIds,
  ) async {
    // Schritt 1: Nachricht einfügen
    final response = await _client
        .from('nachrichten')
        .insert(nachricht.toSupabase())
        .select('*, profiles!absender_id(vorname, nachname)')
        .single();

    final erstellteNachricht = Nachricht.fromSupabase(response);

    // Schritt 2: Empfänger batch-einfügen
    final empfaengerRows = empfaengerIds
        .map((id) => {
              'nachricht_id': erstellteNachricht.id,
              'empfaenger_id': id,
            })
        .toList();

    await _client.from('nachricht_empfaenger').insert(empfaengerRows);

    return erstellteNachricht;
  }

  // ---------------------------------------------------------------------------
  // Lesebestätigung
  // ---------------------------------------------------------------------------

  /// Nachricht als gelesen markieren für einen bestimmten Benutzer.
  Future<void> markAsRead(String nachrichtId, String userId) async {
    await _client
        .from('nachricht_empfaenger')
        .update({
          'gelesen': true,
          'gelesen_am': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('nachricht_id', nachrichtId)
        .eq('empfaenger_id', userId);
  }

  /// Anzahl ungelesener Nachrichten eines Benutzers abfragen.
  Future<int> fetchUnreadCount(String userId) async {
    final response = await _client
        .from('v_nachrichten_ungelesen')
        .select()
        .eq('empfaenger_id', userId);

    return (response as List).length;
  }

  // ---------------------------------------------------------------------------
  // Anhänge (Storage)
  // ---------------------------------------------------------------------------

  /// Dateianhang in Supabase Storage hochladen und Metadaten speichern.
  Future<NachrichtAnhang> uploadAnhang(
    String nachrichtId,
    String dateiname,
    Uint8List bytes,
    String mimeType,
  ) async {
    final storagePath = 'nachrichten/$nachrichtId/$dateiname';

    // Datei in Storage hochladen
    await SupabaseConfig.storage
        .from('attachments')
        .uploadBinary(
          storagePath,
          bytes,
          fileOptions: FileOptions(contentType: mimeType),
        );

    // Metadaten in nachricht_anhaenge speichern
    final response = await _client.from('nachricht_anhaenge').insert({
      'nachricht_id': nachrichtId,
      'dateiname': dateiname,
      'dateipfad': storagePath,
      'dateityp': mimeType,
      'dateigroesse': bytes.length,
    }).select().single();

    return NachrichtAnhang.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Nachricht löschen
  // ---------------------------------------------------------------------------

  /// Nachricht löschen (Cascade löscht Empfänger und Anhänge automatisch).
  Future<void> deleteNachricht(String nachrichtId) async {
    await _client.from('nachrichten').delete().eq('id', nachrichtId);
  }

  // ---------------------------------------------------------------------------
  // Echtzeit (Realtime)
  // ---------------------------------------------------------------------------

  /// Echtzeit-Stream für Nachrichten einer Einrichtung.
  Stream<List<Map<String, dynamic>>> subscribeToNachrichten(
    String einrichtungId,
  ) {
    return _client
        .from('nachrichten')
        .stream(primaryKey: ['id'])
        .eq('einrichtung_id', einrichtungId);
  }

  // ---------------------------------------------------------------------------
  // Profile für Empfängerauswahl
  // ---------------------------------------------------------------------------

  /// Alle Profile einer Einrichtung laden (für Empfänger-Auswahl-Dialog).
  Future<List<Map<String, dynamic>>> fetchProfilesForEinrichtung(
    String einrichtungId,
  ) async {
    final response = await _client
        .from('profiles')
        .select('id, vorname, nachname, rolle')
        .eq('einrichtung_id', einrichtungId);

    return (response as List)
        .map((item) => item as Map<String, dynamic>)
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
      return 'Die Nachricht wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Diese Nachricht existiert bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Diese Nachricht kann nicht geändert werden, da sie mit anderen Daten verknüpft ist.';
    } else if (errorString.contains('network') ||
        errorString.contains('socketexception') ||
        errorString.contains('connection')) {
      return 'Keine Internetverbindung. Bitte prüfe dein Netzwerk.';
    } else if (errorString.contains('rate limit') ||
        errorString.contains('too many requests')) {
      return 'Zu viele Anfragen. Bitte warte einen Moment.';
    } else if (errorString.contains('storage') ||
        errorString.contains('upload')) {
      return 'Fehler beim Hochladen der Datei. Bitte versuche es erneut.';
    } else if (errorString.contains('too large') ||
        errorString.contains('payload')) {
      return 'Die Datei ist zu groß. Bitte wähle eine kleinere Datei.';
    }

    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
  }
}

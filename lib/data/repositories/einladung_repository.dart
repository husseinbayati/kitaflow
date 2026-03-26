import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/einladung.dart';

/// Repository für Einladungs-Verwaltung.
/// Kapselt alle Supabase-Operationen für Einladungscodes,
/// Code-Validierung und Einlösung (Eltern-Onboarding).
class EinladungRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Code validieren
  // ---------------------------------------------------------------------------

  /// Einladungscode prüfen: aktiv, nicht abgelaufen, noch nicht eingelöst.
  /// Gibt `null` zurück, wenn kein gültiger Code gefunden wird.
  Future<Einladung?> validateCode(String code) async {
    final response = await _client
        .from('einladungen')
        .select()
        .eq('code', code)
        .eq('aktiv', true)
        .gt('gueltig_bis', DateTime.now().toUtc().toIso8601String())
        .maybeSingle();

    if (response == null) return null;
    return Einladung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Code einlösen
  // ---------------------------------------------------------------------------

  /// Einladungscode einlösen: Einladung deaktivieren und Eltern-Kind-Zuordnung
  /// erstellen.
  /// 1. Einladung per Code laden
  /// 2. Einladung aktualisieren (eingelöst, deaktiviert)
  /// 3. Eltern-Kind-Verknüpfung anlegen
  Future<Einladung> redeemCode(String code, String userId) async {
    // Schritt 1: Einladung per Code laden
    final einladungResponse = await _client
        .from('einladungen')
        .select()
        .eq('code', code)
        .eq('aktiv', true)
        .single();

    final einladung = Einladung.fromSupabase(einladungResponse);

    // Schritt 2: Einladung als eingelöst markieren
    final updatedResponse = await _client
        .from('einladungen')
        .update({
          'eingeloest_von': userId,
          'eingeloest_am': DateTime.now().toUtc().toIso8601String(),
          'aktiv': false,
        })
        .eq('id', einladung.id)
        .select()
        .single();

    // Schritt 3: Eltern-Kind-Verknüpfung anlegen
    await _client.from('eltern_kind').insert({
      'eltern_id': userId,
      'kind_id': einladung.kindId,
      'beziehung': 'sorgeberechtigt',
      'ist_hauptkontakt': false,
    });

    return Einladung.fromSupabase(updatedResponse);
  }

  // ---------------------------------------------------------------------------
  // Erstellen
  // ---------------------------------------------------------------------------

  /// Neue Einladung erstellen (durch Einrichtungspersonal).
  Future<Einladung> createEinladung(Einladung einladung) async {
    final response = await _client
        .from('einladungen')
        .insert(einladung.toSupabase())
        .select()
        .single();

    return Einladung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Nach Einrichtung laden
  // ---------------------------------------------------------------------------

  /// Alle Einladungen einer Einrichtung laden, neueste zuerst.
  Future<List<Einladung>> fetchByEinrichtung(String einrichtungId) async {
    final response = await _client
        .from('einladungen')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .order('erstellt_am', ascending: false);

    return (response as List)
        .map((item) =>
            Einladung.fromSupabase(item as Map<String, dynamic>))
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
      return 'Der Einladungscode wurde nicht gefunden oder ist ungültig.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Dieser Einladungscode existiert bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Die Einladung kann nicht verarbeitet werden, da verknüpfte Daten fehlen.';
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

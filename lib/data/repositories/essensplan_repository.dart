import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../../core/extensions/datetime_extensions.dart';
import '../models/essensplan.dart';

/// Repository für Essensplan-Verwaltung.
/// Kapselt alle Supabase-Operationen für Wochenpläne, CRUD
/// und Allergen-Abfragen.
class EssensplanRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Wochenplan laden
  // ---------------------------------------------------------------------------

  /// Essensplan einer Einrichtung für eine komplette Woche laden.
  /// [montag] ist der Montag der gewünschten Woche.
  Future<List<Essensplan>> fetchWochenplan(
    String einrichtungId,
    DateTime montag,
  ) async {
    final freitag = montag.add(const Duration(days: 4));
    final montagStr = montag.toSupabaseDateString();
    final freitagStr = freitag.toSupabaseDateString();

    final response = await _client
        .from('essensplaene')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .gte('datum', montagStr)
        .lte('datum', freitagStr)
        .order('datum')
        .order('mahlzeit_typ');

    return (response as List)
        .map((item) =>
            Essensplan.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Essensplan nach Datum
  // ---------------------------------------------------------------------------

  /// Essensplan einer Einrichtung für ein bestimmtes Datum laden.
  Future<List<Essensplan>> fetchByDate(
    String einrichtungId,
    DateTime datum,
  ) async {
    final datumStr = datum.toSupabaseDateString();

    final response = await _client
        .from('essensplaene')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .eq('datum', datumStr)
        .order('mahlzeit_typ');

    return (response as List)
        .map((item) =>
            Essensplan.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Erstellen
  // ---------------------------------------------------------------------------

  /// Neuen Essensplan-Eintrag erstellen.
  Future<Essensplan> createEssensplan(Essensplan plan) async {
    final response = await _client
        .from('essensplaene')
        .insert(plan.toSupabase())
        .select()
        .single();

    return Essensplan.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Aktualisieren
  // ---------------------------------------------------------------------------

  /// Bestehenden Essensplan-Eintrag aktualisieren.
  Future<Essensplan> updateEssensplan(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from('essensplaene')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

    return Essensplan.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Löschen
  // ---------------------------------------------------------------------------

  /// Essensplan-Eintrag löschen.
  Future<void> deleteEssensplan(String id) async {
    await _client.from('essensplaene').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Kinder-Allergien
  // ---------------------------------------------------------------------------

  /// Allergien aller Kinder einer Einrichtung laden.
  /// Gibt Roh-Maps zurück, die vom Provider für Warnungsberechnung genutzt werden.
  Future<List<Map<String, dynamic>>> fetchKinderAllergien(
    String einrichtungId,
  ) async {
    final response = await _client
        .from('allergien')
        .select(
          'allergen, schweregrad, hinweise, kinder!inner(id, vorname, nachname, einrichtung_id)',
        )
        .eq('kinder.einrichtung_id', einrichtungId);

    return (response as List).cast<Map<String, dynamic>>();
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Der Essensplan-Eintrag wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Dieser Essensplan-Eintrag existiert bereits.';
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

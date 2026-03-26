import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/kind.dart';
import '../models/eltern_kind.dart';

/// Repository für Eltern-spezifische Abfragen.
/// Kapselt alle Supabase-Operationen für Eltern-Kind-Zuordnungen,
/// Kinder-Abfragen und Beziehungs-Details.
class ElternRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Meine Kinder laden
  // ---------------------------------------------------------------------------

  /// Alle Kinder eines Elternteils laden (über eltern_kind-Verknüpfung).
  Future<List<Kind>> fetchMeineKinder(String elternId) async {
    final response = await _client
        .from('eltern_kind')
        .select('kinder(*)')
        .eq('eltern_id', elternId);

    return (response as List).map((item) {
      final kinderMap = item['kinder'] as Map<String, dynamic>;
      return Kind.fromSupabase(kinderMap);
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Eltern-Kind-Beziehungen
  // ---------------------------------------------------------------------------

  /// Alle Eltern-Kind-Beziehungen eines Elternteils laden.
  Future<List<ElternKind>> fetchElternKindBeziehungen(
    String elternId,
  ) async {
    final response = await _client
        .from('eltern_kind')
        .select()
        .eq('eltern_id', elternId);

    return (response as List)
        .map((item) =>
            ElternKind.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Kind mit Details
  // ---------------------------------------------------------------------------

  /// Einzelnes Kind per ID laden. Gibt `null` zurück, wenn nicht gefunden.
  Future<Kind?> fetchKindMitDetails(String kindId) async {
    final response = await _client
        .from('kinder')
        .select()
        .eq('id', kindId)
        .maybeSingle();

    if (response == null) return null;
    return Kind.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Das Kind wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Diese Eltern-Kind-Zuordnung existiert bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Die Zuordnung kann nicht geändert werden, da sie mit anderen Daten verknüpft ist.';
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

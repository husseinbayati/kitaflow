import '../../config/supabase_config.dart';
import '../../core/constants/enums.dart';
import '../models/eingewoehnung.dart';
import '../models/eingewoehnung_tagesnotiz.dart';

class EingewoehnungRepository {
  // ---------------------------------------------------------------------------
  // Eingewöhnung laden
  // ---------------------------------------------------------------------------

  /// Alle Eingewöhnungen einer Einrichtung laden.
  /// Verwendet inner join über kinder-Tabelle.
  Future<List<Eingewoehnung>> fetchByEinrichtung(String einrichtungId) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung')
        .select('*, kinder!inner(einrichtung_id)')
        .eq('kinder.einrichtung_id', einrichtungId)
        .order('erstellt_am', ascending: false);
    return (response as List)
        .map((item) => Eingewoehnung.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Eingewöhnung(en) eines Kindes laden.
  Future<List<Eingewoehnung>> fetchByKindId(String kindId) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung')
        .select()
        .eq('kind_id', kindId)
        .order('erstellt_am', ascending: false);
    return (response as List)
        .map((item) => Eingewoehnung.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Einzelne Eingewöhnung laden.
  Future<Eingewoehnung> fetchById(String id) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung')
        .select()
        .eq('id', id)
        .single();
    return Eingewoehnung.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Eingewöhnung CRUD
  // ---------------------------------------------------------------------------

  Future<Eingewoehnung> create(Eingewoehnung e) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung')
        .insert(e.toSupabase())
        .select()
        .single();
    return Eingewoehnung.fromSupabase(response);
  }

  Future<Eingewoehnung> update(Eingewoehnung e) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung')
        .update(e.toSupabase())
        .eq('id', e.id)
        .select()
        .single();
    return Eingewoehnung.fromSupabase(response);
  }

  Future<Eingewoehnung> updatePhase(String id, EingewoehnungPhase phase) async {
    final updates = <String, dynamic>{'phase': phase.name};
    if (phase == EingewoehnungPhase.abgeschlossen) {
      updates['enddatum'] = DateTime.now().toIso8601String().substring(0, 10);
    }
    final response = await SupabaseConfig.client
        .from('eingewoehnung')
        .update(updates)
        .eq('id', id)
        .select()
        .single();
    return Eingewoehnung.fromSupabase(response);
  }

  Future<void> delete(String id) async {
    await SupabaseConfig.client.from('eingewoehnung').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Tagesnotizen
  // ---------------------------------------------------------------------------

  Future<List<EingewoehnungTagesnotiz>> fetchTagesnotizen(String eingewoehnungId) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung_tagesnotizen')
        .select()
        .eq('eingewoehnung_id', eingewoehnungId)
        .order('datum', ascending: false);
    return (response as List)
        .map((item) => EingewoehnungTagesnotiz.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  Future<EingewoehnungTagesnotiz> createTagesnotiz(EingewoehnungTagesnotiz t) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung_tagesnotizen')
        .insert(t.toSupabase())
        .select()
        .single();
    return EingewoehnungTagesnotiz.fromSupabase(response);
  }

  Future<EingewoehnungTagesnotiz> updateTagesnotiz(EingewoehnungTagesnotiz t) async {
    final response = await SupabaseConfig.client
        .from('eingewoehnung_tagesnotizen')
        .update(t.toSupabase())
        .eq('id', t.id)
        .select()
        .single();
    return EingewoehnungTagesnotiz.fromSupabase(response);
  }

  Future<void> deleteTagesnotiz(String id) async {
    await SupabaseConfig.client.from('eingewoehnung_tagesnotizen').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') || errorString.contains('no rows')) {
      return 'Der Eingewöhnungs-Eintrag wurde nicht gefunden.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('unique') || errorString.contains('duplicate')) {
      return 'Für diesen Tag existiert bereits eine Tagesnotiz.';
    } else if (errorString.contains('network') ||
        errorString.contains('socketexception') ||
        errorString.contains('connection')) {
      return 'Keine Internetverbindung. Bitte prüfe dein Netzwerk.';
    }

    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
  }
}

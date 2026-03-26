import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/foto.dart';

/// Repository für Foto-Verwaltung.
/// Kapselt alle Supabase-Operationen für Fotos, Kind-Zuordnungen,
/// Eltern-Sichtbarkeit und Storage-URLs.
class FotoRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Fotos für Eltern laden
  // ---------------------------------------------------------------------------

  /// Alle sichtbaren Fotos der eigenen Kinder laden (Eltern-Ansicht).
  /// Schritt 1: Kind-IDs des Elternteils ermitteln.
  /// Schritt 2: Foto-IDs über foto_kinder-Verknüpfung laden.
  /// Schritt 3: Fotos mit sichtbar_fuer_eltern = true laden.
  Future<List<Foto>> fetchFotosForEltern(String elternId) async {
    // Schritt 1: Kind-IDs des Elternteils holen
    final kinderResponse = await _client
        .from('eltern_kind')
        .select('kind_id')
        .eq('eltern_id', elternId);

    final kindIds = (kinderResponse as List)
        .map((e) => e['kind_id'] as String)
        .toList();

    if (kindIds.isEmpty) return [];

    // Schritt 2: Foto-IDs über foto_kinder-Verknüpfung laden
    final fotoKinderResponse = await _client
        .from('foto_kinder')
        .select('foto_id')
        .inFilter('kind_id', kindIds);

    final fotoIds = (fotoKinderResponse as List)
        .map((e) => e['foto_id'] as String)
        .toSet()
        .toList();

    if (fotoIds.isEmpty) return [];

    // Schritt 3: Fotos laden (nur sichtbare)
    final response = await _client
        .from('fotos')
        .select()
        .inFilter('id', fotoIds)
        .eq('sichtbar_fuer_eltern', true)
        .order('datum', ascending: false);

    return (response as List)
        .map((item) =>
            Foto.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Fotos nach Einrichtung (Personal-Ansicht)
  // ---------------------------------------------------------------------------

  /// Alle Fotos einer Einrichtung laden (Personal-Ansicht).
  Future<List<Foto>> fetchFotosByEinrichtung(String einrichtungId) async {
    final response = await _client
        .from('fotos')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .order('datum', ascending: false);

    return (response as List)
        .map((item) =>
            Foto.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Erstellen
  // ---------------------------------------------------------------------------

  /// Neues Foto erstellen (Metadaten in DB speichern).
  Future<Foto> createFoto(Foto foto) async {
    final response = await _client
        .from('fotos')
        .insert(foto.toSupabase())
        .select()
        .single();

    return Foto.fromSupabase(response);
  }

  // ---------------------------------------------------------------------------
  // Löschen
  // ---------------------------------------------------------------------------

  /// Foto löschen (Metadaten aus DB entfernen).
  Future<void> deleteFoto(String id) async {
    await _client.from('fotos').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Kind-Zuordnungen (foto_kinder)
  // ---------------------------------------------------------------------------

  /// Kind einem Foto zuordnen.
  Future<void> addKindToFoto(String fotoId, String kindId) async {
    await _client.from('foto_kinder').insert({
      'foto_id': fotoId,
      'kind_id': kindId,
    });
  }

  /// Kind-Zuordnung von einem Foto entfernen.
  Future<void> removeKindFromFoto(String fotoId, String kindId) async {
    await _client
        .from('foto_kinder')
        .delete()
        .eq('foto_id', fotoId)
        .eq('kind_id', kindId);
  }

  // ---------------------------------------------------------------------------
  // Storage (signierte URL)
  // ---------------------------------------------------------------------------

  /// Signierte URL für ein Foto generieren (1 Stunde gültig).
  Future<String> getSignedUrl(String storagePfad) async {
    return _client.storage
        .from('fotos')
        .createSignedUrl(storagePfad, 3600);
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Das Foto wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Dieses Foto existiert bereits.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('foreign key') ||
        errorString.contains('violates')) {
      return 'Das Foto kann nicht geändert werden, da es mit anderen Daten verknüpft ist.';
    } else if (errorString.contains('network') ||
        errorString.contains('socketexception') ||
        errorString.contains('connection')) {
      return 'Keine Internetverbindung. Bitte prüfe dein Netzwerk.';
    } else if (errorString.contains('rate limit') ||
        errorString.contains('too many requests')) {
      return 'Zu viele Anfragen. Bitte warte einen Moment.';
    } else if (errorString.contains('storage') ||
        errorString.contains('upload')) {
      return 'Fehler beim Laden des Fotos. Bitte versuche es erneut.';
    } else if (errorString.contains('too large') ||
        errorString.contains('payload')) {
      return 'Das Foto ist zu groß. Bitte wähle ein kleineres Bild.';
    }

    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
  }
}

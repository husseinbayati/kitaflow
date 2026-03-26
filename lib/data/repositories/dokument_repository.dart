import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../../core/constants/enums.dart';
import '../models/dokument.dart';

/// Repository für Dokumenten-Verwaltung.
/// Kapselt alle Supabase-Operationen für Dokumente, Storage und Unterschriften.
class DokumentRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Dokumente laden
  // ---------------------------------------------------------------------------

  /// Alle Dokumente einer Einrichtung laden.
  Future<List<Dokument>> fetchByEinrichtung(String einrichtungId) async {
    final response = await _client
        .from('dokumente')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .order('erstellt_am', ascending: false);
    return (response as List)
        .map((item) => Dokument.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Alle Dokumente eines Kindes laden.
  Future<List<Dokument>> fetchByKind(String kindId) async {
    final response = await _client
        .from('dokumente')
        .select()
        .eq('kind_id', kindId)
        .order('erstellt_am', ascending: false);
    return (response as List)
        .map((item) => Dokument.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Dokumente einer Einrichtung nach Typ filtern.
  Future<List<Dokument>> fetchByTyp(
      String einrichtungId, DocumentType typ) async {
    final response = await _client
        .from('dokumente')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .eq('typ', typ.name)
        .order('erstellt_am', ascending: false);
    return (response as List)
        .map((item) => Dokument.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Erstellen / Aktualisieren / Löschen
  // ---------------------------------------------------------------------------

  /// Neues Dokument erstellen.
  Future<Dokument> createDokument(Dokument dokument) async {
    final response = await _client
        .from('dokumente')
        .insert(dokument.toSupabase())
        .select()
        .single();
    return Dokument.fromSupabase(response);
  }

  /// Dokument aktualisieren.
  Future<Dokument> updateDokument(
      String id, Map<String, dynamic> updates) async {
    final response = await _client
        .from('dokumente')
        .update(updates)
        .eq('id', id)
        .select()
        .single();
    return Dokument.fromSupabase(response);
  }

  /// Dokument löschen.
  Future<void> deleteDokument(String id) async {
    await _client.from('dokumente').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Storage (Datei-Upload / Download)
  // ---------------------------------------------------------------------------

  /// Datei in Supabase Storage hochladen.
  Future<String> uploadDatei(
      String einrichtungId, String dateiname, Uint8List bytes) async {
    final path =
        '$einrichtungId/${DateTime.now().millisecondsSinceEpoch}_$dateiname';
    await _client.storage.from('dokumente').uploadBinary(path, bytes);
    return path;
  }

  /// Signierte URL für eine Datei generieren (1 Stunde gültig).
  Future<String> getSignedUrl(String storagePfad) async {
    return _client.storage
        .from('dokumente')
        .createSignedUrl(storagePfad, 3600);
  }

  /// Datei-Bytes herunterladen.
  Future<Uint8List> downloadDatei(String storagePfad) async {
    return _client.storage.from('dokumente').download(storagePfad);
  }

  // ---------------------------------------------------------------------------
  // Unterschrift
  // ---------------------------------------------------------------------------

  /// Dokument als unterschrieben markieren und Unterschrift-Bild hochladen.
  Future<Dokument> markAsSigned(
      String dokumentId, String signerName, Uint8List signatureImage) async {
    // Unterschrift-Bild hochladen
    final sigPath = 'unterschriften/$dokumentId.png';
    await _client.storage.from('dokumente').uploadBinary(sigPath, signatureImage);

    // Dokument-Datensatz aktualisieren
    return updateDokument(dokumentId, {
      'unterschrieben': true,
      'unterschrieben_am': DateTime.now().toIso8601String(),
      'unterschrieben_von': signerName,
    });
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Das Dokument wurde nicht gefunden.';
    } else if (errorString.contains('permission') ||
        errorString.contains('rls') ||
        errorString.contains('policy')) {
      return 'Keine Berechtigung für diese Aktion.';
    } else if (errorString.contains('network') ||
        errorString.contains('socketexception') ||
        errorString.contains('connection')) {
      return 'Keine Internetverbindung. Bitte prüfe dein Netzwerk.';
    } else if (errorString.contains('storage') ||
        errorString.contains('upload')) {
      return 'Fehler beim Datei-Upload. Bitte versuche es erneut.';
    } else if (errorString.contains('too large') ||
        errorString.contains('payload')) {
      return 'Die Datei ist zu groß. Maximal 10 MB erlaubt.';
    }

    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
  }
}

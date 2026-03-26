import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../../core/constants/enums.dart';
import '../models/kind.dart';
import '../models/allergie.dart';
import '../models/kontaktperson.dart';
import '../models/gruppe.dart';

/// Repository für Kind-Verwaltung.
/// Kapselt alle Supabase-Operationen für Kinder, Allergien,
/// Kontaktpersonen und Gruppen.
class KindRepository {
  SupabaseClient get _client => SupabaseConfig.client;

  // ---------------------------------------------------------------------------
  // Kinder
  // ---------------------------------------------------------------------------

  /// Kinder laden mit optionalen Filtern.
  Future<List<Kind>> fetchKinder({
    String? einrichtungId,
    String? gruppeId,
    String? status,
    String? suchbegriff,
  }) async {
    var query = _client.from('kinder').select();

    if (einrichtungId != null) {
      query = query.eq('einrichtung_id', einrichtungId);
    }
    if (gruppeId != null) {
      query = query.eq('gruppe_id', gruppeId);
    }
    if (status != null) {
      query = query.eq('status', status);
    }
    if (suchbegriff != null && suchbegriff.isNotEmpty) {
      query = query.or(
        'vorname.ilike.%$suchbegriff%,nachname.ilike.%$suchbegriff%',
      );
    }

    final response = await query.order('nachname', ascending: true);

    return (response as List)
        .map((item) => Kind.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Einzelnes Kind anhand der ID laden.
  Future<Kind> fetchKindById(String id) async {
    final response = await _client
        .from('kinder')
        .select()
        .eq('id', id)
        .single();

    return Kind.fromSupabase(response);
  }

  /// Neues Kind anlegen.
  Future<Kind> createKind(Kind kind) async {
    final response = await _client
        .from('kinder')
        .insert(kind.toSupabase())
        .select()
        .single();

    return Kind.fromSupabase(response);
  }

  /// Kind aktualisieren.
  Future<Kind> updateKind(Kind kind) async {
    final response = await _client
        .from('kinder')
        .update(kind.toSupabase())
        .eq('id', kind.id)
        .select()
        .single();

    return Kind.fromSupabase(response);
  }

  /// Kind soft-löschen (Status auf 'abgemeldet' setzen).
  Future<void> deleteKind(String id) async {
    await _client
        .from('kinder')
        .update({'status': ChildStatus.abgemeldet.name})
        .eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Allergien
  // ---------------------------------------------------------------------------

  /// Allergien eines Kindes laden.
  Future<List<Allergie>> fetchAllergien(String kindId) async {
    final response = await _client
        .from('allergien')
        .select()
        .eq('kind_id', kindId);

    return (response as List)
        .map((item) => Allergie.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  /// Neue Allergie hinzufügen.
  Future<Allergie> addAllergie(Allergie allergie) async {
    final response = await _client
        .from('allergien')
        .insert(allergie.toSupabase())
        .select()
        .single();

    return Allergie.fromSupabase(response);
  }

  /// Allergie entfernen.
  Future<void> removeAllergie(String id) async {
    await _client.from('allergien').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Kontaktpersonen
  // ---------------------------------------------------------------------------

  /// Kontaktpersonen eines Kindes laden (sortiert nach Priorität).
  Future<List<Kontaktperson>> fetchKontaktpersonen(String kindId) async {
    final response = await _client
        .from('kontaktpersonen')
        .select()
        .eq('kind_id', kindId)
        .order('prioritaet', ascending: true);

    return (response as List)
        .map(
          (item) => Kontaktperson.fromSupabase(item as Map<String, dynamic>),
        )
        .toList();
  }

  /// Neue Kontaktperson hinzufügen.
  Future<Kontaktperson> addKontaktperson(Kontaktperson kp) async {
    final response = await _client
        .from('kontaktpersonen')
        .insert(kp.toSupabase())
        .select()
        .single();

    return Kontaktperson.fromSupabase(response);
  }

  /// Kontaktperson aktualisieren.
  Future<Kontaktperson> updateKontaktperson(Kontaktperson kp) async {
    final response = await _client
        .from('kontaktpersonen')
        .update(kp.toSupabase())
        .eq('id', kp.id)
        .select()
        .single();

    return Kontaktperson.fromSupabase(response);
  }

  /// Kontaktperson entfernen.
  Future<void> removeKontaktperson(String id) async {
    await _client.from('kontaktpersonen').delete().eq('id', id);
  }

  // ---------------------------------------------------------------------------
  // Gruppen
  // ---------------------------------------------------------------------------

  /// Aktive Gruppen einer Einrichtung laden.
  Future<List<Gruppe>> fetchGruppen(String einrichtungId) async {
    final response = await _client
        .from('gruppen_klassen')
        .select()
        .eq('einrichtung_id', einrichtungId)
        .eq('aktiv', true);

    return (response as List)
        .map((item) => Gruppe.fromSupabase(item as Map<String, dynamic>))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Avatar
  // ---------------------------------------------------------------------------

  /// Avatar hochladen und öffentliche URL zurückgeben.
  Future<String> uploadAvatar(
    String kindId,
    Uint8List bytes,
    String fileName,
  ) async {
    final path = 'kinder/$kindId/$fileName';

    await SupabaseConfig.storage.from('avatars').uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );

    final publicUrl =
        SupabaseConfig.storage.from('avatars').getPublicUrl(path);

    // Kind-Datensatz mit neuer Avatar-URL aktualisieren
    await _client
        .from('kinder')
        .update({'avatar_url': publicUrl})
        .eq('id', kindId);

    return publicUrl;
  }

  // ---------------------------------------------------------------------------
  // Fehlerbehandlung
  // ---------------------------------------------------------------------------

  /// Supabase-Fehlermeldungen in deutsche Benutzersprache übersetzen.
  static String extractErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('not found') ||
        errorString.contains('no rows')) {
      return 'Der Datensatz wurde nicht gefunden.';
    } else if (errorString.contains('duplicate') ||
        errorString.contains('unique') ||
        errorString.contains('already exists')) {
      return 'Dieser Eintrag existiert bereits.';
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
    } else if (errorString.contains('storage') ||
        errorString.contains('bucket')) {
      return 'Fehler beim Dateispeicher. Bitte versuche es erneut.';
    }

    return 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.';
  }
}

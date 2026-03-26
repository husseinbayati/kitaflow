import 'package:flutter/foundation.dart';
import '../../data/models/einrichtung.dart';
import '../../data/repositories/einrichtung_repository.dart';
import 'base_provider.dart';

class EinrichtungProvider extends BaseProvider {
  final EinrichtungRepository _einrichtungRepository;
  EinrichtungProvider(this._einrichtungRepository);

  Einrichtung? _einrichtung;
  Einrichtung? get einrichtung => _einrichtung;

  Future<void> loadEinrichtung(String einrichtungId) async {
    try {
      setLoading();
      _einrichtung = await _einrichtungRepository.fetchById(einrichtungId);
      setSuccess();
    } catch (e) {
      debugPrint('[EinrichtungProvider] loadEinrichtung Fehler: $e');
      setError('Einrichtung konnte nicht geladen werden.');
    }
  }

  Future<bool> updateEinrichtung(String id, Map<String, dynamic> updates) async {
    try {
      setLoading();
      _einrichtung = await _einrichtungRepository.updateEinrichtung(id, updates);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[EinrichtungProvider] updateEinrichtung Fehler: $e');
      setError('Einrichtung konnte nicht aktualisiert werden.');
      return false;
    }
  }

  Future<bool> updateEinstellungen(String id, Map<String, dynamic> einstellungen) async {
    try {
      setLoading();
      _einrichtung = await _einrichtungRepository.updateEinstellungen(id, einstellungen);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[EinrichtungProvider] updateEinstellungen Fehler: $e');
      setError('Einstellungen konnten nicht gespeichert werden.');
      return false;
    }
  }
}

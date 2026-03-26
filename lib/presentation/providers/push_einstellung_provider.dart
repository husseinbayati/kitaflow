import 'package:flutter/foundation.dart';
import '../../data/models/push_einstellung.dart';
import '../../data/repositories/push_einstellung_repository.dart';
import 'base_provider.dart';

class PushEinstellungProvider extends BaseProvider {
  final PushEinstellungRepository _repository;
  PushEinstellungProvider(this._repository);

  PushEinstellung? _einstellungen;

  PushEinstellung? get einstellungen => _einstellungen;

  Future<void> loadEinstellungen(String userId) async {
    try {
      setLoading();
      _einstellungen = await _repository.fetch(userId);
      setSuccess();
    } catch (e) {
      debugPrint('[PushEinstellungProvider] loadEinstellungen Fehler: $e');
      setError('Push-Einstellungen konnten nicht geladen werden.');
    }
  }

  Future<bool> updateEinstellung(PushEinstellung einstellung) async {
    try {
      setLoading();
      _einstellungen = await _repository.upsert(einstellung);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[PushEinstellungProvider] updateEinstellung Fehler: $e');
      setError('Einstellungen konnten nicht gespeichert werden.');
      return false;
    }
  }
}

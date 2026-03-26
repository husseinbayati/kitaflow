import 'package:flutter/foundation.dart';
import '../../data/models/gruppe.dart';
import '../../data/repositories/gruppe_repository.dart';
import 'base_provider.dart';

class GruppeProvider extends BaseProvider {
  final GruppeRepository _gruppeRepository;
  GruppeProvider(this._gruppeRepository);

  List<Gruppe> _gruppen = [];
  Map<String, int> _belegungMap = {};

  List<Gruppe> get gruppen => _gruppen;
  Map<String, int> get belegungMap => _belegungMap;

  int belegungForGruppe(String gruppeId) => _belegungMap[gruppeId] ?? 0;

  Future<void> loadGruppen(String einrichtungId) async {
    try {
      setLoading();
      final results = await Future.wait([
        _gruppeRepository.fetchGruppen(einrichtungId),
        _gruppeRepository.fetchBelegungMap(einrichtungId),
      ]);
      _gruppen = results[0] as List<Gruppe>;
      _belegungMap = results[1] as Map<String, int>;
      setSuccess();
    } catch (e) {
      debugPrint('[GruppeProvider] loadGruppen Fehler: $e');
      setError('Gruppen konnten nicht geladen werden.');
    }
  }

  Future<bool> createGruppe(Gruppe gruppe) async {
    try {
      setLoading();
      final neueGruppe = await _gruppeRepository.createGruppe(gruppe);
      _gruppen.add(neueGruppe);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[GruppeProvider] createGruppe Fehler: $e');
      setError('Gruppe konnte nicht erstellt werden.');
      return false;
    }
  }

  Future<bool> updateGruppe(String id, Map<String, dynamic> updates) async {
    try {
      setLoading();
      final aktualisierteGruppe = await _gruppeRepository.updateGruppe(id, updates);
      final index = _gruppen.indexWhere((g) => g.id == id);
      if (index != -1) _gruppen[index] = aktualisierteGruppe;
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[GruppeProvider] updateGruppe Fehler: $e');
      setError('Gruppe konnte nicht aktualisiert werden.');
      return false;
    }
  }

  Future<bool> deleteGruppe(String id) async {
    try {
      setLoading();
      await _gruppeRepository.deleteGruppe(id);
      _gruppen.removeWhere((g) => g.id == id);
      _belegungMap.remove(id);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[GruppeProvider] deleteGruppe Fehler: $e');
      setError('Gruppe konnte nicht gelöscht werden.');
      return false;
    }
  }
}

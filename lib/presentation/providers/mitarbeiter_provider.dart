import 'package:flutter/foundation.dart';
import '../../data/models/mitarbeiter_einrichtung.dart';
import '../../data/repositories/mitarbeiter_repository.dart';
import 'base_provider.dart';

class MitarbeiterProvider extends BaseProvider {
  final MitarbeiterRepository _mitarbeiterRepository;
  MitarbeiterProvider(this._mitarbeiterRepository);

  List<Map<String, dynamic>> _mitarbeiter = [];
  String? _einrichtungId;

  List<Map<String, dynamic>> get mitarbeiter => _mitarbeiter;

  Future<void> loadMitarbeiter(String einrichtungId) async {
    try {
      _einrichtungId = einrichtungId;
      setLoading();
      _mitarbeiter = await _mitarbeiterRepository.fetchMitarbeiter(einrichtungId);
      setSuccess();
    } catch (e) {
      debugPrint('[MitarbeiterProvider] loadMitarbeiter Fehler: $e');
      setError('Mitarbeiter konnten nicht geladen werden.');
    }
  }

  Future<bool> addMitarbeiter(MitarbeiterEinrichtung me) async {
    try {
      setLoading();
      await _mitarbeiterRepository.addMitarbeiter(me);
      if (_einrichtungId != null) await loadMitarbeiter(_einrichtungId!);
      return true;
    } catch (e) {
      debugPrint('[MitarbeiterProvider] addMitarbeiter Fehler: $e');
      setError('Mitarbeiter konnte nicht hinzugefügt werden.');
      return false;
    }
  }

  Future<bool> updateRolle(String mitarbeiterId, String rolle) async {
    try {
      setLoading();
      await _mitarbeiterRepository.updateRolle(mitarbeiterId, rolle);
      if (_einrichtungId != null) await loadMitarbeiter(_einrichtungId!);
      return true;
    } catch (e) {
      debugPrint('[MitarbeiterProvider] updateRolle Fehler: $e');
      setError('Rolle konnte nicht aktualisiert werden.');
      return false;
    }
  }

  Future<bool> assignGruppe(String meId, String? gruppeId) async {
    try {
      setLoading();
      await _mitarbeiterRepository.assignGruppe(meId, gruppeId);
      if (_einrichtungId != null) await loadMitarbeiter(_einrichtungId!);
      return true;
    } catch (e) {
      debugPrint('[MitarbeiterProvider] assignGruppe Fehler: $e');
      setError('Gruppenzuordnung konnte nicht geändert werden.');
      return false;
    }
  }

  Future<bool> removeMitarbeiter(String id) async {
    try {
      setLoading();
      await _mitarbeiterRepository.removeMitarbeiter(id);
      _mitarbeiter.removeWhere((m) => m['id'] == id);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[MitarbeiterProvider] removeMitarbeiter Fehler: $e');
      setError('Mitarbeiter konnte nicht entfernt werden.');
      return false;
    }
  }
}

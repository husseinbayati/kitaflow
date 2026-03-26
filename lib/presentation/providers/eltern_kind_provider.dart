import 'package:flutter/foundation.dart';
import '../../data/models/allergie.dart';
import '../../data/models/kind.dart';
import '../../data/models/kontaktperson.dart';
import '../../data/repositories/kind_repository.dart';
import 'base_provider.dart';

class ElternKindProvider extends BaseProvider {
  final KindRepository _kindRepository;
  ElternKindProvider(this._kindRepository);

  Kind? _selectedKind;
  List<Allergie> _allergien = [];
  List<Kontaktperson> _kontaktpersonen = [];

  Kind? get selectedKind => _selectedKind;
  List<Allergie> get allergien => _allergien;
  List<Kontaktperson> get kontaktpersonen => _kontaktpersonen;

  Future<void> loadKindDetails(String kindId) async {
    try {
      setLoading();
      final results = await Future.wait([
        _kindRepository.fetchKindById(kindId),
        _kindRepository.fetchAllergien(kindId),
        _kindRepository.fetchKontaktpersonen(kindId),
      ]);
      _selectedKind = results[0] as Kind?;
      _allergien = results[1] as List<Allergie>;
      _kontaktpersonen = results[2] as List<Kontaktperson>;
      setSuccess();
    } catch (e) {
      debugPrint('[ElternKindProvider] loadKindDetails Fehler: $e');
      setError('Kind-Details konnten nicht geladen werden.');
    }
  }

  Future<bool> updateKontaktperson(Kontaktperson kp) async {
    try {
      setLoading();
      final aktualisierteKp = await _kindRepository.updateKontaktperson(kp);
      final index = _kontaktpersonen.indexWhere((k) => k.id == kp.id);
      if (index != -1) {
        _kontaktpersonen[index] = aktualisierteKp;
      }
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[ElternKindProvider] updateKontaktperson Fehler: $e');
      setError('Kontaktperson konnte nicht aktualisiert werden.');
      return false;
    }
  }
}

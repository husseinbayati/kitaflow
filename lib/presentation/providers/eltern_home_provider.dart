import 'package:flutter/foundation.dart';
import '../../data/models/kind.dart';
import '../../data/repositories/eltern_repository.dart';
import 'base_provider.dart';

class ElternHomeProvider extends BaseProvider {
  final ElternRepository _elternRepository;
  ElternHomeProvider(this._elternRepository);

  List<Kind> _meineKinder = [];

  List<Kind> get meineKinder => _meineKinder;
  int get kinderCount => _meineKinder.length;

  Future<void> loadDashboard(String elternId) async {
    try {
      setLoading();
      _meineKinder = await _elternRepository.fetchMeineKinder(elternId);
      setSuccess();
    } catch (e) {
      debugPrint('[ElternHomeProvider] loadDashboard Fehler: $e');
      setError('Dashboard konnte nicht geladen werden.');
    }
  }
}

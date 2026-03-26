import 'package:flutter/foundation.dart';
import '../../data/models/termin.dart';
import '../../data/models/termin_rueckmeldung.dart';
import '../../data/repositories/termin_repository.dart';
import 'base_provider.dart';

class TerminProvider extends BaseProvider {
  final TerminRepository _terminRepository;
  TerminProvider(this._terminRepository);

  List<Termin> _termine = [];
  List<TerminRueckmeldung> _meineRueckmeldungen = [];

  List<Termin> get termine => _termine;
  List<TerminRueckmeldung> get meineRueckmeldungen => _meineRueckmeldungen;

  /// Termine grouped by date for calendar view.
  Map<DateTime, List<Termin>> get termineByDate {
    final map = <DateTime, List<Termin>>{};
    for (final termin in _termine) {
      final key = DateTime(termin.datum.year, termin.datum.month, termin.datum.day);
      map.putIfAbsent(key, () => []).add(termin);
    }
    return map;
  }

  Future<void> loadTermine(String einrichtungId, {DateTime? vonDatum, DateTime? bisDatum}) async {
    try {
      setLoading();
      _termine = await _terminRepository.fetchTermine(einrichtungId, vonDatum: vonDatum, bisDatum: bisDatum);
      setSuccess();
    } catch (e) {
      debugPrint('[TerminProvider] loadTermine Fehler: $e');
      setError('Termine konnten nicht geladen werden.');
    }
  }

  Future<void> loadTermineForEltern(String elternId) async {
    try {
      setLoading();
      final results = await Future.wait([
        _terminRepository.fetchTermineForEltern(elternId),
        _terminRepository.fetchMeineRueckmeldungen(elternId),
      ]);
      _termine = results[0] as List<Termin>;
      _meineRueckmeldungen = results[1] as List<TerminRueckmeldung>;
      setSuccess();
    } catch (e) {
      debugPrint('[TerminProvider] loadTermineForEltern Fehler: $e');
      setError('Termine konnten nicht geladen werden.');
    }
  }

  Future<bool> respondToTermin(TerminRueckmeldung rueckmeldung) async {
    try {
      setLoading();
      final result = await _terminRepository.upsertRueckmeldung(rueckmeldung);
      // Update local state
      final index = _meineRueckmeldungen.indexWhere((r) => r.terminId == rueckmeldung.terminId);
      if (index != -1) {
        _meineRueckmeldungen[index] = result;
      } else {
        _meineRueckmeldungen.add(result);
      }
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[TerminProvider] respondToTermin Fehler: $e');
      setError('Rückmeldung konnte nicht gespeichert werden.');
      return false;
    }
  }

  TerminRueckmeldung? getRueckmeldungForTermin(String terminId) {
    try {
      return _meineRueckmeldungen.firstWhere((r) => r.terminId == terminId);
    } catch (_) {
      return null;
    }
  }
}

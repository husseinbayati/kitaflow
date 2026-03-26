import 'package:flutter/foundation.dart';

import '../../core/constants/enums.dart';
import '../../data/models/eingewoehnung.dart';
import '../../data/models/eingewoehnung_tagesnotiz.dart';
import '../../data/repositories/eingewoehnung_repository.dart';
import 'base_provider.dart';

/// Provider für Eingewöhnung (Berliner Modell).
/// Verwaltet Laden, Filtern, Phasenwechsel und Tagesnotizen.
class EingewoehnungProvider extends BaseProvider {
  final EingewoehnungRepository _eingewoehnungRepository;
  EingewoehnungProvider(this._eingewoehnungRepository);

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  List<Eingewoehnung> _eingewoehnungen = [];
  Eingewoehnung? _selectedEingewoehnung;
  List<EingewoehnungTagesnotiz> _tagesnotizen = [];
  EingewoehnungPhase? _filterPhase;

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  List<Eingewoehnung> get eingewoehnungen => _eingewoehnungen;
  Eingewoehnung? get selectedEingewoehnung => _selectedEingewoehnung;
  List<EingewoehnungTagesnotiz> get tagesnotizen => _tagesnotizen;
  EingewoehnungPhase? get filterPhase => _filterPhase;

  /// Gefilterte Liste: wenn kein Filter gesetzt, alle zurückgeben.
  List<Eingewoehnung> get filteredEingewoehnungen {
    if (_filterPhase == null) return _eingewoehnungen;
    return _eingewoehnungen.where((e) => e.phase == _filterPhase).toList();
  }

  /// Nur aktive (nicht abgeschlossene) Eingewöhnungen.
  List<Eingewoehnung> get aktiveEingewoehnungen {
    return _eingewoehnungen.where((e) => !e.istAbgeschlossen).toList();
  }

  // ---------------------------------------------------------------------------
  // Laden
  // ---------------------------------------------------------------------------

  /// Alle Eingewöhnungen einer Einrichtung laden.
  Future<void> loadEingewoehnungen(String einrichtungId) async {
    try {
      setLoading();
      _eingewoehnungen =
          await _eingewoehnungRepository.fetchByEinrichtung(einrichtungId);
      setSuccess();
    } catch (e) {
      debugPrint('[EingewoehnungProvider] loadEingewoehnungen Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
    }
  }

  /// Einzelne Eingewöhnung mit Tagesnotizen laden.
  Future<void> loadDetail(String id) async {
    try {
      setLoading();
      _selectedEingewoehnung =
          await _eingewoehnungRepository.fetchById(id);
      _tagesnotizen =
          await _eingewoehnungRepository.fetchTagesnotizen(id);
      setSuccess();
    } catch (e) {
      debugPrint('[EingewoehnungProvider] loadDetail Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
    }
  }

  // ---------------------------------------------------------------------------
  // Filter & Auswahl
  // ---------------------------------------------------------------------------

  /// Einzelne Eingewöhnung auswählen (z.B. für Detailansicht).
  void selectEingewoehnung(Eingewoehnung? e) {
    _selectedEingewoehnung = e;
    notifySafely();
  }

  /// Phasen-Filter setzen (null = alle anzeigen).
  void setFilterPhase(EingewoehnungPhase? phase) {
    _filterPhase = phase;
    notifySafely();
  }

  // ---------------------------------------------------------------------------
  // Erstellen / Phasenwechsel
  // ---------------------------------------------------------------------------

  /// Neue Eingewöhnung erstellen.
  Future<bool> createEingewoehnung(Eingewoehnung e) async {
    try {
      final created = await _eingewoehnungRepository.create(e);
      _eingewoehnungen.insert(0, created);
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[EingewoehnungProvider] createEingewoehnung Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Phase einer Eingewöhnung aktualisieren.
  Future<bool> updatePhase(String id, EingewoehnungPhase phase) async {
    try {
      final updated = await _eingewoehnungRepository.updatePhase(id, phase);
      final index = _eingewoehnungen.indexWhere((e) => e.id == id);
      if (index != -1) {
        _eingewoehnungen[index] = updated;
      }
      if (_selectedEingewoehnung?.id == id) {
        _selectedEingewoehnung = updated;
      }
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[EingewoehnungProvider] updatePhase Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Tagesnotizen
  // ---------------------------------------------------------------------------

  /// Neue Tagesnotiz hinzufügen.
  Future<bool> addTagesnotiz(EingewoehnungTagesnotiz notiz) async {
    try {
      final created = await _eingewoehnungRepository.createTagesnotiz(notiz);
      _tagesnotizen.insert(0, created);
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[EingewoehnungProvider] addTagesnotiz Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Tagesnotiz aktualisieren.
  Future<bool> updateTagesnotiz(EingewoehnungTagesnotiz notiz) async {
    try {
      final updated =
          await _eingewoehnungRepository.updateTagesnotiz(notiz);
      final index = _tagesnotizen.indexWhere((n) => n.id == notiz.id);
      if (index != -1) {
        _tagesnotizen[index] = updated;
      }
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[EingewoehnungProvider] updateTagesnotiz Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Eingewöhnungen eines bestimmten Kindes laden.
  Future<void> loadByKindId(String kindId) async {
    try {
      setLoading();
      _eingewoehnungen =
          await _eingewoehnungRepository.fetchByKindId(kindId);
      setSuccess();
    } catch (e) {
      debugPrint('[EingewoehnungProvider] loadByKindId Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
    }
  }

  /// Eingewöhnung aktualisieren (z.B. Eltern-Feedback speichern).
  Future<bool> updateEingewoehnung(Eingewoehnung e) async {
    try {
      final updated = await _eingewoehnungRepository.update(e);
      final index = _eingewoehnungen.indexWhere((x) => x.id == e.id);
      if (index != -1) {
        _eingewoehnungen[index] = updated;
      }
      if (_selectedEingewoehnung?.id == e.id) {
        _selectedEingewoehnung = updated;
      }
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[EingewoehnungProvider] updateEingewoehnung Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Tagesnotiz löschen.
  Future<bool> deleteTagesnotiz(String id) async {
    try {
      await _eingewoehnungRepository.deleteTagesnotiz(id);
      _tagesnotizen.removeWhere((n) => n.id == id);
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[EingewoehnungProvider] deleteTagesnotiz Fehler: $e');
      setError(EingewoehnungRepository.extractErrorMessage(e));
      return false;
    }
  }
}

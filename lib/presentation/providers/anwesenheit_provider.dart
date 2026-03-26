import 'package:flutter/foundation.dart';

import '../../core/constants/enums.dart';
import '../../data/models/anwesenheit_heute.dart';
import '../../data/repositories/anwesenheit_repository.dart';
import 'base_provider.dart';

/// Provider für Anwesenheits-Verwaltung.
/// Kapselt Anwesenheits-State und stellt Check-In/Out + Filter-Logik bereit.
class AnwesenheitProvider extends BaseProvider {
  final AnwesenheitRepository _anwesenheitRepository;

  AnwesenheitProvider(this._anwesenheitRepository);

  // --- Private State ---

  List<AnwesenheitHeute> _heuteEintraege = [];
  DateTime _selectedDate = DateTime.now();
  String? _filterGruppeId;

  // --- Getter ---

  List<AnwesenheitHeute> get heuteEintraege => _heuteEintraege;
  DateTime get selectedDate => _selectedDate;
  String? get filterGruppeId => _filterGruppeId;

  /// Gefilterte Einträge basierend auf Gruppen-Filter.
  List<AnwesenheitHeute> get filteredEintraege {
    if (_filterGruppeId == null) {
      return List<AnwesenheitHeute>.from(_heuteEintraege);
    }
    return _heuteEintraege
        .where((e) => e.gruppeId == _filterGruppeId)
        .toList();
  }

  /// Anzahl anwesender Kinder.
  int get anwesendCount =>
      _heuteEintraege.where((e) => e.status == AttendanceStatus.anwesend).length;

  /// Anzahl abwesender Kinder (abwesend oder unentschuldigt).
  int get abwesendCount => _heuteEintraege
      .where((e) =>
          e.status == AttendanceStatus.abwesend ||
          e.status == AttendanceStatus.unentschuldigt)
      .length;

  /// Anzahl kranker/entschuldigter Kinder (krank, entschuldigt oder urlaub).
  int get krankCount => _heuteEintraege
      .where((e) =>
          e.status == AttendanceStatus.krank ||
          e.status == AttendanceStatus.entschuldigt ||
          e.status == AttendanceStatus.urlaub)
      .length;

  /// Anzahl nicht erfasster Kinder (kein Eintrag für heute).
  int get nichtErfasstCount =>
      _heuteEintraege.where((e) => e.status == null).length;

  /// Gesamtanzahl der Einträge.
  int get gesamtCount => _heuteEintraege.length;

  // --- Laden ---

  /// Lädt die heutige Anwesenheitsübersicht einer Einrichtung.
  /// Nutzt die View v_anwesenheit_heute (nur für heute gültig).
  Future<void> loadHeute(String einrichtungId) async {
    try {
      setLoading();

      _heuteEintraege =
          await _anwesenheitRepository.fetchAnwesenheitHeute(einrichtungId);
      _selectedDate = DateTime.now();
      setSuccess();
    } catch (e) {
      debugPrint('[AnwesenheitProvider] loadHeute Fehler: $e');
      setError('Anwesenheit konnte nicht geladen werden: $e');
    }
  }

  /// Lädt Anwesenheit für ein bestimmtes Datum.
  /// Hinweis: v_anwesenheit_heute funktioniert nur für heute.
  /// Für andere Tage wird derzeit nur die Heute-Ansicht unterstützt.
  Future<void> loadByDate(String einrichtungId, DateTime datum) async {
    final heute = DateTime.now();
    final istHeute = datum.year == heute.year &&
        datum.month == heute.month &&
        datum.day == heute.day;

    if (istHeute) {
      await loadHeute(einrichtungId);
      return;
    }

    // Für andere Tage: aktuell nicht unterstützt via v_anwesenheit_heute.
    // Zukünftig: direkte Abfrage der anwesenheit-Tabelle.
    debugPrint(
      '[AnwesenheitProvider] loadByDate: Nur Heute-Ansicht unterstützt. '
      'Datum $datum wird ignoriert.',
    );
    _selectedDate = datum;
    _heuteEintraege = [];
    notifySafely();
  }

  // --- Mutationen ---

  /// Check-In: Kind als anwesend markieren.
  /// Gibt true bei Erfolg zurück.
  Future<bool> checkIn(
    String kindId,
    String einrichtungId, {
    String? gebrachtVon,
  }) async {
    try {
      setLoading();

      await _anwesenheitRepository.checkIn(
        kindId,
        einrichtungId,
        gebrachtVon: gebrachtVon,
      );
      await loadHeute(einrichtungId);
      return true;
    } catch (e) {
      debugPrint('[AnwesenheitProvider] checkIn Fehler: $e');
      setError('Check-In konnte nicht durchgeführt werden: $e');
      return false;
    }
  }

  /// Check-Out: Abholzeit eintragen.
  /// Gibt true bei Erfolg zurück.
  Future<bool> checkOut(
    String anwesenheitId, {
    String? abgeholtVon,
  }) async {
    try {
      setLoading();

      await _anwesenheitRepository.checkOut(
        anwesenheitId,
        abgeholtVon: abgeholtVon,
      );

      // Einrichtungs-ID aus vorhandenen Einträgen ermitteln
      final einrichtungId = _heuteEintraege.isNotEmpty
          ? _heuteEintraege.first.einrichtungId
          : null;
      if (einrichtungId != null) {
        await loadHeute(einrichtungId);
      }
      return true;
    } catch (e) {
      debugPrint('[AnwesenheitProvider] checkOut Fehler: $e');
      setError('Check-Out konnte nicht durchgeführt werden: $e');
      return false;
    }
  }

  /// Status eines bestehenden Anwesenheitseintrags aktualisieren.
  /// Gibt true bei Erfolg zurück.
  Future<bool> updateStatus(
    String anwesenheitId,
    AttendanceStatus status, {
    String? notiz,
  }) async {
    try {
      setLoading();

      await _anwesenheitRepository.updateStatus(
        anwesenheitId,
        status,
        notiz: notiz,
      );

      // Einrichtungs-ID aus vorhandenen Einträgen ermitteln
      final einrichtungId = _heuteEintraege.isNotEmpty
          ? _heuteEintraege.first.einrichtungId
          : null;
      if (einrichtungId != null) {
        await loadHeute(einrichtungId);
      }
      return true;
    } catch (e) {
      debugPrint('[AnwesenheitProvider] updateStatus Fehler: $e');
      setError('Status konnte nicht aktualisiert werden: $e');
      return false;
    }
  }

  /// Kind als abwesend markieren (neuer Eintrag ohne Check-In).
  /// Gibt true bei Erfolg zurück.
  Future<bool> markAbwesend(
    String kindId,
    String einrichtungId,
    AttendanceStatus status, {
    String? notiz,
  }) async {
    try {
      setLoading();

      await _anwesenheitRepository.markAbwesend(
        kindId,
        einrichtungId,
        status,
        notiz: notiz,
      );
      await loadHeute(einrichtungId);
      return true;
    } catch (e) {
      debugPrint('[AnwesenheitProvider] markAbwesend Fehler: $e');
      setError('Abwesenheit konnte nicht eingetragen werden: $e');
      return false;
    }
  }

  // --- Filter ---

  /// Setzt den Gruppen-Filter.
  void setFilterGruppe(String? gruppeId) {
    _filterGruppeId = gruppeId;
    notifySafely();
  }

  /// Setzt alle Filter zurück.
  void clearFilter() {
    _filterGruppeId = null;
    notifySafely();
  }
}

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../data/models/essensplan.dart';
import '../../data/repositories/essensplan_repository.dart';
import 'base_provider.dart';

/// Warnung bei Allergen-Kollision zwischen Mahlzeit und Kind.
class AllergenWarnung {
  final String kindName;
  final String allergen;
  final String schweregrad;
  final String gerichtName;
  final DateTime datum;

  const AllergenWarnung({
    required this.kindName,
    required this.allergen,
    required this.schweregrad,
    required this.gerichtName,
    required this.datum,
  });
}

/// Provider für Essensplan-Verwaltung.
/// Kapselt Wochenplan-State, Navigation, CRUD und Allergen-Warnungen.
class EssensplanProvider extends BaseProvider {
  final EssensplanRepository _essensplanRepository;

  EssensplanProvider(this._essensplanRepository);

  // --- Private State ---

  List<Essensplan> _wochenplan = [];
  DateTime _selectedMontag = _getMontag(DateTime.now());
  List<Map<String, dynamic>> _kinderAllergien = [];
  List<AllergenWarnung> _warnungen = [];
  String? _einrichtungId;

  // --- Getter ---

  List<Essensplan> get wochenplan => _wochenplan;
  DateTime get selectedMontag => _selectedMontag;
  List<Map<String, dynamic>> get kinderAllergien => _kinderAllergien;
  List<AllergenWarnung> get warnungen => _warnungen;
  String? get einrichtungId => _einrichtungId;

  /// Freitag der ausgewählten Woche.
  DateTime get selectedFreitag => _selectedMontag.add(const Duration(days: 4));

  /// Wochenplan gruppiert nach Datum (Uhrzeit wird abgeschnitten).
  Map<DateTime, List<Essensplan>> get wochenplanByDate {
    final map = <DateTime, List<Essensplan>>{};
    for (final plan in _wochenplan) {
      final key = DateTime(plan.datum.year, plan.datum.month, plan.datum.day);
      map.putIfAbsent(key, () => []).add(plan);
    }
    return map;
  }

  /// Essenspläne für ein bestimmtes Datum.
  List<Essensplan> planForDate(DateTime date) {
    final key = DateTime(date.year, date.month, date.day);
    return wochenplanByDate[key] ?? [];
  }

  /// Formatierte Kalenderwochen-Anzeige, z.B. "KW 13 · 24.03. – 28.03."
  String get kalenderWocheText {
    final kw = _getIsoWeekNumber(_selectedMontag);
    final freitag = selectedFreitag;
    final montagFormat = DateFormat('dd.MM.').format(_selectedMontag);
    final freitagFormat = DateFormat('dd.MM.').format(freitag);
    return 'KW $kw · $montagFormat – $freitagFormat';
  }

  // --- Laden ---

  /// Lädt den Wochenplan und Kinder-Allergien einer Einrichtung.
  /// Berechnet anschließend Allergen-Warnungen.
  Future<void> loadWochenplan(String einrichtungId) async {
    try {
      _einrichtungId = einrichtungId;
      setLoading();

      // Wochenplan und Allergien parallel laden
      final results = await Future.wait([
        _essensplanRepository.fetchWochenplan(einrichtungId, _selectedMontag),
        _essensplanRepository.fetchKinderAllergien(einrichtungId),
      ]);

      _wochenplan = results[0] as List<Essensplan>;
      _kinderAllergien = results[1] as List<Map<String, dynamic>>;

      _berechneWarnungen();
      setSuccess();
    } catch (e) {
      debugPrint('[EssensplanProvider] loadWochenplan Fehler: $e');
      setError('Wochenplan konnte nicht geladen werden: $e');
    }
  }

  // --- Mutationen ---

  /// Neuen Essensplan-Eintrag erstellen.
  /// Gibt true bei Erfolg zurück.
  Future<bool> createEssensplan(Essensplan plan) async {
    try {
      setLoading();

      await _essensplanRepository.createEssensplan(plan);

      if (_einrichtungId != null) {
        await loadWochenplan(_einrichtungId!);
      }
      return true;
    } catch (e) {
      debugPrint('[EssensplanProvider] createEssensplan Fehler: $e');
      setError('Essensplan konnte nicht erstellt werden: $e');
      return false;
    }
  }

  /// Bestehenden Essensplan-Eintrag aktualisieren.
  /// Gibt true bei Erfolg zurück.
  Future<bool> updateEssensplan(
    String id,
    Map<String, dynamic> updates,
  ) async {
    try {
      setLoading();

      await _essensplanRepository.updateEssensplan(id, updates);

      if (_einrichtungId != null) {
        await loadWochenplan(_einrichtungId!);
      }
      return true;
    } catch (e) {
      debugPrint('[EssensplanProvider] updateEssensplan Fehler: $e');
      setError('Essensplan konnte nicht aktualisiert werden: $e');
      return false;
    }
  }

  /// Essensplan-Eintrag löschen.
  /// Gibt true bei Erfolg zurück.
  Future<bool> deleteEssensplan(String id) async {
    try {
      setLoading();

      await _essensplanRepository.deleteEssensplan(id);

      if (_einrichtungId != null) {
        await loadWochenplan(_einrichtungId!);
      }
      return true;
    } catch (e) {
      debugPrint('[EssensplanProvider] deleteEssensplan Fehler: $e');
      setError('Essensplan konnte nicht gelöscht werden: $e');
      return false;
    }
  }

  // --- Navigation ---

  /// Woche vor- oder zurücknavigieren.
  /// [offset] = 1 für nächste Woche, -1 für vorherige Woche.
  void navigateWeek(int offset) {
    _selectedMontag = _selectedMontag.add(Duration(days: 7 * offset));
    if (_einrichtungId != null) {
      loadWochenplan(_einrichtungId!);
    }
  }

  /// Zur aktuellen Woche zurückkehren.
  void goToCurrentWeek() {
    final heuteMontag = _getMontag(DateTime.now());
    if (_selectedMontag != heuteMontag) {
      _selectedMontag = heuteMontag;
      if (_einrichtungId != null) {
        loadWochenplan(_einrichtungId!);
      }
    }
  }

  // --- Allergen-Warnungen ---

  /// Berechnet Warnungen für Allergen-Kollisionen zwischen Essensplänen
  /// und Kinder-Allergien.
  void _berechneWarnungen() {
    _warnungen = [];

    for (final plan in _wochenplan) {
      for (final allergen in plan.allergene) {
        for (final kinderAllergie in _kinderAllergien) {
          if (kinderAllergie['allergen'] == allergen) {
            final kinder = kinderAllergie['kinder'] as Map<String, dynamic>?;
            final vorname = kinder?['vorname'] as String? ?? '';
            final nachname = kinder?['nachname'] as String? ?? '';
            final kindName = '$vorname $nachname'.trim();

            _warnungen.add(AllergenWarnung(
              kindName: kindName,
              allergen: allergen,
              schweregrad:
                  kinderAllergie['schweregrad'] as String? ?? 'unbekannt',
              gerichtName: plan.gerichtName,
              datum: plan.datum,
            ));
          }
        }
      }
    }
  }

  // --- Hilfsmethoden ---

  /// Montag der Woche berechnen, in der [date] liegt.
  static DateTime _getMontag(DateTime date) {
    final weekday = date.weekday; // Montag = 1
    return DateTime(date.year, date.month, date.day - (weekday - 1));
  }

  /// ISO-Wochennummer berechnen.
  static int _getIsoWeekNumber(DateTime date) {
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}

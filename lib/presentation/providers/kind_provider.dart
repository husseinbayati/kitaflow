import 'package:flutter/foundation.dart';

import '../../data/models/allergie.dart';
import '../../data/models/gruppe.dart';
import '../../data/models/kind.dart';
import '../../data/models/kontaktperson.dart';
import '../../data/repositories/kind_repository.dart';
import 'base_provider.dart';

/// Provider für Kinder-Verwaltung.
/// Kapselt Kind-State und stellt CRUD + Filter-Logik bereit.
class KindProvider extends BaseProvider {
  final KindRepository _kindRepository;

  KindProvider(this._kindRepository);

  // --- Private State ---

  List<Kind> _kinder = [];
  Kind? _selectedKind;
  List<Allergie> _allergien = [];
  List<Kontaktperson> _kontaktpersonen = [];
  List<Gruppe> _gruppen = [];
  String? _filterGruppeId;
  String? _filterStatus;
  String? _suchbegriff;

  // --- Getter ---

  List<Kind> get kinder => _kinder;
  Kind? get selectedKind => _selectedKind;
  List<Allergie> get allergien => _allergien;
  List<Kontaktperson> get kontaktpersonen => _kontaktpersonen;
  List<Gruppe> get gruppen => _gruppen;
  String? get filterGruppeId => _filterGruppeId;
  String? get filterStatus => _filterStatus;
  String? get suchbegriff => _suchbegriff;

  /// Gefilterte Kinderliste basierend auf aktiven Filtern.
  List<Kind> get filteredKinder {
    var ergebnis = List<Kind>.from(_kinder);

    if (_filterGruppeId != null) {
      ergebnis = ergebnis.where((k) => k.gruppeId == _filterGruppeId).toList();
    }

    if (_filterStatus != null) {
      ergebnis =
          ergebnis.where((k) => k.status.name == _filterStatus).toList();
    }

    if (_suchbegriff != null && _suchbegriff!.isNotEmpty) {
      final suchtext = _suchbegriff!.toLowerCase();
      ergebnis = ergebnis.where((k) {
        return k.vorname.toLowerCase().contains(suchtext) ||
            k.nachname.toLowerCase().contains(suchtext) ||
            k.vollstaendigerName.toLowerCase().contains(suchtext);
      }).toList();
    }

    return ergebnis;
  }

  // --- Laden ---

  /// Lädt alle Kinder einer Einrichtung und die zugehörigen Gruppen.
  Future<void> loadKinder(String einrichtungId) async {
    try {
      setLoading();

      final results = await Future.wait([
        _kindRepository.fetchKinder(einrichtungId: einrichtungId),
        _kindRepository.fetchGruppen(einrichtungId),
      ]);

      _kinder = results[0] as List<Kind>;
      _gruppen = results[1] as List<Gruppe>;
      setSuccess();
    } catch (e) {
      debugPrint('[KindProvider] loadKinder Fehler: $e');
      setError('Kinder konnten nicht geladen werden: $e');
    }
  }

  /// Lädt Details eines Kindes inkl. Allergien und Kontaktpersonen.
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
      debugPrint('[KindProvider] loadKindDetails Fehler: $e');
      setError('Kind-Details konnten nicht geladen werden: $e');
    }
  }

  // --- Kind CRUD ---

  /// Erstellt ein neues Kind.
  /// Gibt true bei Erfolg zurück.
  Future<bool> createKind(Kind kind) async {
    try {
      setLoading();

      final neuesKind = await _kindRepository.createKind(kind);
      _kinder.add(neuesKind);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] createKind Fehler: $e');
      setError('Kind konnte nicht erstellt werden: $e');
      return false;
    }
  }

  /// Aktualisiert ein bestehendes Kind.
  /// Gibt true bei Erfolg zurück.
  Future<bool> updateKind(Kind kind) async {
    try {
      setLoading();

      final aktualisiertesKind = await _kindRepository.updateKind(kind);
      final index = _kinder.indexWhere((k) => k.id == kind.id);
      if (index != -1) {
        _kinder[index] = aktualisiertesKind;
      }
      if (_selectedKind?.id == kind.id) {
        _selectedKind = aktualisiertesKind;
      }
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] updateKind Fehler: $e');
      setError('Kind konnte nicht aktualisiert werden: $e');
      return false;
    }
  }

  /// Löscht ein Kind (Soft-Delete).
  /// Gibt true bei Erfolg zurück.
  Future<bool> deleteKind(String id) async {
    try {
      setLoading();

      await _kindRepository.deleteKind(id);
      _kinder.removeWhere((k) => k.id == id);
      if (_selectedKind?.id == id) {
        _selectedKind = null;
      }
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] deleteKind Fehler: $e');
      setError('Kind konnte nicht gelöscht werden: $e');
      return false;
    }
  }

  // --- Allergien ---

  /// Fügt eine Allergie hinzu.
  /// Gibt true bei Erfolg zurück.
  Future<bool> addAllergie(Allergie allergie) async {
    try {
      setLoading();

      final neueAllergie = await _kindRepository.addAllergie(allergie);
      _allergien.add(neueAllergie);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] addAllergie Fehler: $e');
      setError('Allergie konnte nicht hinzugefügt werden: $e');
      return false;
    }
  }

  /// Entfernt eine Allergie.
  /// Gibt true bei Erfolg zurück.
  Future<bool> removeAllergie(String id) async {
    try {
      setLoading();

      await _kindRepository.removeAllergie(id);
      _allergien.removeWhere((a) => a.id == id);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] removeAllergie Fehler: $e');
      setError('Allergie konnte nicht entfernt werden: $e');
      return false;
    }
  }

  // --- Kontaktpersonen ---

  /// Fügt eine Kontaktperson hinzu.
  /// Gibt true bei Erfolg zurück.
  Future<bool> addKontaktperson(Kontaktperson kp) async {
    try {
      setLoading();

      final neueKp = await _kindRepository.addKontaktperson(kp);
      _kontaktpersonen.add(neueKp);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] addKontaktperson Fehler: $e');
      setError('Kontaktperson konnte nicht hinzugefügt werden: $e');
      return false;
    }
  }

  /// Aktualisiert eine Kontaktperson.
  /// Gibt true bei Erfolg zurück.
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
      debugPrint('[KindProvider] updateKontaktperson Fehler: $e');
      setError('Kontaktperson konnte nicht aktualisiert werden: $e');
      return false;
    }
  }

  /// Entfernt eine Kontaktperson.
  /// Gibt true bei Erfolg zurück.
  Future<bool> removeKontaktperson(String id) async {
    try {
      setLoading();

      await _kindRepository.removeKontaktperson(id);
      _kontaktpersonen.removeWhere((k) => k.id == id);
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] removeKontaktperson Fehler: $e');
      setError('Kontaktperson konnte nicht entfernt werden: $e');
      return false;
    }
  }

  // --- Filter ---

  /// Setzt Filter für die Kinderliste.
  void setFilter({String? gruppeId, String? status, String? suchbegriff}) {
    _filterGruppeId = gruppeId;
    _filterStatus = status;
    _suchbegriff = suchbegriff;
    notifySafely();
  }

  /// Setzt alle Filter zurück.
  void clearFilters() {
    _filterGruppeId = null;
    _filterStatus = null;
    _suchbegriff = null;
    notifySafely();
  }

  // --- Avatar ---

  /// Lädt ein Avatar-Bild für ein Kind hoch.
  /// Gibt true bei Erfolg zurück.
  Future<bool> uploadAvatar(
    String kindId,
    Uint8List bytes,
    String fileName,
  ) async {
    try {
      setLoading();

      final avatarUrl =
          await _kindRepository.uploadAvatar(kindId, bytes, fileName);

      // Kind in der Liste aktualisieren
      final index = _kinder.indexWhere((k) => k.id == kindId);
      if (index != -1) {
        _kinder[index] = _kinder[index].copyWith(avatarUrl: avatarUrl);
      }
      if (_selectedKind?.id == kindId) {
        _selectedKind = _selectedKind!.copyWith(avatarUrl: avatarUrl);
      }

      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[KindProvider] uploadAvatar Fehler: $e');
      setError('Avatar konnte nicht hochgeladen werden: $e');
      return false;
    }
  }
}

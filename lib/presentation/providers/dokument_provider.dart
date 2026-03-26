import 'package:flutter/foundation.dart';

import '../../core/constants/enums.dart';
import '../../data/models/dokument.dart';
import '../../data/repositories/dokument_repository.dart';
import 'base_provider.dart';

/// Provider für Dokumenten-Verwaltung.
/// Verwaltet Laden, Filtern, Erstellen, Bearbeiten, Löschen und Unterschreiben.
class DokumentProvider extends BaseProvider {
  final DokumentRepository _dokumentRepository;
  DokumentProvider(this._dokumentRepository);

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  List<Dokument> _dokumente = [];
  Dokument? _selectedDokument;
  DocumentType? _filterTyp;

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  List<Dokument> get dokumente => _dokumente;
  Dokument? get selectedDokument => _selectedDokument;
  DocumentType? get filterTyp => _filterTyp;

  /// Gefilterte Liste: wenn kein Filter gesetzt, alle zurückgeben.
  List<Dokument> get filteredDokumente {
    if (_filterTyp == null) return _dokumente;
    return _dokumente.where((d) => d.typ == _filterTyp).toList();
  }

  // ---------------------------------------------------------------------------
  // Laden
  // ---------------------------------------------------------------------------

  /// Alle Dokumente einer Einrichtung laden.
  Future<void> loadDokumente(String einrichtungId) async {
    try {
      setLoading();
      _dokumente =
          await _dokumentRepository.fetchByEinrichtung(einrichtungId);
      setSuccess();
    } catch (e) {
      debugPrint('[DokumentProvider] loadDokumente Fehler: $e');
      setError(DokumentRepository.extractErrorMessage(e));
    }
  }

  /// Alle Dokumente eines Kindes laden.
  Future<void> loadDokumenteByKind(String kindId) async {
    try {
      setLoading();
      _dokumente = await _dokumentRepository.fetchByKind(kindId);
      setSuccess();
    } catch (e) {
      debugPrint('[DokumentProvider] loadDokumenteByKind Fehler: $e');
      setError(DokumentRepository.extractErrorMessage(e));
    }
  }

  // ---------------------------------------------------------------------------
  // Filter & Auswahl
  // ---------------------------------------------------------------------------

  /// Dokumenttyp-Filter setzen (null = alle anzeigen).
  void setFilter(DocumentType? typ) {
    _filterTyp = typ;
    notifySafely();
  }

  /// Einzelnes Dokument auswählen (z.B. für Detailansicht).
  void selectDokument(Dokument? dok) {
    _selectedDokument = dok;
    notifySafely();
  }

  // ---------------------------------------------------------------------------
  // Erstellen / Aktualisieren / Löschen
  // ---------------------------------------------------------------------------

  /// Neues Dokument erstellen.
  Future<bool> createDokument(Dokument dok) async {
    try {
      final created = await _dokumentRepository.createDokument(dok);
      _dokumente.insert(0, created);
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[DokumentProvider] createDokument Fehler: $e');
      setError(DokumentRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Dokument aktualisieren.
  Future<bool> updateDokument(String id, Map<String, dynamic> updates) async {
    try {
      final updated = await _dokumentRepository.updateDokument(id, updates);
      final index = _dokumente.indexWhere((d) => d.id == id);
      if (index != -1) {
        _dokumente[index] = updated;
      }
      if (_selectedDokument?.id == id) {
        _selectedDokument = updated;
      }
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[DokumentProvider] updateDokument Fehler: $e');
      setError(DokumentRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Dokument löschen.
  Future<bool> deleteDokument(String id) async {
    try {
      await _dokumentRepository.deleteDokument(id);
      _dokumente.removeWhere((d) => d.id == id);
      if (_selectedDokument?.id == id) {
        _selectedDokument = null;
      }
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[DokumentProvider] deleteDokument Fehler: $e');
      setError(DokumentRepository.extractErrorMessage(e));
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Storage
  // ---------------------------------------------------------------------------

  /// Datei in Supabase Storage hochladen.
  Future<String> uploadDatei(
      String einrichtungId, String dateiname, Uint8List bytes) async {
    return _dokumentRepository.uploadDatei(einrichtungId, dateiname, bytes);
  }

  /// Signierte URL für eine Datei generieren.
  Future<String> getSignedUrl(String storagePfad) async {
    return _dokumentRepository.getSignedUrl(storagePfad);
  }

  // ---------------------------------------------------------------------------
  // Unterschrift
  // ---------------------------------------------------------------------------

  /// Dokument digital unterschreiben.
  Future<bool> signDokument(
      String dokumentId, String signerName, Uint8List signatureBytes) async {
    try {
      final signed = await _dokumentRepository.markAsSigned(
          dokumentId, signerName, signatureBytes);
      final index = _dokumente.indexWhere((d) => d.id == dokumentId);
      if (index != -1) {
        _dokumente[index] = signed;
      }
      if (_selectedDokument?.id == dokumentId) {
        _selectedDokument = signed;
      }
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[DokumentProvider] signDokument Fehler: $e');
      setError(DokumentRepository.extractErrorMessage(e));
      return false;
    }
  }
}

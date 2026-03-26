import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../config/supabase_config.dart';
import '../../core/constants/enums.dart';
import '../../data/models/nachricht.dart';
import '../../data/models/nachricht_anhang.dart';
import '../../data/models/nachricht_empfaenger.dart';
import '../../data/repositories/nachricht_repository.dart';
import 'base_provider.dart';

/// Provider für Nachrichten-Verwaltung.
/// Kapselt Nachrichten-State und stellt Senden, Empfangen,
/// Lesebestätigungen, Tabs und Echtzeit-Updates bereit.
class NachrichtProvider extends BaseProvider {
  final NachrichtRepository _nachrichtRepository;

  NachrichtProvider(this._nachrichtRepository);

  // --- Private State ---

  List<Nachricht> _nachrichten = [];
  List<Nachricht> _empfangene = [];
  Nachricht? _selectedNachricht;
  List<NachrichtEmpfaenger> _empfaenger = [];
  List<NachrichtAnhang> _anhaenge = [];
  int _unreadCount = 0;
  NachrichtenTab _activeTab = NachrichtenTab.posteingang;
  MessageType? _filterTyp;
  String? _einrichtungId;
  StreamSubscription<List<Map<String, dynamic>>>? _realtimeSubscription;

  // --- Getter ---

  List<Nachricht> get nachrichten => _nachrichten;
  List<Nachricht> get empfangene => _empfangene;
  Nachricht? get selectedNachricht => _selectedNachricht;
  List<NachrichtEmpfaenger> get empfaenger => _empfaenger;
  List<NachrichtAnhang> get anhaenge => _anhaenge;
  int get unreadCount => _unreadCount;
  NachrichtenTab get activeTab => _activeTab;
  MessageType? get filterTyp => _filterTyp;

  /// Aktuelle Benutzer-ID aus Supabase Auth.
  String? get _currentUserId => SupabaseConfig.currentUser?.id;

  /// Gefilterte Nachrichten basierend auf aktivem Tab und optionalem Typ-Filter.
  List<Nachricht> get filteredNachrichten {
    List<Nachricht> basis;

    switch (_activeTab) {
      case NachrichtenTab.posteingang:
        basis = List<Nachricht>.from(_empfangene);
        break;
      case NachrichtenTab.gesendet:
        final userId = _currentUserId;
        basis = _nachrichten
            .where((n) => n.absenderId == userId)
            .toList();
        break;
      case NachrichtenTab.wichtig:
        basis = _empfangene
            .where((n) => n.wichtig)
            .toList();
        break;
    }

    if (_filterTyp != null) {
      basis = basis.where((n) => n.typ == _filterTyp).toList();
    }

    return basis;
  }

  // --- Laden ---

  /// Lädt alle Nachrichten und empfangene Nachrichten einer Einrichtung.
  Future<void> loadNachrichten(String einrichtungId) async {
    try {
      setLoading();
      _einrichtungId = einrichtungId;

      _nachrichten =
          await _nachrichtRepository.fetchNachrichten(einrichtungId);

      final userId = _currentUserId;
      if (userId != null) {
        _empfangene =
            await _nachrichtRepository.fetchEmpfangeneNachrichten(userId);
        _unreadCount = await _nachrichtRepository.fetchUnreadCount(userId);
      }

      setSuccess();
    } catch (e) {
      debugPrint('[NachrichtProvider] loadNachrichten Fehler: $e');
      setError('Nachrichten konnten nicht geladen werden: $e');
    }
  }

  /// Lädt Nachrichtendetails inklusive Empfänger und Anhänge.
  /// Markiert die Nachricht automatisch als gelesen, wenn der aktuelle
  /// Benutzer ein Empfänger ist.
  Future<void> loadNachrichtDetails(String nachrichtId) async {
    try {
      setLoading();

      _selectedNachricht =
          await _nachrichtRepository.fetchNachrichtById(nachrichtId);
      _empfaenger =
          await _nachrichtRepository.fetchEmpfaenger(nachrichtId);
      _anhaenge =
          await _nachrichtRepository.fetchAnhaenge(nachrichtId);

      // Automatisch als gelesen markieren, wenn aktueller Benutzer Empfänger ist
      final userId = _currentUserId;
      if (userId != null) {
        final istEmpfaenger =
            _empfaenger.any((e) => e.empfaengerId == userId && !e.gelesen);
        if (istEmpfaenger) {
          await _nachrichtRepository.markAsRead(nachrichtId, userId);
          if (_unreadCount > 0) _unreadCount--;
        }
      }

      setSuccess();
    } catch (e) {
      debugPrint('[NachrichtProvider] loadNachrichtDetails Fehler: $e');
      setError('Nachrichtendetails konnten nicht geladen werden: $e');
    }
  }

  /// Lädt die Anzahl ungelesener Nachrichten.
  Future<void> loadUnreadCount() async {
    try {
      final userId = _currentUserId;
      if (userId != null) {
        _unreadCount = await _nachrichtRepository.fetchUnreadCount(userId);
        notifySafely();
      }
    } catch (e) {
      debugPrint('[NachrichtProvider] loadUnreadCount Fehler: $e');
    }
  }

  // --- Mutationen ---

  /// Sendet eine neue Nachricht an die angegebenen Empfänger.
  /// Gibt true bei Erfolg zurück.
  Future<bool> sendNachricht(
    Nachricht nachricht,
    List<String> empfaengerIds,
  ) async {
    try {
      setLoading();

      await _nachrichtRepository.sendNachricht(nachricht, empfaengerIds);

      if (_einrichtungId != null) {
        await loadNachrichten(_einrichtungId!);
      }
      return true;
    } catch (e) {
      debugPrint('[NachrichtProvider] sendNachricht Fehler: $e');
      setError('Nachricht konnte nicht gesendet werden: $e');
      return false;
    }
  }

  /// Markiert eine Nachricht als gelesen für den aktuellen Benutzer.
  /// Gibt true bei Erfolg zurück.
  Future<bool> markAsRead(String nachrichtId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) return false;

      await _nachrichtRepository.markAsRead(nachrichtId, userId);

      if (_unreadCount > 0) _unreadCount--;
      notifySafely();
      return true;
    } catch (e) {
      debugPrint('[NachrichtProvider] markAsRead Fehler: $e');
      setError('Nachricht konnte nicht als gelesen markiert werden: $e');
      return false;
    }
  }

  /// Löscht eine Nachricht.
  /// Gibt true bei Erfolg zurück.
  Future<bool> deleteNachricht(String nachrichtId) async {
    try {
      setLoading();

      await _nachrichtRepository.deleteNachricht(nachrichtId);

      if (_einrichtungId != null) {
        await loadNachrichten(_einrichtungId!);
      }
      return true;
    } catch (e) {
      debugPrint('[NachrichtProvider] deleteNachricht Fehler: $e');
      setError('Nachricht konnte nicht gelöscht werden: $e');
      return false;
    }
  }

  // --- Filter & Tabs ---

  /// Setzt den aktiven Tab im Nachrichten-Screen.
  void setActiveTab(NachrichtenTab tab) {
    _activeTab = tab;
    notifySafely();
  }

  /// Setzt den Nachrichtentyp-Filter.
  void setFilterTyp(MessageType? typ) {
    _filterTyp = typ;
    notifySafely();
  }

  // --- Echtzeit ---

  /// Startet eine Echtzeit-Subscription für Nachrichten einer Einrichtung.
  /// Bei neuen Daten werden die Nachrichten automatisch neu geladen.
  void subscribeRealtime(String einrichtungId) {
    _realtimeSubscription?.cancel();
    _realtimeSubscription = _nachrichtRepository
        .subscribeToNachrichten(einrichtungId)
        .listen(
      (_) {
        loadNachrichten(einrichtungId);
      },
      onError: (error) {
        debugPrint('[NachrichtProvider] Realtime Fehler: $error');
      },
    );
  }

  // --- Lifecycle ---

  @override
  void dispose() {
    _realtimeSubscription?.cancel();
    super.dispose();
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/enums.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/auth_repository.dart';
import 'base_provider.dart';

/// Provider für Authentifizierung und Benutzerverwaltung.
/// Kapselt Auth-State und stellt Login/Register/Logout bereit.
class AuthProvider extends BaseProvider {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  UserProfile? _user;
  bool _isAuthenticated = false;
  StreamSubscription<AuthState>? _authSubscription;

  // --- Getter ---

  UserProfile? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  UserRole? get currentRole => _user?.rolle;
  bool get isEmailVerified => _user?.emailVerifiziert ?? false;
  String get displayName => _user?.vollstaendigerName ?? '';

  // --- Initialisierung ---

  /// Initialisiert den Auth-Listener. Einmal beim App-Start aufrufen.
  void init() {
    _authSubscription = _authRepository.authStateChanges.listen(
      _onAuthStateChange,
      onError: (error) {
        debugPrint('[AuthProvider] Auth-Stream Fehler: $error');
      },
    );
  }

  /// Prüft den aktuellen Auth-Status (z.B. beim Splash-Screen).
  Future<void> checkAuthStatus() async {
    try {
      setLoading();

      _isAuthenticated = _authRepository.isAuthenticated();

      if (_isAuthenticated) {
        _user = await _authRepository.getCurrentUser();
        if (_user != null) {
          setSuccess();
        } else {
          // Session vorhanden aber kein Profil → abmelden
          _isAuthenticated = false;
          setIdle();
        }
      } else {
        setIdle();
      }
    } catch (e) {
      debugPrint('[AuthProvider] checkAuthStatus Fehler: $e');
      _isAuthenticated = false;
      _user = null;
      setIdle();
    }
  }

  // --- Auth-Aktionen ---

  /// Login mit Email und Passwort.
  /// Gibt true bei Erfolg zurück.
  Future<bool> login(String email, String password) async {
    try {
      setLoading();

      _user = await _authRepository.signInWithEmail(email, password);
      _isAuthenticated = true;
      setSuccess();
      return true;
    } catch (e) {
      _isAuthenticated = false;
      _user = null;
      setError(AuthRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Registrierung mit Profildaten.
  /// Gibt true bei Erfolg zurück.
  Future<bool> register({
    required String email,
    required String password,
    required String vorname,
    required String nachname,
    required UserRole rolle,
  }) async {
    try {
      setLoading();

      _user = await _authRepository.signUpWithEmail(
        email: email,
        password: password,
        vorname: vorname,
        nachname: nachname,
        rolle: rolle,
      );
      _isAuthenticated = true;
      setSuccess();
      return true;
    } catch (e) {
      _isAuthenticated = false;
      _user = null;
      setError(AuthRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Abmelden.
  Future<void> logout() async {
    try {
      await _authRepository.signOut();
    } catch (e) {
      debugPrint('[AuthProvider] logout Fehler: $e');
    } finally {
      _user = null;
      _isAuthenticated = false;
      setIdle();
    }
  }

  /// Passwort-Reset E-Mail senden.
  /// Gibt true bei Erfolg zurück.
  Future<bool> resetPassword(String email) async {
    try {
      setLoading();
      await _authRepository.sendPasswordResetEmail(email);
      setSuccess();
      return true;
    } catch (e) {
      setError(AuthRepository.extractErrorMessage(e));
      return false;
    }
  }

  /// Konto löschen (DSGVO).
  Future<bool> deleteAccount() async {
    try {
      setLoading();
      await _authRepository.deleteAccount();
      _user = null;
      _isAuthenticated = false;
      setIdle();
      return true;
    } catch (e) {
      setError(AuthRepository.extractErrorMessage(e));
      return false;
    }
  }

  // --- Private Handler ---

  void _onAuthStateChange(AuthState authState) {
    final event = authState.event;

    switch (event) {
      case AuthChangeEvent.signedIn:
      case AuthChangeEvent.tokenRefreshed:
        _isAuthenticated = true;
        // User-Profil asynchron nachladen
        _authRepository.getCurrentUser().then((profile) {
          if (profile != null) {
            _user = profile;
            notifySafely();
          }
        });
      case AuthChangeEvent.signedOut:
        _user = null;
        _isAuthenticated = false;
        setIdle();
      case AuthChangeEvent.userUpdated:
        // Profil neu laden
        _authRepository.getCurrentUser().then((profile) {
          if (profile != null) {
            _user = profile;
            notifySafely();
          }
        });
      default:
        break;
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

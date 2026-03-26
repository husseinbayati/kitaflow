import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Netzwerk-Informationen und Konnektivitäts-Überwachung.
class NetworkInfo {
  final Connectivity _connectivity;
  bool _isConnected = true;

  NetworkInfo({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  bool get isConnected => _isConnected;

  /// Stream für Konnektivitäts-Änderungen.
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) {
      _isConnected = !results.contains(ConnectivityResult.none);
      return _isConnected;
    });
  }

  /// Einmalige Prüfung der aktuellen Konnektivität.
  Future<bool> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    _isConnected = !results.contains(ConnectivityResult.none);
    return _isConnected;
  }
}

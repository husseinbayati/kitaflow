import 'package:hive_flutter/hive_flutter.dart';

/// Einfacher Hive-basierter Cache mit TTL-Support.
class CacheManager {
  static const String _boxName = 'app_cache';
  static const String _timestampSuffix = '_ts';
  Box? _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  /// Wert aus Cache holen. Gibt null zurück wenn abgelaufen oder nicht vorhanden.
  T? get<T>(String key, {Duration? maxAge}) {
    if (_box == null) return null;
    final value = _box!.get(key);
    if (value == null) return null;

    if (maxAge != null) {
      final timestamp = _box!.get('$key$_timestampSuffix') as int?;
      if (timestamp == null) return null;
      final age = DateTime.now().millisecondsSinceEpoch - timestamp;
      if (age > maxAge.inMilliseconds) {
        _box!.delete(key);
        _box!.delete('$key$_timestampSuffix');
        return null;
      }
    }

    return value as T?;
  }

  /// Wert in Cache speichern.
  Future<void> set(String key, dynamic value) async {
    if (_box == null) return;
    await _box!.put(key, value);
    await _box!.put('$key$_timestampSuffix', DateTime.now().millisecondsSinceEpoch);
  }

  /// Einzelnen Key löschen.
  Future<void> invalidate(String key) async {
    if (_box == null) return;
    await _box!.delete(key);
    await _box!.delete('$key$_timestampSuffix');
  }

  /// Gesamten Cache leeren.
  Future<void> clear() async {
    if (_box == null) return;
    await _box!.clear();
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Verschlüsselter Storage für sensitive Daten (Tokens, PINs).
class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  // Token
  Future<void> saveToken(String token) => _storage.write(key: 'auth_token', value: token);
  Future<String?> getToken() => _storage.read(key: 'auth_token');
  Future<void> deleteToken() => _storage.delete(key: 'auth_token');

  // Generisch
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
  Future<String?> read(String key) => _storage.read(key: key);
  Future<void> delete(String key) => _storage.delete(key: key);

  // Alles löschen (z.B. bei Logout)
  Future<void> deleteAll() => _storage.deleteAll();
}

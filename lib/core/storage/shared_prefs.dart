import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences Wrapper für einfache Einstellungen.
class SharedPrefs {
  final SharedPreferences _prefs;

  SharedPrefs(this._prefs);

  // Locale
  String get locale => _prefs.getString('locale') ?? 'de';
  Future<void> setLocale(String locale) => _prefs.setString('locale', locale);

  // Theme Mode
  String get themeMode => _prefs.getString('theme_mode') ?? 'light';
  Future<void> setThemeMode(String mode) => _prefs.setString('theme_mode', mode);

  // Onboarding
  bool get isOnboardingComplete => _prefs.getBool('onboarding_complete') ?? false;
  Future<void> setOnboardingComplete(bool value) => _prefs.setBool('onboarding_complete', value);

  // Letzte Einrichtung
  String? get lastInstitutionId => _prefs.getString('last_institution_id');
  Future<void> setLastInstitutionId(String id) => _prefs.setString('last_institution_id', id);

  // Push Notifications
  bool get pushEnabled => _prefs.getBool('push_enabled') ?? true;
  Future<void> setPushEnabled(bool value) => _prefs.setBool('push_enabled', value);
}

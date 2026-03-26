import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider für Spracheinstellungen.
/// Verwaltet die aktuelle Locale und persistiert die Auswahl.
class LocaleProvider extends ChangeNotifier {
  static const String _prefsKey = 'app_locale';
  static const List<Locale> supportedLocales = [
    Locale('de'),
    Locale('ar'),
    Locale('tr'),
    Locale('uk'),
    Locale('en'),
  ];

  Locale _locale = const Locale('de');
  Locale get locale => _locale;

  /// Gespeicherte Spracheinstellung laden.
  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_prefsKey);
    if (savedCode != null) {
      final saved = Locale(savedCode);
      if (supportedLocales.contains(saved)) {
        _locale = saved;
        notifyListeners();
      }
    }
  }

  /// Sprache ändern und persistieren.
  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
  }
}

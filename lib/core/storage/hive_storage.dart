import 'package:hive_flutter/hive_flutter.dart';

/// Hive Storage Setup für KitaFlow.
class HiveStorage {
  static const String userPrefsBox = 'user_prefs';
  static const String offlineQueueBox = 'offline_queue';

  /// Hive initialisieren und Boxen öffnen.
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(userPrefsBox);
    await Hive.openBox(offlineQueueBox);
  }

  /// User Preferences Box.
  static Box get prefs => Hive.box(userPrefsBox);

  /// Offline Queue Box.
  static Box get offlineQueue => Hive.box(offlineQueueBox);

  /// Alle Boxen schließen.
  static Future<void> close() async {
    await Hive.close();
  }
}

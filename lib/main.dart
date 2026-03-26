import 'package:flutter/material.dart';
import 'app.dart';
import 'core/storage/hive_storage.dart';
import 'core/di/service_locator.dart';
import 'config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Supabase initialisieren
  SupabaseConfig.validate();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  // 2. Hive Local Storage
  await HiveStorage.init();

  // 3. Dependency Injection
  await setupServiceLocator();

  // 4. App starten
  runApp(const KitaFlowApp());
}

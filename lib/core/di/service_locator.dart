import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/cache_manager.dart';
import '../network/network_info.dart';
import '../storage/secure_storage.dart';
import '../storage/shared_prefs.dart';
import '../routing/app_router.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/kind_repository.dart';
import '../../data/repositories/anwesenheit_repository.dart';
import '../../data/repositories/nachricht_repository.dart';
import '../../data/repositories/essensplan_repository.dart';
import '../../data/repositories/einladung_repository.dart';
import '../../data/repositories/eltern_repository.dart';
import '../../data/repositories/foto_repository.dart';
import '../../data/repositories/termin_repository.dart';
import '../../data/repositories/push_einstellung_repository.dart';
import '../../data/repositories/einrichtung_repository.dart';
import '../../data/repositories/gruppe_repository.dart';
import '../../data/repositories/mitarbeiter_repository.dart';
import '../../data/repositories/dokument_repository.dart';
import '../../data/repositories/eingewoehnung_repository.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/kind_provider.dart';
import '../../presentation/providers/anwesenheit_provider.dart';
import '../../presentation/providers/nachricht_provider.dart';
import '../../presentation/providers/essensplan_provider.dart';
import '../../presentation/providers/dashboard_provider.dart';
import '../../presentation/providers/eltern_home_provider.dart';
import '../../presentation/providers/eltern_kind_provider.dart';
import '../../presentation/providers/einladung_provider.dart';
import '../../presentation/providers/termin_provider.dart';
import '../../presentation/providers/foto_provider.dart';
import '../../presentation/providers/push_einstellung_provider.dart';
import '../../presentation/providers/einrichtung_provider.dart';
import '../../presentation/providers/gruppe_provider.dart';
import '../../presentation/providers/mitarbeiter_provider.dart';
import '../../presentation/providers/dokument_provider.dart';
import '../../presentation/providers/eingewoehnung_provider.dart';
import '../../core/providers/locale_provider.dart';

final getIt = GetIt.instance;

/// Dependency Injection Setup.
/// Wird in main.dart aufgerufen.
Future<void> setupServiceLocator() async {
  // --- Core Services ---
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerLazySingleton<SharedPrefs>(
    () => SharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<SecureStorage>(
    () => SecureStorage(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfo(),
  );

  final cacheManager = CacheManager();
  await cacheManager.init();
  getIt.registerSingleton<CacheManager>(cacheManager);

  getIt.registerLazySingleton<LocaleProvider>(
    () => LocaleProvider(),
  );

  // --- Repositories ---
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );
  getIt.registerLazySingleton<KindRepository>(
    () => KindRepository(),
  );
  getIt.registerLazySingleton<AnwesenheitRepository>(
    () => AnwesenheitRepository(),
  );
  getIt.registerLazySingleton<NachrichtRepository>(
    () => NachrichtRepository(),
  );
  getIt.registerLazySingleton<EssensplanRepository>(
    () => EssensplanRepository(),
  );
  getIt.registerLazySingleton<EinladungRepository>(
    () => EinladungRepository(),
  );
  getIt.registerLazySingleton<ElternRepository>(
    () => ElternRepository(),
  );
  getIt.registerLazySingleton<FotoRepository>(
    () => FotoRepository(),
  );
  getIt.registerLazySingleton<TerminRepository>(
    () => TerminRepository(),
  );
  getIt.registerLazySingleton<PushEinstellungRepository>(
    () => PushEinstellungRepository(),
  );
  getIt.registerLazySingleton<EinrichtungRepository>(
    () => EinrichtungRepository(),
  );
  getIt.registerLazySingleton<GruppeRepository>(
    () => GruppeRepository(),
  );
  getIt.registerLazySingleton<MitarbeiterRepository>(
    () => MitarbeiterRepository(),
  );
  getIt.registerLazySingleton<DokumentRepository>(
    () => DokumentRepository(),
  );
  getIt.registerLazySingleton<EingewoehnungRepository>(
    () => EingewoehnungRepository(),
  );

  // --- Providers ---
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(getIt<AuthRepository>())..init(),
  );
  getIt.registerLazySingleton<KindProvider>(
    () => KindProvider(getIt<KindRepository>()),
  );
  getIt.registerLazySingleton<AnwesenheitProvider>(
    () => AnwesenheitProvider(getIt<AnwesenheitRepository>()),
  );
  getIt.registerLazySingleton<NachrichtProvider>(
    () => NachrichtProvider(getIt<NachrichtRepository>()),
  );
  getIt.registerLazySingleton<EssensplanProvider>(
    () => EssensplanProvider(getIt<EssensplanRepository>()),
  );
  getIt.registerLazySingleton<DashboardProvider>(
    () => DashboardProvider(),
  );
  getIt.registerLazySingleton<ElternHomeProvider>(
    () => ElternHomeProvider(getIt<ElternRepository>()),
  );
  getIt.registerLazySingleton<ElternKindProvider>(
    () => ElternKindProvider(getIt<KindRepository>()),
  );
  getIt.registerLazySingleton<EinladungProvider>(
    () => EinladungProvider(getIt<EinladungRepository>()),
  );
  getIt.registerLazySingleton<TerminProvider>(
    () => TerminProvider(getIt<TerminRepository>()),
  );
  getIt.registerLazySingleton<FotoProvider>(
    () => FotoProvider(getIt<FotoRepository>()),
  );
  getIt.registerLazySingleton<PushEinstellungProvider>(
    () => PushEinstellungProvider(getIt<PushEinstellungRepository>()),
  );
  getIt.registerLazySingleton<EinrichtungProvider>(
    () => EinrichtungProvider(getIt<EinrichtungRepository>()),
  );
  getIt.registerLazySingleton<GruppeProvider>(
    () => GruppeProvider(getIt<GruppeRepository>()),
  );
  getIt.registerLazySingleton<MitarbeiterProvider>(
    () => MitarbeiterProvider(getIt<MitarbeiterRepository>()),
  );
  getIt.registerLazySingleton<DokumentProvider>(
    () => DokumentProvider(getIt<DokumentRepository>()),
  );
  getIt.registerLazySingleton<EingewoehnungProvider>(
    () => EingewoehnungProvider(getIt<EingewoehnungRepository>()),
  );

  // --- Router (nach AuthProvider, da refreshListenable) ---
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<AuthProvider>()),
  );
}

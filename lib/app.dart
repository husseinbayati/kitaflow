import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'core/di/service_locator.dart';
import 'core/providers/locale_provider.dart';
import 'core/routing/app_router.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/kind_provider.dart';
import 'presentation/providers/anwesenheit_provider.dart';
import 'presentation/providers/nachricht_provider.dart';
import 'presentation/providers/essensplan_provider.dart';
import 'presentation/providers/dashboard_provider.dart';
import 'presentation/providers/eltern_home_provider.dart';
import 'presentation/providers/eltern_kind_provider.dart';
import 'presentation/providers/einladung_provider.dart';
import 'presentation/providers/termin_provider.dart';
import 'presentation/providers/foto_provider.dart';
import 'presentation/providers/push_einstellung_provider.dart';
import 'presentation/providers/einrichtung_provider.dart';
import 'presentation/providers/gruppe_provider.dart';
import 'presentation/providers/mitarbeiter_provider.dart';
import 'presentation/providers/dokument_provider.dart';
import 'presentation/providers/eingewoehnung_provider.dart';

/// Haupt-App Widget für KitaFlow.
class KitaFlowApp extends StatelessWidget {
  const KitaFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<AuthProvider>()),
        ChangeNotifierProvider.value(value: getIt<KindProvider>()),
        ChangeNotifierProvider.value(value: getIt<AnwesenheitProvider>()),
        ChangeNotifierProvider.value(value: getIt<NachrichtProvider>()),
        ChangeNotifierProvider.value(value: getIt<EssensplanProvider>()),
        ChangeNotifierProvider.value(value: getIt<DashboardProvider>()),
        ChangeNotifierProvider.value(value: getIt<ElternHomeProvider>()),
        ChangeNotifierProvider.value(value: getIt<ElternKindProvider>()),
        ChangeNotifierProvider.value(value: getIt<EinladungProvider>()),
        ChangeNotifierProvider.value(value: getIt<TerminProvider>()),
        ChangeNotifierProvider.value(value: getIt<FotoProvider>()),
        ChangeNotifierProvider.value(value: getIt<PushEinstellungProvider>()),
        ChangeNotifierProvider.value(value: getIt<EinrichtungProvider>()),
        ChangeNotifierProvider.value(value: getIt<GruppeProvider>()),
        ChangeNotifierProvider.value(value: getIt<MitarbeiterProvider>()),
        ChangeNotifierProvider.value(value: getIt<DokumentProvider>()),
        ChangeNotifierProvider.value(value: getIt<EingewoehnungProvider>()),
        ChangeNotifierProvider.value(value: getIt<LocaleProvider>()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) => MaterialApp.router(
          title: 'KitaFlow',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
        ),
      ),
    );
  }
}

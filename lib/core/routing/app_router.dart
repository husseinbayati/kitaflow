import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_constants.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/verify_email_screen.dart';
import '../../features/onboarding/screens/institution_onboarding_screen.dart';
import '../../features/onboarding/screens/parent_onboarding_screen.dart';
import '../../features/shell/app_shell.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/kinder/screens/kinder_liste_screen.dart';
import '../../features/kinder/screens/kind_detail_screen.dart';
import '../../features/anwesenheit/screens/anwesenheit_screen.dart';
import '../../features/kinder/screens/kind_form_screen.dart';
import '../../features/nachrichten/screens/nachrichten_screen.dart';
import '../../features/nachrichten/screens/nachrichten_detail_screen.dart';
import '../../features/nachrichten/screens/nachrichten_form_screen.dart';
import '../../features/essensplan/screens/essensplan_screen.dart';
import '../../features/essensplan/screens/essensplan_form_screen.dart';
import '../../features/shell/eltern_shell.dart';
import '../../features/eltern_home/screens/eltern_home_screen.dart';
import '../../features/eltern_kind/screens/eltern_kind_screen.dart';
import '../../features/termine/screens/termine_screen.dart';
import '../../features/fotos/screens/foto_galerie_screen.dart';
import '../../features/push_einstellungen/screens/push_einstellungen_screen.dart';
import '../../features/eltern_nachrichten/screens/eltern_nachrichten_screen.dart';
import '../../features/verwaltung/screens/verwaltung_home_screen.dart';
import '../../features/verwaltung/screens/einrichtung_form_screen.dart';
import '../../features/verwaltung/screens/gruppen_liste_screen.dart';
import '../../features/verwaltung/screens/gruppe_form_screen.dart';
import '../../features/verwaltung/screens/mitarbeiter_liste_screen.dart';
import '../../features/verwaltung/screens/mitarbeiter_form_screen.dart';
import '../../features/settings/screens/sprache_screen.dart';
import '../../features/dokumente/screens/dokumente_screen.dart';
import '../../features/dokumente/screens/dokument_detail_screen.dart';
import '../../features/dokumente/screens/dokument_form_screen.dart';
import '../../features/dokumente/screens/dokument_signieren_screen.dart';
import '../../features/eingewoehnung/screens/eingewoehnung_liste_screen.dart';
import '../../features/eingewoehnung/screens/eingewoehnung_detail_screen.dart';
import '../../features/eingewoehnung/screens/eingewoehnung_form_screen.dart';
import '../../features/eingewoehnung/screens/tagesnotiz_form_screen.dart';
import '../../features/eingewoehnung/screens/eltern_eingewoehnung_screen.dart';
import '../../core/constants/enums.dart';

/// GoRouter-Konfiguration für KitaFlow mit Auth-Guard.
class AppRouter {
  final AuthProvider _authProvider;

  AppRouter(this._authProvider);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: _authProvider,
    redirect: _handleRedirect,
    routes: [
      // Splash
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth Routes (ohne Shell)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        name: 'verify-email',
        builder: (context, state) => const VerifyEmailScreen(),
      ),

      // Onboarding Routes (ohne Shell)
      GoRoute(
        path: AppRoutes.onboardingInstitution,
        name: 'onboarding-institution',
        builder: (context, state) => const InstitutionOnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingParent,
        name: 'onboarding-parent',
        builder: (context, state) => const ParentOnboardingScreen(),
      ),

      // Sprache (ohne Shell, von überall erreichbar)
      GoRoute(
        path: AppRoutes.sprache,
        name: 'sprache',
        builder: (context, state) => const SpracheScreen(),
      ),

      // Main Shell (mit Bottom Navigation)
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.kinder,
            name: 'kinder',
            builder: (context, state) => const KinderListeScreen(),
            routes: [
              GoRoute(
                path: 'neu',
                name: 'kinder-neu',
                builder: (context, state) => const KindFormScreen(),
              ),
              GoRoute(
                path: ':id',
                name: 'kinder-detail',
                builder: (context, state) {
                  final kindId = state.pathParameters['id']!;
                  return KindDetailScreen(kindId: kindId);
                },
                routes: [
                  GoRoute(
                    path: 'bearbeiten',
                    name: 'kinder-bearbeiten',
                    builder: (context, state) {
                      final kindId = state.pathParameters['id']!;
                      return KindFormScreen(kindId: kindId);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.anwesenheit,
            name: 'anwesenheit',
            builder: (context, state) => const AnwesenheitScreen(),
          ),
          GoRoute(
            path: AppRoutes.nachrichten,
            name: 'nachrichten',
            builder: (context, state) => const NachrichtenScreen(),
            routes: [
              GoRoute(
                path: 'neu',
                name: 'nachrichten-neu',
                builder: (context, state) => const NachrichtenFormScreen(),
              ),
              GoRoute(
                path: ':id',
                name: 'nachrichten-detail',
                builder: (context, state) {
                  final nachrichtId = state.pathParameters['id']!;
                  return NachrichtenDetailScreen(nachrichtId: nachrichtId);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.essensplan,
            name: 'essensplan',
            builder: (context, state) => const EssensplanScreen(),
            routes: [
              GoRoute(
                path: 'neu',
                name: 'essensplan-neu',
                builder: (context, state) => const EssensplanFormScreen(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.profil,
            name: 'profil',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Profil — kommt in Phase 2b')),
            ),
          ),
          GoRoute(
            path: AppRoutes.einstellungen,
            name: 'einstellungen',
            builder: (context, state) => const VerwaltungHomeScreen(),
            routes: [
              GoRoute(
                path: 'einrichtung',
                name: 'verwaltung-einrichtung',
                builder: (context, state) => const EinrichtungFormScreen(),
              ),
              GoRoute(
                path: 'gruppen',
                name: 'verwaltung-gruppen',
                builder: (context, state) => const GruppenListeScreen(),
                routes: [
                  GoRoute(
                    path: 'neu',
                    name: 'verwaltung-gruppe-neu',
                    builder: (context, state) => const GruppeFormScreen(),
                  ),
                  GoRoute(
                    path: ':id/bearbeiten',
                    name: 'verwaltung-gruppe-bearbeiten',
                    builder: (context, state) {
                      final gruppeId = state.pathParameters['id']!;
                      return GruppeFormScreen(gruppeId: gruppeId);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'mitarbeiter',
                name: 'verwaltung-mitarbeiter',
                builder: (context, state) => const MitarbeiterListeScreen(),
                routes: [
                  GoRoute(
                    path: 'neu',
                    name: 'verwaltung-mitarbeiter-neu',
                    builder: (context, state) => const MitarbeiterFormScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: 'dokumente',
                name: 'verwaltung-dokumente',
                builder: (context, state) => const DokumenteScreen(),
                routes: [
                  GoRoute(
                    path: 'neu',
                    name: 'verwaltung-dokumente-neu',
                    builder: (context, state) => const DokumentFormScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    name: 'verwaltung-dokumente-detail',
                    builder: (context, state) {
                      final dokumentId = state.pathParameters['id']!;
                      return DokumentDetailScreen(dokumentId: dokumentId);
                    },
                    routes: [
                      GoRoute(
                        path: 'signieren',
                        name: 'verwaltung-dokumente-signieren',
                        builder: (context, state) {
                          final dokumentId = state.pathParameters['id']!;
                          return DokumentSignierenScreen(dokumentId: dokumentId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: 'eingewoehnung',
                name: 'verwaltung-eingewoehnung',
                builder: (context, state) => const EingewoehnungListeScreen(),
                routes: [
                  GoRoute(
                    path: 'neu',
                    name: 'verwaltung-eingewoehnung-neu',
                    builder: (context, state) => const EingewoehnungFormScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    name: 'verwaltung-eingewoehnung-detail',
                    builder: (context, state) {
                      final eingewoehnungId = state.pathParameters['id']!;
                      return EingewoehnungDetailScreen(eingewoehnungId: eingewoehnungId);
                    },
                    routes: [
                      GoRoute(
                        path: 'notiz',
                        name: 'verwaltung-eingewoehnung-notiz',
                        builder: (context, state) {
                          final eingewoehnungId = state.pathParameters['id']!;
                          return TagesnotizFormScreen(eingewoehnungId: eingewoehnungId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Eltern Shell (mit Eltern-spezifischer Bottom Navigation)
      ShellRoute(
        builder: (context, state, child) => ElternShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.elternHome,
            name: 'eltern-home',
            builder: (context, state) => const ElternHomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.elternNachrichten,
            name: 'eltern-nachrichten',
            builder: (context, state) => const ElternNachrichtenScreen(),
          ),
          GoRoute(
            path: AppRoutes.elternTermine,
            name: 'eltern-termine',
            builder: (context, state) => const TermineScreen(),
          ),
          GoRoute(
            path: AppRoutes.elternKinder,
            name: 'eltern-kinder',
            builder: (context, state) => const ElternKindScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'eltern-kind-detail',
                builder: (context, state) {
                  final kindId = state.pathParameters['id']!;
                  return ElternKindScreen(kindId: kindId);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.elternFotos,
            name: 'eltern-fotos',
            builder: (context, state) => const FotoGalerieScreen(),
          ),
          GoRoute(
            path: AppRoutes.elternPushSettings,
            name: 'eltern-push-settings',
            builder: (context, state) => const PushEinstellungenScreen(),
          ),
          GoRoute(
            path: AppRoutes.elternDokumente,
            name: 'eltern-dokumente',
            builder: (context, state) => const DokumenteScreen(),
          ),
          GoRoute(
            path: AppRoutes.elternEingewoehnung,
            name: 'eltern-eingewoehnung',
            builder: (context, state) => const ElternEingewoehnungScreen(),
          ),
        ],
      ),
    ],
  );

  /// Auth-Guard: Redirect basierend auf Auth-Status.
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = _authProvider.isAuthenticated;
    final currentPath = state.matchedLocation;

    // Öffentliche Routen (kein Redirect nötig wenn nicht eingeloggt)
    const publicRoutes = [
      AppRoutes.splash,
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.verifyEmail,
    ];
    final isPublicRoute = publicRoutes.contains(currentPath);

    // Splash-Screen: kein Redirect (AuthProvider.checkAuthStatus läuft)
    if (currentPath == AppRoutes.splash) {
      return null;
    }

    // Nicht authentifiziert + geschützte Route → Login
    if (!isAuthenticated && !isPublicRoute) {
      return AppRoutes.login;
    }

    // Authentifiziert + Auth-Route → rollenbasierter Redirect
    if (isAuthenticated && isPublicRoute && currentPath != AppRoutes.splash) {
      // Eltern → Eltern-Home, alle anderen → Dashboard
      if (_authProvider.currentRole == UserRole.eltern) {
        return AppRoutes.elternHome;
      }
      return AppRoutes.dashboard;
    }

    return null;
  }
}

# KitaFlow — Vollständiger Implementierungsplan

> Die Bildungsplattform für Kinder von 0–10 Jahren
> Krippe → Kita → Vorschule → Grundschule → OGS/Hort
> Flutter · Supabase · Cloud-nativ

---

## Übersicht

| Info | Detail |
|------|--------|
| **Tech-Stack** | Flutter (Dart) + Supabase (PostgreSQL, EU Frankfurt) |
| **Architektur** | Clean Architecture nach bGen-main (config/, core/, data/, presentation/, features/) |
| **State Management** | Provider (ChangeNotifier) + GetIt DI |
| **Navigation** | GoRouter |
| **5 Rollen** | Erzieher, Lehrer, Leitung, Träger, Eltern |
| **Multi-Tenancy** | Row Level Security (RLS) |
| **Projektpfad** | `C:/Users/User/Desktop/hussein/kitaflow/` |

---

## Phase 0: Projekt-Setup und Infrastruktur

### 0.1 Flutter-Projekt erstellen
- [ ] 0.1.1 `flutter create --org com.kitaflow --project-name kitaflow C:/Users/User/Desktop/hussein/kitaflow`
- [ ] 0.1.2 Minimale Flutter-Version in `pubspec.yaml` setzen: `sdk: '>=3.2.0 <4.0.0'`
- [ ] 0.1.3 Plattformen aktivieren: iOS, Android, Web
- [ ] 0.1.4 `analysis_options.yaml` konfigurieren: strict mode, linter rules (flutter_lints)

### 0.2 Ordnerstruktur anlegen (nach bGen-Architektur)
- [ ] 0.2.1 `lib/config/` — supabase_config.dart, app_theme.dart, environment.dart
- [ ] 0.2.2 `lib/core/constants/` — design_tokens.dart, enums.dart, app_colors.dart
- [ ] 0.2.3 `lib/core/di/` — service_locator.dart
- [ ] 0.2.4 `lib/core/errors/` — exceptions.dart, failures.dart
- [ ] 0.2.5 `lib/core/extensions/` — string_extensions.dart, datetime_extensions.dart, context_extensions.dart
- [ ] 0.2.6 `lib/core/network/` — network_info.dart, cache_manager.dart, offline_queue.dart
- [ ] 0.2.7 `lib/core/routing/` — app_router.dart, route_constants.dart
- [ ] 0.2.8 `lib/core/services/` — notification_service.dart, logger_service.dart
- [ ] 0.2.9 `lib/core/storage/` — hive_storage.dart, secure_storage.dart, shared_prefs.dart
- [ ] 0.2.10 `lib/core/theme/` — app_colors_theme.dart, color_palettes.dart
- [ ] 0.2.11 `lib/core/utils/` — validators.dart, formatters.dart, breakpoints.dart
- [ ] 0.2.12 `lib/core/widgets/` — kf_button.dart, kf_card.dart, kf_input.dart, kf_dialog.dart, kf_app_bar.dart, kf_bottom_nav.dart
- [ ] 0.2.13 `lib/data/models/` — (Freezed data classes kommen in Phase 4+)
- [ ] 0.2.14 `lib/data/repositories/` — base_repository.dart
- [ ] 0.2.15 `lib/data/services/` — (Domain services)
- [ ] 0.2.16 `lib/presentation/providers/` — base_provider.dart
- [ ] 0.2.17 `lib/features/` — (Feature-Module kommen in Phase 4+)
- [ ] 0.2.18 `lib/l10n/` — app_de.arb, app_en.arb, app_ar.arb, app_tr.arb, app_uk.arb
- [ ] 0.2.19 `test/` — unit/, widget/, integration/ Unterordner
- [ ] 0.2.20 `supabase/` — migrations/, seed/, functions/

### 0.3 Package-Abhängigkeiten (pubspec.yaml)
- [ ] 0.3.1 **State Management:** provider (^6.1.0)
- [ ] 0.3.2 **DI:** get_it (^7.6.0)
- [ ] 0.3.3 **Routing:** go_router (^14.0.0)
- [ ] 0.3.4 **Backend:** supabase_flutter (^2.3.0)
- [ ] 0.3.5 **Local Storage:** hive_flutter (^1.1.0), shared_preferences (^2.2.0), flutter_secure_storage (^9.0.0)
- [ ] 0.3.6 **Data Classes:** freezed_annotation (^2.4.0), json_annotation (^4.8.0)
- [ ] 0.3.7 **Code Generation (dev):** freezed (^2.4.0), json_serializable (^6.7.0), build_runner (^2.4.0)
- [ ] 0.3.8 **UI:** cached_network_image (^3.3.0), shimmer (^3.0.0), flutter_svg (^2.0.0)
- [ ] 0.3.9 **Lokalisierung:** flutter_localizations (sdk), intl (^0.19.0)
- [ ] 0.3.10 **Push:** firebase_messaging (^14.7.0), firebase_core (^2.24.0)
- [ ] 0.3.11 **PDF:** pdf (^3.10.0), printing (^5.12.0)
- [ ] 0.3.12 **QR:** qr_flutter (^4.1.0), mobile_scanner (^4.0.0)
- [ ] 0.3.13 **Permissions:** permission_handler (^11.1.0)
- [ ] 0.3.14 **Image:** image_picker (^1.0.0), image_cropper (^5.0.0)
- [ ] 0.3.15 **Testing (dev):** mocktail (^1.0.0), integration_test (sdk)
- [ ] 0.3.16 **Monitoring:** sentry_flutter (^7.14.0)
- [ ] 0.3.17 **Payments:** (GoCardless SDK oder HTTP-Client für REST API)
- [ ] 0.3.18 `flutter pub get` ausführen und alle Abhängigkeiten auflösen

### 0.4 Supabase-Projekt erstellen und konfigurieren
- [ ] 0.4.1 Neues Supabase-Projekt anlegen (Region: eu-central-1 / Frankfurt)
- [ ] 0.4.2 Projekt-URL und anon/service_role Keys notieren
- [ ] 0.4.3 Auth-Provider konfigurieren: Email/Password aktivieren, Magic Link aktivieren
- [ ] 0.4.4 Email-Templates anpassen (Deutsch, Branding mit KitaFlow-Logo)
- [ ] 0.4.5 Supabase Storage Buckets erstellen: `avatars`, `attachments`, `documents`, `meal-photos`
- [ ] 0.4.6 Storage Policies pro Bucket definieren (DSGVO-konform, nur berechtigte Nutzer)
- [ ] 0.4.7 Supabase Realtime für `nachrichten`-Tabelle aktivieren
- [ ] 0.4.8 Edge Functions Ordner vorbereiten (für KI-Reports, Payment-Webhooks)

### 0.5 Environment-Konfiguration
- [ ] 0.5.1 `.env.development` erstellen: SUPABASE_URL, SUPABASE_ANON_KEY, SENTRY_DSN
- [ ] 0.5.2 `.env.staging` erstellen
- [ ] 0.5.3 `.env.production` erstellen
- [ ] 0.5.4 `lib/config/environment.dart` implementieren: Enum für Environment, dart-define Auswertung
- [ ] 0.5.5 `lib/config/supabase_config.dart` implementieren: URL + Key aus Environment lesen
- [ ] 0.5.6 `.gitignore` ergänzen: `.env*`, `*.jks`, `*.keystore`, `google-services.json`, `GoogleService-Info.plist`

### 0.6 Git-Repository
- [ ] 0.6.1 `git init` im Projektverzeichnis
- [ ] 0.6.2 `.gitignore` (Flutter-Standard + .env + Keys + Build-Artefakte)
- [ ] 0.6.3 `README.md` erstellen mit Projekt-Setup-Anleitung
- [ ] 0.6.4 `CLAUDE.md` erstellen (Projekt-Konventionen für AI-Assistenz)
- [ ] 0.6.5 Initial Commit: "chore: Projekt-Setup mit Flutter und Ordnerstruktur"
- [ ] 0.6.6 Remote Repository anlegen (GitHub/GitLab) und pushen
- [ ] 0.6.7 Branch-Strategie definieren: main, develop, feature/*, release/*

### 0.7 CI/CD Grundlagen
- [ ] 0.7.1 GitHub Actions Workflow: `.github/workflows/ci.yml` (flutter analyze, flutter test, build apk, build ipa)
- [ ] 0.7.2 Pre-Commit Hooks (optional): `flutter analyze` + `dart format`

---

## Phase 1: Grundgerüst und Core (Foundation)

### 1.1 App Entry Point
- [ ] 1.1.1 `lib/main.dart` implementieren:
  - WidgetsFlutterBinding.ensureInitialized()
  - Environment aus dart-define lesen
  - Supabase.initialize() aufrufen
  - Hive.initFlutter() aufrufen
  - setupServiceLocator() aufrufen (GetIt)
  - SentryFlutter.init() aufrufen
  - runApp(KitaFlowApp()) mit MultiProvider-Wrapper
- [ ] 1.1.2 `lib/app.dart` (KitaFlowApp Widget):
  - MaterialApp.router mit GoRouter
  - Theme: AppTheme.lightTheme (Kita = Light Mode, kinderfreundlich!)
  - localizationsDelegates und supportedLocales (DE, EN, AR, TR, UK)
  - HINWEIS: Anders als bGen (Dark Mode) → KitaFlow nutzt Light Mode + optional Dark Mode

### 1.2 Theme-System (Kita-freundlich!)
- [ ] 1.2.1 `lib/core/constants/design_tokens.dart`:
  - Farbpaletten: Primary (freundliches Blau/Grün), Secondary (warm), Accent
  - Kita-Palette: Pastelltöne, freundlich, barrierefrei (WCAG AA Kontrast)
  - Font Sizes: 12, 14, 16, 18, 20, 24, 28, 32
  - Spacing: 4, 8, 12, 16, 20, 24, 32, 48
  - Border Radius: small(8), medium(12), large(16), full(999)
  - Shadows: light, medium, strong
  - AppGaps: v4, v8, v12, v16, v20, v24, v32 (SizedBox shortcuts)
  - AppPadding: card, screen, section
  - AppRadius: card, button, dialog, avatar
- [ ] 1.2.2 `lib/core/theme/app_colors_theme.dart`:
  - Primary: #4A90D9 (freundliches Blau)
  - Secondary: #7EC8A0 (freundliches Grün)
  - Accent: #FFB74D (warmes Orange)
  - Background: #F8F9FA (helles Grau)
  - Surface: #FFFFFF
  - Error: #E53935, Success: #43A047, Warning: #FB8C00
  - TextPrimary: #1A1A2E, TextSecondary: #6B7280, TextHint: #9CA3AF
  - Rollen-Farben: Erzieher (Blau), Lehrer (Grün), Leitung (Lila), Träger (Dunkelblau), Eltern (Orange)
- [ ] 1.2.3 `lib/core/theme/color_palettes.dart`:
  - KitaPalette: Pastelltöne für Gruppenfarben (Sonnenblumen, Marienkäfer, Schmetterlinge, etc.)
  - GrundschulPalette: Leicht kräftigere Farben
- [ ] 1.2.4 `lib/config/app_theme.dart`:
  - ThemeData.light() Basis
  - AppBarTheme, CardTheme, InputDecorationTheme, ElevatedButtonTheme, TextTheme
  - Alle Farben über AppColors-Tokens (KEINE hardcoded Farben)
  - Optional: Dark Mode ThemeData für Eltern-App Nachtmodus

### 1.3 Design Tokens und Constants
- [ ] 1.3.1 `lib/core/constants/enums.dart`:
  - UserRole: erzieher, lehrer, leitung, traeger, eltern
  - InstitutionType: krippe, kita, grundschule, ogs, hort
  - AttendanceStatus: anwesend, abwesend, krank, urlaub, entschuldigt, unentschuldigt
  - MessageType: nachricht, elternbrief, ankuendigung, notfall
  - ChildStatus: aktiv, eingewoehnung, abgemeldet, warteliste
  - MealType: fruehstueck, mittagessen, snack
  - AllergyType: (alle gängigen Allergene nach EU-Verordnung 1169/2011)
  - DocumentType: vertrag, einverstaendnis, attest, zeugnis
  - ViewState: idle, loading, success, error (für BaseProvider)

### 1.4 GetIt Dependency Injection
- [ ] 1.4.1 `lib/core/di/service_locator.dart`:
  - setupServiceLocator() Funktion
  - Registrierung in Schichten: Core Services → Repositories → Providers
  - Alle als registerLazySingleton (wie bGen)
  - Kommentierte Platzhalter für spätere Features
- [ ] 1.4.2 Global `getIt` Instanz über GetIt.instance

### 1.5 GoRouter Navigation
- [ ] 1.5.1 `lib/core/routing/route_constants.dart`:
  - class AppRoutes mit statischen String-Konstanten:
    - /splash, /login, /register, /forgot-password
    - /onboarding/institution, /onboarding/parent
    - /dashboard
    - /kinder, /kinder/:id, /kinder/neu
    - /anwesenheit, /anwesenheit/tag/:datum
    - /nachrichten, /nachrichten/:id, /nachrichten/neu
    - /essensplan, /essensplan/woche/:kw
    - /entwicklung, /entwicklung/:kindId
    - /verwaltung, /verwaltung/einrichtung, /verwaltung/gruppen, /verwaltung/mitarbeiter
    - /eltern/kinder, /eltern/nachrichten, /eltern/krankmeldung
    - /profil, /einstellungen
- [ ] 1.5.2 `lib/core/routing/app_router.dart`:
  - GoRouter-Instanz mit ShellRoute für BottomNavigation
  - Auth-Redirect: Nicht eingeloggt → /login
  - Rollen-basierte Guards: Eltern sehen nur Eltern-Routen
  - Verschachtelte Navigation: Dashboard als Shell mit Tabs
  - Transition: CustomTransitionPage mit Fade

### 1.6 Base Widgets (KitaFlow Design System)
- [ ] 1.6.1 `kf_button.dart`: Primary, Secondary, Outline, Text, Danger Varianten + Loading/Disabled State + Icon-Support
- [ ] 1.6.2 `kf_card.dart`: KfCard, KfInfoCard (Icon+Titel+Beschreibung), KfStatCard (Zahl+Label)
- [ ] 1.6.3 `kf_input.dart`: KfTextField, KfSearchField, KfDatePicker, KfTimePicker, KfDropdown
- [ ] 1.6.4 `kf_dialog.dart`: KfAlertDialog, KfConfirmDialog, KfBottomSheet
- [ ] 1.6.5 `kf_app_bar.dart`: KfAppBar, KfSliverAppBar
- [ ] 1.6.6 `kf_bottom_nav.dart`: Rollen-spezifische Bottom Navigation:
  - Erzieher: Dashboard, Kinder, Anwesenheit, Nachrichten, Mehr
  - Lehrer: Dashboard, Klassen, Klassenbuch, Nachrichten, Mehr
  - Leitung: Dashboard, Verwaltung, Statistiken, Nachrichten, Mehr
  - Träger: Dashboard, Einrichtungen, Finanzen, Berichte, Mehr
  - Eltern: Home, Nachrichten, Kalender, Mein Kind, Mehr
- [ ] 1.6.7 `kf_avatar.dart`: Profilbild mit Fallback-Initialen, Runde/Quadratische Variante
- [ ] 1.6.8 `kf_empty_state.dart`: Leere-Liste-Anzeige mit Illustration + Text + Action-Button
- [ ] 1.6.9 `kf_loading.dart`: KfLoadingSpinner, KfShimmerList, KfShimmerCard
- [ ] 1.6.10 `kf_badge.dart`: Status-Badge (Anwesend/Abwesend/Krank), Rollen-Badge, Allergie-Badge

### 1.7 BaseProvider Pattern
- [ ] 1.7.1 `lib/presentation/providers/base_provider.dart`:
  - ViewState enum: idle, loading, success, error
  - BaseProvider extends ChangeNotifier
  - Properties: viewState, errorMessage
  - Methoden: setLoading(), setSuccess(), setError(String), setIdle()
  - Getter: isLoading, isSuccess, isError, isIdle

### 1.8 Netzwerk-Layer
- [ ] 1.8.1 `lib/core/network/network_info.dart`: Connectivity-Check, isConnected getter, Stream für Änderungen
- [ ] 1.8.2 `lib/core/network/cache_manager.dart`: Hive-basierter Cache, get/set/invalidate, TTL-Support
- [ ] 1.8.3 `lib/core/network/offline_queue.dart`: Offline-Mutationen speichern, Retry bei Netzwerk, Operationstypen: CREATE/UPDATE/DELETE

### 1.9 Local Storage Setup
- [ ] 1.9.1 `lib/core/storage/hive_storage.dart`: Boxen: 'cache', 'offline_queue', 'user_prefs', Init/Open/Close
- [ ] 1.9.2 `lib/core/storage/secure_storage.dart`: FlutterSecureStorage Wrapper, Token-Management
- [ ] 1.9.3 `lib/core/storage/shared_prefs.dart`: Locale, ThemeMode, OnboardingComplete

### 1.10 Error Handling
- [ ] 1.10.1 `lib/core/errors/exceptions.dart`: ServerException, CacheException, AuthException, NetworkException, ValidationException, PermissionException
- [ ] 1.10.2 `lib/core/errors/failures.dart`: Failure abstract + ServerFailure, CacheFailure, AuthFailure, NetworkFailure, ValidationFailure

### 1.11 Responsive Layout System
- [ ] 1.11.1 `lib/core/utils/breakpoints.dart`: mobile (<600), tablet (600-1024), desktop (>1024), ResponsiveBuilder Widget, isMobile/isTablet/isDesktop

### 1.12 App Shell
- [ ] 1.12.1 `lib/features/shell/app_shell.dart`: Scaffold + rollenspezifische BottomNavigationBar (Mobile), NavigationRail (Tablet), Sidebar (Desktop/Web), GoRouter ShellRoute, Badge auf Nachrichten-Tab
- [ ] 1.12.2 **Commit:** "feat: Core Foundation mit Theme, DI, Router, Base Widgets"

---

## Phase 2: Authentifizierung und Rollen

### 2.1 Supabase Auth Setup
- [ ] 2.1.1 Auth-Provider in Supabase Dashboard konfigurieren (Email/Password)
- [ ] 2.1.2 Magic Link aktivieren
- [ ] 2.1.3 Email-Templates anpassen (Deutsch): Bestätigung, Passwort-Reset, Magic Link
- [ ] 2.1.4 Redirect-URLs konfigurieren: Deep Links für App (kitaflow://)
- [ ] 2.1.5 JWT-Expiry konfigurieren: 1h Access Token, 7d Refresh Token

### 2.2 Auth Models
- [ ] 2.2.1 `lib/data/models/user_profile.dart` (Freezed): id, email, vorname, nachname, rolle, einrichtungId, avatarUrl, telefon, sprache, erstelltAm, aktualisiertAm
- [ ] 2.2.2 `lib/data/models/auth_state_model.dart`: AuthStatus: unauthenticated, authenticated, onboarding, emailUnverified

### 2.3 Auth Repository
- [ ] 2.3.1 `lib/data/repositories/auth_repository.dart`:
  - signInWithEmail(email, password) → UserProfile
  - signUpWithEmail(email, password, role, name) → UserProfile
  - signOut()
  - sendPasswordResetEmail(email)
  - sendMagicLink(email)
  - getCurrentUser() → UserProfile?
  - updateProfile(UserProfile)
  - onAuthStateChange() → Stream
  - refreshSession()
  - deleteAccount() (DSGVO: Recht auf Löschung)

### 2.4 Auth Provider
- [ ] 2.4.1 `lib/presentation/providers/auth_provider.dart`: extends BaseProvider, currentUser, authStatus, isAuthenticated, login(), register(), logout(), resetPassword(), init() mit Session-Wiederherstellung

### 2.5 Login Screen
- [ ] 2.5.1 `lib/features/auth/screens/login_screen.dart`:
  - Email + Passwort Eingabe, "Anmelden" Button, "Passwort vergessen?" Link
  - "Magic Link senden" Option, "Noch kein Konto? Registrieren" Link
  - KitaFlow-Logo, Loading State, Error-Anzeige, Alle Strings über l10n

### 2.6 Registrierungs-Screen
- [ ] 2.6.1 `lib/features/auth/screens/register_screen.dart`:
  - Vorname, Nachname, Email, Passwort (Stärke-Indikator), Passwort bestätigen
  - Rollenauswahl: "Ich bin..." (Erzieher/Lehrer/Leitung/Träger/Eltern)
  - Einladungscode (optional, für Eltern)
  - AGB + Datenschutz Checkbox, Validierung + Error Handling

### 2.7 Passwort-vergessen Flow
- [ ] 2.7.1 `lib/features/auth/screens/forgot_password_screen.dart`: Email-Eingabe, "Link senden", Bestätigungs-Anzeige

### 2.8 Email-Verifizierung
- [ ] 2.8.1 `lib/features/auth/screens/verify_email_screen.dart`: Hinweis, "Erneut senden" mit 60s Cooldown, Auto-Weiterleitung nach Bestätigung

### 2.9 Session-Persistenz
- [ ] 2.9.1 `lib/features/auth/screens/splash_screen.dart`: Logo-Animation, Session-Check, Netzwerk-Check

### 2.10 Rollenbasierter Zugriff
- [ ] 2.10.1 `lib/core/routing/auth_guard.dart`: GoRouter redirect-Logik, Rollen-Check, hasRole() Helper
- [ ] 2.10.2 `lib/core/widgets/kf_role_guard.dart`: Widget das Content nur für bestimmte Rollen zeigt

### 2.11 Einrichtungs-Onboarding
- [ ] 2.11.1 `lib/features/onboarding/screens/institution_onboarding_screen.dart`:
  - Stepper: 1) Typ wählen, 2) Name/Adresse/Kontakt, 3) Gruppen anlegen, 4) Erzieher einladen
  - Nur für Leitung/Träger
- [ ] 2.11.2 `lib/features/onboarding/screens/parent_onboarding_screen.dart`:
  - Einladungscode → Kind verknüpfen → Push aktivieren → Sprache wählen
- [ ] 2.11.3 **Commit:** "feat: Authentifizierung mit Login, Register, Rollen, Onboarding"

---

## Phase 3: Datenbank-Schema und Multi-Tenancy

### 3.1 Kern-Tabellen (Migration 001)
- [ ] 3.1.1 `supabase/migrations/001_core_tables.sql`:
  - **einrichtungen:** id, name, typ (krippe/kita/grundschule/ogs/hort), adresse_strasse, adresse_plz, adresse_ort, adresse_bundesland, telefon, email, website, traeger_id (FK self-ref), einstellungen (JSONB), aktiv, erstellt_am, aktualisiert_am
  - **gruppen_klassen:** id, einrichtung_id (FK), name, typ (gruppe/klasse), max_kinder, altersspanne_von, altersspanne_bis, farbe, aktiv, schuljahr
  - **profiles:** id (FK auth.users), vorname, nachname, rolle, einrichtung_id (FK), telefon, avatar_url, sprache, push_token, aktiv, einstellungen (JSONB)
  - **mitarbeiter_einrichtung:** mitarbeiter_id (FK profiles), einrichtung_id (FK), rolle_in_einrichtung, gruppe_id (FK nullable), aktiv_seit, aktiv_bis

### 3.2 Kinder-Tabellen (Migration 002)
- [ ] 3.2.1 **kinder:** id, vorname, nachname, geburtsdatum, geschlecht, avatar_url, einrichtung_id (FK), gruppe_id (FK), status, eintrittsdatum, austrittsdatum, notizen, erstellt_am, aktualisiert_am
- [ ] 3.2.2 **allergien:** id, kind_id (FK), allergen, schweregrad (leicht/mittel/schwer/lebensbedrohlich), hinweise, erstellt_am
- [ ] 3.2.3 **kontaktpersonen:** id, kind_id (FK), name, beziehung, telefon, email, ist_abholberechtigt, ist_notfallkontakt, prioritaet, erstellt_am
- [ ] 3.2.4 **eltern_kind:** eltern_id (FK profiles), kind_id (FK), beziehung (mutter/vater/sorgeberechtigt), ist_hauptkontakt

### 3.3 Anwesenheit (Migration 003)
- [ ] 3.3.1 **anwesenheit:** id, kind_id (FK), datum, ankunft_zeit, abgeholt_zeit, status, abgeholt_von, gebracht_von, notiz, erfasst_von (FK profiles), einrichtung_id (FK), erstellt_am

### 3.4 Nachrichten (Migration 004)
- [ ] 3.4.1 **nachrichten:** id, absender_id (FK), einrichtung_id (FK), typ, betreff, inhalt, empfaenger_typ (alle/gruppe/einzeln), gruppe_id (FK nullable), wichtig, erstellt_am
- [ ] 3.4.2 **nachricht_empfaenger:** nachricht_id (FK), empfaenger_id (FK), gelesen, gelesen_am
- [ ] 3.4.3 **nachricht_anhaenge:** id, nachricht_id (FK), dateiname, dateipfad, dateityp, dateigroesse, erstellt_am

### 3.5 Essensplan (Migration 005)
- [ ] 3.5.1 **essensplaene:** id, einrichtung_id (FK), datum, mahlzeit_typ, gericht_name, beschreibung, allergene (TEXT[]), vegetarisch, vegan, bild_url, erstellt_von (FK), erstellt_am

### 3.6 Entwicklungsdokumentation (Migration 006)
- [ ] 3.6.1 **beobachtungen:** id, kind_id (FK), erzieher_id (FK), einrichtung_id (FK), bereich (motorik/sprache/sozial/kognitiv/emotional/kreativ), titel, inhalt, datum, vertraulich, erstellt_am
- [ ] 3.6.2 **meilensteine:** id, kind_id (FK), bereich, bezeichnung, erreicht_am, notiz, erfasst_von (FK)
- [ ] 3.6.3 **ki_berichte:** id, kind_id (FK), berichtstyp, zeitraum_von, zeitraum_bis, inhalt, generiert_am, generiert_von (FK), freigegeben, freigegeben_von, freigegeben_am

### 3.7 Dokumente (Migration 007)
- [ ] 3.7.1 **dokumente:** id, einrichtung_id (FK), kind_id (FK nullable), typ, titel, beschreibung, dateipfad, unterschrieben, unterschrieben_am, unterschrieben_von, gueltig_bis, erstellt_von (FK), erstellt_am

### 3.8 Eingewöhnung (Migration 008)
- [ ] 3.8.1 **eingewoehnung:** id, kind_id (FK), startdatum, enddatum, phase, bezugsperson_id (FK), notizen, eltern_feedback, erstellt_am

### 3.9 Warteliste (Migration 009)
- [ ] 3.9.1 **warteliste:** id, einrichtung_id (FK), kind_vorname, kind_nachname, kind_geburtsdatum, eltern_name, eltern_email, eltern_telefon, gewuenschtes_datum, status, prioritaet, anmerkungen, erstellt_am

### 3.10 Beiträge / Billing (Migration 010)
- [ ] 3.10.1 **beitraege:** id, kind_id (FK), einrichtung_id (FK), betrag, zeitraum_monat, zeitraum_jahr, status, faellig_am, bezahlt_am, zahlungsart, gocardless_payment_id, erstellt_am
- [ ] 3.10.2 **sepa_mandate:** id, eltern_id (FK), gocardless_mandate_id, iban_verschluesselt, kontoinhaber, aktiv, erstellt_am

### 3.11 Grundschul-spezifisch (Migration 011)
- [ ] 3.11.1 **stundenplan:** id, klasse_id (FK), wochentag, stunde, fach, lehrer_id (FK), raum, schuljahr
- [ ] 3.11.2 **klassenbuch:** id, klasse_id (FK), datum, stunde, fach, thema, hausaufgaben, fehlende_schueler (UUID[]), lehrer_id (FK), erstellt_am
- [ ] 3.11.3 **noten:** id, kind_id (FK), fach, note_typ, note, datum, lehrer_id (FK), schuljahr, halbjahr, kommentar
- [ ] 3.11.4 **elternsprechtage:** id, einrichtung_id (FK), datum, zeitslots (JSONB), lehrer_id (FK)

### 3.12 OGS/Hort (Migration 012)
- [ ] 3.12.1 **ags:** id, einrichtung_id (FK), name, beschreibung, leiter_id (FK), max_teilnehmer, wochentag, zeit_von, zeit_bis, aktiv
- [ ] 3.12.2 **ag_teilnahme:** kind_id (FK), ag_id (FK), angemeldet_am

### 3.13 Row Level Security (Migration 013)
- [ ] 3.13.1 RLS aktivieren für ALLE Tabellen
- [ ] 3.13.2 Helper-Funktion: `get_user_einrichtung_id()` — Einrichtungs-ID des eingeloggten Users
- [ ] 3.13.3 Helper-Funktion: `get_user_rolle()` — Rolle des eingeloggten Users
- [ ] 3.13.4 Helper-Funktion: `is_eltern_von(kind_id)` — Prüft Eltern-Kind-Beziehung
- [ ] 3.13.5 Policies pro Tabelle (SELECT/INSERT/UPDATE/DELETE):
  - Erzieher/Lehrer/Leitung: Kinder/Daten ihrer Einrichtung
  - Eltern: Nur eigene Kinder + eigene Nachrichten
  - Träger: Alle Einrichtungen des Trägers
  - Leitung: Volle CRUD-Rechte innerhalb der Einrichtung
- [ ] 3.13.6 Eltern-spezifische Policies: Nur Lese-Zugriff auf eigene Kinder, Nachrichten, Essensplan
- [ ] 3.13.7 Träger-Policies: Lese-Zugriff auf alle Einrichtungen des Trägers

### 3.14 Datenbank-Trigger und Funktionen
- [ ] 3.14.1 Trigger: `update_aktualisiert_am()` — Setzt aktualisiert_am bei UPDATE
- [ ] 3.14.2 Trigger: `on_auth_user_created()` — Erstellt profiles-Eintrag bei neuem Auth-User
- [ ] 3.14.3 Funktion: `check_allergene_warnung(kind_id, essensplan_id)` — Allergen-Warnungen
- [ ] 3.14.4 View: `v_anwesenheit_heute` — Heutige Anwesenheit mit Kind-Details
- [ ] 3.14.5 View: `v_nachrichten_ungelesen` — Ungelesene Nachrichten pro User

### 3.15 Seed Data
- [ ] 3.15.1 `supabase/seed/development_seed.sql`:
  - 1 Träger, 2 Kitas, 1 Grundschule, je 3 Gruppen/Klassen
  - 10 Erzieher, 5 Lehrer, 2 Leitungen, 1 Träger-Admin, 15 Eltern
  - 30 Kinder mit Allergien und Kontaktpersonen
  - 7 Tage Anwesenheitsdaten, 10 Nachrichten, 1 Woche Essenspläne
- [ ] 3.15.2 **Commit:** "feat: Komplettes Datenbank-Schema mit RLS und Seed-Daten"

---

## Phase 4: Kinderverwaltung (Child Management) — MVP

### 4.1 Kind Model
- [ ] 4.1.1 `lib/data/models/kind.dart` (Freezed): Alle Felder, fromJson/toJson, copyWith
- [ ] 4.1.2 `lib/data/models/allergie.dart` (Freezed)
- [ ] 4.1.3 `lib/data/models/kontaktperson.dart` (Freezed)
- [ ] 4.1.4 `lib/data/models/gruppe.dart` (Freezed)
- [ ] 4.1.5 `flutter pub run build_runner build`

### 4.2 Kind Repository
- [ ] 4.2.1 `lib/data/repositories/kind_repository.dart`:
  - fetchKinder(einrichtungId, {gruppeId, status, suchbegriff}) → List<Kind>
  - fetchKindById(id) → Kind
  - createKind(Kind) → Kind
  - updateKind(Kind) → Kind
  - deleteKind(id) (Soft-Delete: status → abgemeldet)
  - fetchAllergien(kindId), addAllergie(), removeAllergie()
  - fetchKontaktpersonen(kindId), addKontaktperson(), updateKontaktperson(), removeKontaktperson()
  - uploadAvatar(kindId, File) → String (URL)
  - Network-First + Cache-Fallback Pattern

### 4.3 Kind Provider
- [ ] 4.3.1 `lib/presentation/providers/kind_provider.dart`: extends BaseProvider, kinder, selectedKind, allergien, kontaktpersonen, filter, suche

### 4.4 Kinderliste Screen
- [ ] 4.4.1 `lib/features/kinder/screens/kinder_liste_screen.dart`:
  - AppBar "Kinder" + Such-Icon, Filter-Chips (Gruppen, Status)
  - ListView.builder mit KindListTile (Avatar, Name, Alter, Gruppe, Status-Badge)
  - FAB "Kind hinzufügen" (nur Erzieher/Leitung)
  - Pull-to-Refresh, Empty State, Loading Shimmer

### 4.5 Kind-Detail Screen
- [ ] 4.5.1 `lib/features/kinder/screens/kind_detail_screen.dart`:
  - Profilbild groß oben, Tabs: Stammdaten, Allergien, Kontaktpersonen, Anwesenheit, Entwicklung
  - Edit-Button (nur Erzieher/Leitung)

### 4.6 Kind erstellen/bearbeiten
- [ ] 4.6.1 `lib/features/kinder/screens/kind_form_screen.dart`: Form mit Stammdaten, Avatar-Upload, Gruppenauswahl, Validierung

### 4.7 Allergien-Management
- [ ] 4.7.1 `lib/features/kinder/widgets/allergie_form.dart`: Allergen-Auswahl (Chips), Schweregrad, Hinweise, Warnung-Icon

### 4.8 Kontaktpersonen
- [ ] 4.8.1 `lib/features/kinder/widgets/kontaktperson_form.dart`: Name, Beziehung, Telefon (Anruf-Button), Email, Abholberechtigt/Notfallkontakt Checkboxen

### 4.9 Foto-Upload
- [ ] 4.9.1 image_picker → image_cropper → Supabase Storage (Bucket: avatars) → cached_network_image

### 4.10 **Commit:** "feat: Kinderverwaltung mit CRUD, Allergien, Kontakten, Foto-Upload"

---

## Phase 5: Anwesenheit (Attendance) — MVP

### 5.1 Anwesenheit Model
- [ ] 5.1.1 `lib/data/models/anwesenheit.dart` (Freezed)

### 5.2 Anwesenheit Repository
- [ ] 5.2.1 `lib/data/repositories/anwesenheit_repository.dart`:
  - fetchAnwesenheitHeute(), fetchByDate(), checkIn(), checkOut(), markAbsent()
  - fetchStatistik(), fetchMonatsStatistik()
  - Realtime-Subscription auf anwesenheit-Tabelle

### 5.3 Anwesenheit Provider
- [ ] 5.3.1 `lib/presentation/providers/anwesenheit_provider.dart`: anwesenheitHeute, Realtime-Listener

### 5.4 Tages-Check-in/Check-out Screen (Tablet-optimiert!)
- [ ] 5.4.1 `lib/features/anwesenheit/screens/anwesenheit_screen.dart`:
  - Datum-Auswahl, Gruppen-Filter, Statistik-Leiste (Anwesend/Abwesend/Krank/Gesamt)
  - Grid/Liste aller Kinder
- [ ] 5.4.2 `lib/features/anwesenheit/widgets/kind_anwesenheit_card.dart`:
  - Großer Touch-Bereich (min 48x48, Tablet-freundlich!)
  - Avatar + Name, farbcodierter Status (Grün/Rot/Orange)
  - Tap: Check-In → Check-Out, Long-Press: Status-Auswahl
  - Zeitanzeige: "seit 08:15" oder "abgeholt 16:30"

### 5.5 Quick-Check-in
- [ ] 5.5.1 `lib/features/anwesenheit/widgets/quick_checkin.dart`: "Alle anwesend" Button, Einzelne nachträglich als abwesend markieren

### 5.6 Anwesenheit-Tagesübersicht
- [ ] 5.6.1 Kalender-Widget (Monatsansicht), Tage farbcodiert, Export CSV/PDF

### 5.7 Fehlzeiten-Statistik
- [ ] 5.7.1 Balkendiagramm (Anwesenheitstage/Monat), Kreisdiagramm (Anteil), Zeitraum-Filter

### 5.8 Eltern-Krankmeldung
- [ ] 5.8.1 `lib/features/anwesenheit/screens/krankmeldung_screen.dart` (Eltern-App):
  - Kind auswählen, Datum, Grund, Notiz, Dauer
  - → Anwesenheits-Eintrag + Benachrichtigung an Erzieher

### 5.9 Push-Notification bei Check-in/out
- [ ] 5.9.1 Supabase Edge Function oder Database Webhook: Push an Eltern bei Check-in/out, konfigurierbar

### 5.10 **Commit:** "feat: Anwesenheit mit Check-in/out, Statistik, Krankmeldung, Push"

---

## Phase 6: Nachrichten und Eltern-Kommunikation — MVP

### 6.1 Nachricht Model
- [ ] 6.1.1 `lib/data/models/nachricht.dart` (Freezed) + `nachricht_anhang.dart`

### 6.2 Nachricht Repository
- [ ] 6.2.1 `lib/data/repositories/nachricht_repository.dart`:
  - fetchNachrichten(), fetchById(), sendNachricht(), markAsRead(), fetchUnreadCount()
  - uploadAnhang(), deleteNachricht()
  - subscribeToNachrichten() → Stream (Supabase Realtime)

### 6.3 Nachricht Provider
- [ ] 6.3.1 nachrichten, unreadCount, Realtime-Subscription

### 6.4 Nachrichtenübersicht Screen
- [ ] 6.4.1 Tabs: Posteingang, Gesendet, Wichtig; Filter: Alle/Elternbriefe/Ankündigungen/Notfall
- [ ] 6.4.2 ListTile: Avatar, Betreff, Vorschau, Zeitstempel, Ungelesen-Badge, FAB "Neue Nachricht"

### 6.5 Nachricht-Detail Screen
- [ ] 6.5.1 Absender-Info, Betreff, Inhalt, Anhänge (Bilder inline, Dateien als Download), Lesebestätigung

### 6.6 Neue Nachricht erstellen
- [ ] 6.6.1 Empfänger: "An alle" / "An Gruppe" / "Einzeln", Typ, Betreff, Inhalt
- [ ] 6.6.2 Anhänge: Foto (Kamera/Galerie) + Datei, Max 5 Anhänge, Max 10MB
- [ ] 6.6.3 "Als wichtig markieren" Toggle, "Senden" Button

### 6.7 Foto-Sharing (DSGVO-konform)
- [ ] 6.7.1 Supabase Storage (Bucket: attachments), Signed URLs (24h), kein Share-Button, RLS-geschützt
- [ ] 6.7.2 Automatische Komprimierung (80%, max 1920px)

### 6.8 Push-Benachrichtigungen
- [ ] 6.8.1 `lib/core/services/notification_service.dart`: FCM Setup, Permission, Token-Speicherung, Foreground/Background Handling, Tap → Navigation
- [ ] 6.8.2 Supabase Edge Function: `send_push_notification` — Trigger bei neuer Nachricht

### 6.9 Lesebestätigungen
- [ ] 6.9.1 Automatisch bei Öffnen, Absender sieht "Gelesen von X/Y", Leitung sieht Elternbrief-Lesequote

### 6.10 **Commit:** "feat: Nachrichten mit Realtime, Anhängen, Push, Lesebestätigung"

---

## Phase 7: Essensplanung — MVP

### 7.1 Essensplan Model
- [ ] 7.1.1 `lib/data/models/essensplan.dart` (Freezed)

### 7.2 Essensplan Repository
- [ ] 7.2.1 fetchWochenplan(), createEssensplan(), updateEssensplan(), checkAllergene()

### 7.3 Essensplan Provider
- [ ] 7.3.1 wochenplan, selectedWoche, allergenWarnungen

### 7.4 Wöchentlicher Essensplan Screen
- [ ] 7.4.1 Mo-Fr Spalten (Tablet) oder Tabs (Mobile), Frühstück/Mittagessen/Snack, KW-Navigation, FAB

### 7.5 Essensplan Formular
- [ ] 7.5.1 Datum, Mahlzeit-Typ, Gericht, Beschreibung, Allergene (14 EU-Allergene als Multi-Select), Vegetarisch/Vegan, Foto

### 7.6 Automatische Allergenwarnungen
- [ ] 7.6.1 Bei Speichern: Prüfe Kinder-Allergien → Warnung "[Kind] hat Allergie gegen [Allergen]!"

### 7.7 Eltern-Ansicht
- [ ] 7.7.1 Read-only, eigene Kinder-Allergien hervorgehoben, Warnung bei Allergenen

### 7.8 **Commit:** "feat: Essensplanung mit Wochenansicht, Allergenwarnungen, Eltern-View"

---

## Phase 8: Dashboard und Übersichten

### 8.1 Dashboard Models
- [ ] 8.1.1 `lib/data/models/dashboard_data.dart`: AnwesenheitSummary, NachrichtenSummary, TagesInfo, AlertItem

### 8.2 Dashboard Repository + Provider
- [ ] 8.2.1 fetchDashboardData(), fetchAlerts(), fetchGeburtstage()

### 8.3 Einrichtungs-Dashboard Screen
- [ ] 8.3.1 **Header:** "Guten Morgen, [Name]!" mit Datum
- [ ] 8.3.2 **Quick Stats:** Anwesend heute, Nachrichten ungelesen, Krankmeldungen
- [ ] 8.3.3 **Alerts:** Allergenwarnungen, fehlende Abholberechtigungen, Geburtstage
- [ ] 8.3.4 **Quick Actions:** "Check-in starten", "Nachricht senden", "Kind hinzufügen"
- [ ] 8.3.5 **Heutiger Essensplan** (Kompakt) + **Letzte Nachrichten** (Top 3)

### 8.4 Rollen-spezifische Inhalte
- [ ] 8.4.1 Erzieher: Eigene Gruppe, Check-in, Beobachtungen
- [ ] 8.4.2 Leitung: Alle Gruppen, Statistiken, Verwaltung
- [ ] 8.4.3 Träger: Alle Einrichtungen, Finanzen
- [ ] 8.4.4 Eltern: Eigene Kinder, Nachrichten, Essensplan, Termine

### 8.5 **Commit:** "feat: Rollen-spezifisches Dashboard mit Stats, Alerts, Quick Actions"

> ### 🎯 MVP FERTIG (Phase 0–8, ca. 8 Wochen)

---

## Phase 9: Entwicklungsdokumentation (Kita-spezifisch)

### 9.1 Models
- [ ] 9.1.1 `beobachtung.dart`, `meilenstein.dart`, `ki_bericht.dart` (Freezed)

### 9.2 Repository
- [ ] 9.2.1 fetchBeobachtungen(), createBeobachtung(), fetchMeilensteine(), generateKiBericht() (via Edge Function)

### 9.3 Provider
- [ ] 9.3.1 `beobachtung_provider.dart`

### 9.4 Beobachtungsnotizen Screen
- [ ] 9.4.1 Kind-Auswahl, Bereich-Filter (Motorik/Sprache/Sozial/Kognitiv/Emotional/Kreativ)
- [ ] 9.4.2 Timeline-Ansicht, FAB "Neue Beobachtung"
- [ ] 9.4.3 Form: Kind, Bereich, Titel, Inhalt (5+ Zeilen), Datum, Vertraulich-Toggle

### 9.5 KI-gestützte Berichte (Claude API)
- [ ] 9.5.1 Supabase Edge Function `generate_ki_bericht`:
  - Input: kindId, berichtstyp, zeitraum
  - Sammelt Beobachtungen + Meilensteine
  - Claude API: Rolle "erfahrene Kita-Pädagogin", stärkenorientiert, strukturiert nach Bereichen
  - Output: 1-2 Seiten Bericht
- [ ] 9.5.2 KI-Bericht Screen: Generieren → Vorschau → Bearbeiten → Freigabe (Leitung) → PDF-Export

### 9.6 Portfolio pro Kind
- [ ] 9.6.1 Gesamtübersicht, Meilensteine-Timeline, Beobachtungen gruppiert, Fotos, PDF-Export

### 9.7 Meilensteine
- [ ] 9.7.1 Vordefinierte Meilensteine pro Bereich + Alter, Abhaken mit Datum, Freitext-Meilensteine

### 9.8 Eltern-Einsicht
- [ ] 9.8.1 Nicht-vertrauliche Beobachtungen + Meilensteine + freigegebene KI-Berichte

### 9.9 **Commit:** "feat: Entwicklungsdoku mit Beobachtungen, KI-Berichten, Portfolio"

---

## Phase 10: Eltern-App Features

### 10.1 Eltern-Onboarding
- [ ] 10.1.1 Einladungscode-System:
  - Edge Function: `generate_invitation_code` (6-stellig, tabelle `einladungen`)
  - QR-Code auf ausdruckbarem Brief
- [ ] 10.1.2 Onboarding: Code eingeben → Validierung → Profil → Sprache wählen (DE/AR/TR/UK/EN) → Push aktivieren

### 10.2 Eltern-Home Screen
- [ ] 10.2.1 Eigene Kinder (Card mit Foto, Status), Essensplan, Ungelesene Nachrichten, Quick Actions

### 10.3 Mein-Kind Screen
- [ ] 10.3.1 Profil, Anwesenheits-Kalender, Allergien (Ansicht), Entwicklung, Kontaktpersonen (bearbeitbar!), Dokumente

### 10.4 Nachrichten (Eltern-Perspektive)
- [ ] 10.4.1 Gefiltert auf eigene Nachrichten, Antwort an Erzieher/Leitung

### 10.5 Termine und Kalender
- [ ] 10.5.1 `termine`-Tabelle (id, einrichtung_id, titel, datum, typ), Kalender-Widget, Zu-/Absage

### 10.6 Fotos ansehen
- [ ] 10.6.1 Galerie freigegebener Fotos, kein Download/Share (DSGVO)

### 10.7 Push-Einstellungen
- [ ] 10.7.1 Toggles: Ankunft/Abholung, Neue Nachrichten, Notfälle, Essensplan, Termine
- [ ] 10.7.2 Ruhezeiten: 20:00–07:00

### 10.8 **Commit:** "feat: Eltern-App mit Onboarding, Kinder-Ansicht, Termine, Push-Settings"

---

## Phase 11: Verwaltung und Einrichtungsmanagement

### 11.1 Einrichtung verwalten
- [ ] 11.1.1 Stammdaten, Logo, Öffnungszeiten, Schließtage, Einstellungen (JSONB)

### 11.2 Gruppen/Klassen verwalten
- [ ] 11.2.1 CRUD, Farbe, Max-Kinder, Erzieher-Zuordnung, Belegungsstatistik

### 11.3 Mitarbeiter verwalten
- [ ] 11.3.1 Liste, Email-Einladung, Rolle zuweisen, Gruppe zuordnen, Deaktivieren

### 11.4 Rollen zuweisen
- [ ] 11.4.1 Leitung vergibt: Erzieher/Lehrer, Träger ernennt: Leitungen

### 11.5 Einstellungen
- [ ] 11.5.1 Benachrichtigungen, Betreuungszeiten, Datenschutz, DSGVO-Datenexport

### 11.6 **Commit:** "feat: Verwaltung mit Einrichtung, Gruppen, Mitarbeiter, Einstellungen"

---

## Phase 12: Mehrsprachigkeit (Internationalization)

### 12.1 Flutter l10n Setup
- [ ] 12.1.1 `l10n.yaml`: arb-dir, template: app_de.arb, nullable-getter: false
- [ ] 12.1.2 `app_de.arb`: ALLE Strings (geschätzt 300–500), strukturiert nach Feature

### 12.2 Arabisch (RTL!)
- [ ] 12.2.1 `app_ar.arb`: Vollständige arabische Übersetzung
- [ ] 12.2.2 RTL-Support:
  - EdgeInsetsDirectional statt EdgeInsets
  - AlignmentDirectional statt Alignment
  - Icons spiegeln (Pfeile, Back-Button)
  - TextDirection in TextFields
- [ ] 12.2.3 RTL-Testing auf allen Screens

### 12.3 Türkisch
- [ ] 12.3.1 `app_tr.arb`

### 12.4 Ukrainisch
- [ ] 12.4.1 `app_uk.arb`

### 12.5 Englisch
- [ ] 12.5.1 `app_en.arb`

### 12.6 Auto-Übersetzung für Nachrichten
- [ ] 12.6.1 Edge Function `translate_message`: Claude/DeepL API, Cached
- [ ] 12.6.2 "Übersetzen" Button in Nachricht-Detail

### 12.7 Sprachumschaltung
- [ ] 12.7.1 Einstellungen + Onboarding, SharedPreferences, sofortige Aktualisierung

### 12.8 **Commit:** "feat: Mehrsprachigkeit DE, AR (RTL), TR, UK, EN mit Auto-Übersetzung"

---

## Phase 13: Dokumentenmanagement

### 13.1 Dokument Model + Repository + Provider
- [ ] 13.1.1 Standard CRUD + Upload/Download + Unterschrift-Status

### 13.2 Dokumenten-Übersicht
- [ ] 13.2.1 Filter: Verträge/Einverständnisse/Atteste, Status, Upload/Download

### 13.3 Digitale Unterschrift
- [ ] 13.3.1 Signature Pad Widget (Canvas), Unterschrift als Bild, Zeitstempel

### 13.4 PDF-Generierung
- [ ] 13.4.1 Vorlagen: Betreuungsvertrag, Einverständniserklärung, Entwicklungsbericht
- [ ] 13.4.2 PDF mit Unterschrift, Vorschau + Drucken + Teilen

### 13.5 **Commit:** "feat: Dokumentenmanagement mit Upload, Unterschrift, PDF-Generierung"

---

## Phase 14: Eingewöhnung

### 14.1 Model + Repository + Provider
- [ ] 14.1.1 CRUD + Phasen-Management (Grundphase → Stabilisierung → Schlussphase → Abgeschlossen)

### 14.2 Eingewöhnungsplan Screen
- [ ] 14.2.1 Stepper-Visualisierung, Kinder in Eingewöhnung, Tägliche Notizen

### 14.3 Tägliche Notizen
- [ ] 14.3.1 Dauer, Trennungsverhalten (1–5 + Freitext), Essen/Schlaf/Spiel, Stimmung (Emoji), Notizen intern + für Eltern

### 14.4 Eltern-Feedback
- [ ] 14.4.1 Tägliche Push "Wie war [Kind] heute zu Hause?", einfaches Formular

### 14.5 **Commit:** "feat: Eingewöhnung mit Phasen, Tagesnotizen, Eltern-Feedback"

---

## Phase 15: Beitragsabrechnung (Billing)

### 15.1 GoCardless Integration
- [ ] 15.1.1 Edge Function `gocardless_webhook`: Payment Events → beitraege-Tabelle
- [ ] 15.1.2 Edge Function `create_sepa_mandate`: IBAN-Validierung, Mandats-Erstellung
- [ ] 15.1.3 Edge Function `create_payment`: SEPA-Lastschrift auslösen

### 15.2 Models + Repository + Provider
- [ ] 15.2.1 `beitrag.dart`, `sepa_mandat.dart`

### 15.3 SEPA-Einrichtung (Eltern)
- [ ] 15.3.1 IBAN-Eingabe, Kontoinhaber, SEPA-Mandat Einwilligung, GoCardless Redirect (WebView)

### 15.4 Beitrags-Übersicht (Leitung)
- [ ] 15.4.1 Liste, Filter (Offen/Bezahlt/Mahnung), Staffelung, Zuschüsse, Monatsübersicht

### 15.5 PDF-Rechnungen
- [ ] 15.5.1 Monatsrechnung mit Logo, Adresse, Betrag, Automatischer Versand (optional)

### 15.6 **Commit:** "feat: Beitragsabrechnung mit SEPA/GoCardless, Staffelung, PDF-Rechnungen"

---

## Phase 16: Warteliste

### 16.1 Model + Repository + Provider
- [ ] 16.1.1 Standard CRUD

### 16.2 Online-Anmeldeformular
- [ ] 16.2.1 Öffentlich (keine Auth), Kind + Eltern Daten, Gewünschter Beginn, Allergien, DSGVO-Einwilligung

### 16.3 Warteliste-Verwaltung (Leitung)
- [ ] 16.3.1 Sortierbar, Status-Management (Wartend → Angeboten → Angenommen/Abgelehnt)
- [ ] 16.3.2 "Platz anbieten" → Auto-Email, "Zusage" → Kind + Eltern-Einladung erstellen
- [ ] 16.3.3 Automatische Priorität (Geschwister, Wohnort, Wartezeit)

### 16.4 **Commit:** "feat: Warteliste mit Online-Anmeldung, Priorität, Automatisierung"

> ### 🎯 FULL KITA-MODUL FERTIG (Phase 0–16, ca. 16 Wochen)

---

## Phase 17: Grundschul-Modul

### 17.1 Stundenplan
- [ ] 17.1.1 Model + Repo + Provider
- [ ] 17.1.2 Wochenansicht als Tabelle, Farbcodierung, Bearbeitung (Leitung), Eltern read-only

### 17.2 Digitales Klassenbuch
- [ ] 17.2.1 Tages-Ansicht mit Stunden, Quick-Entry pro Stunde (Fach, Thema, Hausaufgaben, Fehlende), Kalender

### 17.3 Elternsprechtage (Online-Buchung)
- [ ] 17.3.1 Slot-Erstellung (15min), Eltern buchen, Kalender-Ansicht, Push 24h vorher, Absage/Umbuchung

### 17.4 Vertretungsplan
- [ ] 17.4.1 Tages-Ansicht, Änderungen hervorgehoben, Push bei Änderungen

### 17.5 Noten
- [ ] 17.5.1 Eintragung pro Schüler/Fach, Durchschnitte/Trend, Eltern sehen nur eigene Kinder, PDF-Zeugnis

### 17.6 Hausaufgaben
- [ ] 17.6.1 Lehrer erstellt (Fach, Beschreibung, Fällig bis), Eltern/Kinder sehen Liste, Status, Push-Erinnerung

### 17.7 **Commit:** "feat: Grundschul-Modul mit Stundenplan, Klassenbuch, Noten, Hausaufgaben"

---

## Phase 18: OGS/Hort-Modul

### 18.1 Nachmittagsbetreuung
- [ ] 18.1.1 Separater Check-in nach Schule, individuelle Betreuungszeiten

### 18.2 AG-Verwaltung
- [ ] 18.2.1 AG-Liste (Name, Leiter, Wochentag, freie Plätze), Eltern-Anmeldung, Teilnehmerliste, Warteliste

### 18.3 Abhol-Management
- [ ] 18.3.1 "Wer holt heute ab?" via App, Abholzeiten, Berechtigte prüfen, Push bei Abholung

### 18.4 Hausaufgabenbetreuung
- [ ] 18.4.1 Betreuer notiert: Erledigt? Hilfe in Fach X? Eltern-Info abends

### 18.5 **Commit:** "feat: OGS/Hort-Modul mit AGs, Abhol-Management, Hausaufgabenbetreuung"

---

## Phase 19: Übergangs-Feature Kita → Grundschule

### 19.1 Datenfreigabe-Workflow
- [ ] 19.1.1 Leitung initiiert → Eltern-Benachrichtigung → Daten auswählen → Digitale Einwilligung → Ziel-Schule

### 19.2 Automatische Datenübertragung
- [ ] 19.2.1 Edge Function `transfer_child_data`: Freigegebene Daten kopieren, Kind in neuer Einrichtung, Quell-Status "abgemeldet"

### 19.3 Eltern-App Continuity
- [ ] 19.3.1 Account bleibt, Verknüpfung umgestellt, Alte Nachrichten/Fotos als Archiv, keine Neu-Registrierung

### 19.4 Status-Tracking
- [ ] 19.4.1 Timeline: Initiiert → Eltern-Einwilligung → Übertragen → Abgeschlossen

### 19.5 **Commit:** "feat: Kita-Grundschule-Übergang mit Datenfreigabe und Eltern-Continuity"

---

## Phase 20: Träger-Dashboard

### 20.1 Übersicht aller Einrichtungen
- [ ] 20.1.1 Pro Einrichtung: Kinder, Auslastung, Mitarbeiter, Gesamt-Statistiken

### 20.2 Finanz-Übersicht
- [ ] 20.2.1 Einnahmen pro Einrichtung, Monatsvergleich (Chart), Export CSV/Excel

### 20.3 Personalplanung
- [ ] 20.3.1 Alle Mitarbeiter aller Einrichtungen, Betreuungsschlüssel

### 20.4 Staffelpreise
- [ ] 20.4.1 Preis-Modell pro Einrichtung, Staffelung nach Einkommen/Geschwister, Zuschüsse

### 20.5 **Commit:** "feat: Träger-Dashboard mit Einrichtungsübersicht, Finanzen, Personal"

---

## Phase 21: Landing Page und Marketing

### 21.1 Web Landing Page (Flutter Web)
- [ ] 21.1.1 Hero Section + CTA, Features, Vorteile, Screenshots, Testimonials, Pricing, FAQ, Footer

### 21.2 Pricing Page
- [ ] 21.2.1 Starter (49€), Professional (99€), Enterprise (149€), Feature-Vergleich, "30 Tage kostenlos"

### 21.3 Demo-Anfrage
- [ ] 21.3.1 Kontaktformular → Edge Function → Email an Vertrieb

### 21.4 SEO
- [ ] 21.4.1 Meta-Tags, Schema.org, Sitemap.xml, robots.txt

### 21.5 **Commit:** "feat: Landing Page mit Pricing, Demo-Anfrage, SEO"

---

## Phase 22: Testing und Qualitätssicherung

### 22.1 Unit Tests
- [ ] 22.1.1 Alle Freezed Models (fromJson/toJson roundtrip)
- [ ] 22.1.2 Alle Repositories (gemockter Supabase-Client)
- [ ] 22.1.3 Alle Provider (State-Transitions)
- [ ] 22.1.4 Validators, Formatters
- [ ] 22.1.5 Ziel: >80% Coverage für Models, Repositories, Provider

### 22.2 Widget Tests
- [ ] 22.2.1 Auth Screens: Validierung, Button-States
- [ ] 22.2.2 Kinderliste, Kind-Detail, Kind-Form
- [ ] 22.2.3 Anwesenheit Check-in/out
- [ ] 22.2.4 Nachrichten-Screens
- [ ] 22.2.5 Alle Base Widgets (KfButton, KfCard, etc.)

### 22.3 Integration Tests
- [ ] 22.3.1 Auth Flow (Login → Register → Logout)
- [ ] 22.3.2 Kind CRUD
- [ ] 22.3.3 Anwesenheit Flow
- [ ] 22.3.4 Nachrichten Flow

### 22.4 E2E Tests
- [ ] 22.4.1 Erzieher: Login → Dashboard → Check-in → Nachricht senden
- [ ] 22.4.2 Eltern: Login → Kinder sehen → Krankmeldung → Nachricht lesen

### 22.5 Performance Testing
- [ ] 22.5.1 200+ Kinder laden (Pagination)
- [ ] 22.5.2 500+ Nachrichten (Lazy Loading)
- [ ] 22.5.3 Cold Start <3 Sekunden
- [ ] 22.5.4 Memory Profiling (keine Leaks)

### 22.6 Accessibility Testing
- [ ] 22.6.1 Semantics Labels auf allen interaktiven Elementen
- [ ] 22.6.2 WCAG AA Kontrast
- [ ] 22.6.3 Screen Reader (TalkBack, VoiceOver)
- [ ] 22.6.4 Schriftgröße bis 200%
- [ ] 22.6.5 Touch-Target min 48x48dp

### 22.7 Security Audit
- [ ] 22.7.1 RLS-Policies testen: Kann User A Daten von User B sehen? (JEDE Tabelle!)
- [ ] 22.7.2 Abgelaufene Tokens, ungültige Sessions
- [ ] 22.7.3 Storage: Unautorisierter Dateizugriff?
- [ ] 22.7.4 DSGVO-Checkliste:
  - [ ] Datenschutzerklärung vorhanden
  - [ ] Einwilligungen dokumentiert
  - [ ] Recht auf Auskunft (Datenexport)
  - [ ] Recht auf Löschung (Account + alle Daten)
  - [ ] Verarbeitungsverzeichnis
  - [ ] AVV mit Supabase
  - [ ] Datenminimierung
  - [ ] Verschlüsselung (TLS Transit, AES Rest)
  - [ ] Keine Daten außerhalb EU
- [ ] 22.7.5 Penetrationstest (extern, vor Go-Live)

### 22.8 **Commit:** "test: Umfassende Test-Suite Unit, Widget, Integration, Security"

---

## Phase 23: Deployment und Go-Live

### 23.1 iOS App Store
- [ ] 23.1.1 Apple Developer Account ($99/Jahr)
- [ ] 23.1.2 App-Icons (alle Größen, kinderfreundlich)
- [ ] 23.1.3 Screenshots (iPhone + iPad)
- [ ] 23.1.4 App-Beschreibung (DE + EN)
- [ ] 23.1.5 Datenschutz-URL + Support-URL
- [ ] 23.1.6 Signing Certificate + Provisioning Profile
- [ ] 23.1.7 `flutter build ipa --release`
- [ ] 23.1.8 Upload + App Review einreichen
- [ ] 23.1.9 ASO Keywords

### 23.2 Google Play Store
- [ ] 23.2.1 Google Play Developer Account ($25)
- [ ] 23.2.2 App-Icons + Feature Graphic
- [ ] 23.2.3 Screenshots (Telefon + Tablet)
- [ ] 23.2.4 Keystore generieren (NICHT im Repo!)
- [ ] 23.2.5 `flutter build appbundle --release`
- [ ] 23.2.6 Intern → Geschlossen → Offen → Produktion
- [ ] 23.2.7 Data Safety Section ausfüllen

### 23.3 Web Deployment
- [ ] 23.3.1 `flutter build web --release`
- [ ] 23.3.2 Hosting: Vercel/Netlify/Cloudflare Pages (EU-CDN)
- [ ] 23.3.3 Custom Domain: app.kitaflow.de + www.kitaflow.de
- [ ] 23.3.4 SSL/TLS, CSP Headers, Service Worker (PWA)

### 23.4 Monitoring
- [ ] 23.4.1 Sentry: Performance Monitoring, Release Health, Alert Rules
- [ ] 23.4.2 Supabase Dashboard: DB Health, API Performance
- [ ] 23.4.3 Uptime Monitoring (UptimeRobot / Better Stack)

### 23.5 Analytics
- [ ] 23.5.1 Datenschutzkonform (Plausible.io oder PostHog Self-Hosted)
- [ ] 23.5.2 Kein personenbezogenes Tracking (DSGVO!)

### 23.6 Backup-Strategie
- [ ] 23.6.1 Supabase automatische tägliche Backups
- [ ] 23.6.2 Wöchentlicher pg_dump in separaten Storage
- [ ] 23.6.3 Monatlicher Backup-Test!
- [ ] 23.6.4 Disaster Recovery Plan dokumentieren

### 23.7 Incident Response Plan
- [ ] 23.7.1 Stufe 1 (Warnung) → Stufe 2 (Feature-Fehler, Fix <4h) → Stufe 3 (App down, Fix <1h) → Stufe 4 (Datenleck: 72h DSGVO-Meldepflicht!)
- [ ] 23.7.2 Kontakte + Kommunikationsplan dokumentieren

### 23.8 **Commit:** "chore: Deployment, Monitoring, Backup, Incident Response"

---

## Phase 24: Post-Launch

### 24.1 Pilot-Programm (5–10 Kitas)
- [ ] 24.1.1 Pilot-Kitas akquirieren (persönlich, kostenlos/reduziert)
- [ ] 24.1.2 Onboarding-Support: Persönliche Einrichtung + Erzieher-Schulung
- [ ] 24.1.3 Datenimport: CSV/Excel → Supabase
- [ ] 24.1.4 Wöchentliche Check-ins
- [ ] 24.1.5 In-App Feedback Widget

### 24.2 Feedback-Loop
- [ ] 24.2.1 In-App Feedback (Daumen hoch/runter + Freitext)
- [ ] 24.2.2 Monatliche Umfrage
- [ ] 24.2.3 Feature-Request Board
- [ ] 24.2.4 Impact vs. Effort Priorisierung

### 24.3 Bug Fixing
- [ ] 24.3.1 Sentry-Alerts priorisieren
- [ ] 24.3.2 Wöchentliche Bug-Fix Releases
- [ ] 24.3.3 Hotfixes: Kritisch <24h

### 24.4 Performance Optimization
- [ ] 24.4.1 Flutter DevTools Profiling
- [ ] 24.4.2 Supabase: Langsame Queries (pg_stat_statements)
- [ ] 24.4.3 Indizes optimieren
- [ ] 24.4.4 Bilder: CDN + WebP + Lazy Loading
- [ ] 24.4.5 Listen: Pagination (Limit 20) + Infinite Scroll

### 24.5 AT/CH Expansion vorbereiten
- [ ] 24.5.1 Regulatorische Recherche (AT/CH)
- [ ] 24.5.2 Bundesland/Kanton-Einstellungen
- [ ] 24.5.3 Terminologie ("Kindergarten" statt "Kita" in AT)
- [ ] 24.5.4 CHF-Unterstützung für Schweiz
- [ ] 24.5.5 app_de_AT.arb, app_de_CH.arb (nur Abweichungen)

### 24.6 **Commit:** "chore: Post-Launch Optimierungen, Pilot-Feedback, AT/CH Vorbereitung"

---

## Querschnittsthemen (durch alle Phasen)

### Q.1 DSGVO-Konformität
- [ ] Q.1.1 Datenschutzerklärung (Anwalt prüfen lassen!)
- [ ] Q.1.2 Impressum
- [ ] Q.1.3 AGB
- [ ] Q.1.4 Auftragsverarbeitungsvertrag (AVV) mit Supabase
- [ ] Q.1.5 Verarbeitungsverzeichnis (Artikel 30 DSGVO)
- [ ] Q.1.6 Datenschutz-Folgenabschätzung (Artikel 35) — Pflicht bei Kinderdaten!
- [ ] Q.1.7 Cookie-Banner (Web) — nur technisch notwendige
- [ ] Q.1.8 Einwilligungs-Management für Foto-Freigabe
- [ ] Q.1.9 Daten-Export pro Nutzer (JSON)
- [ ] Q.1.10 Daten-Löschung komplett (Account + Storage)
- [ ] Q.1.11 Verschlüsselung: TLS 1.3 (Transit), AES-256 (Rest), FlutterSecureStorage (sensitiv)

### Q.2 Offline-Fähigkeit
- [ ] Q.2.1 Anwesenheit: Offline Check-in/out in Hive, Sync bei Netzwerk
- [ ] Q.2.2 Nachrichten: Entwürfe lokal speichern
- [ ] Q.2.3 Kinderliste: Cached Version offline anzeigen
- [ ] Q.2.4 Essensplan: Aktuelle Woche cachen
- [ ] Q.2.5 Offline-Banner: "Offline — Daten werden synchronisiert wenn Verbindung verfügbar"

### Q.3 Code-Qualität
- [ ] Q.3.1 `flutter analyze` muss clean sein (keine Warnings)
- [ ] Q.3.2 `dart format` auf allen Dateien
- [ ] Q.3.3 Keine `print()` in Production → Logger Service
- [ ] Q.3.4 Keine hardcoded Strings → l10n
- [ ] Q.3.5 Keine hardcoded Colors → AppColors
- [ ] Q.3.6 Keine hardcoded Spacing → DesignTokens
- [ ] Q.3.7 Alle Provider erben von BaseProvider
- [ ] Q.3.8 Alle Services/Repos als Singletons via GetIt
- [ ] Q.3.9 Kein Supabase-Code in Widgets → Repository
- [ ] Q.3.10 Kein State in Widgets → Provider

---

## Zeitschätzung (Solo-Entwickler mit KI-Assistenz)

| Phase | Dauer | Kumulativ |
|-------|-------|-----------|
| Phase 0: Setup | 1–2 Tage | Woche 1 |
| Phase 1: Core Foundation | 3–5 Tage | Woche 1–2 |
| Phase 2: Auth & Rollen | 3–4 Tage | Woche 2–3 |
| Phase 3: DB-Schema | 2–3 Tage | Woche 3 |
| Phase 4: Kinderverwaltung | 5–7 Tage | Woche 4–5 |
| Phase 5: Anwesenheit | 5–7 Tage | Woche 5–6 |
| Phase 6: Nachrichten | 5–7 Tage | Woche 6–7 |
| Phase 7: Essensplan | 3–4 Tage | Woche 7–8 |
| Phase 8: Dashboard | 3–4 Tage | Woche 8 |
| **MVP FERTIG** | **~8 Wochen** | |
| Phase 9: Entwicklungsdoku | 5–7 Tage | Woche 9–10 |
| Phase 10: Eltern-App | 5–7 Tage | Woche 10–11 |
| Phase 11: Verwaltung | 3–5 Tage | Woche 11–12 |
| Phase 12: Mehrsprachigkeit | 5–7 Tage | Woche 12–13 |
| Phase 13: Dokumente | 3–5 Tage | Woche 13–14 |
| Phase 14: Eingewöhnung | 2–3 Tage | Woche 14 |
| Phase 15: Billing | 5–7 Tage | Woche 15–16 |
| Phase 16: Warteliste | 2–3 Tage | Woche 16 |
| **FULL KITA-MODUL** | **~16 Wochen** | |
| Phase 17: Grundschule | 7–10 Tage | Woche 17–19 |
| Phase 18: OGS/Hort | 3–5 Tage | Woche 19–20 |
| Phase 19: Übergang | 3–5 Tage | Woche 20–21 |
| Phase 20: Träger-Dashboard | 3–5 Tage | Woche 21–22 |
| Phase 21: Landing Page | 3–5 Tage | Woche 22–23 |
| Phase 22: Testing | 5–7 Tage | Woche 23–24 |
| Phase 23: Deployment | 3–5 Tage | Woche 24–25 |
| Phase 24: Post-Launch | Fortlaufend | Ab Woche 25 |
| **KOMPLETT** | **~25 Wochen** | |

---

## Risiken und Mitigationen

| Risiko | Wahrscheinl. | Impact | Mitigation |
|--------|-------------|--------|------------|
| DSGVO-Verstoß (Kinderdaten!) | Mittel | Sehr Hoch | Frühzeitig Anwalt, DSFA, RLS testen |
| Supabase RLS zu komplex | Mittel | Hoch | Schrittweise aufbauen, ausführlich testen |
| RTL-Layout bricht UI | Hoch | Mittel | Frühzeitig testen, EdgeInsetsDirectional |
| GoCardless Integration scheitert | Niedrig | Mittel | Alternative: Stripe SEPA |
| App Store Ablehnung | Niedrig | Mittel | Guidelines studieren, Privacy Labels |
| Performance bei vielen Kindern | Mittel | Mittel | Pagination, Lazy Loading, Indizes, Caching |
| Claude API Kosten (KI-Berichte) | Niedrig | Niedrig | Token-Limit, Caching, Rate Limiting |

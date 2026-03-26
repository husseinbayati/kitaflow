# KitaFlow — Projektstatus

> Stand: 26. März 2026 | Phase 0–14 abgeschlossen

---

## Überblick

**KitaFlow** ist eine SaaS-Plattform für Kindertageseinrichtungen (Kitas, Krippen, Horte, OGS). Die App digitalisiert den Kita-Alltag: Kinderverwaltung, Anwesenheit, Nachrichten, Essensplanung, Dokumentenmanagement, Eingewöhnung und mehr — mit separaten Oberflächen für Personal und Eltern.

| | |
|---|---|
| **Framework** | Flutter 3.35.6 (Dart 3.9.2) |
| **Backend** | Supabase (PostgreSQL, EU Frankfurt) |
| **State Management** | Provider + GetIt DI |
| **Navigation** | GoRouter (ShellRoute, Auth-Guard) |
| **Plattformen** | Android, iOS, Web (responsive) |
| **Sprachen** | Deutsch, Arabisch, Türkisch, Ukrainisch, Englisch |

---

## Kennzahlen

| Metrik | Wert |
|--------|------|
| Dart-Dateien (lib/) | 182 |
| Screens | 42 |
| Feature-Module | 18 |
| Data Models | 23 |
| Repositories | 15 |
| Providers | 18 (+ 1 BaseProvider) |
| Core Widgets (Kf-*) | 10 |
| Enums | 16 |
| DB-Migrationen | 13 |
| l10n-Keys pro Sprache | 611 |
| Unterstützte Sprachen | 5 |
| Seed-Dateien | 1 |
| Test-Dateien | 1 (minimal) |
| Dependencies | 31 + 7 dev |

---

## Implementierte Phasen

| Phase | Name | Status | Beschreibung |
|-------|------|--------|--------------|
| 0 | Projektstruktur | fertig | Clean Architecture, Config, Supabase-Setup, Theme, Design Tokens |
| 1 | Authentifizierung | fertig | Login, Registrierung, Passwort vergessen, E-Mail-Verifizierung, Rollenbasierter Redirect |
| 2 | Dashboard + Shell | fertig | Staff-Dashboard mit Statistiken, AppShell mit Bottom Navigation, Begrüßung, Schnellaktionen |
| 3 | Kinderverwaltung | fertig | CRUD Kinder, Allergien (EU-Verordnung 1169/2011), Kontaktpersonen, Abholberechtigungen, Status-Management |
| 4 | Anwesenheit | fertig | Tages-Tracking, Statuswechsel, Krankmeldung, Abholzeiten |
| 5 | Nachrichten | fertig | Nachrichtentypen (Nachricht, Elternbrief, Ankündigung, Notfall), Anhänge, Tabs (Posteingang/Gesendet/Wichtig) |
| 6 | Essensplan | fertig | Wochenplan, Mahlzeitentypen, Allergene-Anzeige, Formular |
| 7 | Eltern-App | fertig | Eltern-Shell, Eltern-Home, Kinder-Übersicht, Quick-Actions, Kind-Status-Cards |
| 8 | Einladungssystem | fertig | QR-Code-Einladungen, Eltern-Onboarding, Eltern-Kind-Verknüpfung |
| 9 | Termine + Kalender | fertig | Termintypen (6 Typen), RSVP-System, Kalenderansicht |
| 10 | Fotos | fertig | Foto-Galerie, Upload, Viewer, Supabase Storage |
| 11 | Push-Einstellungen | fertig | Granulare Benachrichtigungssteuerung pro Kategorie |
| 12 | Verwaltung | fertig | Einrichtungsdaten, Gruppenverwaltung, Mitarbeiterverwaltung, Verwaltungs-Home mit Kacheln |
| 13 | Dokumentenmanagement | fertig | Dokumenten-Upload, Typen-Filter, Detailansicht, Digitale Unterschrift (SignaturePad), PDF-Generierung |
| 14 | Eingewöhnung | fertig | Berliner Modell (4 Phasen), Tagesnotizen, Stimmung/Trennungsverhalten-Tracking, Eltern-Feedback, Stepper-UI |

---

## Architektur

```
lib/
├── config/              # App-Theme, Environment, Supabase-Config
├── core/                # Shared Infrastructure
│   ├── constants/       # DesignTokens, Enums, Enum-Labels
│   ├── di/              # GetIt Service Locator
│   ├── errors/          # Exceptions, Failures
│   ├── extensions/      # Context, DateTime, l10n, String
│   ├── network/         # CacheManager, NetworkInfo
│   ├── providers/       # LocaleProvider
│   ├── routing/         # GoRouter, Route Constants
│   ├── storage/         # Hive, SecureStorage, SharedPrefs
│   ├── theme/           # AppColors, ColorPalettes
│   ├── utils/           # Breakpoints, Formatters, Validators
│   └── widgets/         # 10 Kf-Widgets (Button, Input, Avatar, ...)
├── data/
│   ├── models/          # 23 Dart-Models (fromSupabase/toSupabase/copyWith)
│   ├── repositories/    # 15 Repositories (Supabase-Zugriff)
│   └── services/        # PDF-Generator
├── features/            # 18 Feature-Module (screens/ + widgets/)
├── l10n/                # 5 ARB-Dateien (DE template + AR, TR, UK, EN)
├── presentation/
│   └── providers/       # 18 Feature-Provider (extends BaseProvider)
└── app.dart             # MultiProvider + MaterialApp.router
```

### Patterns

| Pattern | Umsetzung |
|---------|-----------|
| **State Management** | `BaseProvider` mit `ViewState` (idle/loading/success/error), `notifySafely()` |
| **DI** | `GetIt` mit `registerLazySingleton` für Repos + Providers |
| **Navigation** | `GoRouter` mit `ShellRoute`, `AuthProvider` als `refreshListenable` |
| **Models** | Plain Dart, `fromSupabase(Map)` / `toSupabase()` / `copyWith()`, snake_case ↔ camelCase |
| **Repositories** | Direkter `SupabaseConfig.client`-Zugriff, `extractErrorMessage()` für dt. Fehlermeldungen |
| **Lokalisierung** | `context.l.keyName` Extension, `enum.label(context)` für Enums |
| **Widgets** | `Kf`-Prefix (KfButton, KfTextField, KfRoleGuard, ...), Varianten-Enums |

---

## Feature-Module

| Feature | Screens | Widgets | Gesamt | Beschreibung |
|---------|---------|---------|--------|-------------|
| auth | 5 | 0 | 5 | Login, Register, Passwort, E-Mail-Verifizierung, Splash |
| dashboard | 1 | 6 | 7 | Staff-Dashboard mit Statistik-Karten |
| kinder | 3 | 3 | 6 | Liste, Detail (Tabs), Formular |
| anwesenheit | 2 | 3 | 5 | Tages-Tracking, Krankmeldung |
| nachrichten | 3 | 4 | 7 | Liste, Detail, Formular |
| essensplan | 2 | 4 | 6 | Wochenplan, Formular |
| dokumente | 4 | 3 | 7 | Liste, Detail, Upload, Signierung |
| eingewoehnung | 5 | 3 | 8 | Liste, Detail, Formulare, Eltern-Ansicht |
| verwaltung | 6 | 3 | 9 | Home, Einrichtung, Gruppen, Mitarbeiter |
| eltern_home | 1 | 2 | 3 | Eltern-Dashboard |
| eltern_kind | 1 | 4 | 5 | Eltern-Kinderansicht |
| eltern_nachrichten | 1 | 0 | 1 | Eltern-Nachrichten |
| termine | 1 | 2 | 3 | Kalender, RSVP |
| fotos | 2 | 1 | 3 | Galerie, Viewer |
| onboarding | 2 | 0 | 2 | Institution, Eltern |
| push_einstellungen | 1 | 0 | 1 | Benachrichtigungen |
| settings | 1 | 0 | 1 | Sprachauswahl |
| shell | 0 | 2 | 2 | AppShell, ElternShell |
| **Gesamt** | **41** | **40** | **81** | |

---

## Datenmodell

### Models (23)

| Model | Felder | Quelle |
|-------|--------|--------|
| UserProfile | id, email, vorname, nachname, rolle, einrichtungId, ... | profiles |
| Kind | id, vorname, nachname, geburtsdatum, geschlecht, status, gruppeId, ... | kinder |
| Allergie | kindId, allergen, schweregrad, hinweise | allergien |
| Kontaktperson | kindId, name, beziehung, telefon, email, abholberechtigt, notfallkontakt | kontaktpersonen |
| Anwesenheit | kindId, datum, ankunftZeit, abgeholtZeit, status | anwesenheit |
| AnwesenheitHeute | (aggregierte Tagesansicht) | anwesenheit |
| Nachricht | id, absenderId, betreff, inhalt, typ, wichtig, ... | nachrichten |
| NachrichtAnhang | nachrichtId, dateiname, dateipfad, ... | nachricht_anhaenge |
| NachrichtEmpfaenger | nachrichtId, empfaengerId, gelesen | nachricht_empfaenger |
| NachrichtUngelesen | (ungelesene Zählung) | nachricht_empfaenger |
| Essensplan | einrichtungId, datum, mahlzeitTyp, gerichtName, allergene, vegetarisch | essensplaene |
| Einrichtung | id, name, typ, adresse, telefon, email, traegerId | einrichtungen |
| Gruppe | id, einrichtungId, name, typ, maxKinder, farbe | gruppen_klassen |
| MitarbeiterEinrichtung | id, vorname, nachname, rolle, einrichtungId | (joined view) |
| Einladung | id, einrichtungId, code, rolle, ... | einladungen |
| ElternKind | elternId, kindId, beziehung | eltern_kinder |
| Termin | id, einrichtungId, titel, typ, startzeit, endzeit, ... | termine |
| TerminRueckmeldung | terminId, userId, status | termin_rueckmeldungen |
| Foto | id, einrichtungId, dateipfad, beschreibung, ... | fotos |
| PushEinstellung | userId, kategorie, aktiviert | push_einstellungen |
| Dokument | id, einrichtungId, kindId?, typ, titel, dateipfad, unterschrieben, ... | dokumente |
| Eingewoehnung | id, kindId, startdatum, phase, bezugspersonId?, notizen?, elternFeedback? | eingewoehnung |
| EingewoehnungTagesnotiz | id, eingewoehnungId, datum, dauerMinuten?, stimmung?, trennungsverhalten?, ... | eingewoehnung_tagesnotizen |

### Enums (16)

| Enum | Werte |
|------|-------|
| UserRole | erzieher, lehrer, leitung, traeger, eltern |
| InstitutionType | krippe, kita, grundschule, ogs, hort |
| AttendanceStatus | anwesend, abwesend, krank, urlaub, entschuldigt, unentschuldigt |
| MessageType | nachricht, elternbrief, ankuendigung, notfall |
| ChildStatus | aktiv, eingewoehnung, abgemeldet, warteliste |
| MealType | fruehstueck, mittagessen, snack |
| DevelopmentArea | motorik, sprache, sozial, kognitiv, emotional, kreativ |
| Allergen | 14 EU-Allergene (gluten, krebstiere, eier, fisch, ...) |
| AllergySeverity | leicht, mittel, schwer, lebensbedrohlich |
| DocumentType | vertrag, einverstaendnis, attest, zeugnis, sonstiges |
| NachrichtenTab | posteingang, gesendet, wichtig |
| TerminTyp | allgemein, elternabend, fest, schliessung, ausflug, sonstiges |
| RsvpStatus | zugesagt, abgesagt, vielleicht |
| ElternBeziehung | mutter, vater, sorgeberechtigt |
| EingewoehnungPhase | grundphase, stabilisierung, schlussphase, abgeschlossen |
| Stimmung | sehr_gut, gut, neutral, schlecht, sehr_schlecht |

---

## Backend (Supabase)

### DB-Migrationen (13)

| Nr. | Datei | Inhalt |
|-----|-------|--------|
| 001 | core_tables.sql | profiles, einrichtungen |
| 002 | kinder.sql | kinder, allergien, kontaktpersonen, gruppen_klassen |
| 003 | anwesenheit.sql | anwesenheit |
| 004 | nachrichten.sql | nachrichten, nachricht_empfaenger, nachricht_anhaenge |
| 005 | essensplan.sql | essensplaene |
| 006 | entwicklung.sql | entwicklungsbeobachtungen |
| 007 | weitere.sql | einladungen, eltern_kinder, eingewoehnung, fotos, dokumente, termine, ... |
| 008 | schule.sql | Schul-spezifische Tabellen |
| 009 | functions.sql | DB-Funktionen |
| 010 | rls.sql | Row Level Security Policies (Staff) |
| 011 | eltern_features.sql | push_einstellungen, termin_rueckmeldungen |
| 012 | eltern_rls.sql | RLS-Policies für Eltern |
| 013 | eingewoehnung_tagesnotizen.sql | Tagesnotizen-Tabelle + RLS |

### Seed-Daten

`supabase/seed/development_seed.sql`:
- 4 Einrichtungen (Krippe, Kita, Grundschule, Hort)
- 7 Gruppen
- 21 Kinder (verschiedene Status)
- Allergien, Kontaktpersonen, Essensplaene, Anwesenheit
- 2 Eingewöhnungen + 3 Tagesnotizen

---

## Lokalisierung (i18n)

| Sprache | Code | Datei | Keys | RTL |
|---------|------|-------|------|-----|
| Deutsch (Template) | de | app_de.arb | 611 | Nein |
| Arabisch | ar | app_ar.arb | 611 | Ja |
| Türkisch | tr | app_tr.arb | 611 | Nein |
| Ukrainisch | uk | app_uk.arb | 611 | Nein |
| Englisch | en | app_en.arb | 611 | Nein |

Zugriff: `context.l.keyName` (Extension auf `BuildContext`).
Enum-Labels: `enum.label(context)` via Extensions in `enum_labels.dart`.

---

## UI-System

### Core Widgets (Kf-Prefix)

| Widget | Beschreibung |
|--------|-------------|
| KfButton | 5 Varianten: primary, secondary, outline, text, danger. Loading-State, Icon, isExpanded |
| KfTextField | Label, Hint, Validator, Prefix/Suffix-Icon, Multiline, Passwort-Modus |
| KfAvatar | Profilbild mit Initialen-Fallback |
| KfBadge | Farbiges Label-Badge |
| KfCard | Styled Card mit optionalem Header |
| KfDialog | Bestätigungsdialog |
| KfEmptyState | Icon + Text für leere Listen |
| KfLoading | Ladezustand-Anzeige |
| KfAppBar | Styled AppBar |
| KfRoleGuard | Rollenbasierte Sichtbarkeit (allowedRoles) |

### Design Tokens

- **Spacing:** 2, 4, 8, 12, 16, 20, 24, 32, 48
- **Font Sizes:** Xs(11), Sm(13), Md(15), Lg(17), Xl(20), 2xl(24), 3xl(28), 4xl(34)
- **Border Radius:** Xs(4), Sm(8), Md(12), Lg(16), Xl(24), Full(999)
- **Icons:** Sm(18), Md(24), Lg(32), Xl(48)
- **Avatars:** Sm(32), Md(40), Lg(56), Xl(80)
- **Touch Target:** Min 48dp (WCAG)
- **AppGaps:** v2–v48 (vertikal), h2–h32 (horizontal)
- **AppPadding:** screen, card, section, listTile

### Farbsystem (AppColors)

- **Primary:** #4A90D9 (Blau), Secondary: #7EC8A0 (Grün), Accent: #FFB74D (Orange)
- **Semantic:** Success #43A047, Error #E53935, Warning #FB8C00, Info #1E88E5
- **Rollen:** Erzieher (Blau), Lehrer (Grün), Leitung (Lila), Träger (Dunkelblau), Eltern (Orange)
- **8 Gruppenfarben** (Pastelltöne)

---

## Dependencies

### Haupt-Abhängigkeiten

| Kategorie | Pakete |
|-----------|--------|
| State & DI | provider, get_it |
| Navigation | go_router |
| Backend | supabase_flutter |
| Storage | hive_flutter, shared_preferences, flutter_secure_storage, path_provider |
| UI | cached_network_image, shimmer, flutter_svg, fl_chart, cupertino_icons |
| PDF | pdf, printing |
| QR | qr_flutter |
| Dateien | file_picker, image_picker, permission_handler |
| Netzwerk | connectivity_plus, url_launcher |
| Lokalisierung | intl |
| Monitoring | sentry_flutter |

---

## Offene Punkte

### Fehlend / Ausstehend

- **Tests:** Nur 1 Widget-Test vorhanden. Unit-, Widget- und Integrationstests fehlen komplett.
- **Entwicklungsbeobachtungen (Phase 6 DB):** DB-Tabelle existiert (006_entwicklung.sql), aber kein Flutter-Feature implementiert.
- **Profil-Screen:** Platzhalter ("kommt in Phase 2b") im Router.
- **Nachrichten-Absender:** Seed-Daten enthalten keine Nachrichten (Absender-IDs fehlen).
- **Offline-Sync:** Hive ist als Dependency vorhanden, aber kein Offline-Caching implementiert.
- **Push-Notifications:** Einstellungen existieren, aber kein FCM/APNs-Integration.
- **kind_detail_screen:** Eingewöhnung-Banner noch nicht integriert (war im Plan, aber nicht umgesetzt).

### Nächste mögliche Phasen

- Phase 15+: Entwicklungsbeobachtungen, Berichte/Statistiken, Elternbriefe-Generator, Schichtplanung, Offline-Modus, Push-Integration, Mehreinrichtungs-Support

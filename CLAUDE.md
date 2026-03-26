# CLAUDE.md - KitaFlow

## Projekt
KitaFlow — SaaS-Bildungsplattform für Kinder von 0–10 Jahren (Krippe → Kita → Grundschule → OGS/Hort).
Flutter-App mit Supabase-Backend, Multi-Tenant-Architektur.

## Architektur
Clean Architecture: config/ → core/ → data/ → presentation/ → features/
- State Management: Provider (ChangeNotifier) + GetIt DI
- Navigation: GoRouter mit ShellRoute
- Backend: Supabase (PostgreSQL, RLS für Multi-Tenancy)
- Lokaler Cache: Hive + SharedPreferences + FlutterSecureStorage

## Namenskonventionen
- Widgets: kf_ Präfix (kf_button.dart, kf_card.dart)
- Features: Deutsch (kinder/, anwesenheit/, nachrichten/)
- Enums/Klassen: Englisch (UserRole, AttendanceStatus)
- Dateien: snake_case
- Klassen: PascalCase

## Agenten-Transparenz
Bei JEDER Antwort am Anfang angeben:
- `[Agent: project]` — wenn Flutter/Dart-Code geschrieben wird
- `[Agent: planner]` — wenn ein Plan erstellt wird
- `[Agent: code-reviewer]` — wenn Code reviewed wird
- `[Kein Agent]` — wenn kein spezialisierter Agent verwendet wird

## Coding Conventions
- Dart >= 3.9.2, Flutter >= 3.35
- Keine hardcoded Colors → AppColors
- Keine hardcoded Spacing → DesignTokens
- Keine hardcoded Strings → l10n (ab Phase 12)
- Alle Provider erben von BaseProvider
- Alle Services/Repos als Singletons via GetIt
- Kein Supabase-Code in Widgets (gehört ins Repository)
- Kein State in Widgets (gehört in Provider)
- `flutter analyze` muss clean sein
- `dart format` auf allen Dateien

## Umlaute — HARTE REGEL
- Echte Umlaute in allen deutschen Texten: ä, ö, ü, Ä, Ö, Ü, ß
- ABER: Dart-Identifier (Variablen, Enums) nur ASCII (schalenfruechte statt schalenfrüchte)
- displayName-Getter verwenden echte Umlaute

## Wichtige Pfade
- DI: lib/core/di/service_locator.dart
- Router: lib/core/routing/app_router.dart
- Theme: lib/config/app_theme.dart + lib/core/theme/
- Base Widgets: lib/core/widgets/kf_*.dart
- Features: lib/features/{feature}/

## Referenz
- Architektur-Vorbild: bGen-main (~/Desktop/hussein/bGen-main/)
- Geschäftsplan: ~/Desktop/hussein/plan/fertig/kitaflow/
- Implementierungsplan: todo.md (im Projektroot)

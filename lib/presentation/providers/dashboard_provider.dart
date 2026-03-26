import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/kind.dart';
import 'base_provider.dart';
import 'essensplan_provider.dart';

/// Ein einzelnes Alert-Element für das Dashboard.
/// Wird für Allergen-Warnungen und Geburtstags-Hinweise verwendet.
class AlertItem {
  final String titel;
  final String nachricht;
  final IconData icon;
  final Color farbe;
  final String? routeOnTap;

  const AlertItem({
    required this.titel,
    required this.nachricht,
    required this.icon,
    required this.farbe,
    this.routeOnTap,
  });
}

/// Provider für Dashboard-spezifische Berechnungen.
/// Berechnet Alerts (Allergen-Warnungen, Geburtstage) und
/// zeitbasierte Begrüßungen. Statistiken kommen direkt aus den
/// jeweiligen Feature-Providern (Anwesenheit, Nachrichten, etc.).
class DashboardProvider extends BaseProvider {
  List<AlertItem> _alerts = [];
  List<AlertItem> _geburtstagAlerts = [];

  /// Alle aktiven Alerts (Allergen-Warnungen + Geburtstage).
  List<AlertItem> get alerts => [..._alerts, ..._geburtstagAlerts];

  /// Ob Alerts vorhanden sind.
  bool get hasAlerts => alerts.isNotEmpty;

  // ---------------------------------------------------------------------------
  // Begrüßung
  // ---------------------------------------------------------------------------

  /// Gibt eine zeitbasierte Begrüßung zurück.
  String getGreeting() {
    final stunde = DateTime.now().hour;
    if (stunde < 12) return 'Guten Morgen';
    if (stunde < 18) return 'Guten Tag';
    return 'Guten Abend';
  }

  // ---------------------------------------------------------------------------
  // Alerts berechnen
  // ---------------------------------------------------------------------------

  /// Berechnet alle Dashboard-Alerts aus Allergen-Warnungen und Geburtstagen.
  void berechneAlerts({
    required List<AllergenWarnung> allergenWarnungen,
    required List<Kind> kinder,
  }) {
    _alerts = [];
    _geburtstagAlerts = [];

    // --- Allergen-Warnungen ---
    for (final warnung in allergenWarnungen) {
      final Color farbe;
      switch (warnung.schweregrad.toLowerCase()) {
        case 'lebensbedrohlich':
          farbe = AppColors.allergyLifeThreatening;
        case 'schwer':
          farbe = AppColors.allergySevere;
        default:
          farbe = AppColors.allergyModerate;
      }

      _alerts.add(AlertItem(
        titel: '${warnung.kindName}: ${warnung.allergen}',
        nachricht:
            '${warnung.gerichtName} am ${formatDatum(warnung.datum)} (${warnung.schweregrad})',
        icon: Icons.warning_amber,
        farbe: farbe,
        routeOnTap: '/essensplan',
      ));
    }

    // --- Geburtstags-Alerts ---
    final heute = DateTime.now();
    final heuteDatum = DateTime(heute.year, heute.month, heute.day);

    for (final kind in kinder) {
      final gebMonat = kind.geburtsdatum.month;
      final gebTag = kind.geburtsdatum.day;

      // Prüfe ob Geburtstag heute oder in den nächsten 7 Tagen liegt
      for (int offset = 0; offset <= 7; offset++) {
        final pruefDatum = heuteDatum.add(Duration(days: offset));
        if (pruefDatum.month == gebMonat && pruefDatum.day == gebTag) {
          // Alter am Geburtstag in diesem Jahr berechnen
          int alterAmGeburtstag = pruefDatum.year - kind.geburtsdatum.year;

          if (offset == 0) {
            // Heute Geburtstag
            _geburtstagAlerts.add(AlertItem(
              titel: 'Geburtstag: ${kind.vollstaendigerName}',
              nachricht: 'Wird heute $alterAmGeburtstag Jahre alt!',
              icon: Icons.cake,
              farbe: AppColors.info,
            ));
          } else {
            // In den nächsten 7 Tagen
            _geburtstagAlerts.add(AlertItem(
              titel: 'Geburtstag: ${kind.vollstaendigerName}',
              nachricht:
                  'Wird $alterAmGeburtstag Jahre alt am ${formatDatum(pruefDatum)}',
              icon: Icons.cake,
              farbe: AppColors.info,
            ));
          }
          break; // Nur einmal pro Kind
        }
      }
    }

    notifySafely();
  }

  // ---------------------------------------------------------------------------
  // Hilfsmethoden
  // ---------------------------------------------------------------------------

  /// Deutsche Monatsnamen für die Datumsformatierung.
  static const _monatsNamen = [
    'Januar',
    'Februar',
    'März',
    'April',
    'Mai',
    'Juni',
    'Juli',
    'August',
    'September',
    'Oktober',
    'November',
    'Dezember',
  ];

  /// Deutsche Wochentags-Namen für die Datumsformatierung.
  static const _wochentagNamen = [
    'Montag',
    'Dienstag',
    'Mittwoch',
    'Donnerstag',
    'Freitag',
    'Samstag',
    'Sonntag',
  ];

  /// Formatiert ein Datum im deutschen Format, z.B. "Montag, 26. März 2026".
  String formatDatum(DateTime datum) {
    final wochentag = _wochentagNamen[datum.weekday - 1];
    final tag = datum.day;
    final monat = _monatsNamen[datum.month - 1];
    final jahr = datum.year;
    return '$wochentag, $tag. $monat $jahr';
  }
}

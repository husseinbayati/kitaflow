import 'package:flutter/material.dart';

/// Zentrale Farbdefinitionen für KitaFlow.
/// Kinderfreundlich, barrierefrei (WCAG AA Kontrast).
abstract final class AppColors {
  // Primary & Secondary
  static const Color primary = Color(0xFF4A90D9);
  static const Color primaryLight = Color(0xFF7BB3E8);
  static const Color primaryDark = Color(0xFF2A6CB8);
  static const Color secondary = Color(0xFF7EC8A0);
  static const Color secondaryLight = Color(0xFFA8DEC0);
  static const Color secondaryDark = Color(0xFF4EA87A);

  // Accent
  static const Color accent = Color(0xFFFFB74D);
  static const Color accentLight = Color(0xFFFFD180);
  static const Color accentDark = Color(0xFFFF9800);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F2F5);
  static const Color scaffoldBackground = Color(0xFFF5F6F8);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Semantic
  static const Color success = Color(0xFF43A047);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color warning = Color(0xFFFB8C00);
  static const Color warningLight = Color(0xFFFFF3E0);
  static const Color info = Color(0xFF1E88E5);
  static const Color infoLight = Color(0xFFE3F2FD);

  // Divider & Border
  static const Color divider = Color(0xFFE5E7EB);
  static const Color border = Color(0xFFD1D5DB);
  static const Color borderLight = Color(0xFFE5E7EB);

  // Rollen-Farben
  static const Color roleErzieher = Color(0xFF4A90D9);
  static const Color roleLehrer = Color(0xFF43A047);
  static const Color roleLeitung = Color(0xFF7C4DFF);
  static const Color roleTraeger = Color(0xFF1A237E);
  static const Color roleEltern = Color(0xFFFF9800);

  // Anwesenheits-Farben
  static const Color statusAnwesend = Color(0xFF43A047);
  static const Color statusAbwesend = Color(0xFFE53935);
  static const Color statusKrank = Color(0xFFFB8C00);
  static const Color statusUrlaub = Color(0xFF1E88E5);

  // Allergie-Farben
  static const Color allergyMild = Color(0xFFFFF9C4);
  static const Color allergyModerate = Color(0xFFFFE0B2);
  static const Color allergySevere = Color(0xFFFFCDD2);
  static const Color allergyLifeThreatening = Color(0xFFD32F2F);

  // Gruppen-Farben (Kita-Palette — Pastelltöne)
  static const List<Color> gruppenFarben = [
    Color(0xFFFFE082), // Sonnenblumen (Gelb)
    Color(0xFFEF9A9A), // Marienkäfer (Rot)
    Color(0xFF90CAF9), // Wölkchen (Blau)
    Color(0xFFA5D6A7), // Frösche (Grün)
    Color(0xFFCE93D8), // Schmetterlinge (Lila)
    Color(0xFFFFCC80), // Bienchen (Orange)
    Color(0xFF80DEEA), // Fische (Türkis)
    Color(0xFFF48FB1), // Flamingos (Rosa)
  ];
}

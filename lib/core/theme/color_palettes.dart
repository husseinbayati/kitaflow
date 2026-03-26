import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Vordefinierte Farbpaletten für Einrichtungstypen.
abstract final class ColorPalettes {
  /// Kita-Palette: Weich, pastellig, kinderfreundlich.
  static const List<Color> kita = [
    Color(0xFFFFE082),
    Color(0xFFEF9A9A),
    Color(0xFF90CAF9),
    Color(0xFFA5D6A7),
    Color(0xFFCE93D8),
    Color(0xFFFFCC80),
    Color(0xFF80DEEA),
    Color(0xFFF48FB1),
  ];

  /// Grundschul-Palette: Etwas kräftiger, aber immer noch freundlich.
  static const List<Color> grundschule = [
    Color(0xFFFFC107),
    Color(0xFFF44336),
    Color(0xFF2196F3),
    Color(0xFF4CAF50),
    Color(0xFF9C27B0),
    Color(0xFFFF9800),
    Color(0xFF00BCD4),
    Color(0xFFE91E63),
  ];

  /// Gibt Farbe für Gruppenindex zurück (zyklisch).
  static Color gruppenFarbe(int index) {
    return AppColors.gruppenFarben[index % AppColors.gruppenFarben.length];
  }
}

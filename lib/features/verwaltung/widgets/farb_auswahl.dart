import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';

/// Einfacher Farbauswahl-Widget mit 12 vordefinierten Farben für Gruppen.
class FarbAuswahl extends StatelessWidget {
  final String? selectedColor;
  final ValueChanged<String> onColorSelected;

  const FarbAuswahl({
    super.key,
    this.selectedColor,
    required this.onColorSelected,
  });

  static const List<String> farben = [
    '#F44336', // Rot
    '#E91E63', // Pink
    '#9C27B0', // Lila
    '#673AB7', // Violett
    '#3F51B5', // Indigo
    '#2196F3', // Blau
    '#03A9F4', // Hellblau
    '#009688', // Teal
    '#4CAF50', // Grün
    '#FF9800', // Orange
    '#FF5722', // Tieforange
    '#795548', // Braun
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: DesignTokens.spacing8,
      runSpacing: DesignTokens.spacing8,
      children: farben.map((farbe) {
        final isSelected = farbe == selectedColor;
        final color = Color(int.parse(farbe.replaceFirst('#', '0xFF')));
        return GestureDetector(
          onTap: () => onColorSelected(farbe),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: Theme.of(context).colorScheme.primary, width: 3)
                  : null,
              boxShadow: isSelected
                  ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 1)]
                  : null,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : null,
          ),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';

/// Statistik-Leiste für die Anwesenheitsübersicht.
///
/// Zeigt vier kompakte Statistik-Karten: Anwesend, Abwesend, Krank, Gesamt.
class AnwesenheitStatistikBar extends StatelessWidget {
  const AnwesenheitStatistikBar({
    super.key,
    required this.anwesend,
    required this.abwesend,
    required this.krank,
    required this.gesamt,
  });

  final int anwesend;
  final int abwesend;
  final int krank;
  final int gesamt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing16,
        vertical: DesignTokens.spacing8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat(context.l.anwesenheit_statsPresent, anwesend, AppColors.success, Icons.check_circle),
          _buildStat(context.l.anwesenheit_statsAbsent, abwesend, AppColors.error, Icons.cancel),
          _buildStat(context.l.anwesenheit_statsSick, krank, AppColors.warning, Icons.sick),
          _buildStat(context.l.anwesenheit_statsTotal, gesamt, AppColors.primary, Icons.people),
        ],
      ),
    );
  }

  Widget _buildStat(String label, int count, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: DesignTokens.spacing4),
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spacing12,
          horizontal: DesignTokens.spacing8,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          boxShadow: DesignTokens.shadowLight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: DesignTokens.iconMd),
            const SizedBox(height: DesignTokens.spacing4),
            Text(
              '$count',
              style: TextStyle(
                fontSize: DesignTokens.fontLg,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: DesignTokens.fontXs,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

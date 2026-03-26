import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/eingewoehnung_tagesnotiz.dart';

/// Karte zur Anzeige einer Eingewöhnungs-Tagesnotiz.
class TagesnotizCard extends StatelessWidget {
  const TagesnotizCard({super.key, required this.notiz});

  final EingewoehnungTagesnotiz notiz;

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  bool get _hasDetails =>
      notiz.trennungsverhalten != null ||
      notiz.trennungsverhaltenText != null ||
      notiz.essen != null ||
      notiz.schlaf != null ||
      notiz.spiel != null ||
      notiz.notizenEltern != null;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Padding(
        padding: AppPadding.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Text(
                  _formatDate(notiz.datum),
                  style: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (notiz.stimmung != null)
                  Text(
                    notiz.stimmung!.emoji,
                    style: const TextStyle(fontSize: DesignTokens.fontXl),
                  ),
                if (notiz.dauerMinuten != null) ...[
                  AppGaps.h8,
                  Text(
                    '${notiz.dauerMinuten} Min.',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSm,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),

            // Details
            if (_hasDetails) ...[
              AppGaps.v12,
              const Divider(height: 1),
              AppGaps.v12,

              // Trennungsverhalten
              if (notiz.trennungsverhalten != null) ...[
                _buildRatingRow(context),
                if (notiz.trennungsverhaltenText != null) ...[
                  AppGaps.v4,
                  Text(
                    notiz.trennungsverhaltenText!,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSm,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                AppGaps.v8,
              ],

              // Essen
              if (notiz.essen != null)
                _buildLabeledText(
                  icon: Icons.restaurant,
                  text: notiz.essen!,
                ),

              // Schlaf
              if (notiz.schlaf != null)
                _buildLabeledText(
                  icon: Icons.bedtime,
                  text: notiz.schlaf!,
                ),

              // Spiel
              if (notiz.spiel != null)
                _buildLabeledText(
                  icon: Icons.toys,
                  text: notiz.spiel!,
                ),

              // Eltern Notizen
              if (notiz.notizenEltern != null) ...[
                AppGaps.v4,
                _buildLabeledText(
                  icon: Icons.family_restroom,
                  text: notiz.notizenEltern!,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  /// Trennungsverhalten als Punkte-Reihe (1-5).
  Widget _buildRatingRow(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final isFilled = index < (notiz.trennungsverhalten ?? 0);
        return Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(right: DesignTokens.spacing4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? AppColors.warning : AppColors.border,
          ),
        );
      }),
    );
  }

  /// Zeile mit Icon und Text.
  Widget _buildLabeledText({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacing4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: DesignTokens.iconSm, color: AppColors.textHint),
          AppGaps.h8,
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../presentation/providers/essensplan_provider.dart';

/// Banner für Allergen-Warnungen im Wochenplan.
///
/// Zeigt eine auffällige Warnung, wenn Mahlzeiten Allergene enthalten,
/// die bei Kindern der Einrichtung bekannt sind.
class AllergenWarnungBanner extends StatelessWidget {
  const AllergenWarnungBanner({
    super.key,
    required this.warnungen,
  });

  /// Liste der Allergen-Warnungen.
  final List<AllergenWarnung> warnungen;

  @override
  Widget build(BuildContext context) {
    if (warnungen.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: DesignTokens.iconMd,
              ),
              AppGaps.h8,
              Text(
                context.l.essensplan_allergenWarnings(warnungen.length),
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          AppGaps.v8,
          ...warnungen.map(
            (w) => Padding(
              padding: const EdgeInsets.only(
                bottom: DesignTokens.spacing4,
              ),
              child: Text(
                '${w.kindName}: ${w.allergen} (${w.schweregrad}) \u2014 ${w.gerichtName}',
                style: TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

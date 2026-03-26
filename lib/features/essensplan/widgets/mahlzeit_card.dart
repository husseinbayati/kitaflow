import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/essensplan.dart';
import 'allergen_chips.dart';

/// Karte für eine einzelne Mahlzeit im Wochenplan.
///
/// Zeigt Mahlzeittyp, Gerichtname, Beschreibung, Allergene und
/// vegetarisch/vegan-Badges an. Die linke Randfarbe codiert den Typ.
class MahlzeitCard extends StatelessWidget {
  const MahlzeitCard({
    super.key,
    required this.plan,
    this.onTap,
    this.onLongPress,
  });

  /// Der Essensplan-Eintrag.
  final Essensplan plan;

  /// Callback bei Tippen (Bearbeiten).
  final VoidCallback? onTap;

  /// Callback bei langem Drücken (Löschen).
  final VoidCallback? onLongPress;

  /// Randfarbe basierend auf Mahlzeittyp. Bei Allergenen: Rot.
  Color get _borderColor {
    if (plan.hatAllergene) return AppColors.error;
    switch (plan.mahlzeitTyp) {
      case MealType.fruehstueck:
        return AppColors.info;
      case MealType.mittagessen:
        return AppColors.warning;
      case MealType.snack:
        return AppColors.accent;
    }
  }

  /// Icon basierend auf Mahlzeittyp.
  IconData get _mealIcon {
    switch (plan.mahlzeitTyp) {
      case MealType.fruehstueck:
        return Icons.free_breakfast;
      case MealType.mittagessen:
        return Icons.lunch_dining;
      case MealType.snack:
        return Icons.cookie;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          border: Border(
            left: BorderSide(
              color: _borderColor,
              width: 4,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spacing8,
          horizontal: DesignTokens.spacing12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Mahlzeittyp-Zeile ---
            Row(
              children: [
                Icon(
                  _mealIcon,
                  size: DesignTokens.iconSm,
                  color: AppColors.textSecondary,
                ),
                AppGaps.h4,
                Text(
                  plan.mahlzeitTyp.label(context),
                  style: TextStyle(
                    fontSize: DesignTokens.fontXs,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            AppGaps.v4,

            // --- Gerichtname ---
            Text(
              plan.gerichtName,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),

            // --- Beschreibung (optional) ---
            if (plan.beschreibung != null &&
                plan.beschreibung!.isNotEmpty) ...[
              AppGaps.v2,
              Text(
                plan.beschreibung!,
                style: TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // --- Allergen-Chips ---
            if (plan.hatAllergene) ...[
              AppGaps.v4,
              AllergenChips(allergene: plan.allergene),
            ],

            // --- Vegetarisch / Vegan Badges ---
            if (plan.vegetarisch || plan.vegan) ...[
              AppGaps.v4,
              Row(
                children: [
                  if (plan.vegetarisch)
                    _DietBadge(
                      label: 'V',
                      color: AppColors.success,
                      backgroundColor: AppColors.successLight,
                    ),
                  if (plan.vegetarisch && plan.vegan) AppGaps.h4,
                  if (plan.vegan)
                    _DietBadge(
                      label: 'VG',
                      color: const Color(0xFF2E7D32),
                      backgroundColor: AppColors.successLight,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Kleines Badge für Ernährungshinweise (V = vegetarisch, VG = vegan).
class _DietBadge extends StatelessWidget {
  const _DietBadge({
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  final String label;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing8,
        vertical: DesignTokens.spacing2,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: DesignTokens.fontXs,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

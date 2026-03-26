import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_badge.dart';
import '../../../data/models/essensplan.dart';

/// Kompakte Essensplan-Übersicht für das Dashboard.
///
/// Zeigt maximal 3 heutige Mahlzeiten (Frühstück, Mittagessen, Snack)
/// als kompakte ListTiles mit Allergen-Badges.
class EssensplanKompakt extends StatelessWidget {
  const EssensplanKompakt({
    super.key,
    required this.heutigeMahlzeiten,
  });

  /// Heutige Mahlzeiten (max. 3 werden angezeigt).
  final List<Essensplan> heutigeMahlzeiten;

  /// Icon passend zum Mahlzeitentyp.
  IconData _iconMahlzeit(MealType typ) {
    return switch (typ) {
      MealType.fruehstueck => Icons.free_breakfast_outlined,
      MealType.mittagessen => Icons.lunch_dining_outlined,
      MealType.snack => Icons.cookie_outlined,
    };
  }

  /// Farbe passend zum Mahlzeitentyp.
  Color _farbeMahlzeit(MealType typ) {
    return switch (typ) {
      MealType.fruehstueck => AppColors.accent,
      MealType.mittagessen => AppColors.primary,
      MealType.snack => AppColors.secondary,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (heutigeMahlzeiten.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spacing24,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.no_meals_outlined,
                size: DesignTokens.iconXl,
                color: AppColors.textHint,
              ),
              AppGaps.v8,
              Text(
                context.l.dashboard_noMealPlan,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final angezeigt = heutigeMahlzeiten.take(3).toList();

    return Column(
      children: [
        for (int i = 0; i < angezeigt.length; i++) ...[
          _MahlzeitTile(
            mahlzeit: angezeigt[i],
            icon: _iconMahlzeit(angezeigt[i].mahlzeitTyp),
            iconFarbe: _farbeMahlzeit(angezeigt[i].mahlzeitTyp),
          ),
          if (i < angezeigt.length - 1)
            const Divider(height: 1, indent: 56),
        ],
      ],
    );
  }
}

/// Einzelne Mahlzeit als kompakte Zeile.
class _MahlzeitTile extends StatelessWidget {
  const _MahlzeitTile({
    required this.mahlzeit,
    required this.icon,
    required this.iconFarbe,
  });

  final Essensplan mahlzeit;
  final IconData icon;
  final Color iconFarbe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing12,
        vertical: DesignTokens.spacing2,
      ),
      leading: Icon(icon, color: iconFarbe, size: DesignTokens.iconMd),
      title: Row(
        children: [
          Flexible(
            child: Text(
              mahlzeit.gerichtName,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (mahlzeit.istVegetarisch || mahlzeit.istVegan) ...[
            AppGaps.h4,
            Icon(
              Icons.eco_outlined,
              size: DesignTokens.iconSm,
              color: AppColors.success,
            ),
          ],
        ],
      ),
      subtitle: mahlzeit.hatAllergene
          ? Padding(
              padding: const EdgeInsets.only(top: DesignTokens.spacing4),
              child: Wrap(
                spacing: DesignTokens.spacing4,
                runSpacing: DesignTokens.spacing2,
                children: mahlzeit.allergene.map((allergen) {
                  return KfBadge(
                    label: allergen,
                    color: AppColors.warningLight,
                    textColor: AppColors.warning,
                  );
                }).toList(),
              ),
            )
          : Text(
              mahlzeit.mahlzeitTyp.label(context),
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
              ),
            ),
    );
  }
}

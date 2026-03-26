import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_card.dart';
import '../../../data/models/essensplan.dart';
import 'mahlzeit_card.dart';

/// Tageskarte für den Wochenplan.
///
/// Zeigt alle Mahlzeiten eines Tages (Frühstück, Mittagessen, Snack)
/// und Platzhalter-Slots für fehlende Einträge.
class TagesCard extends StatelessWidget {
  const TagesCard({
    super.key,
    required this.datum,
    required this.mahlzeiten,
    this.onAddMahlzeit,
    this.onEditMahlzeit,
    this.onDeleteMahlzeit,
  });

  /// Datum des Tages.
  final DateTime datum;

  /// Mahlzeiten für diesen Tag.
  final List<Essensplan> mahlzeiten;

  /// Callback zum Hinzufügen einer Mahlzeit.
  final VoidCallback? onAddMahlzeit;

  /// Callback zum Bearbeiten einer Mahlzeit.
  final ValueChanged<Essensplan>? onEditMahlzeit;

  /// Callback zum Löschen einer Mahlzeit.
  final ValueChanged<Essensplan>? onDeleteMahlzeit;

  static List<String> _wochentage(BuildContext context) => [
    context.l.essensplan_weekdayMonday,
    context.l.essensplan_weekdayTuesday,
    context.l.essensplan_weekdayWednesday,
    context.l.essensplan_weekdayThursday,
    context.l.essensplan_weekdayFriday,
    context.l.essensplan_weekdaySaturday,
    context.l.essensplan_weekdaySunday,
  ];

  String _wochentagName(BuildContext context) => _wochentage(context)[datum.weekday - 1];

  String get _datumText =>
      '${datum.day.toString().padLeft(2, '0')}.${datum.month.toString().padLeft(2, '0')}.';

  @override
  Widget build(BuildContext context) {
    return KfCard(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Tages-Header ---
          Text(
            '${_wochentagName(context)}, $_datumText',
            style: TextStyle(
              fontSize: DesignTokens.fontLg,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          AppGaps.v12,

          // --- Mahlzeiten-Slots ---
          for (final typ in MealType.values) ...[
            _buildSlot(typ),
            AppGaps.v8,
          ],
        ],
      ),
    );
  }

  /// Baut einen Slot für einen Mahlzeitentyp.
  /// Zeigt die Mahlzeit-Karte oder einen leeren Platzhalter.
  Widget _buildSlot(MealType typ) {
    final plan = mahlzeiten
        .where((m) => m.mahlzeitTyp == typ)
        .toList();

    if (plan.isNotEmpty) {
      // Zeige alle Einträge dieses Typs
      return Column(
        children: plan
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(
                  bottom: DesignTokens.spacing4,
                ),
                child: MahlzeitCard(
                  plan: p,
                  onTap: () => onEditMahlzeit?.call(p),
                  onLongPress: () => onDeleteMahlzeit?.call(p),
                ),
              ),
            )
            .toList(),
      );
    }

    return _EmptySlot(
      typ: typ,
      onTap: onAddMahlzeit,
    );
  }
}

/// Leerer Platzhalter-Slot für eine fehlende Mahlzeit.
///
/// Zeigt einen gestrichelten Rahmen mit „+" und dem Mahlzeitnamen.
class _EmptySlot extends StatelessWidget {
  const _EmptySlot({
    required this.typ,
    this.onTap,
  });

  final MealType typ;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spacing12,
          horizontal: DesignTokens.spacing16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          border: Border.all(
            color: AppColors.border,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: DesignTokens.iconSm,
              color: AppColors.textHint,
            ),
            AppGaps.h8,
            Text(
              typ.label(context),
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

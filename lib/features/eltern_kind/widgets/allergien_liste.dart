import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/allergie.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

class AllergienListe extends StatelessWidget {
  final List<Allergie> allergien;

  const AllergienListe({super.key, required this.allergien});

  @override
  Widget build(BuildContext context) {
    if (allergien.isEmpty) {
      return Column(
        children: [
          AppGaps.v32,
          Center(
            child: Column(
              children: [
                const Icon(Icons.check_circle_outline,
                    size: DesignTokens.iconXl, color: AppColors.success),
                AppGaps.v12,
                Text(context.l.eltern_kindNoAllergies),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGaps.v16,
        Text(
          context.l.eltern_kindAllergiesTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        AppGaps.v12,
        ...allergien.map((allergie) => _buildAllergieCard(context, allergie)),
      ],
    );
  }

  Widget _buildAllergieCard(BuildContext context, Allergie allergie) {
    // Use severity for color
    final Color severityColor;
    switch (allergie.schweregrad.name) {
      case 'lebensbedrohlich':
        severityColor = AppColors.allergyLifeThreatening;
      case 'schwer':
        severityColor = AppColors.allergySevere;
      default:
        severityColor = AppColors.allergyModerate;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(color: severityColor.withValues(alpha: 0.3)),
      ),
      child: ListTile(
        leading: Icon(Icons.warning_amber, color: severityColor),
        title: Text(allergie.allergen.label(context)),
        subtitle: Text(allergie.schweregrad.label(context)),
        trailing: allergie.hinweise != null
            ? Tooltip(
                message: allergie.hinweise!,
                child: const Icon(Icons.info_outline),
              )
            : null,
      ),
    );
  }
}

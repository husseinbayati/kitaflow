import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';

/// Kompakte Allergen-Chips zur Anzeige auf Essensplan-Karten.
///
/// Zeigt die Allergene eines Gerichts als kleine farbige Chips an.
/// Allergene, die bei einem Kind eine Warnung auslösen, werden rot markiert.
class AllergenChips extends StatelessWidget {
  const AllergenChips({
    super.key,
    required this.allergene,
    this.warnAllergene,
  });

  /// Liste der Allergen-Namen (z.B. ['gluten', 'milch']).
  final List<String> allergene;

  /// Allergene, die eine Warnung auslösen (z.B. wegen Kinder-Allergien).
  /// Diese werden rot hervorgehoben.
  final Set<String>? warnAllergene;

  /// Versucht den Allergen-Enum-Label aufzulösen.
  /// Fällt auf den Rohstring zurück, falls nicht gefunden.
  String _displayName(BuildContext context, String allergenName) {
    try {
      final allergen = Allergen.values.firstWhere(
        (a) => a.name == allergenName,
      );
      return allergen.label(context);
    } catch (_) {
      return allergenName;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (allergene.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: allergene.map((allergenName) {
        final isWarning =
            warnAllergene != null && warnAllergene!.contains(allergenName);

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing8,
            vertical: DesignTokens.spacing2,
          ),
          decoration: BoxDecoration(
            color: isWarning
                ? AppColors.error.withValues(alpha: 0.15)
                : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(DesignTokens.radiusXs),
            border: isWarning
                ? Border.all(color: AppColors.error.withValues(alpha: 0.4))
                : null,
          ),
          child: Text(
            _displayName(context, allergenName),
            style: TextStyle(
              fontSize: DesignTokens.fontSm,
              color: isWarning ? AppColors.error : AppColors.textSecondary,
              fontWeight: isWarning ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}

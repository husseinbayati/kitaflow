import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';

/// Picker für die Stimmung eines Kindes (5 Emoji-Chips).
class StimmungPicker extends StatelessWidget {
  const StimmungPicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final Stimmung? selected;
  final ValueChanged<Stimmung?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: Stimmung.values.map((stimmung) {
        final isSelected = selected == stimmung;
        return Padding(
          padding: const EdgeInsets.only(right: DesignTokens.spacing8),
          child: ChoiceChip(
            label: Text(
              stimmung.emoji,
              style: const TextStyle(fontSize: DesignTokens.fontLg),
            ),
            selected: isSelected,
            selectedColor: AppColors.primaryLight,
            onSelected: (_) {
              if (isSelected) {
                onChanged(null);
              } else {
                onChanged(stimmung);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';

/// Rating-Widget für Trennungsverhalten (1-5 tappbare Kreise).
class TrennungsverhaltenRating extends StatelessWidget {
  const TrennungsverhaltenRating({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final rating = index + 1;
        final isFilled = value != null && rating <= value!;

        return Padding(
          padding: const EdgeInsets.only(right: DesignTokens.spacing8),
          child: GestureDetector(
            onTap: () {
              if (value == rating) {
                onChanged(null);
              } else {
                onChanged(rating);
              }
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled ? AppColors.warning : Colors.transparent,
                border: Border.all(
                  color: isFilled ? AppColors.warning : AppColors.border,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '$rating',
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  fontWeight: FontWeight.w600,
                  color: isFilled
                      ? AppColors.textOnPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

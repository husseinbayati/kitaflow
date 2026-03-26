import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';

/// Wiederverwendbarer Abschnitts-Header mit optionalem Aktions-Link.
///
/// Wird im Dashboard verwendet, um Bereiche wie "Alerts", "Termine" usw.
/// mit einer einheitlichen Überschrift darzustellen.
class DashboardSection extends StatelessWidget {
  const DashboardSection({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  /// Titel des Abschnitts.
  final String title;

  /// Optionaler Text für den Aktions-Button (z.B. "Alle anzeigen").
  final String? actionLabel;

  /// Callback für den Aktions-Button.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing16,
        vertical: DesignTokens.spacing8,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: DesignTokens.fontLg,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          if (actionLabel != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                '$actionLabel \u2192',
                style: TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

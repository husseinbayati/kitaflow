import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../theme/app_colors.dart';
import 'kf_button.dart';

/// Leerer-Zustand-Widget für Listen und Seiten ohne Inhalt.
///
/// Zeigt ein Icon, Titel, Untertitel und optionalen Aktionsbutton.
class KfEmptyState extends StatelessWidget {
  const KfEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  /// Großes Icon als visuelle Orientierung.
  final IconData icon;

  /// Haupttitel (z.B. "Keine Kinder gefunden").
  final String title;

  /// Optionaler erklärender Text.
  final String? subtitle;

  /// Beschriftung des Aktionsbuttons (optional).
  final String? actionLabel;

  /// Callback für den Aktionsbutton.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: DesignTokens.iconXl * 1.5,
              color: AppColors.textHint,
            ),
            AppGaps.v16,
            Text(
              title,
              style: TextStyle(
                fontSize: DesignTokens.fontLg,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              AppGaps.v8,
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              AppGaps.v24,
              KfButton(
                label: actionLabel!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

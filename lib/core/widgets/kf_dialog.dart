import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../extensions/l10n_extension.dart';
import '../theme/app_colors.dart';
import 'kf_button.dart';

/// Alert-Dialog mit einzelnem OK-Button.
///
/// Zeigt eine einfache Meldung an, die der Benutzer bestätigen kann.
abstract final class KfAlertDialog {
  /// Zeigt einen Alert-Dialog mit [title] und [message].
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? buttonLabel,
  }) {
    final resolvedButtonLabel = buttonLabel ?? context.l.common_ok;
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        backgroundColor: AppColors.surface,
        title: Text(
          title,
          style: TextStyle(
            fontSize: DesignTokens.fontLg,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          KfButton(
            label: resolvedButtonLabel,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

/// Bestätigungs-Dialog mit Abbrechen- und Bestätigen-Button.
///
/// Gibt `true` zurück, wenn der Benutzer bestätigt, sonst `false`.
abstract final class KfConfirmDialog {
  /// Zeigt einen Bestätigungs-Dialog mit [title] und [message].
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool isDanger = false,
  }) async {
    final resolvedConfirmLabel = confirmLabel ?? context.l.common_confirm;
    final resolvedCancelLabel = cancelLabel ?? context.l.common_cancel;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        backgroundColor: AppColors.surface,
        title: Text(
          title,
          style: TextStyle(
            fontSize: DesignTokens.fontLg,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          KfButton(
            label: resolvedCancelLabel,
            variant: KfButtonVariant.text,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          KfButton(
            label: resolvedConfirmLabel,
            variant: isDanger ? KfButtonVariant.danger : KfButtonVariant.primary,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

/// Modaler Bottom Sheet.
///
/// Zeigt ein Widget in einem abgerundeten Bottom Sheet an.
abstract final class KfBottomSheet {
  /// Zeigt ein modales Bottom Sheet mit [child] als Inhalt.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    String? title,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusLg),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Griff-Indikator
              Padding(
                padding: const EdgeInsets.only(top: DesignTokens.spacing12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                  ),
                ),
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    DesignTokens.spacing16,
                    DesignTokens.spacing16,
                    DesignTokens.spacing16,
                    DesignTokens.spacing8,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: DesignTokens.fontLg,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

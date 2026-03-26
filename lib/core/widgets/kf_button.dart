import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../theme/app_colors.dart';

/// Varianten für [KfButton].
enum KfButtonVariant { primary, secondary, outline, text, danger }

/// Wiederverwendbarer Button mit mehreren Varianten für KitaFlow.
///
/// Unterstützt Ladezustand, optionales Icon und volle Breite.
class KfButton extends StatelessWidget {
  const KfButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = KfButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.isExpanded = false,
  });

  /// Beschriftung des Buttons.
  final String label;

  /// Callback bei Tap. Wenn null, wird der Button deaktiviert.
  final VoidCallback? onPressed;

  /// Visuelle Variante.
  final KfButtonVariant variant;

  /// Zeigt einen Ladeindikator anstelle des Textes.
  final bool isLoading;

  /// Optionales Icon links vom Text.
  final IconData? icon;

  /// Wenn true, nimmt der Button die volle Breite ein.
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final child = isLoading ? _buildLoader() : _buildContent();

    final button = switch (variant) {
      KfButtonVariant.primary => FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: _primaryStyle(),
          child: child,
        ),
      KfButtonVariant.secondary => FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: _secondaryStyle(),
          child: child,
        ),
      KfButtonVariant.outline => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: _outlineStyle(),
          child: child,
        ),
      KfButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: _textStyle(),
          child: child,
        ),
      KfButtonVariant.danger => FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: _dangerStyle(),
          child: child,
        ),
    };

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Widget _buildLoader() {
    final color = switch (variant) {
      KfButtonVariant.primary || KfButtonVariant.danger => AppColors.textOnPrimary,
      KfButtonVariant.secondary => AppColors.primaryDark,
      KfButtonVariant.outline || KfButtonVariant.text => AppColors.primary,
    };

    return SizedBox(
      width: DesignTokens.iconMd,
      height: DesignTokens.iconMd,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  Widget _buildContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: DesignTokens.iconSm),
          AppGaps.h8,
          Text(label),
        ],
      );
    }
    return Text(label);
  }

  ButtonStyle _baseStyle() {
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(
        Size(0, DesignTokens.touchTargetMin),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing16,
          vertical: DesignTokens.spacing12,
        ),
      ),
    );
  }

  ButtonStyle _primaryStyle() {
    return _baseStyle().copyWith(
      backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      foregroundColor: WidgetStatePropertyAll(AppColors.textOnPrimary),
    );
  }

  ButtonStyle _secondaryStyle() {
    return _baseStyle().copyWith(
      backgroundColor: WidgetStatePropertyAll(AppColors.secondaryLight),
      foregroundColor: WidgetStatePropertyAll(AppColors.secondaryDark),
    );
  }

  ButtonStyle _outlineStyle() {
    return _baseStyle().copyWith(
      foregroundColor: WidgetStatePropertyAll(AppColors.primary),
      side: WidgetStatePropertyAll(
        BorderSide(color: AppColors.primary),
      ),
    );
  }

  ButtonStyle _textStyle() {
    return _baseStyle().copyWith(
      foregroundColor: WidgetStatePropertyAll(AppColors.primary),
    );
  }

  ButtonStyle _dangerStyle() {
    return _baseStyle().copyWith(
      backgroundColor: WidgetStatePropertyAll(AppColors.error),
      foregroundColor: WidgetStatePropertyAll(AppColors.textOnPrimary),
    );
  }
}

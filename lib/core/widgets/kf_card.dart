import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../theme/app_colors.dart';

/// Einfache Card-Hülle mit einheitlichem Padding und abgerundeten Ecken.
class KfCard extends StatelessWidget {
  const KfCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        boxShadow: DesignTokens.shadowLight,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          child: Padding(
            padding: padding ?? AppPadding.card,
            child: child,
          ),
        ),
      ),
    );

    return card;
  }
}

/// Infokarte mit farbigem linken Rand, Icon, Titel und Untertitel.
///
/// Geeignet für Hinweise, Warnungen oder zusammenfassende Informationen.
class KfInfoCard extends StatelessWidget {
  const KfInfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.borderColor,
    this.backgroundColor,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border(
          left: BorderSide(
            color: effectiveBorderColor,
            width: 4,
          ),
        ),
        boxShadow: DesignTokens.shadowLight,
      ),
      padding: AppPadding.card,
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: effectiveBorderColor, size: DesignTokens.iconLg),
            AppGaps.h12,
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  AppGaps.v4,
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSm,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Statistik-Karte für das Dashboard.
///
/// Zeigt einen großen Zahlenwert mit Beschriftung und optionalem Icon.
class KfStatCard extends StatelessWidget {
  const KfStatCard({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.onTap,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return KfCard(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              width: DesignTokens.avatarLg,
              height: DesignTokens.avatarLg,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? AppColors.primaryLight.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: DesignTokens.iconLg,
              ),
            ),
            AppGaps.h16,
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: DesignTokens.font2xl,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                AppGaps.v2,
                Text(
                  label,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSm,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

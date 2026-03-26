import 'package:flutter/material.dart';

/// Design Tokens für KitaFlow — kinderfreundlich, barrierefrei.
abstract final class DesignTokens {
  // Breakpoints
  static const double breakpointMobile = 600;
  static const double breakpointTablet = 1024;

  // Spacing
  static const double spacing2 = 2;
  static const double spacing4 = 4;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  static const double spacing48 = 48;

  // Font Sizes
  static const double fontXs = 11;
  static const double fontSm = 13;
  static const double fontMd = 15;
  static const double fontLg = 17;
  static const double fontXl = 20;
  static const double font2xl = 24;
  static const double font3xl = 28;
  static const double font4xl = 34;

  // Border Radius
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 999;

  // Shadows
  static List<BoxShadow> get shadowLight => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowStrong => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  // Icon Sizes
  static const double iconSm = 18;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 48;

  // Avatar Sizes
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 56;
  static const double avatarXl = 80;

  // Touch Targets (Accessibility: min 48dp)
  static const double touchTargetMin = 48;
}

/// SizedBox Shortcuts für vertikale/horizontale Abstände.
abstract final class AppGaps {
  static const SizedBox v2 = SizedBox(height: DesignTokens.spacing2);
  static const SizedBox v4 = SizedBox(height: DesignTokens.spacing4);
  static const SizedBox v8 = SizedBox(height: DesignTokens.spacing8);
  static const SizedBox v12 = SizedBox(height: DesignTokens.spacing12);
  static const SizedBox v16 = SizedBox(height: DesignTokens.spacing16);
  static const SizedBox v20 = SizedBox(height: DesignTokens.spacing20);
  static const SizedBox v24 = SizedBox(height: DesignTokens.spacing24);
  static const SizedBox v32 = SizedBox(height: DesignTokens.spacing32);
  static const SizedBox v48 = SizedBox(height: DesignTokens.spacing48);

  static const SizedBox h2 = SizedBox(width: DesignTokens.spacing2);
  static const SizedBox h4 = SizedBox(width: DesignTokens.spacing4);
  static const SizedBox h8 = SizedBox(width: DesignTokens.spacing8);
  static const SizedBox h12 = SizedBox(width: DesignTokens.spacing12);
  static const SizedBox h16 = SizedBox(width: DesignTokens.spacing16);
  static const SizedBox h20 = SizedBox(width: DesignTokens.spacing20);
  static const SizedBox h24 = SizedBox(width: DesignTokens.spacing24);
  static const SizedBox h32 = SizedBox(width: DesignTokens.spacing32);
}

/// Standard-Paddings.
abstract final class AppPadding {
  static const EdgeInsets screen = EdgeInsets.all(DesignTokens.spacing16);
  static const EdgeInsets card = EdgeInsets.all(DesignTokens.spacing16);
  static const EdgeInsets section = EdgeInsets.symmetric(
    horizontal: DesignTokens.spacing16,
    vertical: DesignTokens.spacing24,
  );
  static const EdgeInsets listTile = EdgeInsets.symmetric(
    horizontal: DesignTokens.spacing16,
    vertical: DesignTokens.spacing12,
  );
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../theme/app_colors.dart';

/// Avatar-Widget für Benutzer und Kinder.
///
/// Zeigt ein Netzwerkbild, wenn [imageUrl] angegeben ist,
/// andernfalls die Initialen des [name] auf einem farbigen Kreis.
class KfAvatar extends StatelessWidget {
  const KfAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = DesignTokens.avatarMd,
    this.backgroundColor,
  });

  /// URL des Profilbildes (optional).
  final String? imageUrl;

  /// Name der Person — wird für Initialen verwendet.
  final String name;

  /// Durchmesser des Avatars in dp.
  final double size;

  /// Hintergrundfarbe des Initialen-Kreises.
  final Color? backgroundColor;

  /// Berechnet die Initialen aus dem Namen (max. 2 Zeichen).
  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  /// Erzeugt eine stabile Farbe basierend auf dem Namen.
  Color get _defaultColor {
    final index = name.hashCode.abs() % AppColors.gruppenFarben.length;
    return AppColors.gruppenFarben[index];
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackground = backgroundColor ?? _defaultColor;
    final fontSize = size * 0.38;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildInitials(effectiveBackground, fontSize),
          errorWidget: (context, url, error) =>
              _buildInitials(effectiveBackground, fontSize),
        ),
      );
    }

    return _buildInitials(effectiveBackground, fontSize);
  }

  Widget _buildInitials(Color bgColor, double fontSize) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

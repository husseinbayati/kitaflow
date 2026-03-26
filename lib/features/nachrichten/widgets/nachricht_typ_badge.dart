import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/enum_labels.dart';

/// Kleines Badge-Widget, das den Nachrichtentyp farblich kennzeichnet.
///
/// Zeigt Icon + Typname als kompakten Chip.
class NachrichtTypBadge extends StatelessWidget {
  const NachrichtTypBadge({
    super.key,
    required this.typ,
    this.size,
  });

  /// Der anzuzeigende Nachrichtentyp.
  final MessageType typ;

  /// Optionale Größe für das Icon (Standard: iconSm).
  final double? size;

  Color get _backgroundColor {
    return switch (typ) {
      MessageType.nachricht => AppColors.infoLight,
      MessageType.elternbrief => AppColors.successLight,
      MessageType.ankuendigung => AppColors.warningLight,
      MessageType.notfall => AppColors.errorLight,
    };
  }

  Color get _foregroundColor {
    return switch (typ) {
      MessageType.nachricht => AppColors.info,
      MessageType.elternbrief => AppColors.success,
      MessageType.ankuendigung => AppColors.warning,
      MessageType.notfall => AppColors.error,
    };
  }

  IconData get _icon {
    return switch (typ) {
      MessageType.nachricht => Icons.mail,
      MessageType.elternbrief => Icons.description,
      MessageType.ankuendigung => Icons.campaign,
      MessageType.notfall => Icons.warning,
    };
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? DesignTokens.iconSm;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing8,
        vertical: DesignTokens.spacing4,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _icon,
            size: iconSize,
            color: _foregroundColor,
          ),
          const SizedBox(width: DesignTokens.spacing4),
          Text(
            typ.label(context),
            style: TextStyle(
              fontSize: DesignTokens.fontXs,
              fontWeight: FontWeight.w600,
              color: _foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

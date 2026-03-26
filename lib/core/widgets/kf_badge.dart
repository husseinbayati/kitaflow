import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../constants/enum_labels.dart';
import '../constants/enums.dart';
import '../theme/app_colors.dart';

/// Kleines farbiges Chip-Element mit Text.
///
/// Für allgemeine Kennzeichnungen und Tags.
class KfBadge extends StatelessWidget {
  const KfBadge({
    super.key,
    required this.label,
    this.color,
    this.textColor,
  });

  /// Beschriftung des Badges.
  final String label;

  /// Hintergrundfarbe (Standard: primaryLight).
  final Color? color;

  /// Textfarbe (Standard: primaryDark).
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing8,
        vertical: DesignTokens.spacing4,
      ),
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: DesignTokens.fontXs,
          fontWeight: FontWeight.w600,
          color: textColor ?? AppColors.primaryDark,
        ),
      ),
    );
  }
}

/// Badge für den Anwesenheitsstatus eines Kindes.
///
/// Farben werden automatisch aus [AttendanceStatus] abgeleitet.
class KfStatusBadge extends StatelessWidget {
  const KfStatusBadge({
    super.key,
    required this.status,
  });

  /// Der anzuzeigende Anwesenheitsstatus.
  final AttendanceStatus status;

  Color get _backgroundColor {
    return switch (status) {
      AttendanceStatus.anwesend => AppColors.successLight,
      AttendanceStatus.abwesend => AppColors.errorLight,
      AttendanceStatus.krank => AppColors.warningLight,
      AttendanceStatus.urlaub => AppColors.infoLight,
      AttendanceStatus.entschuldigt => AppColors.warningLight,
      AttendanceStatus.unentschuldigt => AppColors.errorLight,
    };
  }

  Color get _textColor {
    return switch (status) {
      AttendanceStatus.anwesend => AppColors.success,
      AttendanceStatus.abwesend => AppColors.error,
      AttendanceStatus.krank => AppColors.warning,
      AttendanceStatus.urlaub => AppColors.info,
      AttendanceStatus.entschuldigt => AppColors.warning,
      AttendanceStatus.unentschuldigt => AppColors.error,
    };
  }

  @override
  Widget build(BuildContext context) {
    return KfBadge(
      label: status.label(context),
      color: _backgroundColor,
      textColor: _textColor,
    );
  }
}

/// Badge für die Benutzerrolle.
///
/// Farben werden automatisch aus [UserRole] abgeleitet.
class KfRoleBadge extends StatelessWidget {
  const KfRoleBadge({
    super.key,
    required this.role,
  });

  /// Die anzuzeigende Rolle.
  final UserRole role;

  Color get _color {
    return switch (role) {
      UserRole.erzieher => AppColors.roleErzieher,
      UserRole.lehrer => AppColors.roleLehrer,
      UserRole.leitung => AppColors.roleLeitung,
      UserRole.traeger => AppColors.roleTraeger,
      UserRole.eltern => AppColors.roleEltern,
    };
  }

  @override
  Widget build(BuildContext context) {
    return KfBadge(
      label: role.label(context),
      color: _color.withValues(alpha: 0.15),
      textColor: _color,
    );
  }
}

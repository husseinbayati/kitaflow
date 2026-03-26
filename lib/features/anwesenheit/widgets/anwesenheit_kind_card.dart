import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_avatar.dart';
import '../../../data/models/anwesenheit_heute.dart';

/// Karte für ein einzelnes Kind in der Anwesenheitsliste.
///
/// Zeigt Name, Gruppe, Status und farbigen linken Rand je nach Anwesenheitsstatus.
class AnwesenheitKindCard extends StatelessWidget {
  const AnwesenheitKindCard({
    super.key,
    required this.eintrag,
    required this.onTap,
    this.onLongPress,
  });

  final AnwesenheitHeute eintrag;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  /// Farbe basierend auf dem Anwesenheitsstatus.
  Color _statusColor(AttendanceStatus? status) {
    return switch (status) {
      AttendanceStatus.anwesend => AppColors.success,
      AttendanceStatus.krank => AppColors.warning,
      AttendanceStatus.abwesend => AppColors.error,
      AttendanceStatus.unentschuldigt => AppColors.error,
      AttendanceStatus.entschuldigt => AppColors.info,
      AttendanceStatus.urlaub => AppColors.info,
      null => AppColors.textHint,
    };
  }

  /// Icon basierend auf dem Anwesenheitsstatus.
  IconData _statusIcon(AttendanceStatus? status) {
    return switch (status) {
      AttendanceStatus.anwesend => Icons.check_circle,
      AttendanceStatus.krank => Icons.sick,
      AttendanceStatus.abwesend => Icons.cancel,
      AttendanceStatus.unentschuldigt => Icons.error,
      AttendanceStatus.entschuldigt => Icons.info,
      AttendanceStatus.urlaub => Icons.beach_access,
      null => Icons.radio_button_unchecked,
    };
  }

  /// Statustext für die Anzeige.
  String _statusText(BuildContext context, AnwesenheitHeute e) {
    if (!e.istErfasst) {
      return context.l.anwesenheit_notRecorded;
    }
    if (e.status == AttendanceStatus.anwesend && e.abgeholtZeit == null) {
      final zeit = e.ankunftZeit?.substring(0, 5) ?? '';
      return context.l.anwesenheit_presentSince(zeit);
    }
    if (e.status == AttendanceStatus.anwesend && e.abgeholtZeit != null) {
      final zeit = e.abgeholtZeit?.substring(0, 5) ?? '';
      return context.l.anwesenheit_pickedUp(zeit);
    }
    return e.status!.label(context);
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(eintrag.status);

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            left: BorderSide(
              color: color,
              width: 4,
            ),
          ),
        ),
        padding: const EdgeInsets.all(DesignTokens.spacing12),
        child: Row(
          children: [
            KfAvatar(
              name: eintrag.vollstaendigerName,
              size: DesignTokens.avatarMd,
            ),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eintrag.vollstaendigerName,
                    style: const TextStyle(
                      fontSize: DesignTokens.fontMd,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing2),
                  Text(
                    eintrag.gruppeName ?? '',
                    style: const TextStyle(
                      fontSize: DesignTokens.fontSm,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    _statusText(context, eintrag),
                    style: TextStyle(
                      fontSize: DesignTokens.fontSm,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _statusIcon(eintrag.status),
              color: color,
              size: DesignTokens.iconMd,
            ),
          ],
        ),
      ),
    );
  }
}

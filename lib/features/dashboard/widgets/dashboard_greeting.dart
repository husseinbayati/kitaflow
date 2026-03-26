import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_badge.dart';

/// Begrüßungs-Header für das Dashboard.
///
/// Zeigt eine tageszeit-abhängige Begrüßung, den Vornamen,
/// die Benutzerrolle als Badge und das aktuelle Datum.
class DashboardGreeting extends StatelessWidget {
  const DashboardGreeting({
    super.key,
    required this.vorname,
    required this.rolle,
    required this.datumText,
  });

  /// Vorname des angemeldeten Benutzers.
  final String vorname;

  /// Rolle des Benutzers (für das Badge).
  final UserRole rolle;

  /// Formatierter Datumstext, z.B. "Montag, 26. März 2026".
  final String datumText;

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return context.l.dashboard_greetingMorning;
    if (hour < 18) return context.l.dashboard_greetingAfternoon;
    return context.l.dashboard_greetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                context.l.dashboard_greetingWithName(_getGreeting(context), vorname),
                style: TextStyle(
                  fontSize: DesignTokens.font2xl,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            AppGaps.h8,
            KfRoleBadge(role: rolle),
          ],
        ),
        AppGaps.v4,
        Text(
          datumText,
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

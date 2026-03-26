import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_card.dart';

/// Zeile mit drei Statistik-Karten für das Dashboard.
///
/// Zeigt Anwesenheit, ungelesene Nachrichten und Krankmeldungen.
class QuickStatsRow extends StatelessWidget {
  const QuickStatsRow({
    super.key,
    required this.anwesend,
    required this.gesamt,
    required this.ungelesen,
    required this.krank,
    this.onAnwesendTap,
    this.onNachrichtenTap,
    this.onKrankTap,
  });

  /// Anzahl anwesender Kinder.
  final int anwesend;

  /// Gesamtanzahl der Kinder.
  final int gesamt;

  /// Anzahl ungelesener Nachrichten.
  final int ungelesen;

  /// Anzahl kranker Kinder.
  final int krank;

  /// Callback bei Tap auf die Anwesenheitskarte.
  final VoidCallback? onAnwesendTap;

  /// Callback bei Tap auf die Nachrichtenkarte.
  final VoidCallback? onNachrichtenTap;

  /// Callback bei Tap auf die Krankmeldungskarte.
  final VoidCallback? onKrankTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KfStatCard(
            value: '$anwesend/$gesamt',
            label: context.l.dashboard_statsPresent,
            icon: Icons.people,
            iconColor: AppColors.statusAnwesend,
            onTap: onAnwesendTap,
          ),
        ),
        const SizedBox(width: DesignTokens.spacing12),
        Expanded(
          child: KfStatCard(
            value: '$ungelesen',
            label: context.l.dashboard_statsUnread,
            icon: Icons.mail,
            iconColor: AppColors.info,
            onTap: onNachrichtenTap,
          ),
        ),
        const SizedBox(width: DesignTokens.spacing12),
        Expanded(
          child: KfStatCard(
            value: '$krank',
            label: context.l.dashboard_statsSick,
            icon: Icons.sick,
            iconColor: AppColors.statusKrank,
            onTap: onKrankTap,
          ),
        ),
      ],
    );
  }
}

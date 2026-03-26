import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/nachricht.dart';

/// Kompakte Nachrichten-Übersicht für das Dashboard.
///
/// Zeigt die letzten Nachrichten (vom Aufrufer auf max. 3 begrenzt)
/// als kompakte ListTiles mit Betreff, Absender und relativem Datum.
class NachrichtenKompakt extends StatelessWidget {
  const NachrichtenKompakt({
    super.key,
    required this.nachrichten,
  });

  /// Aktuelle Nachrichten (bereits auf Top 3 begrenzt).
  final List<Nachricht> nachrichten;

  /// Icon passend zum Nachrichtentyp.
  IconData _iconTyp(MessageType typ) {
    return switch (typ) {
      MessageType.nachricht => Icons.mail_outline,
      MessageType.elternbrief => Icons.description_outlined,
      MessageType.ankuendigung => Icons.campaign_outlined,
      MessageType.notfall => Icons.warning_amber_outlined,
    };
  }

  /// Farbe passend zum Nachrichtentyp.
  Color _farbeTyp(MessageType typ) {
    return switch (typ) {
      MessageType.nachricht => AppColors.primary,
      MessageType.elternbrief => AppColors.secondary,
      MessageType.ankuendigung => AppColors.accent,
      MessageType.notfall => AppColors.error,
    };
  }

  /// Relatives Datum als lesbarer Text.
  String _relativeDatum(BuildContext context, DateTime datum) {
    final jetzt = DateTime.now();
    final differenz = jetzt.difference(datum);

    if (differenz.inMinutes < 1) {
      return context.l.common_justNow;
    } else if (differenz.inMinutes < 60) {
      return context.l.common_minutesAgo(differenz.inMinutes);
    } else if (differenz.inHours < 24) {
      return context.l.common_hoursAgo(differenz.inHours);
    } else if (differenz.inDays == 0 ||
        (jetzt.day == datum.day &&
            jetzt.month == datum.month &&
            jetzt.year == datum.year)) {
      return context.l.common_today;
    } else if (differenz.inDays == 1) {
      return context.l.common_yesterday;
    } else if (differenz.inDays < 7) {
      return context.l.common_daysAgo(differenz.inDays);
    } else {
      return '${datum.day.toString().padLeft(2, '0')}.${datum.month.toString().padLeft(2, '0')}.${datum.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (nachrichten.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spacing24,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: DesignTokens.iconXl,
                color: AppColors.textHint,
              ),
              AppGaps.v8,
              Text(
                context.l.dashboard_noNewMessages,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < nachrichten.length; i++) ...[
          _NachrichtTile(
            nachricht: nachrichten[i],
            icon: _iconTyp(nachrichten[i].typ),
            iconFarbe: _farbeTyp(nachrichten[i].typ),
            relativeDatum: _relativeDatum(context, nachrichten[i].erstelltAm),
          ),
          if (i < nachrichten.length - 1)
            const Divider(height: 1, indent: 56),
        ],
      ],
    );
  }
}

/// Einzelne Nachricht als kompakte Zeile.
class _NachrichtTile extends StatelessWidget {
  const _NachrichtTile({
    required this.nachricht,
    required this.icon,
    required this.iconFarbe,
    required this.relativeDatum,
  });

  final Nachricht nachricht;
  final IconData icon;
  final Color iconFarbe;
  final String relativeDatum;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing12,
        vertical: DesignTokens.spacing2,
      ),
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: iconFarbe, size: DesignTokens.iconMd),
          if (nachricht.wichtig)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        nachricht.betreff,
        style: TextStyle(
          fontSize: DesignTokens.fontMd,
          fontWeight: nachricht.wichtig ? FontWeight.w700 : FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        nachricht.absenderName,
        style: TextStyle(
          fontSize: DesignTokens.fontSm,
          color: AppColors.textSecondary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        relativeDatum,
        style: TextStyle(
          fontSize: DesignTokens.fontXs,
          color: AppColors.textHint,
        ),
      ),
    );
  }
}

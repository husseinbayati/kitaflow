import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/nachricht.dart';
import 'nachricht_typ_badge.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Listenzeile für eine Nachricht in der Übersicht.
///
/// Zeigt Typ-Badge, Betreff, Absendername, relatives Datum
/// und optionalen Wichtig-Stern.
class NachrichtListItem extends StatelessWidget {
  const NachrichtListItem({
    super.key,
    required this.nachricht,
    this.isUnread = false,
    this.onTap,
  });

  /// Die anzuzeigende Nachricht.
  final Nachricht nachricht;

  /// Ob die Nachricht ungelesen ist (fetterer Betreff).
  final bool isUnread;

  /// Callback bei Antippen der Zeile.
  final VoidCallback? onTap;

  String _formatRelativeDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return context.l.common_justNow;
    } else if (difference.inMinutes < 60) {
      return context.l.common_minutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return context.l.common_hoursAgo(difference.inHours);
    } else if (difference.inDays == 1) {
      return context.l.common_yesterday;
    } else {
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing16,
        vertical: DesignTokens.spacing4,
      ),
      leading: NachrichtTypBadge(typ: nachricht.typ),
      title: Text(
        nachricht.betreff,
        style: TextStyle(
          fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
          fontSize: DesignTokens.fontMd,
          color: AppColors.textPrimary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              nachricht.absenderName,
              style: const TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Text(
            _formatRelativeDate(context, nachricht.erstelltAm),
            style: const TextStyle(
              fontSize: DesignTokens.fontXs,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
      trailing: nachricht.wichtig
          ? Icon(
              Icons.star,
              color: AppColors.warning,
              size: DesignTokens.iconSm,
            )
          : null,
      onTap: onTap,
    );
  }
}

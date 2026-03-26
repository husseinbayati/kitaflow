import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_avatar.dart';
import '../../../core/widgets/kf_badge.dart';
import '../../../data/models/kind.dart';

/// Wiederverwendbare Listenzeile für ein Kind.
///
/// Zeigt Avatar, Name, Status-Badge, Alter und optionalen Gruppennamen.
class KindListTile extends StatelessWidget {
  const KindListTile({
    super.key,
    required this.kind,
    this.gruppeName,
    this.onTap,
  });

  /// Das anzuzeigende Kind.
  final Kind kind;

  /// Optionaler Gruppenname (z.B. "Sonnenblumen").
  final String? gruppeName;

  /// Callback bei Antippen der Zeile.
  final VoidCallback? onTap;

  Color _statusBadgeColor(ChildStatus status) {
    return switch (status) {
      ChildStatus.eingewoehnung => AppColors.warningLight,
      ChildStatus.abgemeldet => AppColors.errorLight,
      ChildStatus.warteliste => AppColors.infoLight,
      _ => AppColors.primaryLight,
    };
  }

  Color _statusTextColor(ChildStatus status) {
    return switch (status) {
      ChildStatus.eingewoehnung => AppColors.warning,
      ChildStatus.abgemeldet => AppColors.error,
      ChildStatus.warteliste => AppColors.info,
      _ => AppColors.primaryDark,
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spacing12,
          horizontal: DesignTokens.spacing16,
        ),
        child: Row(
          children: [
            KfAvatar(
              name: kind.vollstaendigerName,
              imageUrl: kind.avatarUrl,
              size: DesignTokens.avatarMd,
            ),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + optionaler Status-Badge
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          kind.vollstaendigerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: DesignTokens.fontMd,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (kind.status != ChildStatus.aktiv) ...[
                        const SizedBox(width: DesignTokens.spacing8),
                        KfBadge(
                          label: kind.status.label(context),
                          color: _statusBadgeColor(kind.status),
                          textColor: _statusTextColor(kind.status),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  // Alter + optionaler Gruppenname
                  Row(
                    children: [
                      Text(
                        context.l.common_yearsOld(kind.alter),
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSm,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (gruppeName != null) ...[
                        Text(
                          ' · $gruppeName',
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSm,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/kind.dart';
import '../../../core/extensions/l10n_extension.dart';

class KindStatusCard extends StatelessWidget {
  final Kind kind;
  final VoidCallback? onTap;

  const KindStatusCard({
    super.key,
    required this.kind,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: DesignTokens.avatarMd / 2,
                backgroundImage: kind.avatarUrl != null
                    ? NetworkImage(kind.avatarUrl!)
                    : null,
                child: kind.avatarUrl == null
                    ? Text(kind.initialen, style: const TextStyle(fontWeight: FontWeight.bold))
                    : null,
              ),
              const SizedBox(width: DesignTokens.spacing16),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kind.vollstaendigerName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing4),
                    Text(
                      context.l.common_yearsOld(kind.alter),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

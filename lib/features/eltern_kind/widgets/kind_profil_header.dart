import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../data/models/kind.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

class KindProfilHeader extends StatelessWidget {
  final Kind kind;

  const KindProfilHeader({super.key, required this.kind});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppGaps.v16,
        // Large avatar
        CircleAvatar(
          radius: DesignTokens.avatarXl / 2,
          backgroundImage:
              kind.avatarUrl != null ? NetworkImage(kind.avatarUrl!) : null,
          child: kind.avatarUrl == null
              ? Text(kind.initialen,
                  style: const TextStyle(
                      fontSize: DesignTokens.font2xl,
                      fontWeight: FontWeight.bold))
              : null,
        ),
        AppGaps.v16,
        Text(
          kind.vollstaendigerName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        AppGaps.v4,
        Text(
          context.l.common_yearsOld(kind.alter),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        AppGaps.v24,
        // Info rows
        _buildInfoRow(context, Icons.cake_outlined, context.l.eltern_kindBirthday,
            '${kind.geburtsdatum.day}.${kind.geburtsdatum.month}.${kind.geburtsdatum.year}'),
        _buildInfoRow(
            context, Icons.person_outlined, context.l.eltern_kindGender, kind.geschlecht),
        _buildInfoRow(context, Icons.badge_outlined, context.l.eltern_kindStatus,
            kind.status.label(context)),
        AppGaps.v16,
      ],
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing8),
      child: Row(
        children: [
          Icon(icon,
              size: DesignTokens.iconMd,
              color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        )),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/termin.dart';
import '../../../data/models/termin_rueckmeldung.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/termin_provider.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

class TerminCard extends StatelessWidget {
  final Termin termin;
  final TerminRueckmeldung? rueckmeldung;
  final Function(RsvpStatus)? onRsvp;

  const TerminCard({
    super.key,
    required this.termin,
    this.rueckmeldung,
    this.onRsvp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(color: _typColor.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Type badge + Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing8,
                    vertical: DesignTokens.spacing2,
                  ),
                  decoration: BoxDecoration(
                    color: _typColor.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusXs),
                  ),
                  child: Text(
                    termin.typ.label(context),
                    style: TextStyle(
                      fontSize: DesignTokens.fontXs,
                      color: _typColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing8),
                Expanded(
                  child: Text(
                    termin.titel,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            // Time
            if (termin.uhrzeitVon != null) ...[
              const SizedBox(height: DesignTokens.spacing8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: DesignTokens.iconSm,
                    color:
                        Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: DesignTokens.spacing4),
                  Text(
                    termin.uhrzeitBis != null
                        ? '${termin.uhrzeitVon} – ${termin.uhrzeitBis}'
                        : '${termin.uhrzeitVon} ${context.l.common_clock}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
            // Description
            if (termin.beschreibung != null &&
                termin.beschreibung!.isNotEmpty) ...[
              const SizedBox(height: DesignTokens.spacing8),
              Text(
                termin.beschreibung!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // RSVP Buttons (only for parents)
            Consumer<AuthProvider>(
              builder: (context, auth, _) {
                if (auth.currentRole != UserRole.eltern) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: [
                    const SizedBox(height: DesignTokens.spacing12),
                    const Divider(height: 1),
                    const SizedBox(height: DesignTokens.spacing12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: RsvpStatus.values
                          .map((status) {
                            final isSelected =
                                rueckmeldung?.status == status;
                            return _buildRsvpButton(
                                context, status, isSelected);
                          })
                          .toList(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRsvpButton(
      BuildContext context, RsvpStatus status, bool isSelected) {
    final Color color;
    final IconData icon;
    switch (status) {
      case RsvpStatus.zugesagt:
        color = AppColors.success;
        icon = Icons.check_circle_outline;
      case RsvpStatus.abgesagt:
        color = AppColors.error;
        icon = Icons.cancel_outlined;
      case RsvpStatus.vielleicht:
        color = AppColors.warning;
        icon = Icons.help_outline;
    }

    return TextButton.icon(
      onPressed: () {
        final auth = context.read<AuthProvider>();
        final userId = auth.user?.id;
        if (userId == null) return;
        context.read<TerminProvider>().respondToTermin(
              TerminRueckmeldung(
                id: rueckmeldung?.id ?? '',
                terminId: termin.id,
                elternId: userId,
                status: status,
                erstelltAm: DateTime.now(),
                aktualisiertAm: DateTime.now(),
              ),
            );
      },
      style: TextButton.styleFrom(
        foregroundColor: isSelected
            ? color
            : Theme.of(context).colorScheme.onSurfaceVariant,
        backgroundColor: isSelected ? color.withValues(alpha: 0.1) : null,
      ),
      icon: Icon(icon, size: DesignTokens.iconSm),
      label: Text(
        status.label(context),
        style: const TextStyle(fontSize: DesignTokens.fontXs),
      ),
    );
  }

  Color get _typColor {
    switch (termin.typ) {
      case TerminTyp.elternabend:
        return AppColors.primary;
      case TerminTyp.fest:
        return AppColors.success;
      case TerminTyp.schliessung:
        return AppColors.error;
      case TerminTyp.ausflug:
        return AppColors.info;
      default:
        return AppColors.secondary;
    }
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/extensions/l10n_extension.dart';

class ElternQuickActions extends StatelessWidget {
  final VoidCallback? onKrankmeldung;
  final VoidCallback? onNachricht;
  final VoidCallback? onTermine;

  const ElternQuickActions({
    super.key,
    this.onKrankmeldung,
    this.onNachricht,
    this.onTermine,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildAction(
          context,
          icon: Icons.sick_outlined,
          label: context.l.eltern_quickSickNote,
          color: AppColors.error,
          onTap: onKrankmeldung,
        ),
        const SizedBox(width: DesignTokens.spacing12),
        _buildAction(
          context,
          icon: Icons.mail_outlined,
          label: context.l.eltern_quickMessage,
          color: AppColors.primary,
          onTap: onNachricht,
        ),
        const SizedBox(width: DesignTokens.spacing12),
        _buildAction(
          context,
          icon: Icons.calendar_month_outlined,
          label: context.l.eltern_quickCalendar,
          color: AppColors.info,
          onTap: onTermine,
        ),
      ],
    );
  }

  Widget _buildAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: DesignTokens.spacing16,
            horizontal: DesignTokens.spacing8,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: DesignTokens.iconLg),
              const SizedBox(height: DesignTokens.spacing8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

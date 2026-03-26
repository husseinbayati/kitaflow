import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';

/// Wiederverwendbare Kachel für die Verwaltungsübersicht.
class VerwaltungTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int? count;
  final VoidCallback? onTap;

  const VerwaltungTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: DesignTokens.iconLg),
              ),
              const SizedBox(width: DesignTokens.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: DesignTokens.spacing4),
                    Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: DesignTokens.spacing8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacing12, vertical: DesignTokens.spacing4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                  ),
                  child: Text('$count', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
                ),
              ],
              const SizedBox(width: DesignTokens.spacing8),
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

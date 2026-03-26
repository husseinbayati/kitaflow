import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';

class AnwesenheitKalender extends StatelessWidget {
  const AnwesenheitKalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGaps.v16,
        Text(
          context.l.eltern_kindAttendanceTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        AppGaps.v12,
        // Simple placeholder — Phase 11 will add full calendar widget
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            side: BorderSide(color: Theme.of(context).dividerColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing24),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.calendar_month, size: DesignTokens.iconXl),
                  AppGaps.v12,
                  Text(context.l.eltern_kindAttendanceLoading),
                ],
              ),
            ),
          ),
        ),
        AppGaps.v16,
      ],
    );
  }
}

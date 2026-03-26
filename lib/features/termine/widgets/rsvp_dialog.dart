import 'package:flutter/material.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

class RsvpDialog extends StatelessWidget {
  final String terminTitel;
  final RsvpStatus? currentStatus;

  const RsvpDialog({
    super.key,
    required this.terminTitel,
    this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l.termine_rsvpTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.l.termine_rsvpFor(terminTitel)),
          const SizedBox(height: 16),
          ...RsvpStatus.values.map((status) {
            final isSelected = currentStatus == status;
            return ListTile(
              leading: Icon(
                _iconForStatus(status),
                color: isSelected ? _colorForStatus(status) : null,
              ),
              title: Text(status.label(context)),
              selected: isSelected,
              onTap: () => Navigator.of(context).pop(status),
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l.common_cancel),
        ),
      ],
    );
  }

  IconData _iconForStatus(RsvpStatus status) {
    switch (status) {
      case RsvpStatus.zugesagt:
        return Icons.check_circle;
      case RsvpStatus.abgesagt:
        return Icons.cancel;
      case RsvpStatus.vielleicht:
        return Icons.help;
    }
  }

  Color _colorForStatus(RsvpStatus status) {
    switch (status) {
      case RsvpStatus.zugesagt:
        return AppColors.success;
      case RsvpStatus.abgesagt:
        return AppColors.error;
      case RsvpStatus.vielleicht:
        return AppColors.warning;
    }
  }
}

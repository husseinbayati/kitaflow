import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';

/// Ergebnis der Statusauswahl.
class StatusAuswahlResult {
  final AttendanceStatus status;
  final String? notiz;

  const StatusAuswahlResult({required this.status, this.notiz});
}

/// Bottom-Sheet-Dialog zur Auswahl des Anwesenheitsstatus.
class StatusAuswahlDialog extends StatefulWidget {
  const StatusAuswahlDialog({super.key, this.currentStatus});

  /// Aktuell gesetzter Status (wird vorausgewählt).
  final AttendanceStatus? currentStatus;

  /// Zeigt den Dialog als modales Bottom Sheet an.
  /// Gibt ein [StatusAuswahlResult] zurück oder null bei Abbruch.
  static Future<StatusAuswahlResult?> show(
    BuildContext context, {
    AttendanceStatus? currentStatus,
  }) {
    return showModalBottomSheet<StatusAuswahlResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusLg),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: StatusAuswahlDialog(currentStatus: currentStatus),
      ),
    );
  }

  @override
  State<StatusAuswahlDialog> createState() => _StatusAuswahlDialogState();
}

class _StatusAuswahlDialogState extends State<StatusAuswahlDialog> {
  AttendanceStatus? _selected;
  final _notizController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selected = widget.currentStatus;
  }

  @override
  void dispose() {
    _notizController.dispose();
    super.dispose();
  }

  /// Farbe für den jeweiligen Status.
  Color _statusColor(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.anwesend => AppColors.success,
      AttendanceStatus.abwesend => AppColors.error,
      AttendanceStatus.krank => AppColors.warning,
      AttendanceStatus.urlaub => AppColors.info,
      AttendanceStatus.entschuldigt => AppColors.accent,
      AttendanceStatus.unentschuldigt => AppColors.error,
    };
  }

  /// Icon für den jeweiligen Status.
  IconData _statusIcon(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.anwesend => Icons.check_circle,
      AttendanceStatus.abwesend => Icons.cancel,
      AttendanceStatus.krank => Icons.sick,
      AttendanceStatus.urlaub => Icons.beach_access,
      AttendanceStatus.entschuldigt => Icons.event_busy,
      AttendanceStatus.unentschuldigt => Icons.warning,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Griff-Indikator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusFull),
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Titel
              Text(
                context.l.anwesenheit_statusDialogTitle,
                style: TextStyle(
                  fontSize: DesignTokens.fontLg,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Status-Optionen
              ...AttendanceStatus.values.map((status) {
                final isSelected = _selected == status;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: _statusColor(status),
                    child: Icon(
                      _statusIcon(status),
                      color: AppColors.textOnPrimary,
                      size: DesignTokens.iconSm,
                    ),
                  ),
                  title: Text(
                    status.label(context),
                    style: TextStyle(
                      fontSize: DesignTokens.fontMd,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  selected: isSelected,
                  onTap: () => setState(() => _selected = status),
                );
              }),

              const SizedBox(height: DesignTokens.spacing16),

              // Notiz-Feld
              KfTextField(
                label: context.l.anwesenheit_statusDialogNote,
                controller: _notizController,
                maxLines: 2,
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Bestätigen-Button
              KfButton(
                label: context.l.anwesenheit_statusDialogSetStatus,
                onPressed: _selected != null
                    ? () {
                        Navigator.of(context).pop(
                          StatusAuswahlResult(
                            status: _selected!,
                            notiz: _notizController.text.isNotEmpty
                                ? _notizController.text
                                : null,
                          ),
                        );
                      }
                    : null,
                isExpanded: true,
              ),
              const SizedBox(height: DesignTokens.spacing16),
            ],
          ),
        ),
      ),
    );
  }
}

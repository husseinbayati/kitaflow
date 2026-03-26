import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/datetime_extensions.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../presentation/providers/anwesenheit_provider.dart';
import '../../../presentation/providers/auth_provider.dart';

/// Krankmeldung-Screen für Eltern (und Personal).
///
/// Erlaubt das Melden von Krankheit, Entschuldigung oder Urlaub
/// für ein Kind mit optionaler Nachricht an die Einrichtung.
class KrankmeldungScreen extends StatefulWidget {
  const KrankmeldungScreen({super.key});

  @override
  State<KrankmeldungScreen> createState() => _KrankmeldungScreenState();
}

class _KrankmeldungScreenState extends State<KrankmeldungScreen> {
  AttendanceStatus _grund = AttendanceStatus.krank;
  final _notizController = TextEditingController();
  DateTime _datum = DateTime.now();

  /// Verfügbare Gründe für die Krankmeldung.
  static const _gruende = [
    AttendanceStatus.krank,
    AttendanceStatus.entschuldigt,
    AttendanceStatus.urlaub,
  ];

  @override
  void dispose() {
    _notizController.dispose();
    super.dispose();
  }

  /// Farbe für den jeweiligen Grund.
  Color _grundColor(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.krank => AppColors.warning,
      AttendanceStatus.entschuldigt => AppColors.accent,
      AttendanceStatus.urlaub => AppColors.info,
      _ => AppColors.textSecondary,
    };
  }

  /// Hintergrundfarbe für den jeweiligen Grund.
  Color _grundBgColor(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.krank => AppColors.warningLight,
      AttendanceStatus.entschuldigt => AppColors.accentLight,
      AttendanceStatus.urlaub => AppColors.infoLight,
      _ => AppColors.surfaceVariant,
    };
  }

  /// Datumsauswahl anzeigen.
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _datum,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      locale: const Locale('de'),
    );
    if (picked != null) {
      setState(() => _datum = picked);
    }
  }

  /// Krankmeldung absenden.
  Future<void> _senden() async {
    final authProvider = context.read<AuthProvider>();
    final anwesenheitProvider = context.read<AnwesenheitProvider>();

    final einrichtungId = authProvider.user?.einrichtungId;
    if (einrichtungId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keine Einrichtung zugeordnet.'),
        ),
      );
      return;
    }

    // TODO: Kind-ID aus Eltern-Kind-Verknüpfung ermitteln.
    // Aktuell Platzhalter — in der finalen Version wählt der Elternteil
    // sein Kind aus der eltern_kind-Tabelle aus.
    const kindId = '';
    if (kindId.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte wähle zuerst ein Kind aus.'),
        ),
      );
      return;
    }

    final notiz = _notizController.text.trim();
    final success = await anwesenheitProvider.markAbwesend(
      kindId,
      einrichtungId,
      _grund,
      notiz: notiz.isNotEmpty ? notiz : null,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l.anwesenheit_sickNoteSend),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.anwesenheit_sickNoteTitle)),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info-Text
            Text(
              context.l.anwesenheit_sickNoteDescription,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // Datum
            Text(
              context.l.anwesenheit_sickNoteDate,
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing8),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface,
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.textSecondary,
                    size: DesignTokens.iconSm,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing16,
                    vertical: DesignTokens.spacing12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusSm),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusSm),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
                child: Text(
                  _datum.formatDate,
                  style: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),

            // Grund
            Text(
              context.l.anwesenheit_sickNoteReason,
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing8),
            Wrap(
              spacing: DesignTokens.spacing8,
              runSpacing: DesignTokens.spacing8,
              children: _gruende.map((status) {
                final isSelected = _grund == status;
                return ChoiceChip(
                  label: Text(status.label(context)),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _grund = status);
                    }
                  },
                  selectedColor: _grundBgColor(status),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? _grundColor(status)
                        : AppColors.textPrimary,
                    fontSize: DesignTokens.fontSm,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: DesignTokens.spacing16),

            // Notiz
            KfTextField(
              label: context.l.anwesenheit_sickNoteMessage,
              hint: context.l.anwesenheit_sickNoteMessageHint,
              controller: _notizController,
              maxLines: 3,
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // Senden-Button
            Consumer<AnwesenheitProvider>(
              builder: (context, provider, _) {
                return KfButton(
                  label: context.l.anwesenheit_sickNoteSend,
                  icon: Icons.send,
                  onPressed: provider.isLoading ? null : _senden,
                  isLoading: provider.isLoading,
                  isExpanded: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

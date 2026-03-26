import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../data/models/eingewoehnung.dart';
import '../../../data/models/eingewoehnung_tagesnotiz.dart';
import '../../../presentation/providers/eingewoehnung_provider.dart';

/// Detailansicht einer einzelnen Eingewöhnung.
/// Zeigt Stammdaten, Phasen-Stepper, Phasenwechsel-Button und Tagesnotizen.
class EingewoehnungDetailScreen extends StatefulWidget {
  const EingewoehnungDetailScreen({super.key, required this.eingewoehnungId});

  final String eingewoehnungId;

  @override
  State<EingewoehnungDetailScreen> createState() =>
      _EingewoehnungDetailScreenState();
}

class _EingewoehnungDetailScreenState extends State<EingewoehnungDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<EingewoehnungProvider>()
          .loadDetail(widget.eingewoehnungId);
    });
  }

  Color _phaseColor(EingewoehnungPhase phase) => switch (phase) {
        EingewoehnungPhase.grundphase => AppColors.info,
        EingewoehnungPhase.stabilisierung => AppColors.warning,
        EingewoehnungPhase.schlussphase => AppColors.primary,
        EingewoehnungPhase.abgeschlossen => AppColors.success,
      };

  EingewoehnungPhase? _nextPhase(EingewoehnungPhase current) =>
      switch (current) {
        EingewoehnungPhase.grundphase => EingewoehnungPhase.stabilisierung,
        EingewoehnungPhase.stabilisierung => EingewoehnungPhase.schlussphase,
        EingewoehnungPhase.schlussphase => EingewoehnungPhase.abgeschlossen,
        EingewoehnungPhase.abgeschlossen => null,
      };

  String _formatDate(DateTime d) => '${d.day}.${d.month}.${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.eingewoehnung_title),
      ),
      body: Consumer<EingewoehnungProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final eingewoehnung = provider.selectedEingewoehnung;
          if (eingewoehnung == null) {
            return Center(
              child: Text(
                context.l.eingewoehnung_keineAktiven,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return SingleChildScrollView(
            padding: AppPadding.screen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(eingewoehnung),
                AppGaps.v16,
                _buildStepperCard(eingewoehnung),
                AppGaps.v16,
                _buildNextPhaseButton(eingewoehnung, provider),
                AppGaps.v24,
                _buildTagesnotizen(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header Card
  // ---------------------------------------------------------------------------

  Widget _buildHeaderCard(Eingewoehnung e) {
    return Card(
      child: Padding(
        padding: AppPadding.card,
        child: Column(
          children: [
            ListTile(
              leading:
                  Icon(Icons.child_care, color: AppColors.primary),
              title: Text('Kind ${e.kindId}'),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              leading: Icon(Icons.calendar_today,
                  color: AppColors.textSecondary),
              title: Text(context.l.eingewoehnung_startdatum),
              subtitle: Text(_formatDate(e.startdatum)),
              contentPadding: EdgeInsets.zero,
            ),
            if (e.bezugspersonId != null)
              ListTile(
                leading:
                    Icon(Icons.person, color: AppColors.textSecondary),
                title: Text(context.l.eingewoehnung_bezugsperson),
                subtitle: Text(e.bezugspersonId!),
                contentPadding: EdgeInsets.zero,
              ),
            ListTile(
              leading:
                  Icon(Icons.timer, color: AppColors.textSecondary),
              title: Text(
                context.l.eingewoehnung_tage(e.tageInEingewoehnung),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Phasen-Stepper
  // ---------------------------------------------------------------------------

  Widget _buildStepperCard(Eingewoehnung e) {
    final currentIndex = e.phase.index;

    return Card(
      child: Padding(
        padding: AppPadding.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l.eingewoehnung_phasenFortschritt,
              style: TextStyle(
                fontSize: DesignTokens.fontLg,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            AppGaps.v16,
            Row(
              children: List.generate(
                EingewoehnungPhase.values.length * 2 - 1,
                (i) {
                  // Ungerade Indizes = Verbindungslinie
                  if (i.isOdd) {
                    final stepBefore = i ~/ 2;
                    final isCompleted = stepBefore < currentIndex;
                    return Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted
                            ? AppColors.success
                            : AppColors.border,
                      ),
                    );
                  }

                  // Gerade Indizes = Phase-Punkt
                  final stepIndex = i ~/ 2;
                  final phase = EingewoehnungPhase.values[stepIndex];
                  final isDone = stepIndex <= currentIndex;
                  final color = _phaseColor(phase);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor:
                            isDone ? color : AppColors.surface,
                        foregroundColor:
                            isDone ? AppColors.textOnPrimary : color,
                        child: isDone
                            ? const Icon(Icons.check,
                                size: DesignTokens.iconSm)
                            : Text(
                                '${stepIndex + 1}',
                                style: TextStyle(
                                  fontSize: DesignTokens.fontXs,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                      AppGaps.v4,
                      Text(
                        phase.label(context),
                        style: TextStyle(
                          fontSize: DesignTokens.fontXs,
                          color: isDone
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Nächste Phase Button
  // ---------------------------------------------------------------------------

  Widget _buildNextPhaseButton(
      Eingewoehnung e, EingewoehnungProvider provider) {
    final next = _nextPhase(e.phase);
    if (next == null) return const SizedBox.shrink();

    return KfButton(
      label: context.l.eingewoehnung_naechstePhase,
      icon: Icons.arrow_forward,
      isExpanded: true,
      onPressed: () async {
        final success = await provider.updatePhase(e.id, next);
        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l.eingewoehnung_phaseGeaendert),
            ),
          );
        }
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Tagesnotizen
  // ---------------------------------------------------------------------------

  Widget _buildTagesnotizen(EingewoehnungProvider provider) {
    final notizen = provider.tagesnotizen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l.eingewoehnung_neueNotiz,
              style: TextStyle(
                fontSize: DesignTokens.fontLg,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO: Navigation zur Tagesnotiz-Erstellung
              },
              icon: Icon(Icons.add, color: AppColors.primary),
            ),
          ],
        ),
        AppGaps.v8,
        if (notizen.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spacing24),
              child: Text(
                context.l.eingewoehnung_keineTagesnotizen,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notizen.length,
            itemBuilder: (context, index) =>
                _buildTagesnotizCard(notizen[index]),
          ),
      ],
    );
  }

  Widget _buildTagesnotizCard(EingewoehnungTagesnotiz notiz) {
    return Card(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing8),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing16,
        ),
        title: Row(
          children: [
            Text(
              _formatDate(notiz.datum),
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (notiz.stimmung != null) ...[
              AppGaps.h8,
              Text(
                notiz.stimmung!.emoji,
                style: const TextStyle(fontSize: DesignTokens.fontLg),
              ),
            ],
          ],
        ),
        subtitle: notiz.dauerMinuten != null
            ? Text(
                '${context.l.eingewoehnung_dauer}: ${notiz.dauerMinuten} min',
                style: TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: AppColors.textSecondary,
                ),
              )
            : null,
        children: [
          Padding(
            padding: AppPadding.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notiz.trennungsverhalten != null)
                  _buildDetailRow(
                    context.l.eingewoehnung_trennungsverhalten,
                    '${notiz.trennungsverhalten}/5',
                  ),
                if (notiz.essen != null)
                  _buildDetailRow(
                      context.l.eingewoehnung_essen, notiz.essen!),
                if (notiz.schlaf != null)
                  _buildDetailRow(
                      context.l.eingewoehnung_schlaf, notiz.schlaf!),
                if (notiz.spiel != null)
                  _buildDetailRow(
                      context.l.eingewoehnung_spiel, notiz.spiel!),
                if (notiz.notizenIntern != null) ...[
                  AppGaps.v8,
                  Text(
                    context.l.eingewoehnung_notizenIntern,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppGaps.v4,
                  Text(notiz.notizenIntern!),
                ],
                if (notiz.notizenEltern != null) ...[
                  AppGaps.v8,
                  Text(
                    context.l.eingewoehnung_notizenEltern,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppGaps.v4,
                  Text(notiz.notizenEltern!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacing4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: DesignTokens.fontSm,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: DesignTokens.fontSm),
            ),
          ),
        ],
      ),
    );
  }
}

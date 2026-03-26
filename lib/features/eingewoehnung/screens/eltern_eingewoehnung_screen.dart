import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../presentation/providers/eingewoehnung_provider.dart';
import '../../../presentation/providers/eltern_home_provider.dart';

/// Eltern-Ansicht der Eingewöhnung ihres Kindes.
/// Zeigt Phasen-Fortschritt, Tagesnotizen (nur Eltern-Notizen) und
/// ein Feedback-Formular.
class ElternEingewoehnungScreen extends StatefulWidget {
  const ElternEingewoehnungScreen({super.key});

  @override
  State<ElternEingewoehnungScreen> createState() =>
      _ElternEingewoehnungScreenState();
}

class _ElternEingewoehnungScreenState
    extends State<ElternEingewoehnungScreen> {
  final _feedbackController = TextEditingController();
  bool _feedbackSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final elternHome = context.read<ElternHomeProvider>();
    final provider = context.read<EingewoehnungProvider>();

    // Lade Eingewöhnungen für alle Kinder der Eltern
    for (final kind in elternHome.meineKinder) {
      await provider.loadByKindId(kind.id);
    }

    // Lade Details der ersten aktiven Eingewöhnung
    final aktive = provider.aktiveEingewoehnungen;
    if (aktive.isNotEmpty) {
      await provider.loadDetail(aktive.first.id);
      if (mounted) {
        _feedbackController.text =
            provider.selectedEingewoehnung?.elternFeedback ?? '';
      }
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.eingewoehnung_title)),
      body: Consumer<EingewoehnungProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.aktiveEingewoehnungen.isEmpty) {
            return Center(
              child: Padding(
                padding: AppPadding.screen,
                child: Text(
                  context.l.eingewoehnung_keineAktiven,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppPadding.screen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final eingewoehnung
                      in provider.aktiveEingewoehnungen) ...[
                    // Phase Stepper
                    _buildPhaseStepper(context, eingewoehnung),
                    AppGaps.v24,

                    // Tagesnotizen (nur Eltern-Notizen)
                    Text(
                      context.l.eingewoehnung_notizenEltern,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    AppGaps.v12,
                    _buildTagesnotizen(context, provider),
                    AppGaps.v24,

                    // Feedback-Formular
                    _buildFeedbackForm(context, provider, eingewoehnung),
                    AppGaps.v32,
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Phase Stepper
  // ---------------------------------------------------------------------------

  Widget _buildPhaseStepper(
      BuildContext context, dynamic eingewoehnung) {
    final currentPhase = eingewoehnung.phase as EingewoehnungPhase;
    final phases = EingewoehnungPhase.values;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l.eingewoehnung_phasenFortschritt,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppGaps.v16,
            Row(
              children: [
                for (int i = 0; i < phases.length; i++) ...[
                  if (i > 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: phases[i].index <= currentPhase.index
                            ? _phaseColor(phases[i])
                            : AppColors.border,
                      ),
                    ),
                  _buildPhaseCircle(
                    context,
                    index: i,
                    phase: phases[i],
                    isActive: phases[i].index <= currentPhase.index,
                  ),
                ],
              ],
            ),
            AppGaps.v8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: phases.map((phase) {
                return Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      phase.label(context),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                            color: phase.index <= currentPhase.index
                                ? _phaseColor(phase)
                                : AppColors.textSecondary,
                            fontWeight: phase == currentPhase
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
            AppGaps.v12,
            Text(
              context.l.eingewoehnung_tage(
                  eingewoehnung.tageInEingewoehnung),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseCircle(
    BuildContext context, {
    required int index,
    required EingewoehnungPhase phase,
    required bool isActive,
  }) {
    final color = isActive ? _phaseColor(phase) : AppColors.border;

    return CircleAvatar(
      radius: 14,
      backgroundColor: color,
      child: Text(
        '${index + 1}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }

  Color _phaseColor(EingewoehnungPhase phase) {
    return switch (phase) {
      EingewoehnungPhase.grundphase => AppColors.info,
      EingewoehnungPhase.stabilisierung => AppColors.warning,
      EingewoehnungPhase.schlussphase => AppColors.primary,
      EingewoehnungPhase.abgeschlossen => AppColors.success,
    };
  }

  // ---------------------------------------------------------------------------
  // Tagesnotizen (nur Eltern-sichtbare Felder)
  // ---------------------------------------------------------------------------

  Widget _buildTagesnotizen(
      BuildContext context, EingewoehnungProvider provider) {
    if (provider.tagesnotizen.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing16),
        child: Center(
          child: Text(
            context.l.eingewoehnung_keineTagesnotizen,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      );
    }

    final dateFormat = DateFormat('dd.MM.yyyy');

    return Column(
      children: provider.tagesnotizen.map((notiz) {
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: DesignTokens.spacing8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            side: BorderSide(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dateFormat.format(notiz.datum),
                      style:
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    if (notiz.stimmung != null) ...[
                      AppGaps.h8,
                      Text(
                        notiz.stimmung!.emoji,
                        style: const TextStyle(
                            fontSize: DesignTokens.fontLg),
                      ),
                    ],
                  ],
                ),
                if (notiz.notizenEltern != null &&
                    notiz.notizenEltern!.isNotEmpty) ...[
                  AppGaps.v8,
                  Text(
                    notiz.notizenEltern!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // Feedback-Formular
  // ---------------------------------------------------------------------------

  Widget _buildFeedbackForm(
    BuildContext context,
    EingewoehnungProvider provider,
    dynamic eingewoehnung,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l.eingewoehnung_feedbackFrage,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppGaps.v12,
            TextFormField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: context.l.eingewoehnung_elternFeedback,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(DesignTokens.radiusSm),
                ),
              ),
            ),
            AppGaps.v12,
            KfButton(
              label: context.l.common_save,
              isLoading: _feedbackSaving,
              isExpanded: true,
              onPressed: () => _saveFeedback(provider, eingewoehnung),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveFeedback(
    EingewoehnungProvider provider,
    dynamic eingewoehnung,
  ) async {
    setState(() => _feedbackSaving = true);

    final updated = eingewoehnung.copyWith(
      elternFeedback: _feedbackController.text.trim(),
    );

    final success = await provider.updateEingewoehnung(updated);

    if (mounted) {
      setState(() => _feedbackSaving = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.eingewoehnung_feedbackGespeichert)),
        );
      }
    }
  }
}

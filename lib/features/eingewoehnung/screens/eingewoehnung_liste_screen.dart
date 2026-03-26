import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/eingewoehnung.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/eingewoehnung_provider.dart';

/// Listenansicht aller Eingewöhnungen einer Einrichtung.
/// Zeigt Filtermöglichkeit nach Phase und FAB zum Erstellen.
class EingewoehnungListeScreen extends StatefulWidget {
  const EingewoehnungListeScreen({super.key});

  @override
  State<EingewoehnungListeScreen> createState() =>
      _EingewoehnungListeScreenState();
}

class _EingewoehnungListeScreenState extends State<EingewoehnungListeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final einrichtungId =
          context.read<AuthProvider>().user?.einrichtungId;
      if (einrichtungId != null) {
        context
            .read<EingewoehnungProvider>()
            .loadEingewoehnungen(einrichtungId);
      }
    });
  }

  Color _phaseColor(EingewoehnungPhase phase) => switch (phase) {
        EingewoehnungPhase.grundphase => AppColors.info,
        EingewoehnungPhase.stabilisierung => AppColors.warning,
        EingewoehnungPhase.schlussphase => AppColors.primary,
        EingewoehnungPhase.abgeschlossen => AppColors.success,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.eingewoehnung_title),
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(child: _buildList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/verwaltung/eingewoehnung/neu'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Consumer<EingewoehnungProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing16,
            vertical: DesignTokens.spacing8,
          ),
          child: Row(
            children: [
              FilterChip(
                label: const Text('Alle'),
                selected: provider.filterPhase == null,
                onSelected: (_) => provider.setFilterPhase(null),
              ),
              AppGaps.h8,
              ...EingewoehnungPhase.values.map(
                (phase) => Padding(
                  padding: const EdgeInsets.only(right: DesignTokens.spacing8),
                  child: FilterChip(
                    label: Text(phase.label(context)),
                    selected: provider.filterPhase == phase,
                    onSelected: (_) => provider.setFilterPhase(
                      provider.filterPhase == phase ? null : phase,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList() {
    return Consumer<EingewoehnungProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline,
                    size: DesignTokens.iconXl, color: AppColors.error),
                AppGaps.v8,
                Text(
                  provider.errorMessage ?? context.l.common_error,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        final liste = provider.filteredEingewoehnungen;

        if (liste.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.child_care,
                    size: DesignTokens.iconXl, color: AppColors.textHint),
                AppGaps.v8,
                Text(
                  context.l.eingewoehnung_keineAktiven,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            final einrichtungId =
                context.read<AuthProvider>().user?.einrichtungId;
            if (einrichtungId != null) {
              await context
                  .read<EingewoehnungProvider>()
                  .loadEingewoehnungen(einrichtungId);
            }
          },
          child: ListView.separated(
            padding: AppPadding.screen,
            itemCount: liste.length,
            separatorBuilder: (_, __) => AppGaps.v8,
            itemBuilder: (context, index) =>
                _buildEingewoehnungCard(liste[index]),
          ),
        );
      },
    );
  }

  Widget _buildEingewoehnungCard(Eingewoehnung e) {
    final color = _phaseColor(e.phase);

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(Icons.child_care, color: color),
        ),
        title: Text('Kind ${e.kindId}'),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing8,
                vertical: DesignTokens.spacing2,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(DesignTokens.radiusXs),
              ),
              child: Text(
                e.phase.label(context),
                style: TextStyle(
                  fontSize: DesignTokens.fontXs,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            AppGaps.h8,
            Text(
              context.l.eingewoehnung_tage(e.tageInEingewoehnung),
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        trailing: e.istAbgeschlossen
            ? Icon(Icons.check_circle, color: AppColors.success)
            : null,
        onTap: () {
          context.read<EingewoehnungProvider>().selectEingewoehnung(e);
          context.go('/verwaltung/eingewoehnung/${e.id}');
        },
      ),
    );
  }
}

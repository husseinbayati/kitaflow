import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_dialog.dart';
import '../../../core/widgets/kf_empty_state.dart';
import '../../../core/widgets/kf_loading.dart';
import '../../../data/models/essensplan.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/essensplan_provider.dart';
import '../widgets/allergen_warnung_banner.dart';
import '../widgets/tages_card.dart';
import 'essensplan_form_screen.dart';

/// Hauptbildschirm für den Wochenplan (Essensplan).
///
/// Zeigt eine Wochenübersicht (Mo–Fr) mit Navigation zwischen Wochen,
/// Allergen-Warnungen und CRUD-Aktionen pro Mahlzeit.
class EssensplanScreen extends StatefulWidget {
  const EssensplanScreen({super.key});

  @override
  State<EssensplanScreen> createState() => _EssensplanScreenState();
}

class _EssensplanScreenState extends State<EssensplanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final einrichtungId =
        context.read<AuthProvider>().user?.einrichtungId;
    if (einrichtungId != null) {
      context.read<EssensplanProvider>().loadWochenplan(einrichtungId);
    }
  }

  Future<void> _openForm(BuildContext context, DateTime datum,
      [Essensplan? plan]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EssensplanFormScreen(
          initialDatum: datum,
          existingPlan: plan,
        ),
      ),
    );
  }

  Future<void> _deleteMahlzeit(Essensplan plan) async {
    final confirmed = await KfConfirmDialog.show(
      context,
      title: context.l.essensplan_deleteMeal,
      message:
          'Möchtest du „${plan.gerichtName}" wirklich löschen?',
      confirmLabel: context.l.common_delete,
      isDanger: true,
    );

    if (confirmed && mounted) {
      await context.read<EssensplanProvider>().deleteEssensplan(plan.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.essensplan_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            tooltip: context.l.essensplan_previousWeek,
            onPressed: () {
              context.read<EssensplanProvider>().navigateWeek(-1);
            },
          ),
          Consumer<EssensplanProvider>(
            builder: (context, provider, _) {
              return TextButton(
                onPressed: () => provider.goToCurrentWeek(),
                child: Text(
                  provider.kalenderWocheText,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSm,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            tooltip: context.l.essensplan_nextWeek,
            onPressed: () {
              context.read<EssensplanProvider>().navigateWeek(1);
            },
          ),
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: context.l.essensplan_currentWeek,
            onPressed: () {
              context.read<EssensplanProvider>().goToCurrentWeek();
            },
          ),
        ],
      ),
      body: Consumer<EssensplanProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const KfShimmerList();
          }

          if (provider.hasError) {
            return Center(
              child: Padding(
                padding: AppPadding.screen,
                child: Text(
                  provider.errorMessage ?? context.l.common_error,
                  style: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    color: AppColors.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (provider.wochenplan.isEmpty) {
            return KfEmptyState(
              icon: Icons.restaurant_menu,
              title: context.l.essensplan_noMealPlan,
              subtitle: context.l.essensplan_noMealsPlanned,
            );
          }

          return ListView.builder(
            padding: AppPadding.screen,
            itemCount: 5 + (provider.warnungen.isNotEmpty ? 1 : 0),
            itemBuilder: (context, index) {
              // Allergen-Warnungsbanner als erstes Element
              if (provider.warnungen.isNotEmpty && index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: DesignTokens.spacing16,
                  ),
                  child: AllergenWarnungBanner(
                    warnungen: provider.warnungen,
                  ),
                );
              }

              final dayIndex =
                  provider.warnungen.isNotEmpty ? index - 1 : index;
              final date = provider.selectedMontag
                  .add(Duration(days: dayIndex));

              return Padding(
                padding: const EdgeInsets.only(
                  bottom: DesignTokens.spacing16,
                ),
                child: TagesCard(
                  datum: date,
                  mahlzeiten: provider.planForDate(date),
                  onAddMahlzeit: () => _openForm(context, date),
                  onEditMahlzeit: (plan) =>
                      _openForm(context, date, plan),
                  onDeleteMahlzeit: (plan) => _deleteMahlzeit(plan),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context, DateTime.now()),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

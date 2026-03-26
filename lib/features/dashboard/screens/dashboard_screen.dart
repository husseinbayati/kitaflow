import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/widgets/kf_card.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/anwesenheit_provider.dart';
import '../../../presentation/providers/nachricht_provider.dart';
import '../../../presentation/providers/essensplan_provider.dart';
import '../../../presentation/providers/kind_provider.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../presentation/providers/dashboard_provider.dart';
import '../widgets/dashboard_greeting.dart';
import '../widgets/quick_stats_row.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/dashboard_section.dart';
import '../widgets/essensplan_kompakt.dart';
import '../widgets/nachrichten_kompakt.dart';

/// Dashboard-Screen — Haupteinstiegspunkt nach dem Login.
/// Aggregiert Daten aus mehreren Providern und zeigt eine Übersicht
/// mit Begrüßung, Statistiken, Alerts, Schnellaktionen, Essensplan und Nachrichten.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final authProvider = context.read<AuthProvider>();
    final einrichtungId = authProvider.user?.einrichtungId;
    if (einrichtungId == null) return;

    // Alle Provider parallel laden
    await Future.wait([
      context.read<AnwesenheitProvider>().loadHeute(einrichtungId),
      context.read<NachrichtProvider>().loadNachrichten(einrichtungId),
      context.read<EssensplanProvider>().loadWochenplan(einrichtungId),
      context.read<KindProvider>().loadKinder(einrichtungId),
    ]);

    // Alerts berechnen nachdem alle Daten geladen sind
    if (!mounted) return;
    context.read<DashboardProvider>().berechneAlerts(
      allergenWarnungen: context.read<EssensplanProvider>().warnungen,
      kinder: context.read<KindProvider>().kinder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.dashboard_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              context.go(AppRoutes.nachrichten);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppPadding.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. Begrüßung ---
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  final dashboardProvider = context.read<DashboardProvider>();
                  return DashboardGreeting(
                    vorname: auth.user?.vorname ?? '',
                    rolle: auth.user?.rolle ?? auth.currentRole!,
                    datumText: dashboardProvider.formatDatum(DateTime.now()),
                  );
                },
              ),
              AppGaps.v24,

              // --- 2. Quick Stats ---
              Consumer3<AnwesenheitProvider, NachrichtProvider, KindProvider>(
                builder: (context, anwesenheit, nachricht, kind, _) {
                  return QuickStatsRow(
                    anwesend: anwesenheit.anwesendCount,
                    gesamt: anwesenheit.gesamtCount,
                    ungelesen: nachricht.unreadCount,
                    krank: anwesenheit.krankCount,
                    onAnwesendTap: () => context.go(AppRoutes.anwesenheit),
                    onNachrichtenTap: () => context.go(AppRoutes.nachrichten),
                    onKrankTap: () => context.go(AppRoutes.anwesenheit),
                  );
                },
              ),
              AppGaps.v24,

              // --- 3. Alerts ---
              Consumer<DashboardProvider>(
                builder: (context, dashboard, _) {
                  if (!dashboard.hasAlerts) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DashboardSection(title: context.l.dashboard_hints),
                      AppGaps.v8,
                      ...dashboard.alerts.map((alert) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: DesignTokens.spacing8,
                          ),
                          child: KfInfoCard(
                            title: alert.titel,
                            subtitle: alert.nachricht,
                            icon: alert.icon,
                            borderColor: alert.farbe,
                          ),
                        );
                      }),
                      AppGaps.v16,
                    ],
                  );
                },
              ),

              // --- 4. Schnellaktionen ---
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  final rolle = auth.user?.rolle;
                  if (rolle == null) return const SizedBox.shrink();
                  return QuickActionsRow(
                    rolle: rolle,
                    onCheckIn: () => context.go(AppRoutes.anwesenheit),
                    onNachricht: () => context.go(AppRoutes.nachrichtenNeu),
                    onKindNeu: () => context.go(AppRoutes.kinderNeu),
                  );
                },
              ),
              AppGaps.v24,

              // --- 5. Essensplan heute ---
              DashboardSection(
                title: context.l.dashboard_mealPlanToday,
                actionLabel: context.l.common_showAll,
                onAction: () => context.go(AppRoutes.essensplan),
              ),
              AppGaps.v8,
              Consumer<EssensplanProvider>(
                builder: (context, essensplan, _) {
                  return EssensplanKompakt(
                    heutigeMahlzeiten: essensplan.planForDate(DateTime.now()),
                  );
                },
              ),
              AppGaps.v24,

              // --- 6. Nachrichten ---
              DashboardSection(
                title: context.l.dashboard_messages,
                actionLabel: context.l.common_showAll,
                onAction: () => context.go(AppRoutes.nachrichten),
              ),
              AppGaps.v8,
              Consumer<NachrichtProvider>(
                builder: (context, nachricht, _) {
                  return NachrichtenKompakt(
                    nachrichten: nachricht.empfangene.take(3).toList(),
                  );
                },
              ),
              AppGaps.v32,
            ],
          ),
        ),
      ),
    );
  }
}

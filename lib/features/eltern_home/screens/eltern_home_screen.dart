import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/routing/route_constants.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/eltern_home_provider.dart';
import '../../../presentation/providers/dashboard_provider.dart';
import '../widgets/kind_status_card.dart';
import '../widgets/eltern_quick_actions.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/enums.dart';

class ElternHomeScreen extends StatefulWidget {
  const ElternHomeScreen({super.key});

  @override
  State<ElternHomeScreen> createState() => _ElternHomeScreenState();
}

class _ElternHomeScreenState extends State<ElternHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final authProvider = context.read<AuthProvider>();
    final userId = authProvider.user?.id;
    if (userId == null) return;

    await context.read<ElternHomeProvider>().loadDashboard(userId);
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.read<DashboardProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.eltern_homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go(AppRoutes.elternNachrichten),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Consumer2<AuthProvider, ElternHomeProvider>(
          builder: (context, auth, elternHome, _) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppPadding.screen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Begrüßung
                  Text(
                    '${dashboardProvider.getGreeting()}, ${auth.user?.vorname ?? ''}!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppGaps.v4,
                  Text(
                    dashboardProvider.formatDatum(DateTime.now()),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  AppGaps.v24,

                  // Ladezustand / Fehler
                  if (elternHome.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (elternHome.hasError)
                    Center(child: Text(elternHome.errorMessage ?? context.l.common_error))
                  else ...[
                    // Meine Kinder
                    Text(
                      context.l.eltern_homeMyChildren,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppGaps.v12,
                    if (elternHome.meineKinder.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(DesignTokens.spacing32),
                          child: Text(context.l.eltern_homeNoChildren),
                        ),
                      )
                    else
                      ...elternHome.meineKinder.map((kind) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
                          child: KindStatusCard(
                            kind: kind,
                            onTap: () => context.go('${AppRoutes.elternKinder}/${kind.id}'),
                          ),
                        );
                      }),
                    // Eingewöhnung-Banner
                    ...elternHome.meineKinder
                        .where((kind) => kind.status == ChildStatus.eingewoehnung)
                        .map((kind) => Padding(
                              padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
                              child: Card(
                                color: AppColors.warningLight,
                                child: ListTile(
                                  leading: Icon(Icons.child_care, color: AppColors.warning),
                                  title: Text('${kind.vorname} ${kind.nachname}'),
                                  subtitle: Text(context.l.eingewoehnung_title),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () => context.go('/eltern/eingewoehnung'),
                                ),
                              ),
                            )),

                    AppGaps.v24,

                    // Schnellaktionen
                    Text(
                      context.l.eltern_homeQuickActions,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppGaps.v12,
                    ElternQuickActions(
                      onKrankmeldung: () => context.go(AppRoutes.elternKrankmeldung),
                      onNachricht: () => context.go(AppRoutes.elternNachrichten),
                      onTermine: () => context.go(AppRoutes.elternTermine),
                    ),
                    AppGaps.v32,
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

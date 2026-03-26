import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/gruppe_provider.dart';
import '../../../core/extensions/l10n_extension.dart';

class GruppenListeScreen extends StatefulWidget {
  const GruppenListeScreen({super.key});
  @override
  State<GruppenListeScreen> createState() => _GruppenListeScreenState();
}

class _GruppenListeScreenState extends State<GruppenListeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final einrichtungId = context.read<AuthProvider>().user?.einrichtungId;
    if (einrichtungId == null) return;
    await context.read<GruppeProvider>().loadGruppen(einrichtungId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.verwaltung_groupsListTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutes.verwaltungGruppeNeu),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Consumer<GruppeProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.hasError) {
              return Center(
                child: Text(provider.errorMessage ?? context.l.common_error),
              );
            }
            if (provider.gruppen.isEmpty) {
              return Center(
                child: Text(context.l.verwaltung_groupsEmpty),
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppPadding.screen,
              itemCount: provider.gruppen.length,
              itemBuilder: (context, index) {
                final gruppe = provider.gruppen[index];
                final belegung = provider.belegungForGruppe(gruppe.id);
                final maxKinder = gruppe.maxKinder;

                // Parse color from hex string
                Color? gruppenFarbe;
                if (gruppe.farbe != null && gruppe.farbe!.isNotEmpty) {
                  try {
                    gruppenFarbe = Color(
                      int.parse(
                        gruppe.farbe!.replaceFirst('#', '0xFF'),
                      ),
                    );
                  } catch (_) {}
                }

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(
                    bottom: DesignTokens.spacing8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusMd,
                    ),
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: gruppenFarbe ?? AppColors.primary,
                      radius: 20,
                      child: Text(
                        gruppe.name.isNotEmpty ? gruppe.name[0] : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(gruppe.name),
                    subtitle: Text(
                      maxKinder != null
                          ? context.l.verwaltung_groupsOccupancyWithMax(belegung, maxKinder)
                          : context.l.verwaltung_groupsOccupancy(belegung),
                    ),
                    trailing: gruppe.aktiv
                        ? null
                        : Chip(
                            label: Text(context.l.verwaltung_groupsInactive),
                            backgroundColor:
                                AppColors.error.withValues(alpha: 0.1),
                          ),
                    onTap: () => context.go(
                      '/verwaltung/gruppen/${gruppe.id}/bearbeiten',
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

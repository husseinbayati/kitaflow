import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_empty_state.dart';
import '../../../core/widgets/kf_loading.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/kind_provider.dart';
import '../widgets/kind_list_tile.dart';

/// Hauptscreen für die Kinderliste.
///
/// Zeigt alle Kinder der Einrichtung mit Such- und Filterfunktion.
class KinderListeScreen extends StatefulWidget {
  const KinderListeScreen({super.key});

  @override
  State<KinderListeScreen> createState() => _KinderListeScreenState();
}

class _KinderListeScreenState extends State<KinderListeScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadKinder();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadKinder() {
    final einrichtungId = context.read<AuthProvider>().user?.einrichtungId;
    if (einrichtungId != null) {
      context.read<KindProvider>().loadKinder(einrichtungId);
    }
  }

  String? get _einrichtungId {
    return context.read<AuthProvider>().user?.einrichtungId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: context.l.kinder_search,
                  hintStyle: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    color: AppColors.textHint,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  final kindProvider = context.read<KindProvider>();
                  kindProvider.setFilter(
                    gruppeId: kindProvider.filterGruppeId,
                    status: kindProvider.filterStatus,
                    suchbegriff: value,
                  );
                },
              )
            : Text(context.l.kinder_title),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  final kindProvider = context.read<KindProvider>();
                  kindProvider.setFilter(
                    gruppeId: kindProvider.filterGruppeId,
                    status: kindProvider.filterStatus,
                    suchbegriff: null,
                  );
                }
              });
            },
          ),
        ],
      ),
      body: Consumer<KindProvider>(
        builder: (context, kindProvider, _) {
          if (kindProvider.isLoading) {
            return const KfShimmerList();
          }

          if (kindProvider.hasError) {
            return Center(
              child: Text(
                kindProvider.errorMessage ?? context.l.kinder_errorOccurred,
                style: const TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          final filteredKinder = kindProvider.filteredKinder;
          final gruppen = kindProvider.gruppen;

          return Column(
            children: [
              // Filter-Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing16,
                  vertical: DesignTokens.spacing8,
                ),
                child: Row(
                  children: [
                    // Gruppen-Filter
                    ...gruppen.map(
                      (gruppe) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: DesignTokens.spacing8,
                        ),
                        child: FilterChip(
                          label: Text(gruppe.name),
                          selected: kindProvider.filterGruppeId == gruppe.id,
                          onSelected: (selected) {
                            kindProvider.setFilter(
                              gruppeId: selected ? gruppe.id : null,
                              status: kindProvider.filterStatus,
                              suchbegriff: kindProvider.suchbegriff,
                            );
                          },
                          selectedColor: AppColors.primaryLight,
                          checkmarkColor: AppColors.primaryDark,
                        ),
                      ),
                    ),
                    // Status-Filter
                    ...ChildStatus.values.map(
                      (status) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: DesignTokens.spacing8,
                        ),
                        child: FilterChip(
                          label: Text(status.label(context)),
                          selected: kindProvider.filterStatus == status.name,
                          onSelected: (selected) {
                            kindProvider.setFilter(
                              gruppeId: kindProvider.filterGruppeId,
                              status: selected ? status.name : null,
                              suchbegriff: kindProvider.suchbegriff,
                            );
                          },
                          selectedColor: AppColors.primaryLight,
                          checkmarkColor: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Kinderliste
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    final einrichtungId = _einrichtungId;
                    if (einrichtungId != null) {
                      await kindProvider.loadKinder(einrichtungId);
                    }
                  },
                  child: filteredKinder.isEmpty
                      ? ListView(
                          // ListView nötig damit RefreshIndicator funktioniert
                          children: [
                            KfEmptyState(
                              title: context.l.kinder_notFound,
                              icon: Icons.child_care,
                              subtitle: context.l.kinder_notFoundDescription,
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemCount: filteredKinder.length,
                          separatorBuilder: (_, __) => const Divider(
                            height: 1,
                            color: AppColors.divider,
                          ),
                          itemBuilder: (context, index) {
                            final kind = filteredKinder[index];
                            final gruppeName = kind.gruppeId != null
                                ? gruppen
                                    .where((g) => g.id == kind.gruppeId)
                                    .map((g) => g.name)
                                    .firstOrNull
                                : null;

                            return KindListTile(
                              kind: kind,
                              gruppeName: gruppeName,
                              onTap: () => context.go('/kinder/${kind.id}'),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          final rolle = authProvider.currentRole;
          final darfHinzufuegen = rolle == UserRole.erzieher ||
              rolle == UserRole.leitung ||
              rolle == UserRole.lehrer;

          if (!darfHinzufuegen) return const SizedBox.shrink();

          return FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: Text(context.l.kinder_addChild),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            onPressed: () => context.go('/kinder/neu'),
          );
        },
      ),
    );
  }
}

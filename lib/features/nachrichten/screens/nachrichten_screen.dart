import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_empty_state.dart';
import '../../../core/widgets/kf_loading.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/nachricht_provider.dart';
import '../widgets/nachricht_list_item.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

/// Hauptscreen für Nachrichten mit Tabs (Posteingang, Gesendet, Wichtig),
/// Typ-Filter-Chips und Pull-to-Refresh.
class NachrichtenScreen extends StatefulWidget {
  const NachrichtenScreen({super.key});

  @override
  State<NachrichtenScreen> createState() => _NachrichtenScreenState();
}

class _NachrichtenScreenState extends State<NachrichtenScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  String? get _einrichtungId {
    return context.read<AuthProvider>().user?.einrichtungId;
  }

  void _loadData() {
    final einrichtungId = _einrichtungId;
    if (einrichtungId != null) {
      final provider = context.read<NachrichtProvider>();
      provider.loadNachrichten(einrichtungId);
      provider.subscribeRealtime(einrichtungId);
    }
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
    final tab = NachrichtenTab.values[_tabController.index];
    context.read<NachrichtProvider>().setActiveTab(tab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.nachrichten_title),
        bottom: TabBar(
          controller: _tabController,
          tabs: NachrichtenTab.values
              .map((tab) => Tab(text: tab.label(context)))
              .toList(),
        ),
      ),
      body: Consumer<NachrichtProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const KfShimmerList();
          }

          if (provider.hasError) {
            return Center(
              child: Text(
                provider.errorMessage ?? context.l.common_error,
                style: const TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return Column(
            children: [
              // Filter-Chips für Nachrichtentyp
              _buildFilterChips(provider),

              // TabBarView mit Listen
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildNachrichtenListe(
                      provider,
                      emptyTitle: context.l.nachrichten_noMessages,
                      emptySubtitle:
                          context.l.nachrichten_inboxEmpty,
                      emptyIcon: Icons.inbox,
                    ),
                    _buildNachrichtenListe(
                      provider,
                      emptyTitle: context.l.nachrichten_noSentMessages,
                      emptySubtitle:
                          context.l.nachrichten_noSentDescription,
                      emptyIcon: Icons.send,
                    ),
                    _buildNachrichtenListe(
                      provider,
                      emptyTitle: context.l.nachrichten_noImportant,
                      emptySubtitle:
                          context.l.nachrichten_noImportantDescription,
                      emptyIcon: Icons.star_border,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/nachrichten/neu'),
        child: const Icon(Icons.edit),
      ),
    );
  }

  /// Horizontale FilterChip-Reihe für Nachrichtentyp-Filter.
  Widget _buildFilterChips(NachrichtProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing16,
        vertical: DesignTokens.spacing8,
      ),
      child: Row(
        children: [
          // "Alle" Chip
          Padding(
            padding: const EdgeInsetsDirectional.only(end: DesignTokens.spacing8),
            child: FilterChip(
              label: Text(context.l.nachrichten_all),
              selected: provider.filterTyp == null,
              onSelected: (_) {
                provider.setFilterTyp(null);
              },
              selectedColor: AppColors.primaryLight,
              checkmarkColor: AppColors.primaryDark,
            ),
          ),
          // Je ein Chip pro MessageType
          ...MessageType.values.map(
            (typ) => Padding(
              padding: const EdgeInsetsDirectional.only(end: DesignTokens.spacing8),
              child: FilterChip(
                label: Text(typ.label(context)),
                selected: provider.filterTyp == typ,
                onSelected: (selected) {
                  provider.setFilterTyp(selected ? typ : null);
                },
                selectedColor: AppColors.primaryLight,
                checkmarkColor: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ListView mit Pull-to-Refresh und Empty State.
  Widget _buildNachrichtenListe(
    NachrichtProvider provider, {
    required String emptyTitle,
    required String emptySubtitle,
    required IconData emptyIcon,
  }) {
    final nachrichten = provider.filteredNachrichten;

    return RefreshIndicator(
      onRefresh: () async {
        final einrichtungId = _einrichtungId;
        if (einrichtungId != null) {
          await provider.loadNachrichten(einrichtungId);
        }
      },
      child: nachrichten.isEmpty
          ? ListView(
              children: [
                KfEmptyState(
                  title: emptyTitle,
                  icon: emptyIcon,
                  subtitle: emptySubtitle,
                ),
              ],
            )
          : ListView.separated(
              itemCount: nachrichten.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: AppColors.divider,
              ),
              itemBuilder: (context, index) {
                final nachricht = nachrichten[index];
                return NachrichtListItem(
                  nachricht: nachricht,
                  onTap: () =>
                      context.push('/nachrichten/${nachricht.id}'),
                );
              },
            ),
    );
  }
}

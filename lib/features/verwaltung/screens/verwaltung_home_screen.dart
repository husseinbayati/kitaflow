import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_role_guard.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/einrichtung_provider.dart';
import '../../../presentation/providers/gruppe_provider.dart';
import '../../../presentation/providers/mitarbeiter_provider.dart';
import '../../../presentation/providers/dokument_provider.dart';
import '../../../presentation/providers/eingewoehnung_provider.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Verwaltungs-Übersicht mit 3 Navigations-Kacheln.
/// Nur für Leitung und Träger sichtbar.
class VerwaltungHomeScreen extends StatefulWidget {
  const VerwaltungHomeScreen({super.key});

  @override
  State<VerwaltungHomeScreen> createState() => _VerwaltungHomeScreenState();
}

class _VerwaltungHomeScreenState extends State<VerwaltungHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final einrichtungId = context.read<AuthProvider>().user?.einrichtungId;
    if (einrichtungId == null) return;
    await Future.wait([
      context.read<EinrichtungProvider>().loadEinrichtung(einrichtungId),
      context.read<GruppeProvider>().loadGruppen(einrichtungId),
      context.read<MitarbeiterProvider>().loadMitarbeiter(einrichtungId),
      context.read<DokumentProvider>().loadDokumente(einrichtungId),
      context.read<EingewoehnungProvider>().loadEingewoehnungen(einrichtungId),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return KfRoleGuard(
      allowedRoles: const [UserRole.leitung, UserRole.traeger],
      child: Scaffold(
        appBar: AppBar(title: Text(context.l.verwaltung_title)),
        body: RefreshIndicator(
          onRefresh: _loadData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppPadding.screen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Einrichtung
                _buildTile(
                  context,
                  icon: Icons.business,
                  color: AppColors.primary,
                  title: context.l.verwaltung_institution,
                  subtitle: Consumer<EinrichtungProvider>(
                    builder: (_, p, __) => Text(
                      p.einrichtung?.name ?? context.l.common_loading,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  onTap: () => context.go(AppRoutes.verwaltungEinrichtung),
                ),
                AppGaps.v12,
                // Gruppen
                _buildTile(
                  context,
                  icon: Icons.group_work,
                  color: AppColors.info,
                  title: context.l.verwaltung_groupsTitle,
                  subtitle: Consumer<GruppeProvider>(
                    builder: (_, p, __) => Text(
                      context.l.verwaltung_groupsCount(p.gruppen.length),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  onTap: () => context.go(AppRoutes.verwaltungGruppen),
                ),
                AppGaps.v12,
                // Mitarbeiter
                _buildTile(
                  context,
                  icon: Icons.people,
                  color: AppColors.success,
                  title: context.l.verwaltung_staffTitle,
                  subtitle: Consumer<MitarbeiterProvider>(
                    builder: (_, p, __) => Text(
                      context.l.verwaltung_staffCount(p.mitarbeiter.length),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  onTap: () => context.go(AppRoutes.verwaltungMitarbeiter),
                ),
                AppGaps.v12,
                // Eingewöhnung
                _buildTile(
                  context,
                  icon: Icons.child_care,
                  color: AppColors.secondary,
                  title: context.l.verwaltung_eingewoehnungTile,
                  subtitle: Consumer<EingewoehnungProvider>(
                    builder: (_, p, __) => Text(
                      context.l.eingewoehnung_count(p.aktiveEingewoehnungen.length),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  onTap: () => context.go('/einstellungen/eingewoehnung'),
                ),
                AppGaps.v12,
                // Dokumente
                _buildTile(
                  context,
                  icon: Icons.folder_open,
                  color: AppColors.warning,
                  title: context.l.verwaltung_dokumenteTile,
                  subtitle: Consumer<DokumentProvider>(
                    builder: (_, p, __) => Text(
                      context.l.dokumente_count(p.dokumente.length),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  onTap: () => context.go('/einstellungen/dokumente'),
                ),
                AppGaps.v12,
                // Sprache
                _buildTile(
                  context,
                  icon: Icons.language,
                  color: AppColors.primary,
                  title: context.l.common_language,
                  subtitle: Consumer<LocaleProvider>(
                    builder: (_, p, __) {
                      const names = {
                        'de': 'Deutsch',
                        'ar': 'العربية',
                        'tr': 'Türkçe',
                        'uk': 'Українська',
                        'en': 'English',
                      };
                      return Text(
                        names[p.locale.languageCode] ?? p.locale.languageCode,
                        style: Theme.of(context).textTheme.bodySmall,
                      );
                    },
                  ),
                  onTap: () => context.push(AppRoutes.sprache),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required Widget subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Row(
            children: [
              Container(
                width: DesignTokens.avatarLg,
                height: DesignTokens.avatarLg,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(DesignTokens.radiusSm),
                ),
                child: Icon(icon, color: color, size: DesignTokens.iconLg),
              ),
              const SizedBox(width: DesignTokens.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: DesignTokens.spacing4),
                    subtitle,
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

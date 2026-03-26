import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_avatar.dart';
import '../../../core/widgets/kf_badge.dart';
import '../../../core/widgets/kf_card.dart';
import '../../../core/widgets/kf_dialog.dart';
import '../../../core/widgets/kf_empty_state.dart';
import '../../../data/models/allergie.dart';
import '../../../data/models/kontaktperson.dart';
import '../../../presentation/providers/kind_provider.dart';
import '../widgets/allergie_form.dart';
import '../widgets/kontaktperson_form.dart';

/// Detailansicht eines Kindes mit Stammdaten, Allergien und Kontaktpersonen.
class KindDetailScreen extends StatefulWidget {
  const KindDetailScreen({super.key, required this.kindId});

  final String kindId;

  @override
  State<KindDetailScreen> createState() => _KindDetailScreenState();
}

class _KindDetailScreenState extends State<KindDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KindProvider>().loadKindDetails(widget.kindId);
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '–';
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Color _statusBadgeColor(ChildStatus status) {
    return switch (status) {
      ChildStatus.aktiv => AppColors.successLight,
      ChildStatus.eingewoehnung => AppColors.warningLight,
      ChildStatus.abgemeldet => AppColors.errorLight,
      ChildStatus.warteliste => AppColors.infoLight,
    };
  }

  Color _statusTextColor(ChildStatus status) {
    return switch (status) {
      ChildStatus.aktiv => AppColors.success,
      ChildStatus.eingewoehnung => AppColors.warning,
      ChildStatus.abgemeldet => AppColors.error,
      ChildStatus.warteliste => AppColors.info,
    };
  }

  Color _severityBadgeColor(AllergySeverity severity) {
    return switch (severity) {
      AllergySeverity.leicht => AppColors.successLight,
      AllergySeverity.mittel => AppColors.warningLight,
      AllergySeverity.schwer => AppColors.accentLight,
      AllergySeverity.lebensbedrohlich => AppColors.errorLight,
    };
  }

  Color _severityTextColor(AllergySeverity severity) {
    return switch (severity) {
      AllergySeverity.leicht => AppColors.success,
      AllergySeverity.mittel => AppColors.warning,
      AllergySeverity.schwer => AppColors.accentDark,
      AllergySeverity.lebensbedrohlich => AppColors.error,
    };
  }

  Future<void> _handleDelete() async {
    final confirmed = await KfConfirmDialog.show(
      context,
      title: context.l.kinder_detailDeleteTitle,
      message: context.l.kinder_detailDeleteConfirm(
        context.read<KindProvider>().selectedKind?.vollstaendigerName ?? '',
      ),
      confirmLabel: context.l.common_delete,
      isDanger: true,
    );
    if (confirmed && mounted) {
      final success = await context.read<KindProvider>().deleteKind(widget.kindId);
      if (success && mounted) {
        context.pop();
      }
    }
  }

  Future<void> _removeAllergie(Allergie allergie) async {
    final confirmed = await KfConfirmDialog.show(
      context,
      title: context.l.kinder_detailRemoveAllergy,
      message: 'Möchten Sie die Allergie "${allergie.allergen.label(context)}" wirklich entfernen?',
      confirmLabel: context.l.common_remove,
      isDanger: true,
    );
    if (confirmed && mounted) {
      await context.read<KindProvider>().removeAllergie(allergie.id);
    }
  }

  Future<void> _removeKontaktperson(Kontaktperson kp) async {
    final confirmed = await KfConfirmDialog.show(
      context,
      title: context.l.kinder_detailRemoveContact,
      message: 'Möchten Sie "${kp.name}" wirklich als Kontaktperson entfernen?',
      confirmLabel: context.l.common_remove,
      isDanger: true,
    );
    if (confirmed && mounted) {
      await context.read<KindProvider>().removeKontaktperson(kp.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KindProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.selectedKind == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.hasError && provider.selectedKind == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                provider.errorMessage ?? context.l.kinder_errorOccurred,
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: DesignTokens.fontMd,
                ),
              ),
            ),
          );
        }

        final kind = provider.selectedKind;
        if (kind == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(context.l.kinder_detailNotFound)),
          );
        }

        final allergien = provider.allergien;
        final kontaktpersonen = provider.kontaktpersonen;

        // Gruppenname ermitteln
        final gruppe = provider.gruppen
            .where((g) => g.id == kind.gruppeId)
            .firstOrNull;

        return Scaffold(
          appBar: AppBar(
            title: Text(kind.vollstaendigerName),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'bearbeiten') {
                    context.push('/kinder/${widget.kindId}/bearbeiten');
                  } else if (value == 'loeschen') {
                    _handleDelete();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'bearbeiten',
                    child: Row(
                      children: [
                        const Icon(Icons.edit_outlined, size: DesignTokens.iconSm),
                        const SizedBox(width: DesignTokens.spacing8),
                        Text(context.l.common_edit),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'loeschen',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline,
                            size: DesignTokens.iconSm, color: AppColors.error),
                        const SizedBox(width: DesignTokens.spacing8),
                        Text(context.l.common_delete,
                            style: const TextStyle(color: AppColors.error)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                // Header
                Container(
                  padding: AppPadding.card,
                  color: AppColors.surface,
                  child: Row(
                    children: [
                      KfAvatar(
                        size: DesignTokens.avatarXl,
                        name: kind.vollstaendigerName,
                        imageUrl: kind.avatarUrl,
                      ),
                      const SizedBox(width: DesignTokens.spacing16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kind.vollstaendigerName,
                              style: const TextStyle(
                                fontSize: DesignTokens.font2xl,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              context.l.common_yearsOld(kind.alter),
                              style: const TextStyle(
                                fontSize: DesignTokens.fontMd,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: DesignTokens.spacing8),
                            Row(
                              children: [
                                KfBadge(
                                  label: kind.status.label(context),
                                  color: _statusBadgeColor(kind.status),
                                  textColor: _statusTextColor(kind.status),
                                ),
                                if (gruppe != null) ...[
                                  const SizedBox(width: DesignTokens.spacing8),
                                  KfBadge(
                                    label: gruppe.name,
                                    color: AppColors.primaryLight
                                        .withValues(alpha: 0.3),
                                    textColor: AppColors.primaryDark,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // TabBar
                TabBar(
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  tabs: [
                    Tab(text: context.l.kinder_detailTabMasterData),
                    Tab(text: context.l.kinder_detailTabAllergies(allergien.length)),
                    Tab(text: context.l.kinder_detailTabContacts(kontaktpersonen.length)),
                  ],
                ),

                // TabBarView
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildStammdatenTab(kind, gruppe?.name),
                      _buildAllergienTab(allergien),
                      _buildKontakteTab(kontaktpersonen),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                context.push('/kinder/${widget.kindId}/bearbeiten'),
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.edit, color: AppColors.textOnPrimary),
          ),
        );
      },
    );
  }

  Widget _buildStammdatenTab(kind, String? gruppeName) {
    return ListView(
      padding: AppPadding.screen,
      children: [
        _buildInfoRow(context.l.kinder_detailBirthDate, _formatDate(kind.geburtsdatum)),
        _buildInfoRow(context.l.kinder_detailGender, kind.geschlecht),
        _buildInfoRow(context.l.kinder_detailGroup, gruppeName ?? '–'),
        _buildInfoRow(context.l.kinder_detailEntryDate, _formatDate(kind.eintrittsdatum)),
        _buildInfoRow(context.l.kinder_detailStatus, kind.status.label(context)),
        if (kind.notizen != null && kind.notizen!.isNotEmpty)
          _buildInfoRow(context.l.kinder_detailNotes, kind.notizen!),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: DesignTokens.fontMd,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergienTab(List<Allergie> allergien) {
    if (allergien.isEmpty) {
      return KfEmptyState(
        icon: Icons.health_and_safety_outlined,
        title: context.l.kinder_detailNoAllergies,
        subtitle: context.l.kinder_detailAddAllergyHint,
        actionLabel: context.l.kinder_detailAddAllergy,
        onAction: () => AllergieForm.show(context, widget.kindId),
      );
    }

    return Stack(
      children: [
        ListView.separated(
          padding: AppPadding.screen,
          itemCount: allergien.length,
          separatorBuilder: (_, __) => AppGaps.v8,
          itemBuilder: (context, index) {
            final allergie = allergien[index];
            return KfCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              allergie.allergen.label(context),
                              style: const TextStyle(
                                fontSize: DesignTokens.fontMd,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: DesignTokens.spacing8),
                            KfBadge(
                              label: allergie.schweregrad.label(context),
                              color: _severityBadgeColor(allergie.schweregrad),
                              textColor:
                                  _severityTextColor(allergie.schweregrad),
                            ),
                          ],
                        ),
                        if (allergie.hinweise != null &&
                            allergie.hinweise!.isNotEmpty) ...[
                          const SizedBox(height: DesignTokens.spacing4),
                          Text(
                            allergie.hinweise!,
                            style: const TextStyle(
                              fontSize: DesignTokens.fontSm,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.error, size: DesignTokens.iconSm),
                    onPressed: () => _removeAllergie(allergie),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: DesignTokens.spacing16,
          right: DesignTokens.spacing16,
          child: FloatingActionButton.small(
            heroTag: 'allergie_fab',
            onPressed: () => AllergieForm.show(context, widget.kindId),
            backgroundColor: AppColors.primary,
            child:
                const Icon(Icons.add, color: AppColors.textOnPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildKontakteTab(List<Kontaktperson> kontaktpersonen) {
    if (kontaktpersonen.isEmpty) {
      return KfEmptyState(
        icon: Icons.contacts_outlined,
        title: context.l.kinder_detailNoContacts,
        subtitle: context.l.kinder_detailAddContactHint,
        actionLabel: context.l.kinder_detailAddContact,
        onAction: () => KontaktpersonForm.show(context, widget.kindId),
      );
    }

    return Stack(
      children: [
        ListView.separated(
          padding: AppPadding.screen,
          itemCount: kontaktpersonen.length,
          separatorBuilder: (_, __) => AppGaps.v8,
          itemBuilder: (context, index) {
            final kp = kontaktpersonen[index];
            return KfCard(
              onTap: () => KontaktpersonForm.show(context, widget.kindId, kp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kp.name,
                              style: const TextStyle(
                                fontSize: DesignTokens.fontMd,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              kp.beziehung,
                              style: const TextStyle(
                                fontSize: DesignTokens.fontSm,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: AppColors.error,
                            size: DesignTokens.iconSm),
                        onPressed: () => _removeKontaktperson(kp),
                      ),
                    ],
                  ),
                  if (kp.telefon != null && kp.telefon!.isNotEmpty) ...[
                    const SizedBox(height: DesignTokens.spacing4),
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined,
                            size: DesignTokens.iconSm,
                            color: AppColors.textSecondary),
                        const SizedBox(width: DesignTokens.spacing8),
                        Text(
                          kp.telefon!,
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSm,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (kp.email != null && kp.email!.isNotEmpty) ...[
                    const SizedBox(height: DesignTokens.spacing4),
                    Row(
                      children: [
                        const Icon(Icons.email_outlined,
                            size: DesignTokens.iconSm,
                            color: AppColors.textSecondary),
                        const SizedBox(width: DesignTokens.spacing8),
                        Text(
                          kp.email!,
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSm,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (kp.istAbholberechtigt || kp.istNotfallkontakt) ...[
                    const SizedBox(height: DesignTokens.spacing8),
                    Wrap(
                      spacing: DesignTokens.spacing8,
                      children: [
                        if (kp.istAbholberechtigt)
                          KfBadge(
                            label: context.l.kinder_detailPickupAuthorized,
                            color: AppColors.successLight,
                            textColor: AppColors.success,
                          ),
                        if (kp.istNotfallkontakt)
                          KfBadge(
                            label: context.l.kinder_detailEmergencyContact,
                            color: AppColors.errorLight,
                            textColor: AppColors.error,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: DesignTokens.spacing16,
          right: DesignTokens.spacing16,
          child: FloatingActionButton.small(
            heroTag: 'kontakt_fab',
            onPressed: () =>
                KontaktpersonForm.show(context, widget.kindId),
            backgroundColor: AppColors.primary,
            child:
                const Icon(Icons.add, color: AppColors.textOnPrimary),
          ),
        ),
      ],
    );
  }
}

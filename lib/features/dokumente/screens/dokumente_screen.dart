import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/dokument.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/dokument_provider.dart';

class DokumenteScreen extends StatefulWidget {
  const DokumenteScreen({super.key});

  @override
  State<DokumenteScreen> createState() => _DokumenteScreenState();
}

class _DokumenteScreenState extends State<DokumenteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final einrichtungId =
          context.read<AuthProvider>().user?.einrichtungId;
      if (einrichtungId != null) {
        context.read<DokumentProvider>().loadDokumente(einrichtungId);
      }
    });
  }

  IconData _iconForTyp(DocumentType typ) {
    return switch (typ) {
      DocumentType.vertrag => Icons.description,
      DocumentType.einverstaendnis => Icons.handshake,
      DocumentType.attest => Icons.medical_services,
      DocumentType.zeugnis => Icons.school,
      DocumentType.sonstiges => Icons.insert_drive_file,
    };
  }

  Color _colorForTyp(DocumentType typ) {
    return switch (typ) {
      DocumentType.vertrag => AppColors.primary,
      DocumentType.einverstaendnis => AppColors.success,
      DocumentType.attest => AppColors.error,
      DocumentType.zeugnis => AppColors.warning,
      DocumentType.sonstiges => AppColors.textSecondary,
    };
  }

  String _formatDate(DateTime d) => '${d.day}.${d.month}.${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.dokumente_title),
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(child: _buildBody()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutes.dokumenteNeu),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Consumer<DokumentProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing16,
            vertical: DesignTokens.spacing8,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: DesignTokens.spacing8),
                child: FilterChip(
                  label: Text(context.l.dokumente_filterAll),
                  selected: provider.filterTyp == null,
                  selectedColor:
                      AppColors.primary.withValues(alpha: 0.2),
                  onSelected: (_) => provider.setFilter(null),
                ),
              ),
              ...DocumentType.values.map(
                (typ) => Padding(
                  padding: EdgeInsets.only(right: DesignTokens.spacing8),
                  child: FilterChip(
                    label: Text(typ.label(context)),
                    selected: provider.filterTyp == typ,
                    selectedColor:
                        AppColors.primary.withValues(alpha: 0.2),
                    onSelected: (_) => provider.setFilter(typ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        final einrichtungId =
            context.read<AuthProvider>().user?.einrichtungId;
        if (einrichtungId != null) {
          await context
              .read<DokumentProvider>()
              .loadDokumente(einrichtungId);
        }
      },
      child: Consumer<DokumentProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.hasError) {
            return Center(
              child: Text(
                provider.errorMessage ?? context.l.common_error,
              ),
            );
          }

          final dokumente = provider.filteredDokumente;

          if (dokumente.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: DesignTokens.iconXl,
                    color: AppColors.textSecondary,
                  ),
                  AppGaps.v16,
                  Text(
                    context.l.dokumente_noDocuments,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: AppPadding.screen,
            itemCount: dokumente.length,
            itemBuilder: (context, index) {
              final dok = dokumente[index];
              return _buildDokumentCard(dok, provider);
            },
          );
        },
      ),
    );
  }

  Widget _buildDokumentCard(Dokument dok, DokumentProvider provider) {
    final typColor = _colorForTyp(dok.typ);

    return Card(
      margin: EdgeInsets.only(bottom: DesignTokens.spacing12),
      child: ListTile(
        leading: Icon(
          _iconForTyp(dok.typ),
          color: typColor,
          size: DesignTokens.iconMd,
        ),
        title: Text(
          dok.titel,
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing8,
                vertical: DesignTokens.spacing4,
              ),
              decoration: BoxDecoration(
                color: typColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              ),
              child: Text(
                dok.typ.label(context),
                style: TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: typColor,
                ),
              ),
            ),
            AppGaps.h8,
            Text(
              _formatDate(dok.erstelltAm),
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        trailing: dok.unterschrieben
            ? Icon(Icons.check_circle, color: AppColors.success)
            : Icon(Icons.radio_button_unchecked, color: AppColors.textHint),
        onTap: () {
          provider.selectDokument(dok);
          context.go('/verwaltung/dokumente/${dok.id}');
        },
      ),
    );
  }
}

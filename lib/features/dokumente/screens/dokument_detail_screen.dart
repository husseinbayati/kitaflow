import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../data/models/dokument.dart';
import '../../../presentation/providers/dokument_provider.dart';

class DokumentDetailScreen extends StatelessWidget {
  final String dokumentId;

  const DokumentDetailScreen({
    super.key,
    required this.dokumentId,
  });

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
    return Consumer<DokumentProvider>(
      builder: (context, provider, _) {
        final dok = provider.selectedDokument ??
            provider.dokumente.where((d) => d.id == dokumentId).firstOrNull;

        if (dok == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(dok.titel),
            actions: [
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon')),
                  );
                },
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    _showDeleteDialog(context, provider, dok);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(context.l.common_delete),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: AppPadding.screen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTypeBadge(context, dok),
                AppGaps.v16,
                _buildInfoSection(context, dok),
                AppGaps.v16,
                _buildSignatureSection(context, dok),
                AppGaps.v24,
                _buildDeleteButton(context, provider, dok),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeBadge(BuildContext context, Dokument dok) {
    final typColor = _colorForTyp(dok.typ);

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing12,
            vertical: DesignTokens.spacing8,
          ),
          decoration: BoxDecoration(
            color: typColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          child: Text(
            dok.typ.label(context),
            style: TextStyle(
              fontSize: DesignTokens.fontMd,
              color: typColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context, Dokument dok) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (dok.beschreibung != null) ...[
              Text(
                dok.beschreibung!,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textSecondary,
                ),
              ),
              AppGaps.v12,
            ],
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.calendar_today,
                size: DesignTokens.iconSm,
                color: AppColors.textSecondary,
              ),
              title: Text(
                'Erstellt am ${_formatDate(dok.erstelltAm)}',
                style: TextStyle(fontSize: DesignTokens.fontMd),
              ),
            ),
            if (dok.gueltigBis != null) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.event,
                  size: DesignTokens.iconSm,
                  color: dok.istAbgelaufen
                      ? AppColors.error
                      : AppColors.textSecondary,
                ),
                title: Text(
                  context.l.dokumente_validUntil(_formatDate(dok.gueltigBis!)),
                  style: TextStyle(fontSize: DesignTokens.fontMd),
                ),
                subtitle: dok.istAbgelaufen
                    ? Text(
                        context.l.dokumente_expired,
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: DesignTokens.fontSm,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : null,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSignatureSection(BuildContext context, Dokument dok) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.spacing16),
        child: dok.unterschrieben
            ? Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: DesignTokens.iconMd,
                  ),
                  AppGaps.h12,
                  Expanded(
                    child: Text(
                      context.l.dokumente_signedBy(
                        dok.unterschriebenVon ?? '',
                        dok.unterschriebenAm != null
                            ? _formatDate(dok.unterschriebenAm!)
                            : '',
                      ),
                      style: TextStyle(fontSize: DesignTokens.fontMd),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pending,
                        color: AppColors.warning,
                        size: DesignTokens.iconMd,
                      ),
                      AppGaps.h12,
                      Expanded(
                        child: Text(
                          context.l.dokumente_unsigned,
                          style: TextStyle(fontSize: DesignTokens.fontMd),
                        ),
                      ),
                    ],
                  ),
                  AppGaps.v16,
                  KfButton(
                    label: context.l.dokumente_sign,
                    onPressed: () => context.go(
                      '/verwaltung/dokumente/${dok.id}/signieren',
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDeleteButton(
    BuildContext context,
    DokumentProvider provider,
    Dokument dok,
  ) {
    return KfButton(
      label: context.l.dokumente_delete,
      variant: KfButtonVariant.danger,
      onPressed: () => _showDeleteDialog(context, provider, dok),
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    DokumentProvider provider,
    Dokument dok,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l.dokumente_delete),
        content: Text(context.l.dokumente_deleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              context.l.common_confirm,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await provider.deleteDokument(dok.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.dokumente_deleteSuccess)),
        );
        context.pop();
      }
    }
  }
}

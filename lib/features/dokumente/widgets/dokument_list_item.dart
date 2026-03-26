import 'package:flutter/material.dart';

import '../../../data/models/dokument.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import 'dokument_typ_badge.dart';

class DokumentListItem extends StatelessWidget {
  const DokumentListItem({
    super.key,
    required this.dokument,
    this.onTap,
  });

  final Dokument dokument;
  final VoidCallback? onTap;

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
      DocumentType.vertrag => AppColors.info,
      DocumentType.einverstaendnis => AppColors.success,
      DocumentType.attest => AppColors.warning,
      DocumentType.zeugnis => const Color(0xFF7C4DFF),
      DocumentType.sonstiges => AppColors.textSecondary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${dokument.erstelltAm.day.toString().padLeft(2, '0')}.${dokument.erstelltAm.month.toString().padLeft(2, '0')}.${dokument.erstelltAm.year}';

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Padding(
          padding: EdgeInsets.all(DesignTokens.spacing12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: _colorForTyp(dokument.typ).withValues(alpha: 0.15),
                child: Icon(
                  _iconForTyp(dokument.typ),
                  color: _colorForTyp(dokument.typ),
                  size: DesignTokens.iconMd,
                ),
              ),
              AppGaps.h12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dokument.titel,
                      style: TextStyle(
                        fontSize: DesignTokens.fontMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppGaps.v4,
                    Row(
                      children: [
                        DokumentTypBadge(typ: dokument.typ),
                        AppGaps.h8,
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: DesignTokens.fontSm,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                dokument.unterschrieben
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: dokument.unterschrieben
                    ? AppColors.success
                    : AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

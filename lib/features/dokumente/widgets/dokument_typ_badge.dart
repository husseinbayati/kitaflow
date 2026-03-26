import 'package:flutter/material.dart';

import '../../../core/constants/enums.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';

class DokumentTypBadge extends StatelessWidget {
  const DokumentTypBadge({super.key, required this.typ});

  final DocumentType typ;

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
    final color = _colorForTyp(typ);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing8,
        vertical: DesignTokens.spacing4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      ),
      child: Text(
        typ.label(context),
        style: TextStyle(
          fontSize: DesignTokens.fontSm,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

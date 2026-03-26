import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/nachricht_anhang.dart';
import '../../../core/extensions/l10n_extension.dart';

/// ListTile zur Anzeige eines Nachrichtenanhangs.
///
/// Zeigt Dateiname, Dateigröße und ein typabhängiges Icon.
/// Unterstützt optionale Download- und Lösch-Aktionen.
class AnhangListTile extends StatelessWidget {
  const AnhangListTile({
    super.key,
    required this.anhang,
    this.onTap,
    this.onDelete,
  });

  /// Der anzuzeigende Anhang.
  final NachrichtAnhang anhang;

  /// Callback beim Tippen auf den Download-Button.
  final VoidCallback? onTap;

  /// Callback beim Tippen auf den Löschen-Button.
  final VoidCallback? onDelete;

  /// Ermittelt das passende Icon basierend auf dem MIME-Typ.
  Widget _buildLeadingIcon() {
    final dateityp = anhang.dateityp ?? '';

    if (dateityp.startsWith('image/')) {
      return Icon(Icons.image, color: AppColors.info);
    } else if (dateityp == 'application/pdf') {
      return Icon(Icons.picture_as_pdf, color: AppColors.error);
    } else {
      return Icon(Icons.attach_file, color: AppColors.textSecondary);
    }
  }

  /// Formatiert die Dateigröße in menschenlesbare Form (KB/MB).
  String _formatFileSize(int? bytes) {
    if (bytes == null) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      final kb = (bytes / 1024).toStringAsFixed(1);
      return '$kb KB';
    }
    final mb = (bytes / (1024 * 1024)).toStringAsFixed(1);
    return '$mb MB';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeadingIcon(),
      title: Text(
        anhang.dateiname,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(_formatFileSize(anhang.dateigroesse)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onTap != null)
            IconButton(
              icon: Icon(Icons.download, color: AppColors.primary),
              onPressed: onTap,
              tooltip: context.l.nachrichten_attachmentDownload,
            ),
          if (onDelete != null)
            IconButton(
              icon: Icon(Icons.close, color: AppColors.error),
              onPressed: onDelete,
              tooltip: context.l.nachrichten_attachmentRemove,
            ),
        ],
      ),
    );
  }
}

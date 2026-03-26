import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_loading.dart';
import '../../../data/models/nachricht.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/nachricht_provider.dart';
import '../widgets/nachricht_typ_badge.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Detailansicht einer einzelnen Nachricht.
///
/// Zeigt Absender, Typ-Badge, Inhalt, Anhänge und Lesebestätigungen.
class NachrichtenDetailScreen extends StatefulWidget {
  const NachrichtenDetailScreen({super.key, required this.nachrichtId});

  /// ID der anzuzeigenden Nachricht.
  final String nachrichtId;

  @override
  State<NachrichtenDetailScreen> createState() =>
      _NachrichtenDetailScreenState();
}

class _NachrichtenDetailScreenState extends State<NachrichtenDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDetails();
    });
  }

  void _loadDetails() {
    context.read<NachrichtProvider>().loadNachrichtDetails(widget.nachrichtId);
  }

  String? get _currentUserId {
    return context.read<AuthProvider>().user?.id;
  }

  /// Formatiert ein Datum im deutschen Format (z.B. "26.03.2026, 14:30").
  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy, HH:mm').format(date);
  }

  /// Gibt die Initialen eines Namens zurück (z.B. "Max Mustermann" → "MM").
  String _initialen(String name) {
    final teile = name.trim().split(' ');
    if (teile.length >= 2) {
      return '${teile.first[0]}${teile.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Future<void> _deleteNachricht() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l.nachrichten_detailDeleteTitle),
        content: Text(
          context.l.nachrichten_detailDeleteConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(context.l.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              context.l.common_delete,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await context
          .read<NachrichtProvider>()
          .deleteNachricht(widget.nachrichtId);
      if (success && mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NachrichtProvider>(
      builder: (context, provider, _) {
        final nachricht = provider.selectedNachricht;

        if (provider.isLoading) {
          return Scaffold(
            appBar: AppBar(title: Text(context.l.nachrichten_detailTitle)),
            body: const KfShimmerList(),
          );
        }

        if (nachricht == null) {
          return Scaffold(
            appBar: AppBar(title: Text(context.l.nachrichten_detailTitle)),
            body: Center(
              child: Text(
                context.l.nachrichten_detailNotFound,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          );
        }

        final istAbsender = nachricht.absenderId == _currentUserId;
        final empfaenger = provider.empfaenger;
        final anhaenge = provider.anhaenge;
        final gelesenCount =
            empfaenger.where((e) => e.gelesen).length;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              nachricht.betreff,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              if (istAbsender)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _deleteNachricht,
                  tooltip: context.l.nachrichten_detailDeleteTooltip,
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header-Card: Absender, Datum, Typ, Wichtig
                _buildHeaderCard(nachricht),

                const Divider(height: DesignTokens.spacing32),

                // Inhalt
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing4,
                  ),
                  child: SelectableText(
                    nachricht.inhalt,
                    style: const TextStyle(
                      fontSize: DesignTokens.fontMd,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),

                // Anhänge
                if (anhaenge.isNotEmpty) ...[
                  const SizedBox(height: DesignTokens.spacing24),
                  Text(
                    context.l.nachrichten_detailAttachments,
                    style: const TextStyle(
                      fontSize: DesignTokens.fontLg,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: anhaenge.length,
                    itemBuilder: (context, index) {
                      final anhang = anhaenge[index];
                      return ListTile(
                        leading: Icon(
                          Icons.attach_file,
                          color: AppColors.info,
                          size: DesignTokens.iconMd,
                        ),
                        title: Text(
                          anhang.dateiname,
                          style: const TextStyle(
                            fontSize: DesignTokens.fontSm,
                          ),
                        ),
                        dense: true,
                      );
                    },
                  ),
                ],

                // Lesebestätigung (nur für Absender)
                if (istAbsender && empfaenger.isNotEmpty) ...[
                  const SizedBox(height: DesignTokens.spacing24),
                  Text(
                    context.l.nachrichten_detailReadBy(gelesenCount, empfaenger.length),
                    style: const TextStyle(
                      fontSize: DesignTokens.fontSm,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  /// Header-Card mit Absender-Avatar, Name, Datum, Typ-Badge und Wichtig-Stern.
  Widget _buildHeaderCard(Nachricht nachricht) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Absender-Avatar mit Initialen
        CircleAvatar(
          radius: DesignTokens.avatarMd / 2,
          backgroundColor: AppColors.primaryLight,
          child: Text(
            _initialen(nachricht.absenderName),
            style: const TextStyle(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w600,
              fontSize: DesignTokens.fontMd,
            ),
          ),
        ),
        const SizedBox(width: DesignTokens.spacing12),

        // Name + Datum
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nachricht.absenderName,
                style: const TextStyle(
                  fontSize: DesignTokens.fontMd,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing4),
              Text(
                _formatDate(nachricht.erstelltAm),
                style: const TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Typ-Badge
        NachrichtTypBadge(typ: nachricht.typ),

        // Wichtig-Stern
        if (nachricht.wichtig) ...[
          const SizedBox(width: DesignTokens.spacing8),
          Icon(
            Icons.star,
            color: AppColors.warning,
            size: DesignTokens.iconMd,
          ),
        ],
      ],
    );
  }
}

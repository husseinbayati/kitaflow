import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/dokument_provider.dart';
import '../widgets/signature_pad.dart';

/// Screen zum digitalen Unterschreiben eines Dokuments.
class DokumentSignierenScreen extends StatefulWidget {
  const DokumentSignierenScreen({
    super.key,
    required this.dokumentId,
  });

  final String dokumentId;

  @override
  State<DokumentSignierenScreen> createState() =>
      _DokumentSignierenScreenState();
}

class _DokumentSignierenScreenState extends State<DokumentSignierenScreen> {
  final _signatureKey = GlobalKey<SignaturePadState>();
  bool _isSubmitting = false;

  // ---------------------------------------------------------------------------
  // Unterschrift absenden
  // ---------------------------------------------------------------------------

  Future<void> _submit() async {
    final state = _signatureKey.currentState;
    if (state == null || state.isEmpty) {
      _showError(context.l.dokumente_signHint);
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final displayName = authProvider.displayName;
    final signerName =
        displayName.isNotEmpty ? displayName : (authProvider.user?.email ?? 'Unbekannt');
    final provider = context.read<DokumentProvider>();

    setState(() => _isSubmitting = true);

    try {
      final imageBytes = await state.toImage();
      if (imageBytes == null || imageBytes.isEmpty) {
        if (mounted) _showError(context.l.common_error);
        return;
      }

      final success = await provider.signDokument(
        widget.dokumentId,
        signerName,
        imageBytes,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.dokumente_signSuccess)),
        );
        context.pop();
      } else {
        _showError(context.l.common_error);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.dokumente_signTitle)),
      body: Padding(
        padding: AppPadding.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Dokument-Info ──────────────────────────────────────────────
            Consumer<DokumentProvider>(
              builder: (context, provider, _) {
                final dok = provider.selectedDokument;
                if (dok == null) return const SizedBox.shrink();

                return Card(
                  child: Padding(
                    padding: AppPadding.card,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dok.titel,
                          style: TextStyle(
                            fontSize: DesignTokens.fontLg,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        AppGaps.v4,
                        Text(
                          dok.typ.label(context),
                          style: TextStyle(
                            fontSize: DesignTokens.fontSm,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            AppGaps.v24,

            // ── Unterschrift-Label ────────────────────────────────────────
            Text(
              context.l.dokumente_sign,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),

            AppGaps.v8,

            // ── Signatur-Pad ─────────────────────────────────────────────
            SignaturePad(key: _signatureKey, height: 200),

            AppGaps.v24,

            // ── Aktionsbuttons ───────────────────────────────────────────
            Row(
              children: [
                KfButton(
                  label: context.l.dokumente_signClear,
                  variant: KfButtonVariant.outline,
                  onPressed: () => _signatureKey.currentState?.clear(),
                ),
                AppGaps.h12,
                Expanded(
                  child: KfButton(
                    label: context.l.dokumente_signConfirm,
                    variant: KfButtonVariant.primary,
                    isLoading: _isSubmitting,
                    isExpanded: true,
                    onPressed: _isSubmitting ? null : _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

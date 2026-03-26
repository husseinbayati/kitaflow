import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/widgets/kf_button.dart';

/// Schnellaktionen-Leiste für das Dashboard.
///
/// Zeigt rollenabhängige Aktions-Buttons (Check-in, Nachricht, Kind hinzufügen
/// für Fachpersonal bzw. Nachrichten und Krankmeldung für Eltern).
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({
    super.key,
    required this.rolle,
    this.onCheckIn,
    this.onNachricht,
    this.onKindNeu,
  });

  /// Rolle des angemeldeten Benutzers.
  final UserRole rolle;

  /// Callback für Check-in (Fachpersonal) bzw. Krankmeldung (Eltern).
  final VoidCallback? onCheckIn;

  /// Callback für Nachricht senden.
  final VoidCallback? onNachricht;

  /// Callback für Kind hinzufügen (nur Fachpersonal).
  final VoidCallback? onKindNeu;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: DesignTokens.spacing8,
      runSpacing: DesignTokens.spacing8,
      children: rolle == UserRole.eltern
          ? _buildElternActions(context)
          : _buildFachpersonalActions(context),
    );
  }

  List<Widget> _buildFachpersonalActions(BuildContext context) {
    return [
      KfButton(
        label: context.l.dashboard_quickCheckIn,
        icon: Icons.login,
        variant: KfButtonVariant.outline,
        onPressed: onCheckIn,
      ),
      KfButton(
        label: context.l.dashboard_quickMessage,
        icon: Icons.send,
        variant: KfButtonVariant.outline,
        onPressed: onNachricht,
      ),
      KfButton(
        label: context.l.dashboard_quickAddChild,
        icon: Icons.person_add,
        variant: KfButtonVariant.outline,
        onPressed: onKindNeu,
      ),
    ];
  }

  List<Widget> _buildElternActions(BuildContext context) {
    return [
      KfButton(
        label: context.l.dashboard_quickMessages,
        icon: Icons.mail,
        variant: KfButtonVariant.outline,
        onPressed: onNachricht,
      ),
      KfButton(
        label: context.l.dashboard_quickSickNote,
        icon: Icons.sick,
        variant: KfButtonVariant.outline,
        onPressed: onCheckIn,
      ),
    ];
  }
}

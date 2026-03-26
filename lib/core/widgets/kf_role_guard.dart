import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../extensions/l10n_extension.dart';
import '../../presentation/providers/auth_provider.dart';

/// Widget das Content nur für bestimmte Rollen anzeigt.
/// Zeigt [child] wenn der aktuelle User eine der [allowedRoles] hat,
/// ansonsten [fallback] oder einen Standard-"Kein Zugriff" Screen.
class KfRoleGuard extends StatelessWidget {
  final List<UserRole> allowedRoles;
  final Widget child;
  final Widget? fallback;

  const KfRoleGuard({
    super.key,
    required this.allowedRoles,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final currentRole = authProvider.currentRole;

        if (currentRole != null && allowedRoles.contains(currentRole)) {
          return child;
        }

        return fallback ?? const _DefaultFallback();
      },
    );
  }
}

class _DefaultFallback extends StatelessWidget {
  const _DefaultFallback();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            context.l.common_noAccess,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            context.l.common_noAccessDescription,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

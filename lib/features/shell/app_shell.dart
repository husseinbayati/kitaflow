import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/extensions/l10n_extension.dart';
import '../../core/routing/route_constants.dart';


/// App Shell mit rollenspezifischer Bottom Navigation.
/// Aktuell: Standard-Erzieher-Navigation (wird in Phase 2 rollenbasiert).
class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.dashboard)) return 0;
    if (location.startsWith(AppRoutes.kinder)) return 1;
    if (location.startsWith(AppRoutes.anwesenheit)) return 2;
    if (location.startsWith(AppRoutes.nachrichten)) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.dashboard);
      case 1:
        context.go(AppRoutes.kinder);
      case 2:
        context.go(AppRoutes.anwesenheit);
      case 3:
        context.go(AppRoutes.nachrichten);
      case 4:
        context.go(AppRoutes.einstellungen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: context.l.shell_dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outlined),
            selectedIcon: const Icon(Icons.people),
            label: context.l.shell_kinder,
          ),
          NavigationDestination(
            icon: const Icon(Icons.fact_check_outlined),
            selectedIcon: const Icon(Icons.fact_check),
            label: context.l.shell_anwesenheit,
          ),
          NavigationDestination(
            icon: const Icon(Icons.mail_outlined),
            selectedIcon: const Icon(Icons.mail),
            label: context.l.shell_nachrichten,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz),
            selectedIcon: const Icon(Icons.more_horiz),
            label: context.l.shell_mehr,
          ),
        ],
      ),
    );
  }
}

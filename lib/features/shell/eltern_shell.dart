import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/extensions/l10n_extension.dart';
import '../../core/routing/route_constants.dart';

/// Eltern-Shell mit Bottom Navigation für die Eltern-Ansicht.
class ElternShell extends StatelessWidget {
  final Widget child;

  const ElternShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.elternNachrichten)) return 1;
    if (location.startsWith(AppRoutes.elternTermine)) return 2;
    if (location.startsWith(AppRoutes.elternKinder)) return 3;
    if (location.startsWith('/eltern/einstellungen')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.elternHome);
      case 1:
        context.go(AppRoutes.elternNachrichten);
      case 2:
        context.go(AppRoutes.elternTermine);
      case 3:
        context.go(AppRoutes.elternKinder);
      case 4:
        context.go(AppRoutes.elternPushSettings);
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
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: context.l.shell_elternHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.mail_outlined),
            selectedIcon: const Icon(Icons.mail),
            label: context.l.shell_elternNachrichten,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon: const Icon(Icons.calendar_month),
            label: context.l.shell_elternTermine,
          ),
          NavigationDestination(
            icon: const Icon(Icons.child_care_outlined),
            selectedIcon: const Icon(Icons.child_care),
            label: context.l.shell_elternMeinKind,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz),
            selectedIcon: const Icon(Icons.more_horiz),
            label: context.l.shell_elternMehr,
          ),
        ],
      ),
    );
  }
}

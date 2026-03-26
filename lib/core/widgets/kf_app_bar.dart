import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../theme/app_colors.dart';

/// App-Leiste für KitaFlow-Screens.
///
/// Konsistentes AppBar-Design mit optionalem Zurück-Button und Aktionen.
class KfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KfAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.centerTitle = false,
    this.leading,
    this.bottom,
    this.elevation = 0,
    this.backgroundColor,
  });

  /// Titel der App-Leiste.
  final String title;

  /// Optionale Aktionsbuttons rechts.
  final List<Widget>? actions;

  /// Ob ein Zurück-Button angezeigt wird.
  final bool showBack;

  /// Ob der Titel zentriert wird.
  final bool centerTitle;

  /// Optionales Widget links (überschreibt Zurück-Button).
  final Widget? leading;

  /// Optionales Widget unterhalb der App-Leiste (z.B. TabBar).
  final PreferredSizeWidget? bottom;

  /// Elevation der App-Leiste.
  final double elevation;

  /// Hintergrundfarbe (Standard: surface).
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: DesignTokens.fontXl,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: centerTitle,
      leading: leading ??
          (showBack && Navigator.of(context).canPop()
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null),
      automaticallyImplyLeading: false,
      actions: actions,
      bottom: bottom,
      elevation: elevation,
      scrolledUnderElevation: 1,
      backgroundColor: backgroundColor ?? AppColors.surface,
      surfaceTintColor: Colors.transparent,
    );
  }
}

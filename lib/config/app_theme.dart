import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/constants/design_tokens.dart';

/// App-Theme für KitaFlow.
/// Light Mode als Standard (kinderfreundlich).
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          error: AppColors.error,
          surface: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.scaffoldBackground,

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: DesignTokens.fontXl,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Cards
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            side: const BorderSide(color: AppColors.borderLight, width: 1),
          ),
          margin: EdgeInsets.zero,
        ),

        // Inputs
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceVariant,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacing16,
            vertical: DesignTokens.spacing12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          hintStyle: const TextStyle(color: AppColors.textHint),
          labelStyle: const TextStyle(color: AppColors.textSecondary),
        ),

        // Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size(double.infinity, 48),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacing24,
              vertical: DesignTokens.spacing12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
            textStyle: const TextStyle(
              fontSize: DesignTokens.fontMd,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 48),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacing24,
              vertical: DesignTokens.spacing12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
            side: const BorderSide(color: AppColors.primary),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),

        // Navigation Bar
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primaryLight.withValues(alpha: 0.3),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: DesignTokens.fontXs,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),

        // Divider
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),

        // Snackbar
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
        ),

        // Floating Action Button
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
        ),
      );

  /// Dark Theme (optional für Eltern-Nachtmodus).
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      );
}

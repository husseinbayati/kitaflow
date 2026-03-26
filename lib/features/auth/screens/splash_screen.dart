import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../presentation/providers/auth_provider.dart';

/// Splash-Screen mit Logo und automatischem Auth-Check.
/// Redirect erfolgt über GoRouter Auth-Guard.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Warte kurz für Logo-Anzeige, dann Auth-Status prüfen
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final authProvider = context.read<AuthProvider>();
    await authProvider.checkAuthStatus();
    // GoRouter redirect übernimmt die Navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
              ),
              child: Center(
                child: Text(
                  context.l.auth_appInitials,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),
            Text(
              context.l.auth_appName,
              style: TextStyle(
                fontSize: DesignTokens.font2xl,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing8),
            Text(
              context.l.auth_appSlogan,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing48),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

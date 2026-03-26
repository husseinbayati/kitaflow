import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';

/// Screen zur E-Mail-Bestätigung nach der Registrierung.
///
/// Zeigt eine Aufforderung, die Bestätigungs-E-Mail zu prüfen,
/// und bietet einen "Erneut senden"-Button mit 60-Sekunden-Cooldown.
class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  static const int _cooldownSeconds = 60;

  Timer? _timer;
  int _remainingSeconds = 0;

  bool get _isCooldownActive => _remainingSeconds > 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _remainingSeconds = _cooldownSeconds);

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        if (mounted) setState(() => _remainingSeconds = 0);
      } else {
        if (mounted) setState(() => _remainingSeconds--);
      }
    });
  }

  void _onResend() {
    _startCooldown();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l.auth_verifyEmailResent),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.auth_verifyEmailTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.screen,
          child: Column(
            children: [
              AppGaps.v32,

              // Icon
              Icon(
                Icons.mark_email_read,
                size: 80,
                color: AppColors.primary,
              ),
              AppGaps.v24,

              // Titel
              Text(
                context.l.auth_verifyEmailSubtitle,
                style: TextStyle(
                  fontSize: DesignTokens.fontXl,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              AppGaps.v12,

              // Beschreibung
              Text(
                context.l.auth_verifyEmailDescription,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              AppGaps.v32,

              // Erneut senden Button
              KfButton(
                label: _isCooldownActive
                    ? context.l.auth_verifyEmailResendCountdown(_remainingSeconds)
                    : context.l.auth_verifyEmailResend,
                onPressed: _isCooldownActive ? null : _onResend,
                isExpanded: true,
                variant: KfButtonVariant.primary,
              ),
              AppGaps.v16,

              // Zurück zum Login
              TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: Text(
                  context.l.auth_verifyEmailBackToLogin,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: DesignTokens.fontMd,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

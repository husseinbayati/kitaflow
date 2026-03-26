import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../presentation/providers/auth_provider.dart';

/// Screen zum Zurücksetzen des Passworts per E-Mail-Link.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l.auth_registerEmailRequired;
    }
    final emailRegex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return context.l.auth_registerEmailInvalid;
    }
    return null;
  }

  Future<void> _onSubmit(AuthProvider authProvider) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await authProvider.resetPassword(
      _emailController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      setState(() => _sent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.auth_forgotPasswordTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.screen,
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return _sent ? _buildSuccessView() : _buildFormView(authProvider);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFormView(AuthProvider authProvider) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppGaps.v32,

          // Icon
          Icon(
            Icons.lock_reset,
            size: 64,
            color: AppColors.primary,
          ),
          AppGaps.v24,

          // Beschreibung
          Text(
            context.l.auth_forgotPasswordDescription,
            style: TextStyle(
              fontSize: DesignTokens.fontMd,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          AppGaps.v32,

          // E-Mail-Feld
          KfTextField(
            label: context.l.common_email,
            hint: context.l.auth_loginEmailHint,
            controller: _emailController,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: _validateEmail,
          ),
          AppGaps.v24,

          // Senden-Button
          KfButton(
            label: context.l.auth_forgotPasswordSendLink,
            onPressed: () => _onSubmit(authProvider),
            isLoading: authProvider.isLoading,
            isExpanded: true,
            variant: KfButtonVariant.primary,
          ),
          AppGaps.v16,

          // Zurück zum Login
          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            child: Text(
              context.l.auth_forgotPasswordBackToLogin,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: DesignTokens.fontMd,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      children: [
        AppGaps.v48,

        // Erfolg-Icon
        Icon(
          Icons.check_circle,
          size: 80,
          color: AppColors.success,
        ),
        AppGaps.v24,

        // Erfolgsmeldung
        Text(
          context.l.auth_forgotPasswordEmailSent,
          style: TextStyle(
            fontSize: DesignTokens.fontXl,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        AppGaps.v12,

        Text(
          context.l.auth_forgotPasswordCheckInbox,
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        AppGaps.v32,

        // Zurück zum Login
        TextButton(
          onPressed: () => context.go(AppRoutes.login),
          child: Text(
            context.l.auth_forgotPasswordBackToLogin,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: DesignTokens.fontMd,
            ),
          ),
        ),
      ],
    );
  }
}

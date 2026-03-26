import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../presentation/providers/auth_provider.dart';

/// Login-Screen mit Email/Passwort-Authentifizierung.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      context.go(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppPadding.screen,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusLg),
                    ),
                    child: const Icon(
                      Icons.child_care,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing16),
                  Text(
                    context.l.auth_appName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: DesignTokens.spacing8),
                  Text(
                    context.l.auth_appTagline,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DesignTokens.spacing48),

                  // Fehlermeldung
                  if (authProvider.hasError && authProvider.errorMessage != null)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          bottom: DesignTokens.spacing16),
                      padding: const EdgeInsets.all(DesignTokens.spacing12),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(DesignTokens.radiusSm),
                        border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline,
                              color: AppColors.error, size: 20),
                          const SizedBox(width: DesignTokens.spacing8),
                          Expanded(
                            child: Text(
                              authProvider.errorMessage!,
                              style: const TextStyle(
                                color: AppColors.error,
                                fontSize: DesignTokens.fontSm,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // E-Mail
                  KfTextField(
                    label: context.l.auth_loginEmail,
                    hint: context.l.auth_loginEmailHint,
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.l.auth_loginEmailRequired;
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return context.l.auth_loginEmailInvalid;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DesignTokens.spacing16),

                  // Passwort
                  KfTextField(
                    label: context.l.auth_loginPassword,
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    prefixIcon: Icons.lock_outlined,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textHint,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l.auth_loginPasswordRequired;
                      }
                      if (value.length < 8) {
                        return context.l.auth_loginPasswordMinLength;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: DesignTokens.spacing8),

                  // Passwort vergessen
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () => context.push(AppRoutes.forgotPassword),
                      child: Text(context.l.auth_forgotPassword),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing16),

                  // Login Button
                  KfButton(
                    label: context.l.auth_loginTitle,
                    onPressed: authProvider.isLoading ? null : _handleLogin,
                    isLoading: authProvider.isLoading,
                    isExpanded: true,
                  ),
                  const SizedBox(height: DesignTokens.spacing24),

                  // Registrieren
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.l.auth_noAccount,
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      TextButton(
                        onPressed: () => context.push(AppRoutes.register),
                        child: Text(context.l.auth_register),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

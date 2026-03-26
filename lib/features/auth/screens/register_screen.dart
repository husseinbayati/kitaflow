import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../presentation/providers/auth_provider.dart';

/// Registrierungs-Screen für neue KitaFlow-Benutzer.
///
/// Enthält Formularfelder für persönliche Daten, Rollenauswahl,
/// Passwortstärke-Indikator und AGB-Akzeptierung.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _vornameController = TextEditingController();
  final _nachnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  UserRole? _selectedRole;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agbAccepted = false;
  double _passwordStrength = 0.0;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    _vornameController.dispose();
    _nachnameController.dispose();
    _emailController.dispose();
    _passwordController.removeListener(_updatePasswordStrength);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength() {
    final password = _passwordController.text;
    double strength = 0.0;

    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
    });
  }

  Color _strengthColor() {
    if (_passwordStrength < 0.5) return AppColors.error;
    if (_passwordStrength < 0.75) return Colors.orange;
    return AppColors.success;
  }

  String _strengthLabel() {
    if (_passwordStrength < 0.5) return context.l.auth_registerPasswordStrengthWeak;
    if (_passwordStrength < 0.75) return context.l.auth_registerPasswordStrengthMedium;
    return context.l.auth_registerPasswordStrengthStrong;
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agbAccepted) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      vorname: _vornameController.text.trim(),
      nachname: _nachnameController.text.trim(),
      rolle: _selectedRole!,
    );

    if (success && mounted) {
      context.go(AppRoutes.verifyEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.screen,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppGaps.v32,

                // Titel
                Text(
                  context.l.auth_registerTitle,
                  style: TextStyle(
                    fontSize: DesignTokens.font2xl,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                AppGaps.v8,

                // Untertitel
                Text(
                  context.l.auth_registerSubtitle,
                  style: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    color: AppColors.textSecondary,
                  ),
                ),
                AppGaps.v32,

                // Vorname
                KfTextField(
                  label: context.l.auth_registerFirstName,
                  hint: context.l.auth_registerFirstNameHint,
                  controller: _vornameController,
                  prefixIcon: Icons.person_outlined,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l.auth_registerFirstNameRequired;
                    }
                    return null;
                  },
                ),
                AppGaps.v16,

                // Nachname
                KfTextField(
                  label: context.l.auth_registerLastName,
                  hint: context.l.auth_registerLastNameHint,
                  controller: _nachnameController,
                  prefixIcon: Icons.person_outlined,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l.auth_registerLastNameRequired;
                    }
                    return null;
                  },
                ),
                AppGaps.v16,

                // E-Mail
                KfTextField(
                  label: context.l.common_email,
                  hint: context.l.auth_registerEmailHint,
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l.auth_registerEmailRequired;
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value.trim())) {
                      return context.l.auth_registerEmailInvalid;
                    }
                    return null;
                  },
                ),
                AppGaps.v16,

                // Passwort
                KfTextField(
                  label: context.l.common_password,
                  hint: context.l.auth_registerPasswordMinLength,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outlined,
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l.auth_registerPasswordRequired;
                    }
                    if (value.length < 8) {
                      return context.l.auth_registerPasswordTooShort;
                    }
                    return null;
                  },
                ),
                AppGaps.v8,

                // Passwortstärke-Indikator
                if (_passwordController.text.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                    child: LinearProgressIndicator(
                      value: _passwordStrength,
                      backgroundColor:
                          AppColors.textSecondary.withValues(alpha: 0.2),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(_strengthColor()),
                      minHeight: 4,
                    ),
                  ),
                  AppGaps.v4,
                  Text(
                    _strengthLabel(),
                    style: TextStyle(
                      fontSize: DesignTokens.fontSm,
                      color: _strengthColor(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                AppGaps.v16,

                // Passwort bestätigen
                KfTextField(
                  label: context.l.auth_registerConfirmPassword,
                  hint: context.l.auth_registerConfirmPasswordHint,
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  prefixIcon: Icons.lock_outlined,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l.auth_registerConfirmPasswordRequired;
                    }
                    if (value != _passwordController.text) {
                      return context.l.auth_registerPasswordMismatch;
                    }
                    return null;
                  },
                ),
                AppGaps.v16,

                // Rollenauswahl
                DropdownButtonFormField<UserRole>(
                  initialValue: _selectedRole,
                  decoration: InputDecoration(
                    labelText: context.l.auth_registerRoleLabel,
                    labelStyle: TextStyle(
                      fontSize: DesignTokens.fontMd,
                      color: AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(
                      Icons.badge_outlined,
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacing16,
                      vertical: DesignTokens.spacing12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusSm),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusSm),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusSm),
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusSm),
                      borderSide: BorderSide(color: AppColors.error),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusSm),
                      borderSide:
                          BorderSide(color: AppColors.error, width: 2),
                    ),
                  ),
                  hint: Text(
                    context.l.auth_registerRoleHint,
                    style: TextStyle(
                      fontSize: DesignTokens.fontMd,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                  style: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    color: AppColors.textPrimary,
                  ),
                  items: UserRole.values.map((role) {
                    return DropdownMenuItem<UserRole>(
                      value: role,
                      child: Text(role.label(context)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return context.l.auth_registerRoleRequired;
                    }
                    return null;
                  },
                ),
                AppGaps.v16,

                // AGB-Checkbox
                FormField<bool>(
                  initialValue: _agbAccepted,
                  validator: (value) {
                    if (value != true) {
                      return context.l.auth_registerTermsRequired;
                    }
                    return null;
                  },
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: _agbAccepted,
                              activeColor: AppColors.primary,
                              onChanged: (value) {
                                setState(() {
                                  _agbAccepted = value ?? false;
                                });
                                formFieldState.didChange(value);
                              },
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _agbAccepted = !_agbAccepted;
                                  });
                                  formFieldState.didChange(_agbAccepted);
                                },
                                child: Text(
                                  context.l.auth_registerAcceptTerms,
                                  style: TextStyle(
                                    fontSize: DesignTokens.fontSm,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (formFieldState.hasError)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: DesignTokens.spacing16,
                              top: DesignTokens.spacing4,
                            ),
                            child: Text(
                              formFieldState.errorText!,
                              style: TextStyle(
                                fontSize: DesignTokens.fontSm,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                AppGaps.v16,

                // Fehlermeldung
                if (authProvider.errorMessage != null) ...[
                  Container(
                    width: double.infinity,
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
                        Icon(
                          Icons.error_outline,
                          color: AppColors.error,
                          size: DesignTokens.iconSm,
                        ),
                        AppGaps.h8,
                        Expanded(
                          child: Text(
                            authProvider.errorMessage!,
                            style: TextStyle(
                              fontSize: DesignTokens.fontSm,
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppGaps.v16,
                ],

                // Registrieren-Button
                KfButton(
                  label: context.l.auth_register,
                  onPressed: authProvider.isLoading ? null : _onSubmit,
                  isLoading: authProvider.isLoading,
                  isExpanded: true,
                ),
                AppGaps.v16,

                // Bereits ein Konto?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l.auth_alreadyHaveAccount,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: Text(context.l.auth_loginTitle),
                    ),
                  ],
                ),
                AppGaps.v16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

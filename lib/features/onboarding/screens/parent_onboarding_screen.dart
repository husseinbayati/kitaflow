import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/einladung_provider.dart';

class ParentOnboardingScreen extends StatefulWidget {
  const ParentOnboardingScreen({super.key});

  @override
  State<ParentOnboardingScreen> createState() =>
      _ParentOnboardingScreenState();
}

class _ParentOnboardingScreenState extends State<ParentOnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Step 1: Einladungscode
  final _codeController = TextEditingController();
  String? _codeError;

  @override
  void dispose() {
    _pageController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = page);
  }

  /// Step 1: Einladungscode validieren
  Future<void> _validateCode() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      setState(() => _codeError = 'Bitte gib einen Einladungscode ein.');
      return;
    }

    setState(() => _codeError = null);

    final provider = context.read<EinladungProvider>();
    final valid = await provider.validateCode(code);

    if (!mounted) return;

    if (valid) {
      _goToPage(1);
    } else {
      setState(() {
        _codeError = provider.errorMessage ?? 'Ungültiger Einladungscode.';
      });
    }
  }

  /// Step 2: Einladungscode einlösen
  Future<void> _redeemCode() async {
    final code = _codeController.text.trim();
    final userId = context.read<AuthProvider>().user?.id;
    if (userId == null) return;

    final provider = context.read<EinladungProvider>();
    final success = await provider.redeemCode(code, userId);

    if (!mounted) return;

    if (success) {
      _goToPage(2);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ?? 'Code konnte nicht eingelöst werden.',
          ),
        ),
      );
    }
  }

  /// Step 3: Onboarding abschließen
  void _onComplete() {
    context.read<EinladungProvider>().clearInvitation();
    context.go(AppRoutes.elternHome);
  }

  /// Onboarding überspringen
  void _skip() {
    context.read<EinladungProvider>().clearInvitation();
    context.go(AppRoutes.elternHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.onboarding_parentTitle),
      ),
      body: Column(
        children: [
          // Fortschrittsanzeige
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacing24,
              vertical: DesignTokens.spacing16,
            ),
            child: Row(
              children: List.generate(3, (index) {
                final isActive = index <= _currentPage;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacing4,
                    ),
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.2),
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusSm),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Seiten
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildStep1CodeEingabe(),
                _buildStep2Bestaetigung(),
                _buildStep3Fertig(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Step 1: Einladungscode eingeben und validieren.
  Widget _buildStep1CodeEingabe() {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l.onboarding_parentLinkChild,
            style: TextStyle(
              fontSize: DesignTokens.font2xl,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            'Gib den Einladungscode ein, den du von der Einrichtung erhalten hast.',
            style: TextStyle(
              fontSize: DesignTokens.fontMd,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing32),
          KfTextField(
            label: context.l.onboarding_parentCodeLabel,
            hint: context.l.onboarding_parentCodeHint,
            controller: _codeController,
            prefixIcon: Icons.vpn_key_outlined,
            textInputAction: TextInputAction.done,
          ),
          if (_codeError != null) ...[
            const SizedBox(height: DesignTokens.spacing8),
            Text(
              _codeError!,
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.error,
              ),
            ),
          ],
          const SizedBox(height: DesignTokens.spacing24),
          Consumer<EinladungProvider>(
            builder: (context, provider, _) {
              return KfButton(
                label: context.l.onboarding_parentCheckCode,
                onPressed: provider.isLoading ? null : _validateCode,
                isExpanded: true,
                isLoading: provider.isLoading,
              );
            },
          ),
          const SizedBox(height: DesignTokens.spacing12),
          Center(
            child: TextButton(
              onPressed: _skip,
              child: Text(context.l.common_skip),
            ),
          ),
        ],
      ),
    );
  }

  /// Step 2: Einladung bestätigen und einlösen.
  Widget _buildStep2Bestaetigung() {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.spacing24),
      child: Consumer<EinladungProvider>(
        builder: (context, provider, _) {
          final einladung = provider.validatedInvitation;
          return Column(
            children: [
              const Spacer(),
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: AppColors.success,
              ),
              const SizedBox(height: DesignTokens.spacing24),
              Text(
                context.l.onboarding_parentInvitationFound,
                style: TextStyle(
                  fontSize: DesignTokens.font2xl,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Text(
                einladung != null
                    ? 'Möchtest du die Einladung für diese Einrichtung annehmen?'
                    : 'Der Einladungscode ist gültig.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.textSecondary,
                ),
              ),
              if (einladung != null) ...[
                const SizedBox(height: DesignTokens.spacing16),
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: DesignTokens.iconMd,
                      ),
                      const SizedBox(width: DesignTokens.spacing12),
                      Expanded(
                        child: Text(
                          'Code: ${einladung.code}\n'
                          'Gültig bis: ${einladung.gueltigBis.day}.${einladung.gueltigBis.month}.${einladung.gueltigBis.year}',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSm,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              KfButton(
                label: context.l.onboarding_parentAcceptInvitation,
                onPressed: provider.isLoading ? null : _redeemCode,
                isExpanded: true,
                isLoading: provider.isLoading,
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Center(
                child: TextButton(
                  onPressed: () => _goToPage(0),
                  child: Text(context.l.common_back),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing24),
            ],
          );
        },
      ),
    );
  }

  /// Step 3: Abschluss – Willkommen.
  Widget _buildStep3Fertig() {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.spacing24),
      child: Column(
        children: [
          const Spacer(),
          Icon(
            Icons.celebration,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: DesignTokens.spacing24),
          Text(
            context.l.onboarding_parentWelcome,
            style: TextStyle(
              fontSize: DesignTokens.font2xl,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing12),
          Text(
            context.l.onboarding_parentChildLinked,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: DesignTokens.fontMd,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          KfButton(
            label: context.l.onboarding_parentLetsGo,
            onPressed: _onComplete,
            isExpanded: true,
          ),
          const SizedBox(height: DesignTokens.spacing24),
        ],
      ),
    );
  }
}

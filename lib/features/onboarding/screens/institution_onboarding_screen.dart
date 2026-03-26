import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';

class InstitutionOnboardingScreen extends StatefulWidget {
  const InstitutionOnboardingScreen({super.key});

  @override
  State<InstitutionOnboardingScreen> createState() =>
      _InstitutionOnboardingScreenState();
}

class _InstitutionOnboardingScreenState
    extends State<InstitutionOnboardingScreen> {
  int _currentStep = 0;

  // Step 1
  InstitutionType? _selectedType;

  // Step 2
  final _nameController = TextEditingController();
  final _strasseController = TextEditingController();
  final _plzController = TextEditingController();
  final _ortController = TextEditingController();
  final _bundeslandController = TextEditingController();
  final _telefonController = TextEditingController();
  final _emailController = TextEditingController();

  // Step 3
  final List<_GruppeData> _gruppen = [];

  // Step 4
  final List<TextEditingController> _einladungControllers = [];

  static const List<Color> _gruppenFarben = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _strasseController.dispose();
    _plzController.dispose();
    _ortController.dispose();
    _bundeslandController.dispose();
    _telefonController.dispose();
    _emailController.dispose();
    for (final gruppe in _gruppen) {
      gruppe.nameController.dispose();
      gruppe.maxKinderController.dispose();
    }
    for (final controller in _einladungControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool get _isGrundschule =>
      _selectedType == InstitutionType.grundschule;

  String get _gruppeLabel => _isGrundschule ? 'Klasse' : 'Gruppe';

  void _addGruppe() {
    setState(() {
      _gruppen.add(_GruppeData(
        nameController: TextEditingController(),
        maxKinderController: TextEditingController(),
        farbe: _gruppenFarben[_gruppen.length % _gruppenFarben.length],
      ));
    });
  }

  void _removeGruppe(int index) {
    setState(() {
      _gruppen[index].nameController.dispose();
      _gruppen[index].maxKinderController.dispose();
      _gruppen.removeAt(index);
    });
  }

  void _addEinladung() {
    setState(() {
      _einladungControllers.add(TextEditingController());
    });
  }

  void _removeEinladung(int index) {
    setState(() {
      _einladungControllers[index].dispose();
      _einladungControllers.removeAt(index);
    });
  }

  void _onStepContinue() {
    if (_currentStep == 0 && _selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l.onboarding_selectTypePrompt),
        ),
      );
      return;
    }

    if (_currentStep == 1 && _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l.onboarding_nameRequired),
        ),
      );
      return;
    }

    if (_currentStep < 3) {
      setState(() => _currentStep += 1);
    } else {
      _onComplete();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  void _onComplete() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l.onboarding_creatingInstitution)),
    );
    context.go(AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.onboarding_institutionTitle),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _currentStep > 0 ? _onStepCancel : null,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: DesignTokens.spacing16),
            child: Row(
              children: [
                KfButton(
                  label: _currentStep == 3
                      ? context.l.onboarding_institutionCreate
                      : context.l.common_next,
                  onPressed: details.onStepContinue,
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: DesignTokens.spacing12),
                  KfButton(
                    label: context.l.common_back,
                    variant: KfButtonVariant.outline,
                    onPressed: details.onStepCancel,
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text(context.l.onboarding_stepType),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: _buildStep1(),
          ),
          Step(
            title: Text(context.l.onboarding_stepData),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: _buildStep2(),
          ),
          Step(
            title: Text(context.l.onboarding_stepGroups),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            content: _buildStep3(),
          ),
          Step(
            title: Text(context.l.onboarding_stepStaff),
            isActive: _currentStep >= 3,
            state: StepState.indexed,
            content: _buildStep4(),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welche Art von Einrichtung möchtest du einrichten?',
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing12),
        Wrap(
          spacing: DesignTokens.spacing8,
          runSpacing: DesignTokens.spacing8,
          children: InstitutionType.values.map((type) {
            final isSelected = _selectedType == type;
            return ChoiceChip(
              label: Text(type.label(context)),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedType = type),
              selectedColor:
                  AppColors.primary.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textPrimary,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        KfTextField(
          label: context.l.onboarding_nameLabel,
          hint: 'z. B. Kita Sonnenschein',
          controller: _nameController,
          prefixIcon: Icons.business,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: DesignTokens.spacing12),
        KfTextField(
          label: context.l.onboarding_street,
          hint: 'Musterstraße 1',
          controller: _strasseController,
          prefixIcon: Icons.location_on_outlined,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: DesignTokens.spacing12),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: KfTextField(
                label: context.l.onboarding_zip,
                hint: '12345',
                controller: _plzController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: KfTextField(
                label: context.l.onboarding_city,
                hint: 'Musterstadt',
                controller: _ortController,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        const SizedBox(height: DesignTokens.spacing12),
        KfTextField(
          label: context.l.onboarding_state,
          hint: 'z. B. Nordrhein-Westfalen',
          controller: _bundeslandController,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: DesignTokens.spacing12),
        KfTextField(
          label: context.l.onboarding_phone,
          hint: '0221 1234567',
          controller: _telefonController,
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: DesignTokens.spacing12),
        KfTextField(
          label: context.l.onboarding_emailLabel,
          hint: 'info@kita-sonnenschein.de',
          controller: _emailController,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lege ${_gruppeLabel}n an, die du in deiner Einrichtung hast.',
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing16),
        ..._gruppen.asMap().entries.map((entry) {
          final index = entry.key;
          final gruppe = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: DesignTokens.spacing12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacing12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: KfTextField(
                            label: '${_gruppeLabel}name',
                            hint: _isGrundschule
                                ? 'z. B. Klasse 1a'
                                : 'z. B. Bärengruppe',
                            controller: gruppe.nameController,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: DesignTokens.spacing8),
                        IconButton(
                          onPressed: () => _removeGruppe(index),
                          icon: Icon(
                            Icons.delete_outline,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DesignTokens.spacing8),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: KfTextField(
                            label: context.l.onboarding_maxChildren,
                            hint: '25',
                            controller: gruppe.maxKinderController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: DesignTokens.spacing12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l.onboarding_color,
                                style: TextStyle(
                                  fontSize: DesignTokens.fontSm,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spacing4),
                              Wrap(
                                spacing: DesignTokens.spacing4,
                                children: _gruppenFarben.map((farbe) {
                                  final isSelected = gruppe.farbe == farbe;
                                  return GestureDetector(
                                    onTap: () => setState(
                                        () => gruppe.farbe = farbe),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: farbe,
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? Border.all(
                                                color: AppColors.textPrimary,
                                                width: 2.5,
                                              )
                                            : null,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: DesignTokens.spacing8),
        KfButton(
          label: context.l.onboarding_addGroup,
          icon: Icons.add,
          variant: KfButtonVariant.outline,
          onPressed: _addGruppe,
        ),
        const SizedBox(height: DesignTokens.spacing8),
        TextButton(
          onPressed: _onStepContinue,
          child: Text(context.l.common_skip),
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lade Mitarbeiter per E-Mail ein, um gemeinsam zu starten.',
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: DesignTokens.spacing16),
        ..._einladungControllers.asMap().entries.map((entry) {
          final index = entry.key;
          final controller = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: DesignTokens.spacing8),
            child: Row(
              children: [
                Expanded(
                  child: KfTextField(
                    hint: 'kollegin@beispiel.de',
                    controller: controller,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing8),
                IconButton(
                  onPressed: () => _removeEinladung(index),
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: DesignTokens.spacing8),
        KfButton(
          label: context.l.onboarding_addInvitation,
          icon: Icons.person_add_outlined,
          variant: KfButtonVariant.outline,
          onPressed: _addEinladung,
        ),
        const SizedBox(height: DesignTokens.spacing8),
        TextButton(
          onPressed: _onComplete,
          child: Text(context.l.common_skip),
        ),
      ],
    );
  }
}

class _GruppeData {
  _GruppeData({
    required this.nameController,
    required this.maxKinderController,
    required this.farbe,
  });

  final TextEditingController nameController;
  final TextEditingController maxKinderController;
  Color farbe;
}

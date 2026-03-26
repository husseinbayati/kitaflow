import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../core/widgets/kf_role_guard.dart';
import '../../../data/models/einrichtung.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/einrichtung_provider.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

/// Formular zum Bearbeiten der Einrichtungsdaten.
/// Nur für Leitung und Träger zugänglich.
class EinrichtungFormScreen extends StatefulWidget {
  const EinrichtungFormScreen({super.key});

  @override
  State<EinrichtungFormScreen> createState() => _EinrichtungFormScreenState();
}

class _EinrichtungFormScreenState extends State<EinrichtungFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _strasseController;
  late final TextEditingController _plzController;
  late final TextEditingController _ortController;
  late final TextEditingController _bundeslandController;
  late final TextEditingController _telefonController;
  late final TextEditingController _emailController;
  late final TextEditingController _websiteController;

  InstitutionType? _selectedTyp;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _strasseController = TextEditingController();
    _plzController = TextEditingController();
    _ortController = TextEditingController();
    _bundeslandController = TextEditingController();
    _telefonController = TextEditingController();
    _emailController = TextEditingController();
    _websiteController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAndPopulate());
  }

  Future<void> _loadAndPopulate() async {
    final einrichtungId = context.read<AuthProvider>().user?.einrichtungId;
    if (einrichtungId == null) return;

    final provider = context.read<EinrichtungProvider>();
    if (provider.einrichtung == null) {
      await provider.loadEinrichtung(einrichtungId);
    }
    _populateFields(provider.einrichtung);
  }

  void _populateFields(Einrichtung? einrichtung) {
    if (einrichtung == null || _initialized) return;
    _nameController.text = einrichtung.name;
    _strasseController.text = einrichtung.adresseStrasse ?? '';
    _plzController.text = einrichtung.adressePlz ?? '';
    _ortController.text = einrichtung.adresseOrt ?? '';
    _bundeslandController.text = einrichtung.adresseBundesland ?? '';
    _telefonController.text = einrichtung.telefon ?? '';
    _emailController.text = einrichtung.email ?? '';
    _websiteController.text = einrichtung.website ?? '';
    setState(() {
      _selectedTyp = einrichtung.typ;
      _initialized = true;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _strasseController.dispose();
    _plzController.dispose();
    _ortController.dispose();
    _bundeslandController.dispose();
    _telefonController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<EinrichtungProvider>();
    final einrichtung = provider.einrichtung;
    if (einrichtung == null) return;

    final updates = <String, dynamic>{
      'name': _nameController.text.trim(),
      'typ': _selectedTyp?.name ?? einrichtung.typ.name,
      'adresse_strasse': _strasseController.text.trim(),
      'adresse_plz': _plzController.text.trim(),
      'adresse_ort': _ortController.text.trim(),
      'adresse_bundesland': _bundeslandController.text.trim(),
      'telefon': _telefonController.text.trim(),
      'email': _emailController.text.trim(),
      'website': _websiteController.text.trim(),
    };

    final success = await provider.updateEinrichtung(einrichtung.id, updates);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l.verwaltung_institutionFormSaveSuccess),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ?? context.l.verwaltung_institutionFormSaveError,
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return KfRoleGuard(
      allowedRoles: const [UserRole.leitung, UserRole.traeger],
      child: Scaffold(
        appBar: AppBar(title: Text(context.l.verwaltung_institutionFormTitle)),
        body: Consumer<EinrichtungProvider>(
          builder: (context, provider, _) {
            // Felder befüllen, falls noch nicht geschehen
            if (!_initialized && provider.einrichtung != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _populateFields(provider.einrichtung);
              });
            }

            if (provider.isLoading && !_initialized) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.hasError && !_initialized) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: DesignTokens.iconXl, color: AppColors.error),
                    AppGaps.v12,
                    Text(
                      provider.errorMessage ?? context.l.verwaltung_institutionFormLoadError,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    AppGaps.v16,
                    KfButton(
                      label: context.l.common_retry,
                      variant: KfButtonVariant.outline,
                      onPressed: _loadAndPopulate,
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: AppPadding.screen,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Allgemein ---
                    Text(
                      context.l.verwaltung_institutionFormSectionGeneral,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    AppGaps.v12,
                    KfTextField(
                      label: context.l.verwaltung_institutionFormName,
                      controller: _nameController,
                      prefixIcon: Icons.business,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? context.l.verwaltung_institutionFormNameRequired
                          : null,
                      textInputAction: TextInputAction.next,
                    ),
                    AppGaps.v16,
                    KfDropdown<InstitutionType>(
                      label: context.l.verwaltung_institutionFormType,
                      value: _selectedTyp,
                      hint: context.l.verwaltung_institutionFormTypeHint,
                      items: InstitutionType.values
                          .map(
                            (t) => DropdownMenuItem(
                              value: t,
                              child: Text(t.label(context)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedTyp = v),
                      validator: (v) =>
                          v == null ? context.l.verwaltung_institutionFormTypeRequired : null,
                    ),

                    AppGaps.v24,

                    // --- Adresse ---
                    Text(
                      context.l.verwaltung_institutionFormSectionAddress,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    AppGaps.v12,
                    KfTextField(
                      label: context.l.verwaltung_institutionFormStreet,
                      controller: _strasseController,
                      prefixIcon: Icons.location_on,
                      textInputAction: TextInputAction.next,
                    ),
                    AppGaps.v16,
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: KfTextField(
                            label: context.l.verwaltung_institutionFormZip,
                            controller: _plzController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        AppGaps.h12,
                        Expanded(
                          child: KfTextField(
                            label: context.l.verwaltung_institutionFormCity,
                            controller: _ortController,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    AppGaps.v16,
                    KfTextField(
                      label: context.l.verwaltung_institutionFormState,
                      controller: _bundeslandController,
                      textInputAction: TextInputAction.next,
                    ),

                    AppGaps.v24,

                    // --- Kontakt ---
                    Text(
                      context.l.verwaltung_institutionFormSectionContact,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    AppGaps.v12,
                    KfTextField(
                      label: context.l.verwaltung_institutionFormPhone,
                      controller: _telefonController,
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    AppGaps.v16,
                    KfTextField(
                      label: context.l.verwaltung_institutionFormEmail,
                      controller: _emailController,
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v != null && v.trim().isNotEmpty) {
                          if (!v.contains('@') || !v.contains('.')) {
                            return context.l.verwaltung_institutionFormEmailInvalid;
                          }
                        }
                        return null;
                      },
                    ),
                    AppGaps.v16,
                    KfTextField(
                      label: context.l.verwaltung_institutionFormWebsite,
                      controller: _websiteController,
                      prefixIcon: Icons.language,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                    ),

                    AppGaps.v32,

                    // --- Speichern ---
                    KfButton(
                      label: context.l.common_save,
                      icon: Icons.save,
                      isExpanded: true,
                      isLoading: provider.isLoading,
                      onPressed: provider.isLoading ? null : _save,
                    ),

                    AppGaps.v24,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

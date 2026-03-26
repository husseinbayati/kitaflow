import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/kontaktperson.dart';
import '../../../presentation/providers/kind_provider.dart';

/// Bottom-Sheet-Formular zum Hinzufügen oder Bearbeiten einer Kontaktperson.
class KontaktpersonForm extends StatefulWidget {
  const KontaktpersonForm({
    super.key,
    required this.kindId,
    this.kontaktperson,
  });

  final String kindId;

  /// Wenn gesetzt, wird die Kontaktperson bearbeitet. Sonst neu angelegt.
  final Kontaktperson? kontaktperson;

  /// Zeigt das Formular als modales Bottom Sheet an.
  static Future<void> show(
    BuildContext context,
    String kindId, [
    Kontaktperson? kp,
  ]) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusLg),
        ),
      ),
      builder: (ctx) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: KontaktpersonForm(kindId: kindId, kontaktperson: kp),
      ),
    );
  }

  @override
  State<KontaktpersonForm> createState() => _KontaktpersonFormState();
}

class _KontaktpersonFormState extends State<KontaktpersonForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _beziehungController = TextEditingController();
  final _telefonController = TextEditingController();
  final _emailController = TextEditingController();

  bool _istAbholberechtigt = false;
  bool _istNotfallkontakt = false;
  int _prioritaet = 1;

  bool get _isEdit => widget.kontaktperson != null;

  @override
  void initState() {
    super.initState();
    if (widget.kontaktperson != null) {
      final kp = widget.kontaktperson!;
      _nameController.text = kp.name;
      _beziehungController.text = kp.beziehung;
      _telefonController.text = kp.telefon ?? '';
      _emailController.text = kp.email ?? '';
      _istAbholberechtigt = kp.istAbholberechtigt;
      _istNotfallkontakt = kp.istNotfallkontakt;
      _prioritaet = kp.prioritaet;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _beziehungController.dispose();
    _telefonController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final kp = Kontaktperson(
      id: _isEdit ? widget.kontaktperson!.id : '',
      kindId: widget.kindId,
      name: _nameController.text.trim(),
      beziehung: _beziehungController.text.trim(),
      telefon: _telefonController.text.trim().isEmpty
          ? null
          : _telefonController.text.trim(),
      email: _emailController.text.trim().isEmpty
          ? null
          : _emailController.text.trim(),
      istAbholberechtigt: _istAbholberechtigt,
      istNotfallkontakt: _istNotfallkontakt,
      prioritaet: _prioritaet,
      erstelltAm: _isEdit
          ? widget.kontaktperson!.erstelltAm
          : DateTime.now(),
    );

    final provider = context.read<KindProvider>();
    bool success;

    if (_isEdit) {
      success = await provider.updateKontaktperson(kp);
    } else {
      success = await provider.addKontaktperson(kp);
    }

    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Griff-Indikator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin:
                      const EdgeInsets.only(bottom: DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusFull),
                  ),
                ),
              ),

              // Titel
              Text(
                _isEdit ? context.l.kinder_contactFormEditTitle : context.l.kinder_contactFormAddTitle,
                style: TextStyle(
                  fontSize: DesignTokens.fontLg,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name
                    KfTextField(
                      label: context.l.kinder_contactFormName,
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.l.kinder_contactFormNameRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: DesignTokens.spacing8),

                    // Beziehung
                    KfTextField(
                      label: context.l.kinder_contactFormRelation,
                      hint: context.l.kinder_contactFormRelationHint,
                      controller: _beziehungController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.l.kinder_contactFormRelationRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: DesignTokens.spacing8),

                    // Telefon
                    KfTextField(
                      label: context.l.kinder_contactFormPhone,
                      controller: _telefonController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_outlined,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: DesignTokens.spacing8),

                    // E-Mail
                    KfTextField(
                      label: context.l.kinder_contactFormEmail,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: DesignTokens.spacing12),

                    // Abholberechtigt
                    SwitchListTile(
                      title: Text(
                        context.l.kinder_contactFormPickupAuthorized,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontMd,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        context.l.kinder_contactFormPickupDescription,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSm,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      value: _istAbholberechtigt,
                      onChanged: (value) =>
                          setState(() => _istAbholberechtigt = value),
                      activeTrackColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    ),

                    // Notfallkontakt
                    SwitchListTile(
                      title: Text(
                        context.l.kinder_contactFormEmergencyContact,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontMd,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        context.l.kinder_contactFormEmergencyDescription,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSm,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      value: _istNotfallkontakt,
                      onChanged: (value) =>
                          setState(() => _istNotfallkontakt = value),
                      activeTrackColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: DesignTokens.spacing16),

                    // Speichern
                    Consumer<KindProvider>(
                      builder: (context, provider, _) {
                        return KfButton(
                          label: _isEdit
                              ? context.l.kinder_contactFormSave
                              : context.l.kinder_detailAddContact,
                          isLoading: provider.isLoading,
                          onPressed:
                              provider.isLoading ? null : _save,
                          isExpanded: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

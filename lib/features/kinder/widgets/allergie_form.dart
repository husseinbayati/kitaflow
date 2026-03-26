import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/allergie.dart';
import '../../../presentation/providers/kind_provider.dart';

/// Bottom-Sheet-Formular zum Hinzufügen einer Allergie.
class AllergieForm extends StatefulWidget {
  const AllergieForm({super.key, required this.kindId});

  final String kindId;

  /// Zeigt das Formular als modales Bottom Sheet an.
  static Future<void> show(BuildContext context, String kindId) {
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
        child: AllergieForm(kindId: kindId),
      ),
    );
  }

  @override
  State<AllergieForm> createState() => _AllergieFormState();
}

class _AllergieFormState extends State<AllergieForm> {
  Allergen? _selectedAllergen;
  AllergySeverity _schweregrad = AllergySeverity.mittel;
  final _hinweiseController = TextEditingController();

  @override
  void dispose() {
    _hinweiseController.dispose();
    super.dispose();
  }

  Color _severityColor(AllergySeverity severity) {
    return switch (severity) {
      AllergySeverity.leicht => AppColors.success,
      AllergySeverity.mittel => AppColors.warning,
      AllergySeverity.schwer => AppColors.accentDark,
      AllergySeverity.lebensbedrohlich => AppColors.error,
    };
  }

  Color _severityBgColor(AllergySeverity severity) {
    return switch (severity) {
      AllergySeverity.leicht => AppColors.successLight,
      AllergySeverity.mittel => AppColors.warningLight,
      AllergySeverity.schwer => AppColors.accentLight,
      AllergySeverity.lebensbedrohlich => AppColors.errorLight,
    };
  }

  Future<void> _save() async {
    if (_selectedAllergen == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.kinder_allergyFormAllergenRequired)),
      );
      return;
    }

    final allergie = Allergie(
      id: '',
      kindId: widget.kindId,
      allergen: _selectedAllergen!,
      schweregrad: _schweregrad,
      hinweise: _hinweiseController.text.trim().isEmpty
          ? null
          : _hinweiseController.text.trim(),
      erstelltAm: DateTime.now(),
    );

    final success =
        await context.read<KindProvider>().addAllergie(allergie);

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
                context.l.kinder_allergyFormTitle,
                style: TextStyle(
                  fontSize: DesignTokens.fontLg,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Allergen-Auswahl
              Text(
                context.l.kinder_allergyFormAllergen,
                style: TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing8),
              Wrap(
                spacing: DesignTokens.spacing8,
                runSpacing: DesignTokens.spacing8,
                children: Allergen.values.map((allergen) {
                  final isSelected = _selectedAllergen == allergen;
                  return FilterChip(
                    label: Text(allergen.label(context)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedAllergen = selected ? allergen : null;
                      });
                    },
                    selectedColor:
                        AppColors.primaryLight.withValues(alpha: 0.3),
                    checkmarkColor: AppColors.primaryDark,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.primaryDark
                          : AppColors.textPrimary,
                      fontSize: DesignTokens.fontSm,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Schweregrad
              Text(
                context.l.kinder_allergyFormSeverity,
                style: TextStyle(
                  fontSize: DesignTokens.fontSm,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing8),
              Wrap(
                spacing: DesignTokens.spacing8,
                runSpacing: DesignTokens.spacing8,
                children: AllergySeverity.values.map((severity) {
                  final isSelected = _schweregrad == severity;
                  return ChoiceChip(
                    label: Text(severity.label(context)),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _schweregrad = severity);
                      }
                    },
                    selectedColor: _severityBgColor(severity),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? _severityColor(severity)
                          : AppColors.textPrimary,
                      fontSize: DesignTokens.fontSm,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Hinweise
              KfTextField(
                label: context.l.kinder_allergyFormHints,
                hint: context.l.kinder_allergyFormHintsPlaceholder,
                controller: _hinweiseController,
                maxLines: 2,
              ),
              const SizedBox(height: DesignTokens.spacing24),

              // Speichern
              Consumer<KindProvider>(
                builder: (context, provider, _) {
                  return KfButton(
                    label: context.l.kinder_detailAddAllergy,
                    isLoading: provider.isLoading,
                    onPressed: provider.isLoading ? null : _save,
                    isExpanded: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/supabase_config.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/essensplan.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/essensplan_provider.dart';

/// Formular zum Erstellen oder Bearbeiten eines Essensplan-Eintrags.
class EssensplanFormScreen extends StatefulWidget {
  const EssensplanFormScreen({
    super.key,
    this.existingPlan,
    this.initialDatum,
  });

  /// Wenn gesetzt, wird der Eintrag bearbeitet. Sonst wird ein neuer erstellt.
  final Essensplan? existingPlan;

  /// Optionales Datum für neue Einträge (z.B. aus Kalenderansicht).
  final DateTime? initialDatum;

  @override
  State<EssensplanFormScreen> createState() => _EssensplanFormScreenState();
}

class _EssensplanFormScreenState extends State<EssensplanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _gerichtNameController = TextEditingController();
  final _beschreibungController = TextEditingController();

  MealType _selectedTyp = MealType.mittagessen;
  List<String> _selectedAllergene = [];
  bool _vegetarisch = false;
  bool _vegan = false;
  bool _isLoading = false;
  late DateTime _selectedDatum;

  bool get _isEditMode => widget.existingPlan != null;

  @override
  void initState() {
    super.initState();
    _selectedDatum =
        widget.existingPlan?.datum ?? widget.initialDatum ?? DateTime.now();

    if (widget.existingPlan != null) {
      final plan = widget.existingPlan!;
      _gerichtNameController.text = plan.gerichtName;
      _beschreibungController.text = plan.beschreibung ?? '';
      _selectedTyp = plan.mahlzeitTyp;
      _selectedAllergene = List<String>.from(plan.allergene);
      _vegetarisch = plan.vegetarisch;
      _vegan = plan.vegan;
    }
  }

  @override
  void dispose() {
    _gerichtNameController.dispose();
    _beschreibungController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDatum,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 90)),
      locale: const Locale('de', 'DE'),
    );
    if (picked != null) {
      setState(() => _selectedDatum = picked);
    }
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = context.read<AuthProvider>();
      final essensplanProvider = context.read<EssensplanProvider>();
      final einrichtungId = authProvider.user?.einrichtungId ?? '';

      if (_isEditMode) {
        // Bearbeitungsmodus: nur geänderte Felder senden
        final updates = <String, dynamic>{
          'datum':
              '${_selectedDatum.year.toString().padLeft(4, '0')}-${_selectedDatum.month.toString().padLeft(2, '0')}-${_selectedDatum.day.toString().padLeft(2, '0')}',
          'mahlzeit_typ': _selectedTyp.name,
          'gericht_name': _gerichtNameController.text.trim(),
          'beschreibung': _beschreibungController.text.trim().isEmpty
              ? null
              : _beschreibungController.text.trim(),
          'allergene': _selectedAllergene,
          'vegetarisch': _vegetarisch,
          'vegan': _vegan,
        };

        final success = await essensplanProvider.updateEssensplan(
          widget.existingPlan!.id,
          updates,
        );

        if (mounted) {
          if (success) {
            context.pop();
          } else {
            _showError('Mahlzeit konnte nicht aktualisiert werden.');
          }
        }
      } else {
        // Erstellungsmodus: neues Essensplan-Objekt
        final plan = Essensplan(
          id: '',
          einrichtungId: einrichtungId,
          datum: _selectedDatum,
          mahlzeitTyp: _selectedTyp,
          gerichtName: _gerichtNameController.text.trim(),
          beschreibung: _beschreibungController.text.trim().isEmpty
              ? null
              : _beschreibungController.text.trim(),
          allergene: _selectedAllergene,
          vegetarisch: _vegetarisch,
          vegan: _vegan,
          erstelltVon: SupabaseConfig.currentUser?.id,
          erstelltAm: DateTime.now(),
        );

        final success = await essensplanProvider.createEssensplan(plan);

        if (mounted) {
          if (success) {
            context.pop();
          } else {
            _showError('Mahlzeit konnte nicht erstellt werden.');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        _showError('Ein Fehler ist aufgetreten: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? context.l.essensplan_formEditTitle : context.l.essensplan_formNewTitle),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Datum
              _buildDatumField(),
              AppGaps.v16,

              // 2. Mahlzeit-Typ
              _buildMahlzeitTypField(),
              AppGaps.v16,

              // 3. Gericht-Name
              KfTextField(
                label: context.l.essensplan_formDishName,
                controller: _gerichtNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l.essensplan_formDishNameRequired;
                  }
                  return null;
                },
              ),
              AppGaps.v16,

              // 4. Beschreibung
              KfTextField(
                label: context.l.essensplan_formDescription,
                controller: _beschreibungController,
                maxLines: 3,
              ),
              AppGaps.v16,

              // 5. Allergene
              _buildAllergeneSection(),
              AppGaps.v16,

              // 6. Vegetarisch
              SwitchListTile(
                title: Text(context.l.essensplan_formVegetarian),
                value: _vegetarisch,
                activeTrackColor: AppColors.success,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() => _vegetarisch = value);
                },
              ),

              // 7. Vegan
              SwitchListTile(
                title: Text(context.l.essensplan_formVegan),
                value: _vegan,
                activeTrackColor: AppColors.success,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _vegan = value;
                    // Vegan impliziert vegetarisch
                    if (value) _vegetarisch = true;
                  });
                },
              ),
              AppGaps.v24,

              // 8. Speichern
              KfButton(
                label: context.l.essensplan_formSave,
                onPressed: _isLoading ? null : _onSave,
                isExpanded: true,
                isLoading: _isLoading,
                icon: Icons.save,
              ),
              AppGaps.v16,
            ],
          ),
        ),
      ),
    );
  }

  /// Datumsauswahl als anklickbares Feld.
  Widget _buildDatumField() {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: context.l.essensplan_formDate,
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            borderSide: BorderSide(color: AppColors.border),
          ),
          suffixIcon:
              Icon(Icons.calendar_today, color: AppColors.textSecondary),
        ),
        child: Text(
          _formatDate(_selectedDatum),
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  /// Mahlzeit-Typ als ChoiceChip-Reihe.
  Widget _buildMahlzeitTypField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l.essensplan_formMealType,
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            color: AppColors.textSecondary,
          ),
        ),
        AppGaps.v8,
        Row(
          children: MealType.values.map((typ) {
            final isSelected = _selectedTyp == typ;
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: DesignTokens.spacing8),
              child: ChoiceChip(
                label: Text(typ.label(context)),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedTyp = typ),
                selectedColor: AppColors.primaryLight,
                labelStyle: TextStyle(
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Allergene-Auswahl als FilterChips.
  Widget _buildAllergeneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l.essensplan_formAllergens,
          style: TextStyle(
            fontSize: DesignTokens.fontMd,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        AppGaps.v8,
        Wrap(
          spacing: DesignTokens.spacing8,
          runSpacing: DesignTokens.spacing8,
          children: Allergen.values.map((allergen) {
            final isSelected = _selectedAllergene.contains(allergen.name);
            return FilterChip(
              label: Text(allergen.label(context)),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAllergene.add(allergen.name);
                  } else {
                    _selectedAllergene.remove(allergen.name);
                  }
                });
              },
              selectedColor: AppColors.warningLight,
              checkmarkColor: AppColors.warning,
            );
          }).toList(),
        ),
      ],
    );
  }
}

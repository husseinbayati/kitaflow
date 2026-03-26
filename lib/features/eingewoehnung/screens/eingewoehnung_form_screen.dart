import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/eingewoehnung.dart';
import '../../../presentation/providers/eingewoehnung_provider.dart';
import '../../../presentation/providers/kind_provider.dart';
import '../../../presentation/providers/mitarbeiter_provider.dart';

/// Formular zum Erstellen einer neuen Eingewöhnung.
class EingewoehnungFormScreen extends StatefulWidget {
  const EingewoehnungFormScreen({super.key});

  @override
  State<EingewoehnungFormScreen> createState() =>
      _EingewoehnungFormScreenState();
}

class _EingewoehnungFormScreenState extends State<EingewoehnungFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedKindId;
  DateTime? _startdatum = DateTime.now();
  String? _selectedBezugspersonId;
  final _notizenController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _notizenController.dispose();
    super.dispose();
  }

  Future<void> _pickStartdatum() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startdatum ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _startdatum = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startdatum == null) return;

    setState(() => _isSubmitting = true);

    final eingewoehnungProvider = context.read<EingewoehnungProvider>();

    final eingewoehnung = Eingewoehnung(
      id: '',
      kindId: _selectedKindId!,
      startdatum: _startdatum!,
      phase: EingewoehnungPhase.grundphase,
      bezugspersonId: _selectedBezugspersonId,
      notizen: _notizenController.text.isNotEmpty
          ? _notizenController.text
          : null,
      erstelltAm: DateTime.now(),
    );

    final success =
        await eingewoehnungProvider.createEingewoehnung(eingewoehnung);

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.eingewoehnung_neueEingewoehnung)),
      );
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l.common_error),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.eingewoehnung_neueEingewoehnung),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Kind Dropdown
              Consumer<KindProvider>(
                builder: (context, kindProvider, _) {
                  final eingewoehnungsKinder = kindProvider.kinder
                      .where((k) => k.status == ChildStatus.eingewoehnung)
                      .toList();
                  return DropdownButtonFormField<String>(
                    value: _selectedKindId,
                    decoration: InputDecoration(
                      labelText: context.l.eingewoehnung_kindAuswaehlen,
                      helperText: context.l.eingewoehnung_nurEingewoehnung,
                      filled: true,
                      fillColor: AppColors.surface,
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
                    ),
                    items: eingewoehnungsKinder
                        .map((kind) => DropdownMenuItem<String>(
                              value: kind.id,
                              child: Text(
                                  '${kind.vorname} ${kind.nachname}'),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedKindId = value),
                    validator: (value) => value == null
                        ? context.l.common_requiredField
                        : null,
                  );
                },
              ),
              AppGaps.v16,

              // 2. Startdatum
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: DesignTokens.iconMd,
                      color: AppColors.textSecondary),
                  AppGaps.h8,
                  Text(
                    '${context.l.eingewoehnung_startdatum}: '
                    '${_startdatum != null ? _formatDate(_startdatum!) : '–'}',
                    style: TextStyle(
                      fontSize: DesignTokens.fontMd,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit_calendar),
                    onPressed: _pickStartdatum,
                  ),
                ],
              ),
              AppGaps.v16,

              // 3. Bezugsperson Dropdown
              Consumer<MitarbeiterProvider>(
                builder: (context, mitarbeiterProvider, _) {
                  final mitarbeiterList = mitarbeiterProvider.mitarbeiter;
                  return DropdownButtonFormField<String?>(
                    value: _selectedBezugspersonId,
                    decoration: InputDecoration(
                      labelText: context.l.eingewoehnung_bezugsperson,
                      filled: true,
                      fillColor: AppColors.surface,
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
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('– Keine –'),
                      ),
                      ...mitarbeiterList.map((m) => DropdownMenuItem<String?>(
                            value: m['mitarbeiter_id'] as String?,
                            child: Text(
                                '${m['vorname'] ?? ''} ${m['nachname'] ?? ''}'),
                          )),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedBezugspersonId = value),
                  );
                },
              ),
              AppGaps.v16,

              // 4. Notizen
              KfTextField(
                label: 'Notizen',
                controller: _notizenController,
                maxLines: 3,
                prefixIcon: Icons.notes,
              ),
              AppGaps.v24,

              // 5. Save Button
              KfButton(
                label: context.l.common_save,
                isExpanded: true,
                isLoading: _isSubmitting,
                onPressed: _isSubmitting ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

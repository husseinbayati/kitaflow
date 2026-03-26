import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/gruppe.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/gruppe_provider.dart';
import '../../../core/extensions/l10n_extension.dart';

class GruppeFormScreen extends StatefulWidget {
  final String? gruppeId;
  const GruppeFormScreen({super.key, this.gruppeId});
  @override
  State<GruppeFormScreen> createState() => _GruppeFormScreenState();
}

class _GruppeFormScreenState extends State<GruppeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _maxKinderController;
  late TextEditingController _alterVonController;
  late TextEditingController _alterBisController;
  late TextEditingController _schuljahrController;
  String _selectedTyp = 'gruppe';
  String? _selectedFarbe;
  bool _aktiv = true;
  bool _initialized = false;

  bool get isEditMode => widget.gruppeId != null;

  // Predefined colors for groups
  static const List<String> _verfuegbareFarben = [
    '#FF6B6B', '#FF9F43', '#FECA57', '#48DBFB', '#0ABDE3',
    '#10AC84', '#1DD1A1', '#5F27CD', '#341F97', '#2E86DE',
    '#54A0FF', '#C44569',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _maxKinderController = TextEditingController();
    _alterVonController = TextEditingController();
    _alterBisController = TextEditingController();
    _schuljahrController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initForm());
  }

  void _initForm() {
    if (isEditMode && !_initialized) {
      final gruppen = context.read<GruppeProvider>().gruppen;
      final gruppe =
          gruppen.where((g) => g.id == widget.gruppeId).firstOrNull;
      if (gruppe != null) {
        _nameController.text = gruppe.name;
        _maxKinderController.text = gruppe.maxKinder?.toString() ?? '';
        _alterVonController.text =
            gruppe.altersspanneVon?.toString() ?? '';
        _alterBisController.text =
            gruppe.altersspanneBis?.toString() ?? '';
        _schuljahrController.text = gruppe.schuljahr ?? '';
        _selectedTyp = gruppe.typ;
        _selectedFarbe = gruppe.farbe;
        _aktiv = gruppe.aktiv;
        setState(() => _initialized = true);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _maxKinderController.dispose();
    _alterVonController.dispose();
    _alterBisController.dispose();
    _schuljahrController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<GruppeProvider>();
    final einrichtungId =
        context.read<AuthProvider>().user?.einrichtungId ?? '';

    bool success;
    if (isEditMode) {
      success = await provider.updateGruppe(widget.gruppeId!, {
        'name': _nameController.text.trim(),
        'typ': _selectedTyp,
        'max_kinder': _maxKinderController.text.isNotEmpty
            ? int.tryParse(_maxKinderController.text)
            : null,
        'altersspanne_von': _alterVonController.text.isNotEmpty
            ? int.tryParse(_alterVonController.text)
            : null,
        'altersspanne_bis': _alterBisController.text.isNotEmpty
            ? int.tryParse(_alterBisController.text)
            : null,
        'farbe': _selectedFarbe,
        'schuljahr': _schuljahrController.text.isNotEmpty
            ? _schuljahrController.text.trim()
            : null,
        'aktiv': _aktiv,
      });
    } else {
      success = await provider.createGruppe(Gruppe(
        id: '',
        einrichtungId: einrichtungId,
        name: _nameController.text.trim(),
        typ: _selectedTyp,
        maxKinder: _maxKinderController.text.isNotEmpty
            ? int.tryParse(_maxKinderController.text)
            : null,
        altersspanneVon: _alterVonController.text.isNotEmpty
            ? int.tryParse(_alterVonController.text)
            : null,
        altersspanneBis: _alterBisController.text.isNotEmpty
            ? int.tryParse(_alterBisController.text)
            : null,
        farbe: _selectedFarbe,
        aktiv: _aktiv,
        schuljahr: _schuljahrController.text.isNotEmpty
            ? _schuljahrController.text.trim()
            : null,
        erstelltAm: DateTime.now(),
      ));
    }

    if (success && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? context.l.verwaltung_groupFormEditTitle : context.l.verwaltung_groupFormNewTitle),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KfTextField(
                label: context.l.verwaltung_groupFormName,
                controller: _nameController,
                validator: (v) =>
                    v == null || v.isEmpty ? context.l.verwaltung_groupFormNameRequired : null,
              ),
              AppGaps.v16,
              // Typ Dropdown
              DropdownButtonFormField<String>(
                value: _selectedTyp,
                decoration: InputDecoration(labelText: context.l.verwaltung_groupFormType),
                items: [
                  DropdownMenuItem(
                    value: 'gruppe',
                    child: Text(context.l.verwaltung_groupFormTypeGroup),
                  ),
                  DropdownMenuItem(
                    value: 'klasse',
                    child: Text(context.l.verwaltung_groupFormTypeClass),
                  ),
                ],
                onChanged: (v) => setState(() => _selectedTyp = v!),
              ),
              AppGaps.v16,
              KfTextField(
                label: context.l.verwaltung_groupFormMaxChildren,
                controller: _maxKinderController,
                keyboardType: TextInputType.number,
              ),
              AppGaps.v16,
              Row(
                children: [
                  Expanded(
                    child: KfTextField(
                      label: context.l.verwaltung_groupFormAgeFrom,
                      controller: _alterVonController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  AppGaps.h16,
                  Expanded(
                    child: KfTextField(
                      label: context.l.verwaltung_groupFormAgeTo,
                      controller: _alterBisController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              AppGaps.v16,
              KfTextField(
                label: context.l.verwaltung_groupFormSchoolYear,
                controller: _schuljahrController,
                hint: 'z.B. 2025/2026',
              ),
              AppGaps.v16,
              // Farbe
              Text(context.l.verwaltung_groupFormColor, style: Theme.of(context).textTheme.bodyMedium),
              AppGaps.v8,
              Wrap(
                spacing: DesignTokens.spacing8,
                runSpacing: DesignTokens.spacing8,
                children: _verfuegbareFarben.map((hex) {
                  final color = Color(
                    int.parse(hex.replaceFirst('#', '0xFF')),
                  );
                  final isSelected = _selectedFarbe == hex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFarbe = hex),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.black, width: 3)
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
              if (isEditMode) ...[
                AppGaps.v16,
                SwitchListTile(
                  title: Text(context.l.verwaltung_groupFormActive),
                  value: _aktiv,
                  onChanged: (v) => setState(() => _aktiv = v),
                ),
              ],
              AppGaps.v24,
              SizedBox(
                width: double.infinity,
                child: Consumer<GruppeProvider>(
                  builder: (context, provider, _) {
                    return FilledButton(
                      onPressed: provider.isLoading ? null : _save,
                      child: provider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              isEditMode ? context.l.verwaltung_groupFormSave : context.l.verwaltung_groupFormCreate,
                            ),
                    );
                  },
                ),
              ),
              AppGaps.v32,
            ],
          ),
        ),
      ),
    );
  }
}

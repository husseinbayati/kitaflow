import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/kind.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/kind_provider.dart';

/// Formular zum Erstellen oder Bearbeiten eines Kindes.
class KindFormScreen extends StatefulWidget {
  const KindFormScreen({super.key, this.kindId});

  /// Wenn gesetzt, wird das Kind bearbeitet. Sonst wird ein neues Kind erstellt.
  final String? kindId;

  @override
  State<KindFormScreen> createState() => _KindFormScreenState();
}

class _KindFormScreenState extends State<KindFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vornameController = TextEditingController();
  final _nachnameController = TextEditingController();
  final _notizenController = TextEditingController();

  DateTime? _geburtsdatum;
  String? _geschlecht;
  String? _gruppeId;
  DateTime? _eintrittsdatum;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.kindId != null) {
      _isEdit = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = context.read<KindProvider>();
        // Wenn Details bereits geladen sind, direkt befüllen
        if (provider.selectedKind != null &&
            provider.selectedKind!.id == widget.kindId) {
          _prefillFromKind(provider.selectedKind!);
        } else {
          // Andernfalls Details laden und dann befüllen
          provider.loadKindDetails(widget.kindId!).then((_) {
            if (mounted && provider.selectedKind != null) {
              _prefillFromKind(provider.selectedKind!);
            }
          });
        }
      });
    }
  }

  void _prefillFromKind(Kind kind) {
    setState(() {
      _vornameController.text = kind.vorname;
      _nachnameController.text = kind.nachname;
      _notizenController.text = kind.notizen ?? '';
      _geburtsdatum = kind.geburtsdatum;
      _geschlecht = kind.geschlecht;
      _gruppeId = kind.gruppeId;
      _eintrittsdatum = kind.eintrittsdatum;
    });
  }

  @override
  void dispose() {
    _vornameController.dispose();
    _nachnameController.dispose();
    _notizenController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Future<void> _pickDate({required bool isGeburtsdatum}) async {
    final now = DateTime.now();
    final initialDate = isGeburtsdatum
        ? (_geburtsdatum ?? DateTime(now.year - 3, now.month, now.day))
        : (_eintrittsdatum ?? now);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(now.year + 2),
      locale: const Locale('de', 'DE'),
    );

    if (picked != null) {
      setState(() {
        if (isGeburtsdatum) {
          _geburtsdatum = picked;
        } else {
          _eintrittsdatum = picked;
        }
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (_geburtsdatum == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.kinder_formBirthDateRequired)),
      );
      return;
    }

    final kindProvider = context.read<KindProvider>();
    final now = DateTime.now();

    final kind = Kind(
      id: _isEdit ? widget.kindId! : '',
      vorname: _vornameController.text.trim(),
      nachname: _nachnameController.text.trim(),
      geburtsdatum: _geburtsdatum!,
      geschlecht: _geschlecht ?? '',
      einrichtungId: _isEdit
          ? (kindProvider.selectedKind?.einrichtungId ?? '')
          : (context.read<AuthProvider>().user?.einrichtungId ?? ''),
      gruppeId: _gruppeId,
      status: _isEdit
          ? (kindProvider.selectedKind?.status ?? ChildStatus.aktiv)
          : ChildStatus.aktiv,
      eintrittsdatum: _eintrittsdatum,
      notizen: _notizenController.text.trim().isEmpty
          ? null
          : _notizenController.text.trim(),
      erstelltAm: _isEdit
          ? (kindProvider.selectedKind?.erstelltAm ?? now)
          : now,
      aktualisiertAm: now,
    );

    bool success;
    if (_isEdit) {
      success = await kindProvider.updateKind(kind);
    } else {
      success = await kindProvider.createKind(kind);
    }

    if (success && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final kindProvider = context.watch<KindProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? context.l.kinder_formEditTitle : context.l.kinder_formNewTitle),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vorname
              KfTextField(
                label: context.l.kinder_formFirstName,
                controller: _vornameController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l.kinder_formFirstNameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: DesignTokens.spacing12),

              // Nachname
              KfTextField(
                label: context.l.kinder_formLastName,
                controller: _nachnameController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l.kinder_formLastNameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: DesignTokens.spacing12),

              // Geburtsdatum
              InkWell(
                onTap: () => _pickDate(isGeburtsdatum: true),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: context.l.kinder_formBirthDate,
                    labelStyle: TextStyle(
                      fontSize: DesignTokens.fontMd,
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
                    suffixIcon: const Icon(Icons.calendar_today_outlined,
                        color: AppColors.textSecondary),
                  ),
                  child: Text(
                    _geburtsdatum != null
                        ? _formatDate(_geburtsdatum)
                        : context.l.kinder_formBirthDateSelect,
                    style: TextStyle(
                      fontSize: DesignTokens.fontMd,
                      color: _geburtsdatum != null
                          ? AppColors.textPrimary
                          : AppColors.textHint,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),

              // Geschlecht
              KfDropdown<String>(
                label: context.l.kinder_formGender,
                hint: context.l.kinder_formGenderSelect,
                value: _geschlecht,
                onChanged: (value) => setState(() => _geschlecht = value),
                items: [
                  DropdownMenuItem(
                      value: 'männlich', child: Text(context.l.kinder_formGenderMale)),
                  DropdownMenuItem(
                      value: 'weiblich', child: Text(context.l.kinder_formGenderFemale)),
                  DropdownMenuItem(
                      value: 'divers', child: Text(context.l.kinder_formGenderDiverse)),
                ],
              ),
              const SizedBox(height: DesignTokens.spacing12),

              // Gruppe
              KfDropdown<String>(
                label: context.l.kinder_formGroup,
                hint: context.l.kinder_formGroupSelect,
                value: _gruppeId,
                onChanged: (value) => setState(() => _gruppeId = value),
                items: kindProvider.gruppen
                    .map((g) => DropdownMenuItem(
                          value: g.id,
                          child: Text(g.name),
                        ))
                    .toList(),
              ),
              const SizedBox(height: DesignTokens.spacing12),

              // Eintrittsdatum
              InkWell(
                onTap: () => _pickDate(isGeburtsdatum: false),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: context.l.kinder_formEntryDate,
                    labelStyle: TextStyle(
                      fontSize: DesignTokens.fontMd,
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
                    suffixIcon: const Icon(Icons.calendar_today_outlined,
                        color: AppColors.textSecondary),
                  ),
                  child: Text(
                    _eintrittsdatum != null
                        ? _formatDate(_eintrittsdatum)
                        : context.l.kinder_formEntryDateSelect,
                    style: TextStyle(
                      fontSize: DesignTokens.fontMd,
                      color: _eintrittsdatum != null
                          ? AppColors.textPrimary
                          : AppColors.textHint,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),

              // Notizen
              KfTextField(
                label: context.l.kinder_formNotes,
                hint: context.l.kinder_formNotesHint,
                controller: _notizenController,
                maxLines: 3,
              ),
              const SizedBox(height: DesignTokens.spacing24),

              // Speichern-Button
              Consumer<KindProvider>(
                builder: (context, provider, _) {
                  return KfButton(
                    label: _isEdit ? context.l.kinder_formSave : context.l.kinder_formCreate,
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

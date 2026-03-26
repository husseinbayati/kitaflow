import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/dokument.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/enum_labels.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../presentation/providers/dokument_provider.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/kind_provider.dart';

class DokumentFormScreen extends StatefulWidget {
  const DokumentFormScreen({super.key});

  @override
  State<DokumentFormScreen> createState() => _DokumentFormScreenState();
}

class _DokumentFormScreenState extends State<DokumentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titelController = TextEditingController();
  final _beschreibungController = TextEditingController();

  DocumentType _selectedTyp = DocumentType.sonstiges;
  String? _selectedKindId;
  DateTime? _gueltigBis;
  PlatformFile? _pickedFile;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titelController.dispose();
    _beschreibungController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedFile = result.files.first;
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _gueltigBis ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null) {
      setState(() {
        _gueltigBis = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final authProvider = context.read<AuthProvider>();
      final dokumentProvider = context.read<DokumentProvider>();
      final einrichtungId = authProvider.user?.einrichtungId ?? '';

      String? storagePath;
      if (_pickedFile != null && _pickedFile!.bytes != null) {
        storagePath = await dokumentProvider.uploadDatei(
          einrichtungId,
          _pickedFile!.name,
          _pickedFile!.bytes!,
        );
      }

      final dok = Dokument(
        id: '',
        einrichtungId: einrichtungId,
        kindId: _selectedKindId,
        typ: _selectedTyp,
        titel: _titelController.text.trim(),
        beschreibung: _beschreibungController.text.trim().isNotEmpty
            ? _beschreibungController.text.trim()
            : null,
        dateipfad: storagePath,
        unterschrieben: false,
        erstelltAm: DateTime.now(),
      );

      await dokumentProvider.createDokument(dok);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.dokumente_uploadSuccess)),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.dokumente_uploadError)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.dokumente_formTitle),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KfTextField(
                label: context.l.dokumente_formTitel,
                controller: _titelController,
                prefixIcon: Icons.title,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l.common_requiredField;
                  }
                  return null;
                },
              ),
              AppGaps.v16,
              DropdownButtonFormField<DocumentType>(
                value: _selectedTyp,
                decoration: InputDecoration(
                  labelText: context.l.dokumente_formTyp,
                ),
                items: DocumentType.values
                    .map((typ) => DropdownMenuItem(
                          value: typ,
                          child: Text(typ.label(context)),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedTyp = value);
                  }
                },
              ),
              AppGaps.v16,
              KfTextField(
                label: context.l.dokumente_formBeschreibung,
                controller: _beschreibungController,
                prefixIcon: Icons.notes,
                maxLines: 3,
              ),
              AppGaps.v16,
              Consumer<KindProvider>(
                builder: (context, kindProvider, _) {
                  return DropdownButtonFormField<String?>(
                    value: _selectedKindId,
                    decoration: InputDecoration(
                      labelText: context.l.dokumente_formKind,
                    ),
                    items: [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text(context.l.dokumente_formKindOptional),
                      ),
                      ...kindProvider.kinder.map(
                        (kind) => DropdownMenuItem<String?>(
                          value: kind.id,
                          child: Text('${kind.vorname} ${kind.nachname}'),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedKindId = value);
                    },
                  );
                },
              ),
              AppGaps.v16,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _gueltigBis != null
                          ? '${_gueltigBis!.day.toString().padLeft(2, '0')}.${_gueltigBis!.month.toString().padLeft(2, '0')}.${_gueltigBis!.year}'
                          : context.l.dokumente_formGueltigBis,
                      style: TextStyle(
                        fontSize: DesignTokens.fontMd,
                        color: _gueltigBis != null
                            ? AppColors.textPrimary
                            : AppColors.textHint,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickDate,
                  ),
                ],
              ),
              AppGaps.v16,
              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: Text(context.l.dokumente_formFileSelect),
              ),
              if (_pickedFile != null) ...[
                AppGaps.v8,
                Text(
                  _pickedFile!.name,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSm,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              AppGaps.v24,
              KfButton(
                label: context.l.common_save,
                isExpanded: true,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

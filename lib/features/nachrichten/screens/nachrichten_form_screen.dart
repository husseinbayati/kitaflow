import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/supabase_config.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/nachricht.dart';
import '../../../data/repositories/nachricht_repository.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/kind_provider.dart';
import '../../../presentation/providers/nachricht_provider.dart';
import '../widgets/empfaenger_auswahl_dialog.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

/// Formular zum Erstellen und Versenden einer neuen Nachricht.
///
/// Ermöglicht die Auswahl von Typ, Empfängergruppe, Betreff, Inhalt
/// und Wichtigkeits-Flag.
class NachrichtenFormScreen extends StatefulWidget {
  const NachrichtenFormScreen({super.key});

  @override
  State<NachrichtenFormScreen> createState() => _NachrichtenFormScreenState();
}

class _NachrichtenFormScreenState extends State<NachrichtenFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _betreffController = TextEditingController();
  final _inhaltController = TextEditingController();

  MessageType _selectedTyp = MessageType.nachricht;
  String _empfaengerTyp = 'alle';
  String? _selectedGruppeId;
  List<String> _selectedEmpfaengerIds = [];
  bool _wichtig = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _betreffController.dispose();
    _inhaltController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Senden
  // ---------------------------------------------------------------------------

  Future<void> _onSend() async {
    if (!_formKey.currentState!.validate()) return;

    final currentUser = SupabaseConfig.currentUser;
    if (currentUser == null) {
      _showError('Nicht angemeldet. Bitte erneut einloggen.');
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final einrichtungId = authProvider.user?.einrichtungId;
    if (einrichtungId == null) {
      _showError('Keine Einrichtung zugeordnet.');
      return;
    }

    final provider = context.read<NachrichtProvider>();

    setState(() => _isLoading = true);

    try {
      // Empfänger-IDs bestimmen
      final empfaengerIds = await _resolveEmpfaengerIds(einrichtungId);

      if (empfaengerIds.isEmpty) {
        _showError('Keine Empfänger gefunden.');
        setState(() => _isLoading = false);
        return;
      }

      final nachricht = Nachricht(
        id: '',
        absenderId: currentUser.id,
        einrichtungId: einrichtungId,
        typ: _selectedTyp,
        betreff: _betreffController.text.trim(),
        inhalt: _inhaltController.text.trim(),
        empfaengerTyp: _empfaengerTyp,
        gruppeId: _empfaengerTyp == 'gruppe' ? _selectedGruppeId : null,
        wichtig: _wichtig,
        erstelltAm: DateTime.now(),
      );

      final success = await provider.sendNachricht(nachricht, empfaengerIds);

      if (!mounted) return;

      if (success) {
        context.pop();
      } else {
        _showError('Nachricht konnte nicht gesendet werden.');
      }
    } catch (e) {
      if (mounted) {
        _showError('Fehler beim Senden: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Löst die Empfänger-IDs basierend auf dem gewählten Empfänger-Typ auf.
  Future<List<String>> _resolveEmpfaengerIds(String einrichtungId) async {
    final repository = getIt<NachrichtRepository>();

    switch (_empfaengerTyp) {
      case 'alle':
        final profiles =
            await repository.fetchProfilesForEinrichtung(einrichtungId);
        return profiles.map((p) => p['id'] as String).toList();

      case 'gruppe':
        // Placeholder: Alle Profile der Einrichtung laden.
        // In Zukunft nach Gruppenverknüpfung filtern.
        final profiles =
            await repository.fetchProfilesForEinrichtung(einrichtungId);
        return profiles.map((p) => p['id'] as String).toList();

      case 'einzeln':
        return _selectedEmpfaengerIds;

      default:
        return [];
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empfänger-Auswahl
  // ---------------------------------------------------------------------------

  Future<void> _openEmpfaengerAuswahl() async {
    final authProvider = context.read<AuthProvider>();
    final einrichtungId = authProvider.user?.einrichtungId;
    if (einrichtungId == null) return;

    final result = await EmpfaengerAuswahlDialog.show(
      context,
      einrichtungId: einrichtungId,
      selectedIds: _selectedEmpfaengerIds,
    );

    if (result != null) {
      setState(() => _selectedEmpfaengerIds = result);
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final gruppen = context.read<KindProvider>().gruppen;

    return Scaffold(
      appBar: AppBar(title: Text(context.l.nachrichten_formTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Typ-Auswahl
              Text(
                context.l.nachrichten_formType,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              AppGaps.v8,
              Wrap(
                spacing: DesignTokens.spacing8,
                children: MessageType.values.map((typ) {
                  final isSelected = _selectedTyp == typ;
                  return ChoiceChip(
                    label: Text(typ.label(context)),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedTyp = typ),
                    selectedColor: AppColors.primaryLight,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.textOnPrimary
                          : AppColors.textPrimary,
                    ),
                  );
                }).toList(),
              ),

              AppGaps.v24,

              // 2. Empfänger-Typ
              Text(
                context.l.nachrichten_formRecipients,
                style: TextStyle(
                  fontSize: DesignTokens.fontMd,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              RadioGroup<String>(
                groupValue: _empfaengerTyp,
                onChanged: (v) => setState(() => _empfaengerTyp = v ?? _empfaengerTyp),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Text(context.l.nachrichten_formRecipientsAll),
                      value: 'alle',
                      toggleable: false,
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      title: Text(context.l.nachrichten_formRecipientsGroup),
                      value: 'gruppe',
                      toggleable: false,
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (_empfaengerTyp == 'gruppe')
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: DesignTokens.spacing16,
                          bottom: DesignTokens.spacing8,
                        ),
                        child: KfDropdown<String>(
                          label: context.l.nachrichten_formSelectGroup,
                          hint: context.l.nachrichten_formSelectGroupHint,
                          value: _selectedGruppeId,
                          items: gruppen
                              .map((g) => DropdownMenuItem<String>(
                                    value: g.id,
                                    child: Text(g.name),
                                  ))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedGruppeId = v),
                          validator: (v) => v == null
                              ? context.l.nachrichten_formSelectGroupRequired
                              : null,
                        ),
                      ),
                    RadioListTile<String>(
                      title: Text(context.l.nachrichten_formRecipientsIndividual),
                      value: 'einzeln',
                      toggleable: false,
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              if (_empfaengerTyp == 'einzeln') ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: DesignTokens.spacing16,
                    bottom: DesignTokens.spacing8,
                  ),
                  child: OutlinedButton.icon(
                    onPressed: _openEmpfaengerAuswahl,
                    icon: const Icon(Icons.people),
                    label: Text(
                      _selectedEmpfaengerIds.isEmpty
                          ? context.l.nachrichten_formSelectRecipients
                          : context.l.nachrichten_formRecipientsSelected(_selectedEmpfaengerIds.length),
                    ),
                  ),
                ),
              ],

              AppGaps.v24,

              // 3. Betreff
              KfTextField(
                label: context.l.nachrichten_formSubject,
                hint: context.l.nachrichten_formSubjectHint,
                controller: _betreffController,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? context.l.common_requiredField : null,
              ),

              AppGaps.v16,

              // 4. Inhalt
              KfTextField(
                label: context.l.nachrichten_formContent,
                hint: context.l.nachrichten_formContentHint,
                controller: _inhaltController,
                maxLines: 8,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? context.l.common_requiredField : null,
              ),

              AppGaps.v16,

              // 5. Wichtig
              SwitchListTile(
                title: Text(context.l.nachrichten_formMarkImportant),
                value: _wichtig,
                onChanged: (v) => setState(() => _wichtig = v),
                activeTrackColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),

              AppGaps.v24,

              // 6. Senden
              KfButton(
                label: context.l.nachrichten_formSend,
                onPressed: _isLoading ? null : _onSend,
                isExpanded: true,
                isLoading: _isLoading,
                icon: Icons.send,
              ),

              AppGaps.v16,
            ],
          ),
        ),
      ),
    );
  }
}

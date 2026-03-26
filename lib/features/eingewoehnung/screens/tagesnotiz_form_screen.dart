import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/models/eingewoehnung_tagesnotiz.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/eingewoehnung_provider.dart';
import '../widgets/stimmung_picker.dart';
import '../widgets/trennungsverhalten_rating.dart';

/// Formular zum Erstellen einer neuen Tagesnotiz für eine Eingewöhnung.
class TagesnotizFormScreen extends StatefulWidget {
  const TagesnotizFormScreen({super.key, required this.eingewoehnungId});

  final String eingewoehnungId;

  @override
  State<TagesnotizFormScreen> createState() => _TagesnotizFormScreenState();
}

class _TagesnotizFormScreenState extends State<TagesnotizFormScreen> {
  DateTime _datum = DateTime.now();
  final _dauerController = TextEditingController();
  int? _trennungsverhalten;
  final _trennungsverhaltenTextController = TextEditingController();
  final _essenController = TextEditingController();
  final _schlafController = TextEditingController();
  final _spielController = TextEditingController();
  Stimmung? _stimmung;
  final _notizenInternController = TextEditingController();
  final _notizenElternController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _dauerController.dispose();
    _trennungsverhaltenTextController.dispose();
    _essenController.dispose();
    _schlafController.dispose();
    _spielController.dispose();
    _notizenInternController.dispose();
    _notizenElternController.dispose();
    super.dispose();
  }

  Future<void> _pickDatum() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _datum,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _datum = picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);

    final authProvider = context.read<AuthProvider>();
    final provider = context.read<EingewoehnungProvider>();

    final notiz = EingewoehnungTagesnotiz(
      id: '',
      eingewoehnungId: widget.eingewoehnungId,
      datum: _datum,
      dauerMinuten: int.tryParse(_dauerController.text),
      trennungsverhalten: _trennungsverhalten,
      trennungsverhaltenText:
          _trennungsverhaltenTextController.text.isNotEmpty
              ? _trennungsverhaltenTextController.text
              : null,
      essen: _essenController.text.isNotEmpty
          ? _essenController.text
          : null,
      schlaf: _schlafController.text.isNotEmpty
          ? _schlafController.text
          : null,
      spiel: _spielController.text.isNotEmpty
          ? _spielController.text
          : null,
      stimmung: _stimmung,
      notizenIntern: _notizenInternController.text.isNotEmpty
          ? _notizenInternController.text
          : null,
      notizenEltern: _notizenElternController.text.isNotEmpty
          ? _notizenElternController.text
          : null,
      erstelltVon: authProvider.user?.id,
      erstelltAm: DateTime.now(),
    );

    final success = await provider.addTagesnotiz(notiz);

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.eingewoehnung_notizGespeichert)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.eingewoehnung_neueNotiz),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Datum
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: DesignTokens.iconMd,
                    color: AppColors.textSecondary),
                AppGaps.h8,
                Text(
                  _formatDate(_datum),
                  style: TextStyle(
                    fontSize: DesignTokens.fontMd,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit_calendar),
                  onPressed: _pickDatum,
                ),
              ],
            ),
            AppGaps.v16,

            // 2. Dauer
            KfTextField(
              label: context.l.eingewoehnung_dauer,
              controller: _dauerController,
              keyboardType: TextInputType.number,
              prefixIcon: Icons.timer,
            ),
            AppGaps.v16,

            // 3. Trennungsverhalten
            Text(
              context.l.eingewoehnung_trennungsverhalten,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                color: AppColors.textSecondary,
              ),
            ),
            AppGaps.v8,
            TrennungsverhaltenRating(
              value: _trennungsverhalten,
              onChanged: (value) =>
                  setState(() => _trennungsverhalten = value),
            ),
            AppGaps.v8,

            // 4. Trennungsverhalten Text
            KfTextField(
              hint: 'Details...',
              controller: _trennungsverhaltenTextController,
              maxLines: 2,
            ),
            AppGaps.v16,

            // 5. Essen
            KfTextField(
              label: context.l.eingewoehnung_essen,
              controller: _essenController,
              maxLines: 2,
              prefixIcon: Icons.restaurant,
            ),
            AppGaps.v16,

            // 6. Schlaf
            KfTextField(
              label: context.l.eingewoehnung_schlaf,
              controller: _schlafController,
              maxLines: 2,
              prefixIcon: Icons.bedtime,
            ),
            AppGaps.v16,

            // 7. Spiel
            KfTextField(
              label: context.l.eingewoehnung_spiel,
              controller: _spielController,
              maxLines: 2,
              prefixIcon: Icons.toys,
            ),
            AppGaps.v16,

            // 8. Stimmung
            Text(
              context.l.eingewoehnung_stimmung,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                color: AppColors.textSecondary,
              ),
            ),
            AppGaps.v8,
            StimmungPicker(
              selected: _stimmung,
              onChanged: (value) => setState(() => _stimmung = value),
            ),
            AppGaps.v16,

            // 9. Interne Notizen
            KfTextField(
              label: context.l.eingewoehnung_notizenIntern,
              controller: _notizenInternController,
              maxLines: 3,
              prefixIcon: Icons.lock,
            ),
            AppGaps.v16,

            // 10. Eltern Notizen
            KfTextField(
              label: context.l.eingewoehnung_notizenEltern,
              controller: _notizenElternController,
              maxLines: 3,
              prefixIcon: Icons.family_restroom,
            ),
            AppGaps.v4,
            Text(
              context.l.eingewoehnung_notizenElternHinweis,
              style: TextStyle(
                fontSize: DesignTokens.fontSm,
                color: AppColors.warning,
              ),
            ),
            AppGaps.v24,

            // 11. Save Button
            KfButton(
              label: context.l.common_save,
              isExpanded: true,
              isLoading: _isSubmitting,
              onPressed: _isSubmitting ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}

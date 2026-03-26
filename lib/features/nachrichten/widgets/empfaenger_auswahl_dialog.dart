import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_button.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../data/repositories/nachricht_repository.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Bottom-Sheet-Dialog zur Auswahl von Nachrichtenempfängern.
///
/// Lädt alle Profile einer Einrichtung und erlaubt Mehrfachauswahl
/// mit Suche und "Alle auswählen"-Toggle.
class EmpfaengerAuswahlDialog extends StatefulWidget {
  const EmpfaengerAuswahlDialog({
    super.key,
    required this.einrichtungId,
    this.selectedIds = const [],
  });

  /// Die Einrichtungs-ID, deren Profile geladen werden.
  final String einrichtungId;

  /// Bereits ausgewählte Empfänger-IDs.
  final List<String> selectedIds;

  /// Zeigt den Dialog als Modal-Bottom-Sheet an.
  ///
  /// Gibt die ausgewählten Empfänger-IDs zurück oder null bei Abbruch.
  static Future<List<String>?> show(
    BuildContext context, {
    required String einrichtungId,
    List<String> selectedIds = const [],
  }) {
    return showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusLg),
        ),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => EmpfaengerAuswahlDialog(
          einrichtungId: einrichtungId,
          selectedIds: selectedIds,
        ),
      ),
    );
  }

  @override
  State<EmpfaengerAuswahlDialog> createState() =>
      _EmpfaengerAuswahlDialogState();
}

class _EmpfaengerAuswahlDialogState extends State<EmpfaengerAuswahlDialog> {
  List<Map<String, dynamic>> _profiles = [];
  late Set<String> _selectedIds;
  String _searchQuery = '';
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedIds = Set<String>.from(widget.selectedIds);
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    try {
      final repository = getIt<NachrichtRepository>();
      final profiles =
          await repository.fetchProfilesForEinrichtung(widget.einrichtungId);
      if (mounted) {
        setState(() {
          _profiles = profiles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = context.l.nachrichten_recipientDialogLoadError;
          _isLoading = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> get _filteredProfiles {
    if (_searchQuery.isEmpty) return _profiles;
    final query = _searchQuery.toLowerCase();
    return _profiles.where((p) {
      final vorname = (p['vorname'] as String? ?? '').toLowerCase();
      final nachname = (p['nachname'] as String? ?? '').toLowerCase();
      final rolle = (p['rolle'] as String? ?? '').toLowerCase();
      return vorname.contains(query) ||
          nachname.contains(query) ||
          rolle.contains(query);
    }).toList();
  }

  void _toggleAll() {
    setState(() {
      if (_selectedIds.length == _profiles.length) {
        _selectedIds.clear();
      } else {
        _selectedIds = _profiles.map((p) => p['id'] as String).toSet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grip-Indikator
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
            ),
          ),
          AppGaps.v16,

          // Titel
          Text(
            context.l.nachrichten_recipientDialogTitle,
            style: TextStyle(
              fontSize: DesignTokens.fontXl,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          AppGaps.v16,

          // Suchfeld
          KfTextField(
            hint: context.l.nachrichten_recipientDialogSearch,
            prefixIcon: Icons.search,
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          AppGaps.v8,

          // Alle auswählen / Keine
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: _toggleAll,
              child: Text(
                _selectedIds.length == _profiles.length
                    ? context.l.nachrichten_recipientDialogNone
                    : context.l.nachrichten_recipientDialogAll,
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ),

          // Liste
          Expanded(
            child: _buildContent(),
          ),

          AppGaps.v12,

          // Bestätigen-Button
          KfButton(
            label: context.l.nachrichten_recipientDialogConfirm(_selectedIds.length),
            onPressed: () => Navigator.of(context).pop(_selectedIds.toList()),
            isExpanded: true,
            icon: Icons.check,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: TextStyle(color: AppColors.error),
        ),
      );
    }

    final filtered = _filteredProfiles;

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          _searchQuery.isEmpty
              ? context.l.nachrichten_recipientDialogNoProfiles
              : context.l.nachrichten_recipientDialogNoResults(_searchQuery),
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final profile = filtered[index];
        final id = profile['id'] as String;
        final vorname = profile['vorname'] as String? ?? '';
        final nachname = profile['nachname'] as String? ?? '';
        final rolle = profile['rolle'] as String? ?? '';
        final isSelected = _selectedIds.contains(id);

        return CheckboxListTile(
          title: Text('$vorname $nachname'),
          subtitle: rolle.isNotEmpty ? Text(rolle) : null,
          value: isSelected,
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                _selectedIds.add(id);
              } else {
                _selectedIds.remove(id);
              }
            });
          },
          activeColor: AppColors.primary,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }
}

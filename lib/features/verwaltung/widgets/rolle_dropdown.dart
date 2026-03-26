import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Dropdown für Rollenzuweisung (Erzieher, Lehrer, Leitung).
class RolleDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final String? label;

  const RolleDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  /// Keys for the roles (values are localized in build).
  static const List<String> _rollenKeys = ['erzieher', 'lehrer', 'leitung'];

  Map<String, String> _localizedRollen(BuildContext context) => {
    'erzieher': context.l.verwaltung_rolleDropdownErzieher,
    'lehrer': context.l.verwaltung_rolleDropdownLehrer,
    'leitung': context.l.verwaltung_rolleDropdownLeitung,
  };

  @override
  Widget build(BuildContext context) {
    final rollen = _localizedRollen(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: DesignTokens.spacing8),
        ],
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacing12,
              vertical: DesignTokens.spacing12,
            ),
          ),
          items: _rollenKeys.map((key) {
            return DropdownMenuItem<String>(
              value: key,
              child: Text(rollen[key]!),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        ),
      ],
    );
  }
}

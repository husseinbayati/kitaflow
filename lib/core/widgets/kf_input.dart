import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/design_tokens.dart';
import '../theme/app_colors.dart';

/// Textfeld mit Label, Hint und optionalen Icons.
///
/// Unterstützt Validierung, Passwort-Modus und mehrzeilige Eingabe.
class KfTextField extends StatelessWidget {
  const KfTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      onChanged: onChanged,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: DesignTokens.fontMd,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          fontSize: DesignTokens.fontMd,
          color: AppColors.textSecondary,
        ),
        hintStyle: TextStyle(
          fontSize: DesignTokens.fontMd,
          color: AppColors.textHint,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.textSecondary)
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing16,
          vertical: DesignTokens.spacing12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}

/// Suchfeld mit Lupen-Icon und optionalem Debounce.
///
/// Ruft [onChanged] erst nach Ablauf der [debounceDuration] auf.
class KfSearchField extends StatefulWidget {
  const KfSearchField({
    super.key,
    this.hint = 'Suchen...',
    this.onChanged,
    this.controller,
    this.debounceDuration = const Duration(milliseconds: 400),
  });

  final String hint;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Duration debounceDuration;

  @override
  State<KfSearchField> createState() => _KfSearchFieldState();
}

class _KfSearchFieldState extends State<KfSearchField> {
  Timer? _debounceTimer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return KfTextField(
      controller: _controller,
      hint: widget.hint,
      prefixIcon: Icons.search,
      onChanged: _onChanged,
      suffixIcon: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (_controller.text.isEmpty) return const SizedBox.shrink();
          return IconButton(
            icon: Icon(Icons.clear, color: AppColors.textHint),
            onPressed: () {
              _controller.clear();
              widget.onChanged?.call('');
            },
          );
        },
      ),
    );
  }
}

/// Generisches Dropdown-Feld mit Label.
///
/// Verwendet [DropdownButtonFormField] mit dem KitaFlow-Design.
class KfDropdown<T> extends StatelessWidget {
  const KfDropdown({
    super.key,
    this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.validator,
    this.isExpanded = true,
  });

  final String? label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? Function(T?)? validator;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      isExpanded: isExpanded,
      hint: hint != null
          ? Text(
              hint!,
              style: TextStyle(
                fontSize: DesignTokens.fontMd,
                color: AppColors.textHint,
              ),
            )
          : null,
      style: TextStyle(
        fontSize: DesignTokens.fontMd,
        color: AppColors.textPrimary,
      ),
      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
      decoration: InputDecoration(
        labelText: label,
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
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}

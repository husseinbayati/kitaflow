import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Sprachauswahl-Screen.
/// Zeigt 5 Sprachen mit der aktuellen Auswahl hervorgehoben.
class SpracheScreen extends StatelessWidget {
  const SpracheScreen({super.key});

  static const _languages = [
    _LanguageOption(locale: Locale('de'), nativeName: 'Deutsch', flag: '🇩🇪'),
    _LanguageOption(locale: Locale('ar'), nativeName: 'العربية', flag: '🇸🇦'),
    _LanguageOption(locale: Locale('tr'), nativeName: 'Türkçe', flag: '🇹🇷'),
    _LanguageOption(locale: Locale('uk'), nativeName: 'Українська', flag: '🇺🇦'),
    _LanguageOption(locale: Locale('en'), nativeName: 'English', flag: '🇬🇧'),
  ];

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final currentLocale = localeProvider.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.common_language),
      ),
      body: ListView.separated(
        padding: AppPadding.screen,
        itemCount: _languages.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final lang = _languages[index];
          final isSelected = lang.locale == currentLocale;

          return ListTile(
            leading: Text(lang.flag, style: const TextStyle(fontSize: 28)),
            title: Text(
              lang.nativeName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
            trailing: isSelected
                ? Icon(Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary)
                : null,
            onTap: () {
              localeProvider.setLocale(lang.locale);
            },
          );
        },
      ),
    );
  }
}

class _LanguageOption {
  final Locale locale;
  final String nativeName;
  final String flag;

  const _LanguageOption({
    required this.locale,
    required this.nativeName,
    required this.flag,
  });
}

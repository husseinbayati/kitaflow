import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Convenience-Extension für schnellen Zugriff auf Lokalisierung.
/// Ermöglicht `context.l.keyName` statt `AppLocalizations.of(context)!.keyName`.
extension L10nContext on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this);
}

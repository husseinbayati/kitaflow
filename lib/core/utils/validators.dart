/// Validierungs-Funktionen für Formulare.
abstract final class Validators {
  /// Email-Validierung.
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'E-Mail ist erforderlich';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value)) {
      return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
    }
    return null;
  }

  /// Passwort-Validierung (min 8 Zeichen).
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Passwort ist erforderlich';
    if (value.length < 8) return 'Passwort muss mindestens 8 Zeichen lang sein';
    return null;
  }

  /// Passwort-Bestätigung.
  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) return 'Passwort bestätigen ist erforderlich';
      if (value != password) return 'Passwörter stimmen nicht überein';
      return null;
    };
  }

  /// Pflichtfeld.
  static String? required(String? value, [String fieldName = 'Dieses Feld']) {
    if (value == null || value.trim().isEmpty) return '$fieldName ist erforderlich';
    return null;
  }

  /// Telefonnummer.
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return null; // Optional
    if (!RegExp(r'^[\+]?[0-9\s\-]{6,}$').hasMatch(value)) {
      return 'Bitte geben Sie eine gültige Telefonnummer ein';
    }
    return null;
  }

  /// IBAN (vereinfacht).
  static String? iban(String? value) {
    if (value == null || value.isEmpty) return 'IBAN ist erforderlich';
    final cleaned = value.replaceAll(RegExp(r'\s'), '');
    if (cleaned.length < 15 || cleaned.length > 34) {
      return 'Ungültige IBAN-Länge';
    }
    if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Za-z0-9]+$').hasMatch(cleaned)) {
      return 'Ungültiges IBAN-Format';
    }
    return null;
  }
}

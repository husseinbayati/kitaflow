import 'package:intl/intl.dart';

/// Formatierungs-Hilfsfunktionen.
abstract final class Formatters {
  /// Währung: "49,00 €"
  static String currency(double amount) {
    return NumberFormat.currency(locale: 'de_DE', symbol: '€').format(amount);
  }

  /// Zahl mit Tausender-Trenner: "1.234"
  static String number(num value) {
    return NumberFormat('#,##0', 'de_DE').format(value);
  }

  /// Datum: "15.03.2026"
  static String date(DateTime dt) {
    return DateFormat('dd.MM.yyyy').format(dt);
  }

  /// Zeit: "08:30"
  static String time(DateTime dt) {
    return DateFormat('HH:mm').format(dt);
  }

  /// Datum + Zeit: "15.03.2026, 08:30"
  static String dateTime(DateTime dt) {
    return DateFormat('dd.MM.yyyy, HH:mm').format(dt);
  }

  /// Relativer Zeitstempel: "vor 5 Minuten", "gestern"
  static String timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Gerade eben';
    if (diff.inMinutes < 60) return 'Vor ${diff.inMinutes} Minuten';
    if (diff.inHours < 24) return 'Vor ${diff.inHours} Stunden';
    if (diff.inDays == 1) return 'Gestern';
    if (diff.inDays < 7) return 'Vor ${diff.inDays} Tagen';
    return date(dt);
  }

  /// Name formatieren: "Max M."
  static String nameShort(String vorname, String nachname) {
    if (nachname.isEmpty) return vorname;
    return '$vorname ${nachname[0]}.';
  }
}

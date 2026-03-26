import 'package:intl/intl.dart';

/// DateTime-Extensions für KitaFlow.
extension DateTimeExtensions on DateTime {
  /// Format: "15.03.2026"
  String get formatDate => DateFormat('dd.MM.yyyy').format(this);

  /// Format: "15.03."
  String get formatDateShort => DateFormat('dd.MM.').format(this);

  /// Format: "08:30"
  String get formatTime => DateFormat('HH:mm').format(this);

  /// Format: "15.03.2026, 08:30"
  String get formatDateTime => DateFormat('dd.MM.yyyy, HH:mm').format(this);

  /// Format: "Montag, 15. März 2026"
  String get formatDateLong => DateFormat('EEEE, d. MMMM yyyy', 'de').format(this);

  /// Format: "März 2026"
  String get formatMonthYear => DateFormat('MMMM yyyy', 'de').format(this);

  /// Prüft ob heute.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Prüft ob gestern.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// Alter in Jahren berechnen (für Kinder).
  int get age {
    final now = DateTime.now();
    int alter = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      alter--;
    }
    return alter;
  }

  /// Alter als String: "3 Jahre, 5 Monate"
  String get ageDetailed {
    final now = DateTime.now();
    int jahre = now.year - year;
    int monate = now.month - month;
    if (now.day < day) monate--;
    if (monate < 0) {
      jahre--;
      monate += 12;
    }
    if (jahre == 0) return '$monate Monate';
    if (monate == 0) return '$jahre Jahre';
    return '$jahre Jahre, $monate Monate';
  }

  /// Formatiert als yyyy-MM-dd für Supabase-Queries.
  String toSupabaseDateString() {
    return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  /// Formatiert als HH:mm für Supabase-Zeitfelder.
  String toSupabaseTimeString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Nur Datum (ohne Zeit).
  DateTime get dateOnly => DateTime(year, month, day);

  /// Kalenderwoche (ISO 8601).
  int get calendarWeek {
    final dayOfYear = difference(DateTime(year, 1, 1)).inDays;
    return ((dayOfYear - weekday + 10) / 7).floor();
  }
}

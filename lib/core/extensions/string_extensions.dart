/// String-Extensions für KitaFlow.
extension StringExtensions on String {
  /// Erster Buchstabe groß.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Initialen aus Name (z.B. "Max Mustermann" → "MM").
  String get initials {
    final parts = trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts.last[0]}'.toUpperCase();
  }

  /// Prüft ob String eine gültige Email ist.
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(this);
  }

  /// Kürzt String auf maxLength mit "..." am Ende.
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - 3)}...';
  }
}

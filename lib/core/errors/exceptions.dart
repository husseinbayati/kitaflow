// Benutzerdefinierte Exceptions für KitaFlow.

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException($statusCode): $message';
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Cache-Fehler'});

  @override
  String toString() => 'CacheException: $message';
}

class AuthException implements Exception {
  final String message;
  final AuthErrorType type;

  const AuthException({
    required this.message,
    this.type = AuthErrorType.unknown,
  });

  @override
  String toString() => 'AuthException($type): $message';
}

enum AuthErrorType {
  expired,
  invalid,
  unauthorized,
  emailNotVerified,
  unknown,
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({this.message = 'Keine Internetverbindung'});

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String field;
  final String message;

  const ValidationException({required this.field, required this.message});

  @override
  String toString() => 'ValidationException($field): $message';
}

class PermissionException implements Exception {
  final String message;
  final String? requiredRole;

  const PermissionException({
    this.message = 'Keine Berechtigung',
    this.requiredRole,
  });

  @override
  String toString() => 'PermissionException: $message (benötigt: $requiredRole)';
}

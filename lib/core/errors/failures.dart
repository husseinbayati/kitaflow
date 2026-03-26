// Failure-Klassen für Result-Pattern.

abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache-Fehler']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentifizierungsfehler']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Keine Internetverbindung']);
}

class ValidationFailure extends Failure {
  final String? field;
  const ValidationFailure(super.message, {this.field});
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Keine Berechtigung']);
}

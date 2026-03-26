/// Umgebungskonfiguration für KitaFlow.
/// Werte werden über --dart-define übergeben.
enum Environment { development, staging, production }

class EnvironmentConfig {
  static const String _env = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static Environment get current {
    switch (_env) {
      case 'production':
        return Environment.production;
      case 'staging':
        return Environment.staging;
      default:
        return Environment.development;
    }
  }

  static bool get isDevelopment => current == Environment.development;
  static bool get isStaging => current == Environment.staging;
  static bool get isProduction => current == Environment.production;
}

/// Alle Route-Pfade als Konstanten.
abstract final class AppRoutes {
  // Auth
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyEmail = '/verify-email';

  // Onboarding
  static const String onboardingInstitution = '/onboarding/institution';
  static const String onboardingParent = '/onboarding/parent';

  // Main (Shell)
  static const String dashboard = '/dashboard';
  static const String kinder = '/kinder';
  static const String kinderDetail = '/kinder/:id';
  static const String kinderNeu = '/kinder/neu';
  static const String kinderBearbeiten = '/kinder/:id/bearbeiten';
  static const String anwesenheit = '/anwesenheit';
  static const String nachrichten = '/nachrichten';
  static const String nachrichtenDetail = '/nachrichten/:id';
  static const String nachrichtenNeu = '/nachrichten/neu';
  static const String essensplan = '/essensplan';
  static const String entwicklung = '/entwicklung';
  static const String entwicklungKind = '/entwicklung/:kindId';

  // Verwaltung
  static const String verwaltung = '/verwaltung';
  static const String verwaltungEinrichtung = '/verwaltung/einrichtung';
  static const String verwaltungGruppen = '/verwaltung/gruppen';
  static const String verwaltungMitarbeiter = '/verwaltung/mitarbeiter';
  static const String verwaltungGruppeNeu = '/verwaltung/gruppen/neu';
  static const String verwaltungGruppeBearbeiten = '/verwaltung/gruppen/:id/bearbeiten';
  static const String verwaltungMitarbeiterNeu = '/verwaltung/mitarbeiter/neu';

  // Dokumente
  static const String dokumente = '/verwaltung/dokumente';
  static const String dokumenteNeu = '/verwaltung/dokumente/neu';
  static const String dokumenteDetail = '/verwaltung/dokumente/:id';
  static const String dokumenteSignieren = '/verwaltung/dokumente/:id/signieren';
  static const String elternDokumente = '/eltern/dokumente';

  // Eingewöhnung
  static const String eingewoehnung = '/verwaltung/eingewoehnung';
  static const String eingewoehnungNeu = '/verwaltung/eingewoehnung/neu';
  static const String eingewoehnungDetail = '/verwaltung/eingewoehnung/:id';
  static const String eingewoehnungTagesnotizNeu = '/verwaltung/eingewoehnung/:id/notiz';
  static const String elternEingewoehnung = '/eltern/eingewoehnung';
  static const String elternEingewoehnungFeedback = '/eltern/eingewoehnung/feedback';

  // Eltern
  static const String elternHome = '/eltern';
  static const String elternKinder = '/eltern/kinder';
  static const String elternNachrichten = '/eltern/nachrichten';
  static const String elternKrankmeldung = '/eltern/krankmeldung';
  static const String elternTermine = '/eltern/termine';
  static const String elternFotos = '/eltern/fotos';
  static const String elternPushSettings = '/eltern/einstellungen/push';
  static const String elternKindDetail = '/eltern/kinder/:id';

  // Profil & Einstellungen
  static const String profil = '/profil';
  static const String einstellungen = '/einstellungen';
  static const String sprache = '/sprache';
}

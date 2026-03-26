import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('tr'),
    Locale('uk'),
  ];

  /// No description provided for @common_save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get common_save;

  /// No description provided for @common_cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get common_cancel;

  /// No description provided for @common_delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get common_delete;

  /// No description provided for @common_edit.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get common_edit;

  /// No description provided for @common_ok.
  ///
  /// In de, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// No description provided for @common_confirm.
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get common_confirm;

  /// No description provided for @common_back.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get common_back;

  /// No description provided for @common_next.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get common_next;

  /// No description provided for @common_skip.
  ///
  /// In de, this message translates to:
  /// **'Überspringen'**
  String get common_skip;

  /// No description provided for @common_close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get common_close;

  /// No description provided for @common_error.
  ///
  /// In de, this message translates to:
  /// **'Fehler'**
  String get common_error;

  /// No description provided for @common_retry.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get common_retry;

  /// No description provided for @common_loading.
  ///
  /// In de, this message translates to:
  /// **'Laden...'**
  String get common_loading;

  /// No description provided for @common_showAll.
  ///
  /// In de, this message translates to:
  /// **'Alle anzeigen'**
  String get common_showAll;

  /// No description provided for @common_noAccess.
  ///
  /// In de, this message translates to:
  /// **'Kein Zugriff'**
  String get common_noAccess;

  /// No description provided for @common_noAccessDescription.
  ///
  /// In de, this message translates to:
  /// **'Sie haben keine Berechtigung für diesen Bereich.'**
  String get common_noAccessDescription;

  /// No description provided for @common_requiredField.
  ///
  /// In de, this message translates to:
  /// **'Pflichtfeld'**
  String get common_requiredField;

  /// No description provided for @common_all.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get common_all;

  /// No description provided for @common_active.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get common_active;

  /// No description provided for @common_inactive.
  ///
  /// In de, this message translates to:
  /// **'Inaktiv'**
  String get common_inactive;

  /// No description provided for @common_add.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get common_add;

  /// No description provided for @common_remove.
  ///
  /// In de, this message translates to:
  /// **'Entfernen'**
  String get common_remove;

  /// No description provided for @common_create.
  ///
  /// In de, this message translates to:
  /// **'Erstellen'**
  String get common_create;

  /// No description provided for @common_search.
  ///
  /// In de, this message translates to:
  /// **'Suchen'**
  String get common_search;

  /// No description provided for @common_email.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get common_email;

  /// No description provided for @common_phone.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get common_phone;

  /// No description provided for @common_notes.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get common_notes;

  /// No description provided for @common_name.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get common_name;

  /// No description provided for @common_firstName.
  ///
  /// In de, this message translates to:
  /// **'Vorname'**
  String get common_firstName;

  /// No description provided for @common_lastName.
  ///
  /// In de, this message translates to:
  /// **'Nachname'**
  String get common_lastName;

  /// No description provided for @common_password.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get common_password;

  /// No description provided for @common_date.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get common_date;

  /// No description provided for @common_description.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get common_description;

  /// No description provided for @common_type.
  ///
  /// In de, this message translates to:
  /// **'Typ'**
  String get common_type;

  /// No description provided for @common_group.
  ///
  /// In de, this message translates to:
  /// **'Gruppe'**
  String get common_group;

  /// No description provided for @common_role.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get common_role;

  /// No description provided for @common_color.
  ///
  /// In de, this message translates to:
  /// **'Farbe'**
  String get common_color;

  /// No description provided for @common_download.
  ///
  /// In de, this message translates to:
  /// **'Herunterladen'**
  String get common_download;

  /// No description provided for @common_send.
  ///
  /// In de, this message translates to:
  /// **'Senden'**
  String get common_send;

  /// No description provided for @common_justNow.
  ///
  /// In de, this message translates to:
  /// **'Gerade eben'**
  String get common_justNow;

  /// No description provided for @common_minutesAgo.
  ///
  /// In de, this message translates to:
  /// **'vor {minutes} Min.'**
  String common_minutesAgo(int minutes);

  /// No description provided for @common_hoursAgo.
  ///
  /// In de, this message translates to:
  /// **'vor {hours} Std.'**
  String common_hoursAgo(int hours);

  /// No description provided for @common_today.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get common_today;

  /// No description provided for @common_yesterday.
  ///
  /// In de, this message translates to:
  /// **'Gestern'**
  String get common_yesterday;

  /// No description provided for @common_daysAgo.
  ///
  /// In de, this message translates to:
  /// **'vor {days} Tagen'**
  String common_daysAgo(int days);

  /// No description provided for @common_yearsOld.
  ///
  /// In de, this message translates to:
  /// **'{years} Jahre'**
  String common_yearsOld(int years);

  /// No description provided for @common_clock.
  ///
  /// In de, this message translates to:
  /// **'Uhr'**
  String get common_clock;

  /// No description provided for @auth_appName.
  ///
  /// In de, this message translates to:
  /// **'KitaFlow'**
  String get auth_appName;

  /// No description provided for @auth_appInitials.
  ///
  /// In de, this message translates to:
  /// **'KF'**
  String get auth_appInitials;

  /// No description provided for @auth_appTagline.
  ///
  /// In de, this message translates to:
  /// **'Bildungsplattform für Kinder von 0–10 Jahren'**
  String get auth_appTagline;

  /// No description provided for @auth_appSlogan.
  ///
  /// In de, this message translates to:
  /// **'Die Bildungsplattform für Kinder'**
  String get auth_appSlogan;

  /// No description provided for @auth_loginTitle.
  ///
  /// In de, this message translates to:
  /// **'Anmelden'**
  String get auth_loginTitle;

  /// No description provided for @auth_loginEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get auth_loginEmail;

  /// No description provided for @auth_loginEmailHint.
  ///
  /// In de, this message translates to:
  /// **'name@beispiel.de'**
  String get auth_loginEmailHint;

  /// No description provided for @auth_loginEmailRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte E-Mail eingeben'**
  String get auth_loginEmailRequired;

  /// No description provided for @auth_loginEmailInvalid.
  ///
  /// In de, this message translates to:
  /// **'Bitte gültige E-Mail eingeben'**
  String get auth_loginEmailInvalid;

  /// No description provided for @auth_loginPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get auth_loginPassword;

  /// No description provided for @auth_loginPasswordRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Passwort eingeben'**
  String get auth_loginPasswordRequired;

  /// No description provided for @auth_loginPasswordMinLength.
  ///
  /// In de, this message translates to:
  /// **'Mindestens 8 Zeichen'**
  String get auth_loginPasswordMinLength;

  /// No description provided for @auth_forgotPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort vergessen?'**
  String get auth_forgotPassword;

  /// No description provided for @auth_noAccount.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Konto?'**
  String get auth_noAccount;

  /// No description provided for @auth_register.
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get auth_register;

  /// No description provided for @auth_alreadyHaveAccount.
  ///
  /// In de, this message translates to:
  /// **'Bereits ein Konto?'**
  String get auth_alreadyHaveAccount;

  /// No description provided for @auth_registerTitle.
  ///
  /// In de, this message translates to:
  /// **'Konto erstellen'**
  String get auth_registerTitle;

  /// No description provided for @auth_registerSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Erstelle dein KitaFlow-Konto'**
  String get auth_registerSubtitle;

  /// No description provided for @auth_registerFirstName.
  ///
  /// In de, this message translates to:
  /// **'Vorname'**
  String get auth_registerFirstName;

  /// No description provided for @auth_registerFirstNameHint.
  ///
  /// In de, this message translates to:
  /// **'Dein Vorname'**
  String get auth_registerFirstNameHint;

  /// No description provided for @auth_registerFirstNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib deinen Vornamen ein'**
  String get auth_registerFirstNameRequired;

  /// No description provided for @auth_registerLastName.
  ///
  /// In de, this message translates to:
  /// **'Nachname'**
  String get auth_registerLastName;

  /// No description provided for @auth_registerLastNameHint.
  ///
  /// In de, this message translates to:
  /// **'Dein Nachname'**
  String get auth_registerLastNameHint;

  /// No description provided for @auth_registerLastNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib deinen Nachnamen ein'**
  String get auth_registerLastNameRequired;

  /// No description provided for @auth_registerEmailHint.
  ///
  /// In de, this message translates to:
  /// **'deine@email.de'**
  String get auth_registerEmailHint;

  /// No description provided for @auth_registerEmailRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib deine E-Mail-Adresse ein'**
  String get auth_registerEmailRequired;

  /// No description provided for @auth_registerEmailInvalid.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib eine gültige E-Mail-Adresse ein'**
  String get auth_registerEmailInvalid;

  /// No description provided for @auth_registerPasswordMinLength.
  ///
  /// In de, this message translates to:
  /// **'Mindestens 8 Zeichen'**
  String get auth_registerPasswordMinLength;

  /// No description provided for @auth_registerPasswordRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib ein Passwort ein'**
  String get auth_registerPasswordRequired;

  /// No description provided for @auth_registerPasswordTooShort.
  ///
  /// In de, this message translates to:
  /// **'Das Passwort muss mindestens 8 Zeichen lang sein'**
  String get auth_registerPasswordTooShort;

  /// No description provided for @auth_registerPasswordStrengthWeak.
  ///
  /// In de, this message translates to:
  /// **'Schwach'**
  String get auth_registerPasswordStrengthWeak;

  /// No description provided for @auth_registerPasswordStrengthMedium.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get auth_registerPasswordStrengthMedium;

  /// No description provided for @auth_registerPasswordStrengthStrong.
  ///
  /// In de, this message translates to:
  /// **'Stark'**
  String get auth_registerPasswordStrengthStrong;

  /// No description provided for @auth_registerConfirmPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort bestätigen'**
  String get auth_registerConfirmPassword;

  /// No description provided for @auth_registerConfirmPasswordHint.
  ///
  /// In de, this message translates to:
  /// **'Passwort wiederholen'**
  String get auth_registerConfirmPasswordHint;

  /// No description provided for @auth_registerConfirmPasswordRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte bestätige dein Passwort'**
  String get auth_registerConfirmPasswordRequired;

  /// No description provided for @auth_registerPasswordMismatch.
  ///
  /// In de, this message translates to:
  /// **'Die Passwörter stimmen nicht überein'**
  String get auth_registerPasswordMismatch;

  /// No description provided for @auth_registerRoleLabel.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get auth_registerRoleLabel;

  /// No description provided for @auth_registerRoleHint.
  ///
  /// In de, this message translates to:
  /// **'Rolle auswählen'**
  String get auth_registerRoleHint;

  /// No description provided for @auth_registerRoleRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte wähle eine Rolle aus'**
  String get auth_registerRoleRequired;

  /// No description provided for @auth_registerAcceptTerms.
  ///
  /// In de, this message translates to:
  /// **'Ich akzeptiere die AGB und Datenschutzerklärung'**
  String get auth_registerAcceptTerms;

  /// No description provided for @auth_registerTermsRequired.
  ///
  /// In de, this message translates to:
  /// **'Du musst die AGB und Datenschutzerklärung akzeptieren'**
  String get auth_registerTermsRequired;

  /// No description provided for @auth_forgotPasswordTitle.
  ///
  /// In de, this message translates to:
  /// **'Passwort zurücksetzen'**
  String get auth_forgotPasswordTitle;

  /// No description provided for @auth_forgotPasswordDescription.
  ///
  /// In de, this message translates to:
  /// **'Gib deine E-Mail-Adresse ein und wir senden dir einen Link zum Zurücksetzen deines Passworts.'**
  String get auth_forgotPasswordDescription;

  /// No description provided for @auth_forgotPasswordSendLink.
  ///
  /// In de, this message translates to:
  /// **'Link senden'**
  String get auth_forgotPasswordSendLink;

  /// No description provided for @auth_forgotPasswordBackToLogin.
  ///
  /// In de, this message translates to:
  /// **'Zurück zum Login'**
  String get auth_forgotPasswordBackToLogin;

  /// No description provided for @auth_forgotPasswordEmailSent.
  ///
  /// In de, this message translates to:
  /// **'E-Mail wurde gesendet!'**
  String get auth_forgotPasswordEmailSent;

  /// No description provided for @auth_forgotPasswordCheckInbox.
  ///
  /// In de, this message translates to:
  /// **'Prüfe dein Postfach.'**
  String get auth_forgotPasswordCheckInbox;

  /// No description provided for @auth_verifyEmailTitle.
  ///
  /// In de, this message translates to:
  /// **'E-Mail bestätigen'**
  String get auth_verifyEmailTitle;

  /// No description provided for @auth_verifyEmailSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Bitte bestätige deine E-Mail-Adresse'**
  String get auth_verifyEmailSubtitle;

  /// No description provided for @auth_verifyEmailDescription.
  ///
  /// In de, this message translates to:
  /// **'Wir haben dir eine Bestätigungs-E-Mail gesendet. Klicke auf den Link in der E-Mail, um dein Konto zu aktivieren.'**
  String get auth_verifyEmailDescription;

  /// No description provided for @auth_verifyEmailResend.
  ///
  /// In de, this message translates to:
  /// **'Erneut senden'**
  String get auth_verifyEmailResend;

  /// No description provided for @auth_verifyEmailResendCountdown.
  ///
  /// In de, this message translates to:
  /// **'Erneut senden ({seconds}s)'**
  String auth_verifyEmailResendCountdown(int seconds);

  /// No description provided for @auth_verifyEmailBackToLogin.
  ///
  /// In de, this message translates to:
  /// **'Zurück zum Login'**
  String get auth_verifyEmailBackToLogin;

  /// No description provided for @auth_verifyEmailResent.
  ///
  /// In de, this message translates to:
  /// **'E-Mail wurde erneut gesendet'**
  String get auth_verifyEmailResent;

  /// No description provided for @shell_dashboard.
  ///
  /// In de, this message translates to:
  /// **'Dashboard'**
  String get shell_dashboard;

  /// No description provided for @shell_kinder.
  ///
  /// In de, this message translates to:
  /// **'Kinder'**
  String get shell_kinder;

  /// No description provided for @shell_anwesenheit.
  ///
  /// In de, this message translates to:
  /// **'Anwesenheit'**
  String get shell_anwesenheit;

  /// No description provided for @shell_nachrichten.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get shell_nachrichten;

  /// No description provided for @shell_mehr.
  ///
  /// In de, this message translates to:
  /// **'Mehr'**
  String get shell_mehr;

  /// No description provided for @shell_elternHome.
  ///
  /// In de, this message translates to:
  /// **'Home'**
  String get shell_elternHome;

  /// No description provided for @shell_elternNachrichten.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get shell_elternNachrichten;

  /// No description provided for @shell_elternTermine.
  ///
  /// In de, this message translates to:
  /// **'Termine'**
  String get shell_elternTermine;

  /// No description provided for @shell_elternMeinKind.
  ///
  /// In de, this message translates to:
  /// **'Mein Kind'**
  String get shell_elternMeinKind;

  /// No description provided for @shell_elternMehr.
  ///
  /// In de, this message translates to:
  /// **'Mehr'**
  String get shell_elternMehr;

  /// No description provided for @onboarding_institutionTitle.
  ///
  /// In de, this message translates to:
  /// **'Einrichtung einrichten'**
  String get onboarding_institutionTitle;

  /// No description provided for @onboarding_institutionCreate.
  ///
  /// In de, this message translates to:
  /// **'Einrichtung erstellen'**
  String get onboarding_institutionCreate;

  /// No description provided for @onboarding_stepType.
  ///
  /// In de, this message translates to:
  /// **'Einrichtungstyp wählen'**
  String get onboarding_stepType;

  /// No description provided for @onboarding_stepData.
  ///
  /// In de, this message translates to:
  /// **'Einrichtungsdaten'**
  String get onboarding_stepData;

  /// No description provided for @onboarding_stepGroups.
  ///
  /// In de, this message translates to:
  /// **'Gruppen/Klassen anlegen'**
  String get onboarding_stepGroups;

  /// No description provided for @onboarding_stepStaff.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter einladen'**
  String get onboarding_stepStaff;

  /// No description provided for @onboarding_selectTypePrompt.
  ///
  /// In de, this message translates to:
  /// **'Bitte wähle einen Einrichtungstyp aus.'**
  String get onboarding_selectTypePrompt;

  /// No description provided for @onboarding_nameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib einen Namen für die Einrichtung ein.'**
  String get onboarding_nameRequired;

  /// No description provided for @onboarding_nameLabel.
  ///
  /// In de, this message translates to:
  /// **'Name der Einrichtung'**
  String get onboarding_nameLabel;

  /// No description provided for @onboarding_street.
  ///
  /// In de, this message translates to:
  /// **'Straße'**
  String get onboarding_street;

  /// No description provided for @onboarding_zip.
  ///
  /// In de, this message translates to:
  /// **'PLZ'**
  String get onboarding_zip;

  /// No description provided for @onboarding_city.
  ///
  /// In de, this message translates to:
  /// **'Ort'**
  String get onboarding_city;

  /// No description provided for @onboarding_state.
  ///
  /// In de, this message translates to:
  /// **'Bundesland'**
  String get onboarding_state;

  /// No description provided for @onboarding_phone.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get onboarding_phone;

  /// No description provided for @onboarding_emailLabel.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get onboarding_emailLabel;

  /// No description provided for @onboarding_maxChildren.
  ///
  /// In de, this message translates to:
  /// **'Max. Kinder'**
  String get onboarding_maxChildren;

  /// No description provided for @onboarding_color.
  ///
  /// In de, this message translates to:
  /// **'Farbe'**
  String get onboarding_color;

  /// No description provided for @onboarding_addGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe/Klasse hinzufügen'**
  String get onboarding_addGroup;

  /// No description provided for @onboarding_addInvitation.
  ///
  /// In de, this message translates to:
  /// **'Einladung hinzufügen'**
  String get onboarding_addInvitation;

  /// No description provided for @onboarding_creatingInstitution.
  ///
  /// In de, this message translates to:
  /// **'Einrichtung wird erstellt...'**
  String get onboarding_creatingInstitution;

  /// No description provided for @onboarding_parentTitle.
  ///
  /// In de, this message translates to:
  /// **'Eltern-Onboarding'**
  String get onboarding_parentTitle;

  /// No description provided for @onboarding_parentLinkChild.
  ///
  /// In de, this message translates to:
  /// **'Kind verknüpfen'**
  String get onboarding_parentLinkChild;

  /// No description provided for @onboarding_parentCodeHint.
  ///
  /// In de, this message translates to:
  /// **'Gib den Einladungscode ein...'**
  String get onboarding_parentCodeHint;

  /// No description provided for @onboarding_parentCodeLabel.
  ///
  /// In de, this message translates to:
  /// **'Einladungscode'**
  String get onboarding_parentCodeLabel;

  /// No description provided for @onboarding_parentCheckCode.
  ///
  /// In de, this message translates to:
  /// **'Code prüfen'**
  String get onboarding_parentCheckCode;

  /// No description provided for @onboarding_parentInvitationFound.
  ///
  /// In de, this message translates to:
  /// **'Einladung gefunden!'**
  String get onboarding_parentInvitationFound;

  /// No description provided for @onboarding_parentAcceptInvitation.
  ///
  /// In de, this message translates to:
  /// **'Einladung annehmen'**
  String get onboarding_parentAcceptInvitation;

  /// No description provided for @onboarding_parentWelcome.
  ///
  /// In de, this message translates to:
  /// **'Willkommen bei KitaFlow!'**
  String get onboarding_parentWelcome;

  /// No description provided for @onboarding_parentChildLinked.
  ///
  /// In de, this message translates to:
  /// **'Dein Kind wurde erfolgreich verknüpft.'**
  String get onboarding_parentChildLinked;

  /// No description provided for @onboarding_parentLetsGo.
  ///
  /// In de, this message translates to:
  /// **'Los geht\'s'**
  String get onboarding_parentLetsGo;

  /// No description provided for @dashboard_title.
  ///
  /// In de, this message translates to:
  /// **'Dashboard'**
  String get dashboard_title;

  /// No description provided for @dashboard_hints.
  ///
  /// In de, this message translates to:
  /// **'Hinweise'**
  String get dashboard_hints;

  /// No description provided for @dashboard_mealPlanToday.
  ///
  /// In de, this message translates to:
  /// **'Essensplan heute'**
  String get dashboard_mealPlanToday;

  /// No description provided for @dashboard_messages.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get dashboard_messages;

  /// No description provided for @dashboard_greetingMorning.
  ///
  /// In de, this message translates to:
  /// **'Guten Morgen'**
  String get dashboard_greetingMorning;

  /// No description provided for @dashboard_greetingAfternoon.
  ///
  /// In de, this message translates to:
  /// **'Guten Tag'**
  String get dashboard_greetingAfternoon;

  /// No description provided for @dashboard_greetingEvening.
  ///
  /// In de, this message translates to:
  /// **'Guten Abend'**
  String get dashboard_greetingEvening;

  /// No description provided for @dashboard_greetingWithName.
  ///
  /// In de, this message translates to:
  /// **'{greeting}, {name}!'**
  String dashboard_greetingWithName(String greeting, String name);

  /// No description provided for @dashboard_statsPresent.
  ///
  /// In de, this message translates to:
  /// **'Anwesend'**
  String get dashboard_statsPresent;

  /// No description provided for @dashboard_statsUnread.
  ///
  /// In de, this message translates to:
  /// **'Ungelesen'**
  String get dashboard_statsUnread;

  /// No description provided for @dashboard_statsSick.
  ///
  /// In de, this message translates to:
  /// **'Krank'**
  String get dashboard_statsSick;

  /// No description provided for @dashboard_quickCheckIn.
  ///
  /// In de, this message translates to:
  /// **'Check-in'**
  String get dashboard_quickCheckIn;

  /// No description provided for @dashboard_quickMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht'**
  String get dashboard_quickMessage;

  /// No description provided for @dashboard_quickAddChild.
  ///
  /// In de, this message translates to:
  /// **'Kind +'**
  String get dashboard_quickAddChild;

  /// No description provided for @dashboard_quickMessages.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get dashboard_quickMessages;

  /// No description provided for @dashboard_quickSickNote.
  ///
  /// In de, this message translates to:
  /// **'Krankmeldung'**
  String get dashboard_quickSickNote;

  /// No description provided for @dashboard_noMealPlan.
  ///
  /// In de, this message translates to:
  /// **'Kein Essensplan für heute'**
  String get dashboard_noMealPlan;

  /// No description provided for @dashboard_noNewMessages.
  ///
  /// In de, this message translates to:
  /// **'Keine neuen Nachrichten'**
  String get dashboard_noNewMessages;

  /// No description provided for @dashboard_birthdayAlert.
  ///
  /// In de, this message translates to:
  /// **'Geburtstag: {name}'**
  String dashboard_birthdayAlert(String name);

  /// No description provided for @dashboard_birthdayToday.
  ///
  /// In de, this message translates to:
  /// **'Wird heute {years} Jahre alt!'**
  String dashboard_birthdayToday(int years);

  /// No description provided for @dashboard_birthdayUpcoming.
  ///
  /// In de, this message translates to:
  /// **'Wird {years} Jahre alt am {date}'**
  String dashboard_birthdayUpcoming(int years, String date);

  /// No description provided for @kinder_title.
  ///
  /// In de, this message translates to:
  /// **'Kinder'**
  String get kinder_title;

  /// No description provided for @kinder_search.
  ///
  /// In de, this message translates to:
  /// **'Kinder suchen...'**
  String get kinder_search;

  /// No description provided for @kinder_notFound.
  ///
  /// In de, this message translates to:
  /// **'Keine Kinder gefunden'**
  String get kinder_notFound;

  /// No description provided for @kinder_notFoundDescription.
  ///
  /// In de, this message translates to:
  /// **'Es wurden keine Kinder mit den aktuellen Filtern gefunden.'**
  String get kinder_notFoundDescription;

  /// No description provided for @kinder_addChild.
  ///
  /// In de, this message translates to:
  /// **'Kind hinzufügen'**
  String get kinder_addChild;

  /// No description provided for @kinder_errorOccurred.
  ///
  /// In de, this message translates to:
  /// **'Ein Fehler ist aufgetreten.'**
  String get kinder_errorOccurred;

  /// No description provided for @kinder_formEditTitle.
  ///
  /// In de, this message translates to:
  /// **'Kind bearbeiten'**
  String get kinder_formEditTitle;

  /// No description provided for @kinder_formNewTitle.
  ///
  /// In de, this message translates to:
  /// **'Neues Kind'**
  String get kinder_formNewTitle;

  /// No description provided for @kinder_formFirstName.
  ///
  /// In de, this message translates to:
  /// **'Vorname *'**
  String get kinder_formFirstName;

  /// No description provided for @kinder_formLastName.
  ///
  /// In de, this message translates to:
  /// **'Nachname *'**
  String get kinder_formLastName;

  /// No description provided for @kinder_formFirstNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Vorname eingeben'**
  String get kinder_formFirstNameRequired;

  /// No description provided for @kinder_formLastNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Nachname eingeben'**
  String get kinder_formLastNameRequired;

  /// No description provided for @kinder_formBirthDate.
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum *'**
  String get kinder_formBirthDate;

  /// No description provided for @kinder_formBirthDateSelect.
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum wählen'**
  String get kinder_formBirthDateSelect;

  /// No description provided for @kinder_formBirthDateRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Geburtsdatum wählen'**
  String get kinder_formBirthDateRequired;

  /// No description provided for @kinder_formGender.
  ///
  /// In de, this message translates to:
  /// **'Geschlecht'**
  String get kinder_formGender;

  /// No description provided for @kinder_formGenderSelect.
  ///
  /// In de, this message translates to:
  /// **'Geschlecht wählen'**
  String get kinder_formGenderSelect;

  /// No description provided for @kinder_formGenderMale.
  ///
  /// In de, this message translates to:
  /// **'Männlich'**
  String get kinder_formGenderMale;

  /// No description provided for @kinder_formGenderFemale.
  ///
  /// In de, this message translates to:
  /// **'Weiblich'**
  String get kinder_formGenderFemale;

  /// No description provided for @kinder_formGenderDiverse.
  ///
  /// In de, this message translates to:
  /// **'Divers'**
  String get kinder_formGenderDiverse;

  /// No description provided for @kinder_formGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe'**
  String get kinder_formGroup;

  /// No description provided for @kinder_formGroupSelect.
  ///
  /// In de, this message translates to:
  /// **'Gruppe wählen'**
  String get kinder_formGroupSelect;

  /// No description provided for @kinder_formEntryDate.
  ///
  /// In de, this message translates to:
  /// **'Eintrittsdatum'**
  String get kinder_formEntryDate;

  /// No description provided for @kinder_formEntryDateSelect.
  ///
  /// In de, this message translates to:
  /// **'Eintrittsdatum wählen'**
  String get kinder_formEntryDateSelect;

  /// No description provided for @kinder_formNotes.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get kinder_formNotes;

  /// No description provided for @kinder_formNotesHint.
  ///
  /// In de, this message translates to:
  /// **'Besondere Hinweise, Bedürfnisse etc.'**
  String get kinder_formNotesHint;

  /// No description provided for @kinder_formSave.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get kinder_formSave;

  /// No description provided for @kinder_formCreate.
  ///
  /// In de, this message translates to:
  /// **'Kind anlegen'**
  String get kinder_formCreate;

  /// No description provided for @kinder_detailNotFound.
  ///
  /// In de, this message translates to:
  /// **'Kind nicht gefunden.'**
  String get kinder_detailNotFound;

  /// No description provided for @kinder_detailDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Kind löschen'**
  String get kinder_detailDeleteTitle;

  /// No description provided for @kinder_detailDeleteConfirm.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du {name} wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.'**
  String kinder_detailDeleteConfirm(String name);

  /// No description provided for @kinder_detailTabMasterData.
  ///
  /// In de, this message translates to:
  /// **'Stammdaten'**
  String get kinder_detailTabMasterData;

  /// No description provided for @kinder_detailTabAllergies.
  ///
  /// In de, this message translates to:
  /// **'Allergien ({count})'**
  String kinder_detailTabAllergies(int count);

  /// No description provided for @kinder_detailTabContacts.
  ///
  /// In de, this message translates to:
  /// **'Kontakte ({count})'**
  String kinder_detailTabContacts(int count);

  /// No description provided for @kinder_detailBirthDate.
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum'**
  String get kinder_detailBirthDate;

  /// No description provided for @kinder_detailGender.
  ///
  /// In de, this message translates to:
  /// **'Geschlecht'**
  String get kinder_detailGender;

  /// No description provided for @kinder_detailGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe'**
  String get kinder_detailGroup;

  /// No description provided for @kinder_detailEntryDate.
  ///
  /// In de, this message translates to:
  /// **'Eintrittsdatum'**
  String get kinder_detailEntryDate;

  /// No description provided for @kinder_detailStatus.
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get kinder_detailStatus;

  /// No description provided for @kinder_detailNotes.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get kinder_detailNotes;

  /// No description provided for @kinder_detailNoAllergies.
  ///
  /// In de, this message translates to:
  /// **'Keine Allergien erfasst'**
  String get kinder_detailNoAllergies;

  /// No description provided for @kinder_detailAddAllergyHint.
  ///
  /// In de, this message translates to:
  /// **'Fügen Sie bekannte Allergien hinzu...'**
  String get kinder_detailAddAllergyHint;

  /// No description provided for @kinder_detailAddAllergy.
  ///
  /// In de, this message translates to:
  /// **'Allergie hinzufügen'**
  String get kinder_detailAddAllergy;

  /// No description provided for @kinder_detailRemoveAllergy.
  ///
  /// In de, this message translates to:
  /// **'Allergie entfernen'**
  String get kinder_detailRemoveAllergy;

  /// No description provided for @kinder_detailNoContacts.
  ///
  /// In de, this message translates to:
  /// **'Keine Kontaktpersonen'**
  String get kinder_detailNoContacts;

  /// No description provided for @kinder_detailAddContactHint.
  ///
  /// In de, this message translates to:
  /// **'Fügen Sie Kontaktpersonen hinzu...'**
  String get kinder_detailAddContactHint;

  /// No description provided for @kinder_detailAddContact.
  ///
  /// In de, this message translates to:
  /// **'Kontakt hinzufügen'**
  String get kinder_detailAddContact;

  /// No description provided for @kinder_detailRemoveContact.
  ///
  /// In de, this message translates to:
  /// **'Kontakt entfernen'**
  String get kinder_detailRemoveContact;

  /// No description provided for @kinder_detailPickupAuthorized.
  ///
  /// In de, this message translates to:
  /// **'Abholberechtigt'**
  String get kinder_detailPickupAuthorized;

  /// No description provided for @kinder_detailEmergencyContact.
  ///
  /// In de, this message translates to:
  /// **'Notfallkontakt'**
  String get kinder_detailEmergencyContact;

  /// No description provided for @kinder_allergyFormTitle.
  ///
  /// In de, this message translates to:
  /// **'Allergie hinzufügen'**
  String get kinder_allergyFormTitle;

  /// No description provided for @kinder_allergyFormAllergen.
  ///
  /// In de, this message translates to:
  /// **'Allergen *'**
  String get kinder_allergyFormAllergen;

  /// No description provided for @kinder_allergyFormAllergenRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte ein Allergen auswählen'**
  String get kinder_allergyFormAllergenRequired;

  /// No description provided for @kinder_allergyFormSeverity.
  ///
  /// In de, this message translates to:
  /// **'Schweregrad'**
  String get kinder_allergyFormSeverity;

  /// No description provided for @kinder_allergyFormHints.
  ///
  /// In de, this message translates to:
  /// **'Hinweise'**
  String get kinder_allergyFormHints;

  /// No description provided for @kinder_allergyFormHintsPlaceholder.
  ///
  /// In de, this message translates to:
  /// **'z. B. Reaktion, Notfallmedikation'**
  String get kinder_allergyFormHintsPlaceholder;

  /// No description provided for @kinder_contactFormEditTitle.
  ///
  /// In de, this message translates to:
  /// **'Kontakt bearbeiten'**
  String get kinder_contactFormEditTitle;

  /// No description provided for @kinder_contactFormAddTitle.
  ///
  /// In de, this message translates to:
  /// **'Kontakt hinzufügen'**
  String get kinder_contactFormAddTitle;

  /// No description provided for @kinder_contactFormName.
  ///
  /// In de, this message translates to:
  /// **'Name *'**
  String get kinder_contactFormName;

  /// No description provided for @kinder_contactFormNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Name eingeben'**
  String get kinder_contactFormNameRequired;

  /// No description provided for @kinder_contactFormRelation.
  ///
  /// In de, this message translates to:
  /// **'Beziehung *'**
  String get kinder_contactFormRelation;

  /// No description provided for @kinder_contactFormRelationHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Mutter, Vater, Großeltern'**
  String get kinder_contactFormRelationHint;

  /// No description provided for @kinder_contactFormRelationRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Beziehung eingeben'**
  String get kinder_contactFormRelationRequired;

  /// No description provided for @kinder_contactFormPhone.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get kinder_contactFormPhone;

  /// No description provided for @kinder_contactFormEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get kinder_contactFormEmail;

  /// No description provided for @kinder_contactFormPickupAuthorized.
  ///
  /// In de, this message translates to:
  /// **'Abholberechtigt'**
  String get kinder_contactFormPickupAuthorized;

  /// No description provided for @kinder_contactFormPickupDescription.
  ///
  /// In de, this message translates to:
  /// **'Darf das Kind aus der Einrichtung abholen'**
  String get kinder_contactFormPickupDescription;

  /// No description provided for @kinder_contactFormEmergencyContact.
  ///
  /// In de, this message translates to:
  /// **'Notfallkontakt'**
  String get kinder_contactFormEmergencyContact;

  /// No description provided for @kinder_contactFormEmergencyDescription.
  ///
  /// In de, this message translates to:
  /// **'Wird im Notfall kontaktiert'**
  String get kinder_contactFormEmergencyDescription;

  /// No description provided for @kinder_contactFormSave.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get kinder_contactFormSave;

  /// No description provided for @anwesenheit_title.
  ///
  /// In de, this message translates to:
  /// **'Anwesenheit'**
  String get anwesenheit_title;

  /// No description provided for @anwesenheit_all.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get anwesenheit_all;

  /// No description provided for @anwesenheit_markAllPresent.
  ///
  /// In de, this message translates to:
  /// **'Alle anwesend markieren'**
  String get anwesenheit_markAllPresent;

  /// No description provided for @anwesenheit_alreadyPickedUp.
  ///
  /// In de, this message translates to:
  /// **'Bereits abgeholt oder abwesend gemeldet.'**
  String get anwesenheit_alreadyPickedUp;

  /// No description provided for @anwesenheit_allRecorded.
  ///
  /// In de, this message translates to:
  /// **'Alle Kinder sind bereits erfasst.'**
  String get anwesenheit_allRecorded;

  /// No description provided for @anwesenheit_markedPresent.
  ///
  /// In de, this message translates to:
  /// **'{count} Kinder als anwesend markiert.'**
  String anwesenheit_markedPresent(int count);

  /// No description provided for @anwesenheit_notRecorded.
  ///
  /// In de, this message translates to:
  /// **'Nicht erfasst'**
  String get anwesenheit_notRecorded;

  /// No description provided for @anwesenheit_presentSince.
  ///
  /// In de, this message translates to:
  /// **'Anwesend seit {time}'**
  String anwesenheit_presentSince(String time);

  /// No description provided for @anwesenheit_pickedUp.
  ///
  /// In de, this message translates to:
  /// **'Abgeholt {time}'**
  String anwesenheit_pickedUp(String time);

  /// No description provided for @anwesenheit_statsPresent.
  ///
  /// In de, this message translates to:
  /// **'Anwesend'**
  String get anwesenheit_statsPresent;

  /// No description provided for @anwesenheit_statsAbsent.
  ///
  /// In de, this message translates to:
  /// **'Abwesend'**
  String get anwesenheit_statsAbsent;

  /// No description provided for @anwesenheit_statsSick.
  ///
  /// In de, this message translates to:
  /// **'Krank'**
  String get anwesenheit_statsSick;

  /// No description provided for @anwesenheit_statsTotal.
  ///
  /// In de, this message translates to:
  /// **'Gesamt'**
  String get anwesenheit_statsTotal;

  /// No description provided for @anwesenheit_statusDialogTitle.
  ///
  /// In de, this message translates to:
  /// **'Status ändern'**
  String get anwesenheit_statusDialogTitle;

  /// No description provided for @anwesenheit_statusDialogNote.
  ///
  /// In de, this message translates to:
  /// **'Notiz (optional)'**
  String get anwesenheit_statusDialogNote;

  /// No description provided for @anwesenheit_statusDialogSetStatus.
  ///
  /// In de, this message translates to:
  /// **'Status setzen'**
  String get anwesenheit_statusDialogSetStatus;

  /// No description provided for @anwesenheit_sickNoteTitle.
  ///
  /// In de, this message translates to:
  /// **'Krankmeldung'**
  String get anwesenheit_sickNoteTitle;

  /// No description provided for @anwesenheit_sickNoteDescription.
  ///
  /// In de, this message translates to:
  /// **'Melde dein Kind krank oder entschuldige es.'**
  String get anwesenheit_sickNoteDescription;

  /// No description provided for @anwesenheit_sickNoteDate.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get anwesenheit_sickNoteDate;

  /// No description provided for @anwesenheit_sickNoteReason.
  ///
  /// In de, this message translates to:
  /// **'Grund *'**
  String get anwesenheit_sickNoteReason;

  /// No description provided for @anwesenheit_sickNoteMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht an die Einrichtung'**
  String get anwesenheit_sickNoteMessage;

  /// No description provided for @anwesenheit_sickNoteMessageHint.
  ///
  /// In de, this message translates to:
  /// **'Optionale Nachricht an die Einrichtung...'**
  String get anwesenheit_sickNoteMessageHint;

  /// No description provided for @anwesenheit_sickNoteSend.
  ///
  /// In de, this message translates to:
  /// **'Krankmeldung senden'**
  String get anwesenheit_sickNoteSend;

  /// No description provided for @nachrichten_title.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get nachrichten_title;

  /// No description provided for @nachrichten_all.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get nachrichten_all;

  /// No description provided for @nachrichten_noMessages.
  ///
  /// In de, this message translates to:
  /// **'Keine Nachrichten'**
  String get nachrichten_noMessages;

  /// No description provided for @nachrichten_inboxEmpty.
  ///
  /// In de, this message translates to:
  /// **'Dein Posteingang ist leer.'**
  String get nachrichten_inboxEmpty;

  /// No description provided for @nachrichten_noSentMessages.
  ///
  /// In de, this message translates to:
  /// **'Keine gesendeten Nachrichten'**
  String get nachrichten_noSentMessages;

  /// No description provided for @nachrichten_noSentDescription.
  ///
  /// In de, this message translates to:
  /// **'Du hast noch keine Nachrichten versendet.'**
  String get nachrichten_noSentDescription;

  /// No description provided for @nachrichten_noImportant.
  ///
  /// In de, this message translates to:
  /// **'Keine wichtigen Nachrichten'**
  String get nachrichten_noImportant;

  /// No description provided for @nachrichten_noImportantDescription.
  ///
  /// In de, this message translates to:
  /// **'Es gibt keine als wichtig markierten Nachrichten.'**
  String get nachrichten_noImportantDescription;

  /// No description provided for @nachrichten_detailTitle.
  ///
  /// In de, this message translates to:
  /// **'Nachricht'**
  String get nachrichten_detailTitle;

  /// No description provided for @nachrichten_detailDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Nachricht löschen'**
  String get nachrichten_detailDeleteTitle;

  /// No description provided for @nachrichten_detailDeleteConfirm.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du diese Nachricht wirklich unwiderruflich löschen?'**
  String get nachrichten_detailDeleteConfirm;

  /// No description provided for @nachrichten_detailNotFound.
  ///
  /// In de, this message translates to:
  /// **'Nachricht nicht gefunden.'**
  String get nachrichten_detailNotFound;

  /// No description provided for @nachrichten_detailAttachments.
  ///
  /// In de, this message translates to:
  /// **'Anhänge'**
  String get nachrichten_detailAttachments;

  /// No description provided for @nachrichten_detailReadBy.
  ///
  /// In de, this message translates to:
  /// **'Gelesen von {read}/{total}'**
  String nachrichten_detailReadBy(int read, int total);

  /// No description provided for @nachrichten_detailDeleteTooltip.
  ///
  /// In de, this message translates to:
  /// **'Nachricht löschen'**
  String get nachrichten_detailDeleteTooltip;

  /// No description provided for @nachrichten_formTitle.
  ///
  /// In de, this message translates to:
  /// **'Neue Nachricht'**
  String get nachrichten_formTitle;

  /// No description provided for @nachrichten_formType.
  ///
  /// In de, this message translates to:
  /// **'Typ'**
  String get nachrichten_formType;

  /// No description provided for @nachrichten_formRecipients.
  ///
  /// In de, this message translates to:
  /// **'Empfänger'**
  String get nachrichten_formRecipients;

  /// No description provided for @nachrichten_formRecipientsAll.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get nachrichten_formRecipientsAll;

  /// No description provided for @nachrichten_formRecipientsGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe'**
  String get nachrichten_formRecipientsGroup;

  /// No description provided for @nachrichten_formRecipientsIndividual.
  ///
  /// In de, this message translates to:
  /// **'Einzeln'**
  String get nachrichten_formRecipientsIndividual;

  /// No description provided for @nachrichten_formSelectGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe auswählen'**
  String get nachrichten_formSelectGroup;

  /// No description provided for @nachrichten_formSelectGroupHint.
  ///
  /// In de, this message translates to:
  /// **'Bitte Gruppe wählen'**
  String get nachrichten_formSelectGroupHint;

  /// No description provided for @nachrichten_formSelectGroupRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte eine Gruppe auswählen'**
  String get nachrichten_formSelectGroupRequired;

  /// No description provided for @nachrichten_formSelectRecipients.
  ///
  /// In de, this message translates to:
  /// **'Empfänger auswählen'**
  String get nachrichten_formSelectRecipients;

  /// No description provided for @nachrichten_formRecipientsSelected.
  ///
  /// In de, this message translates to:
  /// **'{count} Empfänger ausgewählt'**
  String nachrichten_formRecipientsSelected(int count);

  /// No description provided for @nachrichten_formSubject.
  ///
  /// In de, this message translates to:
  /// **'Betreff'**
  String get nachrichten_formSubject;

  /// No description provided for @nachrichten_formSubjectHint.
  ///
  /// In de, this message translates to:
  /// **'Betreff eingeben'**
  String get nachrichten_formSubjectHint;

  /// No description provided for @nachrichten_formContent.
  ///
  /// In de, this message translates to:
  /// **'Inhalt'**
  String get nachrichten_formContent;

  /// No description provided for @nachrichten_formContentHint.
  ///
  /// In de, this message translates to:
  /// **'Nachricht eingeben...'**
  String get nachrichten_formContentHint;

  /// No description provided for @nachrichten_formMarkImportant.
  ///
  /// In de, this message translates to:
  /// **'Als wichtig markieren'**
  String get nachrichten_formMarkImportant;

  /// No description provided for @nachrichten_formSend.
  ///
  /// In de, this message translates to:
  /// **'Nachricht senden'**
  String get nachrichten_formSend;

  /// No description provided for @nachrichten_recipientDialogTitle.
  ///
  /// In de, this message translates to:
  /// **'Empfänger auswählen'**
  String get nachrichten_recipientDialogTitle;

  /// No description provided for @nachrichten_recipientDialogSearch.
  ///
  /// In de, this message translates to:
  /// **'Name oder Rolle suchen...'**
  String get nachrichten_recipientDialogSearch;

  /// No description provided for @nachrichten_recipientDialogNone.
  ///
  /// In de, this message translates to:
  /// **'Keine auswählen'**
  String get nachrichten_recipientDialogNone;

  /// No description provided for @nachrichten_recipientDialogAll.
  ///
  /// In de, this message translates to:
  /// **'Alle auswählen'**
  String get nachrichten_recipientDialogAll;

  /// No description provided for @nachrichten_recipientDialogConfirm.
  ///
  /// In de, this message translates to:
  /// **'{count} Empfänger auswählen'**
  String nachrichten_recipientDialogConfirm(int count);

  /// No description provided for @nachrichten_recipientDialogLoadError.
  ///
  /// In de, this message translates to:
  /// **'Profile konnten nicht geladen werden.'**
  String get nachrichten_recipientDialogLoadError;

  /// No description provided for @nachrichten_recipientDialogNoProfiles.
  ///
  /// In de, this message translates to:
  /// **'Keine Profile gefunden.'**
  String get nachrichten_recipientDialogNoProfiles;

  /// No description provided for @nachrichten_recipientDialogNoResults.
  ///
  /// In de, this message translates to:
  /// **'Keine Ergebnisse für \"{query}\".'**
  String nachrichten_recipientDialogNoResults(String query);

  /// No description provided for @nachrichten_attachmentDownload.
  ///
  /// In de, this message translates to:
  /// **'Herunterladen'**
  String get nachrichten_attachmentDownload;

  /// No description provided for @nachrichten_attachmentRemove.
  ///
  /// In de, this message translates to:
  /// **'Entfernen'**
  String get nachrichten_attachmentRemove;

  /// No description provided for @essensplan_title.
  ///
  /// In de, this message translates to:
  /// **'Essensplan'**
  String get essensplan_title;

  /// No description provided for @essensplan_previousWeek.
  ///
  /// In de, this message translates to:
  /// **'Vorherige Woche'**
  String get essensplan_previousWeek;

  /// No description provided for @essensplan_nextWeek.
  ///
  /// In de, this message translates to:
  /// **'Nächste Woche'**
  String get essensplan_nextWeek;

  /// No description provided for @essensplan_currentWeek.
  ///
  /// In de, this message translates to:
  /// **'Aktuelle Woche'**
  String get essensplan_currentWeek;

  /// No description provided for @essensplan_noMealPlan.
  ///
  /// In de, this message translates to:
  /// **'Kein Essensplan'**
  String get essensplan_noMealPlan;

  /// No description provided for @essensplan_noMealsPlanned.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Mahlzeiten für diese Woche geplant.'**
  String get essensplan_noMealsPlanned;

  /// No description provided for @essensplan_deleteMeal.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit löschen'**
  String get essensplan_deleteMeal;

  /// No description provided for @essensplan_formEditTitle.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit bearbeiten'**
  String get essensplan_formEditTitle;

  /// No description provided for @essensplan_formNewTitle.
  ///
  /// In de, this message translates to:
  /// **'Neue Mahlzeit'**
  String get essensplan_formNewTitle;

  /// No description provided for @essensplan_formDate.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get essensplan_formDate;

  /// No description provided for @essensplan_formMealType.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit-Typ'**
  String get essensplan_formMealType;

  /// No description provided for @essensplan_formDishName.
  ///
  /// In de, this message translates to:
  /// **'Gericht'**
  String get essensplan_formDishName;

  /// No description provided for @essensplan_formDishNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Gerichtname eingeben'**
  String get essensplan_formDishNameRequired;

  /// No description provided for @essensplan_formDescription.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung (optional)'**
  String get essensplan_formDescription;

  /// No description provided for @essensplan_formAllergens.
  ///
  /// In de, this message translates to:
  /// **'Allergene (EU-Verordnung 1169/2011)'**
  String get essensplan_formAllergens;

  /// No description provided for @essensplan_formVegetarian.
  ///
  /// In de, this message translates to:
  /// **'Vegetarisch'**
  String get essensplan_formVegetarian;

  /// No description provided for @essensplan_formVegan.
  ///
  /// In de, this message translates to:
  /// **'Vegan'**
  String get essensplan_formVegan;

  /// No description provided for @essensplan_formSave.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit speichern'**
  String get essensplan_formSave;

  /// No description provided for @essensplan_allergenWarnings.
  ///
  /// In de, this message translates to:
  /// **'Allergen-Warnungen ({count})'**
  String essensplan_allergenWarnings(int count);

  /// No description provided for @essensplan_weekdayMonday.
  ///
  /// In de, this message translates to:
  /// **'Montag'**
  String get essensplan_weekdayMonday;

  /// No description provided for @essensplan_weekdayTuesday.
  ///
  /// In de, this message translates to:
  /// **'Dienstag'**
  String get essensplan_weekdayTuesday;

  /// No description provided for @essensplan_weekdayWednesday.
  ///
  /// In de, this message translates to:
  /// **'Mittwoch'**
  String get essensplan_weekdayWednesday;

  /// No description provided for @essensplan_weekdayThursday.
  ///
  /// In de, this message translates to:
  /// **'Donnerstag'**
  String get essensplan_weekdayThursday;

  /// No description provided for @essensplan_weekdayFriday.
  ///
  /// In de, this message translates to:
  /// **'Freitag'**
  String get essensplan_weekdayFriday;

  /// No description provided for @essensplan_weekdaySaturday.
  ///
  /// In de, this message translates to:
  /// **'Samstag'**
  String get essensplan_weekdaySaturday;

  /// No description provided for @essensplan_weekdaySunday.
  ///
  /// In de, this message translates to:
  /// **'Sonntag'**
  String get essensplan_weekdaySunday;

  /// No description provided for @eltern_homeTitle.
  ///
  /// In de, this message translates to:
  /// **'KitaFlow'**
  String get eltern_homeTitle;

  /// No description provided for @eltern_homeMyChildren.
  ///
  /// In de, this message translates to:
  /// **'Meine Kinder'**
  String get eltern_homeMyChildren;

  /// No description provided for @eltern_homeNoChildren.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Kinder verknüpft.'**
  String get eltern_homeNoChildren;

  /// No description provided for @eltern_homeQuickActions.
  ///
  /// In de, this message translates to:
  /// **'Schnellaktionen'**
  String get eltern_homeQuickActions;

  /// No description provided for @eltern_quickSickNote.
  ///
  /// In de, this message translates to:
  /// **'Krankmeldung'**
  String get eltern_quickSickNote;

  /// No description provided for @eltern_quickMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht'**
  String get eltern_quickMessage;

  /// No description provided for @eltern_quickCalendar.
  ///
  /// In de, this message translates to:
  /// **'Termine'**
  String get eltern_quickCalendar;

  /// No description provided for @eltern_kindTitle.
  ///
  /// In de, this message translates to:
  /// **'Mein Kind'**
  String get eltern_kindTitle;

  /// No description provided for @eltern_kindTabProfile.
  ///
  /// In de, this message translates to:
  /// **'Profil'**
  String get eltern_kindTabProfile;

  /// No description provided for @eltern_kindTabAttendance.
  ///
  /// In de, this message translates to:
  /// **'Anwesenheit'**
  String get eltern_kindTabAttendance;

  /// No description provided for @eltern_kindTabAllergies.
  ///
  /// In de, this message translates to:
  /// **'Allergien'**
  String get eltern_kindTabAllergies;

  /// No description provided for @eltern_kindTabContacts.
  ///
  /// In de, this message translates to:
  /// **'Kontakte'**
  String get eltern_kindTabContacts;

  /// No description provided for @eltern_kindNoChildSelected.
  ///
  /// In de, this message translates to:
  /// **'Kein Kind ausgewählt.'**
  String get eltern_kindNoChildSelected;

  /// No description provided for @eltern_kindBirthday.
  ///
  /// In de, this message translates to:
  /// **'Geburtstag'**
  String get eltern_kindBirthday;

  /// No description provided for @eltern_kindGender.
  ///
  /// In de, this message translates to:
  /// **'Geschlecht'**
  String get eltern_kindGender;

  /// No description provided for @eltern_kindStatus.
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get eltern_kindStatus;

  /// No description provided for @eltern_kindNoAllergies.
  ///
  /// In de, this message translates to:
  /// **'Keine Allergien erfasst.'**
  String get eltern_kindNoAllergies;

  /// No description provided for @eltern_kindAllergiesTitle.
  ///
  /// In de, this message translates to:
  /// **'Allergien & Unverträglichkeiten'**
  String get eltern_kindAllergiesTitle;

  /// No description provided for @eltern_kindAttendanceTitle.
  ///
  /// In de, this message translates to:
  /// **'Anwesenheit'**
  String get eltern_kindAttendanceTitle;

  /// No description provided for @eltern_kindAttendanceLoading.
  ///
  /// In de, this message translates to:
  /// **'Anwesenheitskalender wird geladen...'**
  String get eltern_kindAttendanceLoading;

  /// No description provided for @eltern_kindNoContacts.
  ///
  /// In de, this message translates to:
  /// **'Keine Kontaktpersonen erfasst.'**
  String get eltern_kindNoContacts;

  /// No description provided for @eltern_kindContactsTitle.
  ///
  /// In de, this message translates to:
  /// **'Kontaktpersonen'**
  String get eltern_kindContactsTitle;

  /// No description provided for @eltern_nachrichtenTitle.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get eltern_nachrichtenTitle;

  /// No description provided for @eltern_nachrichtenLoading.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten werden geladen…'**
  String get eltern_nachrichtenLoading;

  /// No description provided for @eltern_nachrichtenEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Nachrichten'**
  String get eltern_nachrichtenEmpty;

  /// No description provided for @eltern_nachrichtenEmptyDescription.
  ///
  /// In de, this message translates to:
  /// **'Du hast noch keine Nachrichten erhalten.'**
  String get eltern_nachrichtenEmptyDescription;

  /// No description provided for @termine_title.
  ///
  /// In de, this message translates to:
  /// **'Termine'**
  String get termine_title;

  /// No description provided for @termine_noAppointments.
  ///
  /// In de, this message translates to:
  /// **'Keine Termine vorhanden.'**
  String get termine_noAppointments;

  /// No description provided for @termine_rsvpTitle.
  ///
  /// In de, this message translates to:
  /// **'Rückmeldung'**
  String get termine_rsvpTitle;

  /// No description provided for @termine_rsvpFor.
  ///
  /// In de, this message translates to:
  /// **'Für: {title}'**
  String termine_rsvpFor(String title);

  /// No description provided for @termine_weekdayMon.
  ///
  /// In de, this message translates to:
  /// **'Mo'**
  String get termine_weekdayMon;

  /// No description provided for @termine_weekdayTue.
  ///
  /// In de, this message translates to:
  /// **'Di'**
  String get termine_weekdayTue;

  /// No description provided for @termine_weekdayWed.
  ///
  /// In de, this message translates to:
  /// **'Mi'**
  String get termine_weekdayWed;

  /// No description provided for @termine_weekdayThu.
  ///
  /// In de, this message translates to:
  /// **'Do'**
  String get termine_weekdayThu;

  /// No description provided for @termine_weekdayFri.
  ///
  /// In de, this message translates to:
  /// **'Fr'**
  String get termine_weekdayFri;

  /// No description provided for @termine_weekdaySat.
  ///
  /// In de, this message translates to:
  /// **'Sa'**
  String get termine_weekdaySat;

  /// No description provided for @termine_weekdaySun.
  ///
  /// In de, this message translates to:
  /// **'So'**
  String get termine_weekdaySun;

  /// No description provided for @fotos_title.
  ///
  /// In de, this message translates to:
  /// **'Fotos'**
  String get fotos_title;

  /// No description provided for @fotos_noPhotos.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Fotos vorhanden.'**
  String get fotos_noPhotos;

  /// No description provided for @fotos_viewerTitle.
  ///
  /// In de, this message translates to:
  /// **'Foto'**
  String get fotos_viewerTitle;

  /// No description provided for @push_title.
  ///
  /// In de, this message translates to:
  /// **'Push-Benachrichtigungen'**
  String get push_title;

  /// No description provided for @push_sectionNotifications.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen'**
  String get push_sectionNotifications;

  /// No description provided for @push_messages.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get push_messages;

  /// No description provided for @push_messagesDescription.
  ///
  /// In de, this message translates to:
  /// **'Neue Nachrichten und Elternbriefe'**
  String get push_messagesDescription;

  /// No description provided for @push_attendance.
  ///
  /// In de, this message translates to:
  /// **'Anwesenheit'**
  String get push_attendance;

  /// No description provided for @push_attendanceDescription.
  ///
  /// In de, this message translates to:
  /// **'Änderungen am Anwesenheitsstatus'**
  String get push_attendanceDescription;

  /// No description provided for @push_appointments.
  ///
  /// In de, this message translates to:
  /// **'Termine'**
  String get push_appointments;

  /// No description provided for @push_appointmentsDescription.
  ///
  /// In de, this message translates to:
  /// **'Neue Termine und Erinnerungen'**
  String get push_appointmentsDescription;

  /// No description provided for @push_mealPlan.
  ///
  /// In de, this message translates to:
  /// **'Essensplan'**
  String get push_mealPlan;

  /// No description provided for @push_mealPlanDescription.
  ///
  /// In de, this message translates to:
  /// **'Änderungen am Essensplan'**
  String get push_mealPlanDescription;

  /// No description provided for @push_emergency.
  ///
  /// In de, this message translates to:
  /// **'Notfall'**
  String get push_emergency;

  /// No description provided for @push_emergencyDescription.
  ///
  /// In de, this message translates to:
  /// **'Wichtige Notfallmeldungen'**
  String get push_emergencyDescription;

  /// No description provided for @push_sectionQuietHours.
  ///
  /// In de, this message translates to:
  /// **'Ruhezeiten'**
  String get push_sectionQuietHours;

  /// No description provided for @push_quietHoursDescription.
  ///
  /// In de, this message translates to:
  /// **'Keine Benachrichtigungen in diesem Zeitraum'**
  String get push_quietHoursDescription;

  /// No description provided for @push_quietHoursFrom.
  ///
  /// In de, this message translates to:
  /// **'Von'**
  String get push_quietHoursFrom;

  /// No description provided for @push_quietHoursTo.
  ///
  /// In de, this message translates to:
  /// **'Bis'**
  String get push_quietHoursTo;

  /// No description provided for @verwaltung_title.
  ///
  /// In de, this message translates to:
  /// **'Verwaltung'**
  String get verwaltung_title;

  /// No description provided for @verwaltung_institution.
  ///
  /// In de, this message translates to:
  /// **'Einrichtung'**
  String get verwaltung_institution;

  /// No description provided for @verwaltung_groupsTitle.
  ///
  /// In de, this message translates to:
  /// **'Gruppen & Klassen'**
  String get verwaltung_groupsTitle;

  /// No description provided for @verwaltung_groupsCount.
  ///
  /// In de, this message translates to:
  /// **'{count} Gruppen'**
  String verwaltung_groupsCount(int count);

  /// No description provided for @verwaltung_staffTitle.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter'**
  String get verwaltung_staffTitle;

  /// No description provided for @verwaltung_staffCount.
  ///
  /// In de, this message translates to:
  /// **'{count} Mitarbeiter'**
  String verwaltung_staffCount(int count);

  /// No description provided for @verwaltung_groupsListTitle.
  ///
  /// In de, this message translates to:
  /// **'Gruppen & Klassen'**
  String get verwaltung_groupsListTitle;

  /// No description provided for @verwaltung_groupsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Gruppen vorhanden.'**
  String get verwaltung_groupsEmpty;

  /// No description provided for @verwaltung_groupsOccupancyWithMax.
  ///
  /// In de, this message translates to:
  /// **'Belegung: {current} / {max}'**
  String verwaltung_groupsOccupancyWithMax(int current, int max);

  /// No description provided for @verwaltung_groupsOccupancy.
  ///
  /// In de, this message translates to:
  /// **'Belegung: {count} Kinder'**
  String verwaltung_groupsOccupancy(int count);

  /// No description provided for @verwaltung_groupsInactive.
  ///
  /// In de, this message translates to:
  /// **'Inaktiv'**
  String get verwaltung_groupsInactive;

  /// No description provided for @verwaltung_groupFormEditTitle.
  ///
  /// In de, this message translates to:
  /// **'Gruppe bearbeiten'**
  String get verwaltung_groupFormEditTitle;

  /// No description provided for @verwaltung_groupFormNewTitle.
  ///
  /// In de, this message translates to:
  /// **'Neue Gruppe'**
  String get verwaltung_groupFormNewTitle;

  /// No description provided for @verwaltung_groupFormName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get verwaltung_groupFormName;

  /// No description provided for @verwaltung_groupFormNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Name ist erforderlich'**
  String get verwaltung_groupFormNameRequired;

  /// No description provided for @verwaltung_groupFormType.
  ///
  /// In de, this message translates to:
  /// **'Typ'**
  String get verwaltung_groupFormType;

  /// No description provided for @verwaltung_groupFormTypeGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe'**
  String get verwaltung_groupFormTypeGroup;

  /// No description provided for @verwaltung_groupFormTypeClass.
  ///
  /// In de, this message translates to:
  /// **'Klasse'**
  String get verwaltung_groupFormTypeClass;

  /// No description provided for @verwaltung_groupFormMaxChildren.
  ///
  /// In de, this message translates to:
  /// **'Max. Kinder'**
  String get verwaltung_groupFormMaxChildren;

  /// No description provided for @verwaltung_groupFormAgeFrom.
  ///
  /// In de, this message translates to:
  /// **'Alter von'**
  String get verwaltung_groupFormAgeFrom;

  /// No description provided for @verwaltung_groupFormAgeTo.
  ///
  /// In de, this message translates to:
  /// **'Alter bis'**
  String get verwaltung_groupFormAgeTo;

  /// No description provided for @verwaltung_groupFormSchoolYear.
  ///
  /// In de, this message translates to:
  /// **'Schuljahr'**
  String get verwaltung_groupFormSchoolYear;

  /// No description provided for @verwaltung_groupFormColor.
  ///
  /// In de, this message translates to:
  /// **'Farbe'**
  String get verwaltung_groupFormColor;

  /// No description provided for @verwaltung_groupFormActive.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get verwaltung_groupFormActive;

  /// No description provided for @verwaltung_groupFormSave.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get verwaltung_groupFormSave;

  /// No description provided for @verwaltung_groupFormCreate.
  ///
  /// In de, this message translates to:
  /// **'Erstellen'**
  String get verwaltung_groupFormCreate;

  /// No description provided for @verwaltung_staffListTitle.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter'**
  String get verwaltung_staffListTitle;

  /// No description provided for @verwaltung_staffEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Mitarbeiter vorhanden.'**
  String get verwaltung_staffEmpty;

  /// No description provided for @verwaltung_staffChangeRole.
  ///
  /// In de, this message translates to:
  /// **'Rolle ändern'**
  String get verwaltung_staffChangeRole;

  /// No description provided for @verwaltung_staffAssignGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe zuordnen'**
  String get verwaltung_staffAssignGroup;

  /// No description provided for @verwaltung_staffRemove.
  ///
  /// In de, this message translates to:
  /// **'Entfernen'**
  String get verwaltung_staffRemove;

  /// No description provided for @verwaltung_staffNoGroup.
  ///
  /// In de, this message translates to:
  /// **'Keine Gruppe'**
  String get verwaltung_staffNoGroup;

  /// No description provided for @verwaltung_staffRemoveTitle.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter entfernen'**
  String get verwaltung_staffRemoveTitle;

  /// No description provided for @verwaltung_staffRemoveConfirm.
  ///
  /// In de, this message translates to:
  /// **'{name} wirklich aus der Einrichtung entfernen?'**
  String verwaltung_staffRemoveConfirm(String name);

  /// No description provided for @verwaltung_staffFormTitle.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter hinzufügen'**
  String get verwaltung_staffFormTitle;

  /// No description provided for @verwaltung_staffFormEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse'**
  String get verwaltung_staffFormEmail;

  /// No description provided for @verwaltung_staffFormEmailRequired.
  ///
  /// In de, this message translates to:
  /// **'E-Mail ist erforderlich'**
  String get verwaltung_staffFormEmailRequired;

  /// No description provided for @verwaltung_staffFormEmailInvalid.
  ///
  /// In de, this message translates to:
  /// **'Ungültige E-Mail-Adresse'**
  String get verwaltung_staffFormEmailInvalid;

  /// No description provided for @verwaltung_staffFormRole.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get verwaltung_staffFormRole;

  /// No description provided for @verwaltung_staffFormGroup.
  ///
  /// In de, this message translates to:
  /// **'Gruppe (optional)'**
  String get verwaltung_staffFormGroup;

  /// No description provided for @verwaltung_staffFormNoGroup.
  ///
  /// In de, this message translates to:
  /// **'Keine Gruppe'**
  String get verwaltung_staffFormNoGroup;

  /// No description provided for @verwaltung_staffFormAdd.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get verwaltung_staffFormAdd;

  /// No description provided for @verwaltung_staffFormInvitePending.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter-Einladung per E-Mail wird in einer späteren Phase implementiert.'**
  String get verwaltung_staffFormInvitePending;

  /// No description provided for @verwaltung_institutionFormTitle.
  ///
  /// In de, this message translates to:
  /// **'Einrichtung bearbeiten'**
  String get verwaltung_institutionFormTitle;

  /// No description provided for @verwaltung_institutionFormSectionGeneral.
  ///
  /// In de, this message translates to:
  /// **'Allgemein'**
  String get verwaltung_institutionFormSectionGeneral;

  /// No description provided for @verwaltung_institutionFormName.
  ///
  /// In de, this message translates to:
  /// **'Name der Einrichtung'**
  String get verwaltung_institutionFormName;

  /// No description provided for @verwaltung_institutionFormNameRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Name eingeben'**
  String get verwaltung_institutionFormNameRequired;

  /// No description provided for @verwaltung_institutionFormType.
  ///
  /// In de, this message translates to:
  /// **'Typ'**
  String get verwaltung_institutionFormType;

  /// No description provided for @verwaltung_institutionFormTypeHint.
  ///
  /// In de, this message translates to:
  /// **'Einrichtungstyp wählen'**
  String get verwaltung_institutionFormTypeHint;

  /// No description provided for @verwaltung_institutionFormTypeRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Typ auswählen'**
  String get verwaltung_institutionFormTypeRequired;

  /// No description provided for @verwaltung_institutionFormSectionAddress.
  ///
  /// In de, this message translates to:
  /// **'Adresse'**
  String get verwaltung_institutionFormSectionAddress;

  /// No description provided for @verwaltung_institutionFormStreet.
  ///
  /// In de, this message translates to:
  /// **'Straße & Hausnummer'**
  String get verwaltung_institutionFormStreet;

  /// No description provided for @verwaltung_institutionFormZip.
  ///
  /// In de, this message translates to:
  /// **'PLZ'**
  String get verwaltung_institutionFormZip;

  /// No description provided for @verwaltung_institutionFormCity.
  ///
  /// In de, this message translates to:
  /// **'Ort'**
  String get verwaltung_institutionFormCity;

  /// No description provided for @verwaltung_institutionFormState.
  ///
  /// In de, this message translates to:
  /// **'Bundesland'**
  String get verwaltung_institutionFormState;

  /// No description provided for @verwaltung_institutionFormSectionContact.
  ///
  /// In de, this message translates to:
  /// **'Kontakt'**
  String get verwaltung_institutionFormSectionContact;

  /// No description provided for @verwaltung_institutionFormPhone.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get verwaltung_institutionFormPhone;

  /// No description provided for @verwaltung_institutionFormEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get verwaltung_institutionFormEmail;

  /// No description provided for @verwaltung_institutionFormEmailInvalid.
  ///
  /// In de, this message translates to:
  /// **'Bitte gültige E-Mail eingeben'**
  String get verwaltung_institutionFormEmailInvalid;

  /// No description provided for @verwaltung_institutionFormWebsite.
  ///
  /// In de, this message translates to:
  /// **'Website'**
  String get verwaltung_institutionFormWebsite;

  /// No description provided for @verwaltung_institutionFormSaveSuccess.
  ///
  /// In de, this message translates to:
  /// **'Einrichtung erfolgreich gespeichert.'**
  String get verwaltung_institutionFormSaveSuccess;

  /// No description provided for @verwaltung_institutionFormSaveError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Speichern.'**
  String get verwaltung_institutionFormSaveError;

  /// No description provided for @verwaltung_institutionFormLoadError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden.'**
  String get verwaltung_institutionFormLoadError;

  /// No description provided for @enum_roleErzieher.
  ///
  /// In de, this message translates to:
  /// **'Erzieher:in'**
  String get enum_roleErzieher;

  /// No description provided for @enum_roleLehrer.
  ///
  /// In de, this message translates to:
  /// **'Lehrer:in'**
  String get enum_roleLehrer;

  /// No description provided for @enum_roleLeitung.
  ///
  /// In de, this message translates to:
  /// **'Leitung'**
  String get enum_roleLeitung;

  /// No description provided for @enum_roleTraeger.
  ///
  /// In de, this message translates to:
  /// **'Träger'**
  String get enum_roleTraeger;

  /// No description provided for @enum_roleEltern.
  ///
  /// In de, this message translates to:
  /// **'Eltern'**
  String get enum_roleEltern;

  /// No description provided for @enum_institutionTypeKrippe.
  ///
  /// In de, this message translates to:
  /// **'Krippe'**
  String get enum_institutionTypeKrippe;

  /// No description provided for @enum_institutionTypeKita.
  ///
  /// In de, this message translates to:
  /// **'Kita'**
  String get enum_institutionTypeKita;

  /// No description provided for @enum_institutionTypeGrundschule.
  ///
  /// In de, this message translates to:
  /// **'Grundschule'**
  String get enum_institutionTypeGrundschule;

  /// No description provided for @enum_institutionTypeOgs.
  ///
  /// In de, this message translates to:
  /// **'OGS'**
  String get enum_institutionTypeOgs;

  /// No description provided for @enum_institutionTypeHort.
  ///
  /// In de, this message translates to:
  /// **'Hort'**
  String get enum_institutionTypeHort;

  /// No description provided for @enum_attendanceAnwesend.
  ///
  /// In de, this message translates to:
  /// **'Anwesend'**
  String get enum_attendanceAnwesend;

  /// No description provided for @enum_attendanceAbwesend.
  ///
  /// In de, this message translates to:
  /// **'Abwesend'**
  String get enum_attendanceAbwesend;

  /// No description provided for @enum_attendanceKrank.
  ///
  /// In de, this message translates to:
  /// **'Krank'**
  String get enum_attendanceKrank;

  /// No description provided for @enum_attendanceUrlaub.
  ///
  /// In de, this message translates to:
  /// **'Urlaub'**
  String get enum_attendanceUrlaub;

  /// No description provided for @enum_attendanceEntschuldigt.
  ///
  /// In de, this message translates to:
  /// **'Entschuldigt'**
  String get enum_attendanceEntschuldigt;

  /// No description provided for @enum_attendanceUnentschuldigt.
  ///
  /// In de, this message translates to:
  /// **'Unentschuldigt'**
  String get enum_attendanceUnentschuldigt;

  /// No description provided for @enum_messageTypeNachricht.
  ///
  /// In de, this message translates to:
  /// **'Nachricht'**
  String get enum_messageTypeNachricht;

  /// No description provided for @enum_messageTypeElternbrief.
  ///
  /// In de, this message translates to:
  /// **'Elternbrief'**
  String get enum_messageTypeElternbrief;

  /// No description provided for @enum_messageTypeAnkuendigung.
  ///
  /// In de, this message translates to:
  /// **'Ankündigung'**
  String get enum_messageTypeAnkuendigung;

  /// No description provided for @enum_messageTypeNotfall.
  ///
  /// In de, this message translates to:
  /// **'Notfall'**
  String get enum_messageTypeNotfall;

  /// No description provided for @enum_childStatusAktiv.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get enum_childStatusAktiv;

  /// No description provided for @enum_childStatusEingewoehnung.
  ///
  /// In de, this message translates to:
  /// **'Eingewöhnung'**
  String get enum_childStatusEingewoehnung;

  /// No description provided for @enum_childStatusAbgemeldet.
  ///
  /// In de, this message translates to:
  /// **'Abgemeldet'**
  String get enum_childStatusAbgemeldet;

  /// No description provided for @enum_childStatusWarteliste.
  ///
  /// In de, this message translates to:
  /// **'Warteliste'**
  String get enum_childStatusWarteliste;

  /// No description provided for @enum_mealTypeFruehstueck.
  ///
  /// In de, this message translates to:
  /// **'Frühstück'**
  String get enum_mealTypeFruehstueck;

  /// No description provided for @enum_mealTypeMittagessen.
  ///
  /// In de, this message translates to:
  /// **'Mittagessen'**
  String get enum_mealTypeMittagessen;

  /// No description provided for @enum_mealTypeSnack.
  ///
  /// In de, this message translates to:
  /// **'Snack'**
  String get enum_mealTypeSnack;

  /// No description provided for @enum_developmentMotorik.
  ///
  /// In de, this message translates to:
  /// **'Motorik'**
  String get enum_developmentMotorik;

  /// No description provided for @enum_developmentSprache.
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get enum_developmentSprache;

  /// No description provided for @enum_developmentSozialverhalten.
  ///
  /// In de, this message translates to:
  /// **'Sozialverhalten'**
  String get enum_developmentSozialverhalten;

  /// No description provided for @enum_developmentKognitiv.
  ///
  /// In de, this message translates to:
  /// **'Kognitive Entwicklung'**
  String get enum_developmentKognitiv;

  /// No description provided for @enum_developmentEmotional.
  ///
  /// In de, this message translates to:
  /// **'Emotionale Entwicklung'**
  String get enum_developmentEmotional;

  /// No description provided for @enum_developmentKreativitaet.
  ///
  /// In de, this message translates to:
  /// **'Kreativität'**
  String get enum_developmentKreativitaet;

  /// No description provided for @enum_allergenGluten.
  ///
  /// In de, this message translates to:
  /// **'Gluten'**
  String get enum_allergenGluten;

  /// No description provided for @enum_allergenKrebstiere.
  ///
  /// In de, this message translates to:
  /// **'Krebstiere'**
  String get enum_allergenKrebstiere;

  /// No description provided for @enum_allergenEier.
  ///
  /// In de, this message translates to:
  /// **'Eier'**
  String get enum_allergenEier;

  /// No description provided for @enum_allergenFisch.
  ///
  /// In de, this message translates to:
  /// **'Fisch'**
  String get enum_allergenFisch;

  /// No description provided for @enum_allergenErdnuesse.
  ///
  /// In de, this message translates to:
  /// **'Erdnüsse'**
  String get enum_allergenErdnuesse;

  /// No description provided for @enum_allergenSoja.
  ///
  /// In de, this message translates to:
  /// **'Soja'**
  String get enum_allergenSoja;

  /// No description provided for @enum_allergenMilch.
  ///
  /// In de, this message translates to:
  /// **'Milch'**
  String get enum_allergenMilch;

  /// No description provided for @enum_allergenSchalenfruechte.
  ///
  /// In de, this message translates to:
  /// **'Schalenfrüchte'**
  String get enum_allergenSchalenfruechte;

  /// No description provided for @enum_allergenSellerie.
  ///
  /// In de, this message translates to:
  /// **'Sellerie'**
  String get enum_allergenSellerie;

  /// No description provided for @enum_allergenSenf.
  ///
  /// In de, this message translates to:
  /// **'Senf'**
  String get enum_allergenSenf;

  /// No description provided for @enum_allergenSesam.
  ///
  /// In de, this message translates to:
  /// **'Sesam'**
  String get enum_allergenSesam;

  /// No description provided for @enum_allergenSchwefeldioxid.
  ///
  /// In de, this message translates to:
  /// **'Schwefeldioxid'**
  String get enum_allergenSchwefeldioxid;

  /// No description provided for @enum_allergenLupinen.
  ///
  /// In de, this message translates to:
  /// **'Lupinen'**
  String get enum_allergenLupinen;

  /// No description provided for @enum_allergenWeichtiere.
  ///
  /// In de, this message translates to:
  /// **'Weichtiere'**
  String get enum_allergenWeichtiere;

  /// No description provided for @enum_allergySeverityLeicht.
  ///
  /// In de, this message translates to:
  /// **'Leicht'**
  String get enum_allergySeverityLeicht;

  /// No description provided for @enum_allergySeverityMittel.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get enum_allergySeverityMittel;

  /// No description provided for @enum_allergySeveritySchwer.
  ///
  /// In de, this message translates to:
  /// **'Schwer'**
  String get enum_allergySeveritySchwer;

  /// No description provided for @enum_allergySeverityLebensbedrohlich.
  ///
  /// In de, this message translates to:
  /// **'Lebensbedrohlich'**
  String get enum_allergySeverityLebensbedrohlich;

  /// No description provided for @enum_documentTypeVertrag.
  ///
  /// In de, this message translates to:
  /// **'Vertrag'**
  String get enum_documentTypeVertrag;

  /// No description provided for @enum_documentTypeEinverstaendnis.
  ///
  /// In de, this message translates to:
  /// **'Einverständniserklärung'**
  String get enum_documentTypeEinverstaendnis;

  /// No description provided for @enum_documentTypeAttest.
  ///
  /// In de, this message translates to:
  /// **'Attest'**
  String get enum_documentTypeAttest;

  /// No description provided for @enum_documentTypeZeugnis.
  ///
  /// In de, this message translates to:
  /// **'Zeugnis'**
  String get enum_documentTypeZeugnis;

  /// No description provided for @enum_documentTypeSonstiges.
  ///
  /// In de, this message translates to:
  /// **'Sonstiges'**
  String get enum_documentTypeSonstiges;

  /// No description provided for @enum_nachrichtenTabPosteingang.
  ///
  /// In de, this message translates to:
  /// **'Posteingang'**
  String get enum_nachrichtenTabPosteingang;

  /// No description provided for @enum_nachrichtenTabGesendet.
  ///
  /// In de, this message translates to:
  /// **'Gesendet'**
  String get enum_nachrichtenTabGesendet;

  /// No description provided for @enum_nachrichtenTabWichtig.
  ///
  /// In de, this message translates to:
  /// **'Wichtig'**
  String get enum_nachrichtenTabWichtig;

  /// No description provided for @enum_terminTypAllgemein.
  ///
  /// In de, this message translates to:
  /// **'Allgemein'**
  String get enum_terminTypAllgemein;

  /// No description provided for @enum_terminTypElternabend.
  ///
  /// In de, this message translates to:
  /// **'Elternabend'**
  String get enum_terminTypElternabend;

  /// No description provided for @enum_terminTypFestFeier.
  ///
  /// In de, this message translates to:
  /// **'Fest/Feier'**
  String get enum_terminTypFestFeier;

  /// No description provided for @enum_terminTypSchliessung.
  ///
  /// In de, this message translates to:
  /// **'Schließung'**
  String get enum_terminTypSchliessung;

  /// No description provided for @enum_terminTypAusflug.
  ///
  /// In de, this message translates to:
  /// **'Ausflug'**
  String get enum_terminTypAusflug;

  /// No description provided for @enum_terminTypSonstiges.
  ///
  /// In de, this message translates to:
  /// **'Sonstiges'**
  String get enum_terminTypSonstiges;

  /// No description provided for @enum_rsvpZugesagt.
  ///
  /// In de, this message translates to:
  /// **'Zugesagt'**
  String get enum_rsvpZugesagt;

  /// No description provided for @enum_rsvpAbgesagt.
  ///
  /// In de, this message translates to:
  /// **'Abgesagt'**
  String get enum_rsvpAbgesagt;

  /// No description provided for @enum_rsvpVielleicht.
  ///
  /// In de, this message translates to:
  /// **'Vielleicht'**
  String get enum_rsvpVielleicht;

  /// No description provided for @enum_elternBeziehungMutter.
  ///
  /// In de, this message translates to:
  /// **'Mutter'**
  String get enum_elternBeziehungMutter;

  /// No description provided for @enum_elternBeziehungVater.
  ///
  /// In de, this message translates to:
  /// **'Vater'**
  String get enum_elternBeziehungVater;

  /// No description provided for @enum_elternBeziehungSorgeberechtigt.
  ///
  /// In de, this message translates to:
  /// **'Sorgeberechtigt'**
  String get enum_elternBeziehungSorgeberechtigt;

  /// No description provided for @dashboard_monthJanuar.
  ///
  /// In de, this message translates to:
  /// **'Januar'**
  String get dashboard_monthJanuar;

  /// No description provided for @dashboard_monthFebruar.
  ///
  /// In de, this message translates to:
  /// **'Februar'**
  String get dashboard_monthFebruar;

  /// No description provided for @dashboard_monthMaerz.
  ///
  /// In de, this message translates to:
  /// **'März'**
  String get dashboard_monthMaerz;

  /// No description provided for @dashboard_monthApril.
  ///
  /// In de, this message translates to:
  /// **'April'**
  String get dashboard_monthApril;

  /// No description provided for @dashboard_monthMai.
  ///
  /// In de, this message translates to:
  /// **'Mai'**
  String get dashboard_monthMai;

  /// No description provided for @dashboard_monthJuni.
  ///
  /// In de, this message translates to:
  /// **'Juni'**
  String get dashboard_monthJuni;

  /// No description provided for @dashboard_monthJuli.
  ///
  /// In de, this message translates to:
  /// **'Juli'**
  String get dashboard_monthJuli;

  /// No description provided for @dashboard_monthAugust.
  ///
  /// In de, this message translates to:
  /// **'August'**
  String get dashboard_monthAugust;

  /// No description provided for @dashboard_monthSeptember.
  ///
  /// In de, this message translates to:
  /// **'September'**
  String get dashboard_monthSeptember;

  /// No description provided for @dashboard_monthOktober.
  ///
  /// In de, this message translates to:
  /// **'Oktober'**
  String get dashboard_monthOktober;

  /// No description provided for @dashboard_monthNovember.
  ///
  /// In de, this message translates to:
  /// **'November'**
  String get dashboard_monthNovember;

  /// No description provided for @dashboard_monthDezember.
  ///
  /// In de, this message translates to:
  /// **'Dezember'**
  String get dashboard_monthDezember;

  /// No description provided for @dashboard_weekdayMontag.
  ///
  /// In de, this message translates to:
  /// **'Montag'**
  String get dashboard_weekdayMontag;

  /// No description provided for @dashboard_weekdayDienstag.
  ///
  /// In de, this message translates to:
  /// **'Dienstag'**
  String get dashboard_weekdayDienstag;

  /// No description provided for @dashboard_weekdayMittwoch.
  ///
  /// In de, this message translates to:
  /// **'Mittwoch'**
  String get dashboard_weekdayMittwoch;

  /// No description provided for @dashboard_weekdayDonnerstag.
  ///
  /// In de, this message translates to:
  /// **'Donnerstag'**
  String get dashboard_weekdayDonnerstag;

  /// No description provided for @dashboard_weekdayFreitag.
  ///
  /// In de, this message translates to:
  /// **'Freitag'**
  String get dashboard_weekdayFreitag;

  /// No description provided for @dashboard_weekdaySamstag.
  ///
  /// In de, this message translates to:
  /// **'Samstag'**
  String get dashboard_weekdaySamstag;

  /// No description provided for @dashboard_weekdaySonntag.
  ///
  /// In de, this message translates to:
  /// **'Sonntag'**
  String get dashboard_weekdaySonntag;

  /// No description provided for @verwaltung_rolleDropdownErzieher.
  ///
  /// In de, this message translates to:
  /// **'Erzieher/in'**
  String get verwaltung_rolleDropdownErzieher;

  /// No description provided for @verwaltung_rolleDropdownLehrer.
  ///
  /// In de, this message translates to:
  /// **'Lehrer/in'**
  String get verwaltung_rolleDropdownLehrer;

  /// No description provided for @verwaltung_rolleDropdownLeitung.
  ///
  /// In de, this message translates to:
  /// **'Leitung'**
  String get verwaltung_rolleDropdownLeitung;

  /// No description provided for @common_language.
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get common_language;

  /// No description provided for @dokumente_title.
  ///
  /// In de, this message translates to:
  /// **'Dokumente'**
  String get dokumente_title;

  /// No description provided for @dokumente_noDocuments.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Dokumente vorhanden.'**
  String get dokumente_noDocuments;

  /// No description provided for @dokumente_upload.
  ///
  /// In de, this message translates to:
  /// **'Hochladen'**
  String get dokumente_upload;

  /// No description provided for @dokumente_download.
  ///
  /// In de, this message translates to:
  /// **'Herunterladen'**
  String get dokumente_download;

  /// No description provided for @dokumente_delete.
  ///
  /// In de, this message translates to:
  /// **'Dokument löschen'**
  String get dokumente_delete;

  /// No description provided for @dokumente_deleteConfirm.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du dieses Dokument wirklich löschen?'**
  String get dokumente_deleteConfirm;

  /// No description provided for @dokumente_filterAll.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get dokumente_filterAll;

  /// No description provided for @dokumente_signed.
  ///
  /// In de, this message translates to:
  /// **'Unterschrieben'**
  String get dokumente_signed;

  /// No description provided for @dokumente_unsigned.
  ///
  /// In de, this message translates to:
  /// **'Nicht unterschrieben'**
  String get dokumente_unsigned;

  /// No description provided for @dokumente_signedBy.
  ///
  /// In de, this message translates to:
  /// **'Unterschrieben von {name} am {date}'**
  String dokumente_signedBy(String name, String date);

  /// No description provided for @dokumente_validUntil.
  ///
  /// In de, this message translates to:
  /// **'Gültig bis {date}'**
  String dokumente_validUntil(String date);

  /// No description provided for @dokumente_expired.
  ///
  /// In de, this message translates to:
  /// **'Abgelaufen'**
  String get dokumente_expired;

  /// No description provided for @dokumente_sign.
  ///
  /// In de, this message translates to:
  /// **'Unterschreiben'**
  String get dokumente_sign;

  /// No description provided for @dokumente_signTitle.
  ///
  /// In de, this message translates to:
  /// **'Dokument unterschreiben'**
  String get dokumente_signTitle;

  /// No description provided for @dokumente_signClear.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get dokumente_signClear;

  /// No description provided for @dokumente_signConfirm.
  ///
  /// In de, this message translates to:
  /// **'Unterschrift bestätigen'**
  String get dokumente_signConfirm;

  /// No description provided for @dokumente_signHint.
  ///
  /// In de, this message translates to:
  /// **'Hier unterschreiben'**
  String get dokumente_signHint;

  /// No description provided for @dokumente_uploadSuccess.
  ///
  /// In de, this message translates to:
  /// **'Dokument erfolgreich hochgeladen.'**
  String get dokumente_uploadSuccess;

  /// No description provided for @dokumente_uploadError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Hochladen des Dokuments.'**
  String get dokumente_uploadError;

  /// No description provided for @dokumente_deleteSuccess.
  ///
  /// In de, this message translates to:
  /// **'Dokument erfolgreich gelöscht.'**
  String get dokumente_deleteSuccess;

  /// No description provided for @dokumente_signSuccess.
  ///
  /// In de, this message translates to:
  /// **'Dokument erfolgreich unterschrieben.'**
  String get dokumente_signSuccess;

  /// No description provided for @dokumente_pdfGenerate.
  ///
  /// In de, this message translates to:
  /// **'PDF erstellen'**
  String get dokumente_pdfGenerate;

  /// No description provided for @dokumente_pdfPreview.
  ///
  /// In de, this message translates to:
  /// **'PDF-Vorschau'**
  String get dokumente_pdfPreview;

  /// No description provided for @dokumente_formTitle.
  ///
  /// In de, this message translates to:
  /// **'Neues Dokument'**
  String get dokumente_formTitle;

  /// No description provided for @dokumente_formTitel.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get dokumente_formTitel;

  /// No description provided for @dokumente_formTyp.
  ///
  /// In de, this message translates to:
  /// **'Dokumenttyp'**
  String get dokumente_formTyp;

  /// No description provided for @dokumente_formBeschreibung.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get dokumente_formBeschreibung;

  /// No description provided for @dokumente_formGueltigBis.
  ///
  /// In de, this message translates to:
  /// **'Gültig bis'**
  String get dokumente_formGueltigBis;

  /// No description provided for @dokumente_formKind.
  ///
  /// In de, this message translates to:
  /// **'Kind zuordnen'**
  String get dokumente_formKind;

  /// No description provided for @dokumente_formKindOptional.
  ///
  /// In de, this message translates to:
  /// **'Kein Kind (allgemein)'**
  String get dokumente_formKindOptional;

  /// No description provided for @dokumente_formFile.
  ///
  /// In de, this message translates to:
  /// **'Datei'**
  String get dokumente_formFile;

  /// No description provided for @dokumente_formFileSelect.
  ///
  /// In de, this message translates to:
  /// **'Datei auswählen'**
  String get dokumente_formFileSelect;

  /// No description provided for @dokumente_formFileSelected.
  ///
  /// In de, this message translates to:
  /// **'Datei ausgewählt: {filename}'**
  String dokumente_formFileSelected(String filename);

  /// No description provided for @dokumente_count.
  ///
  /// In de, this message translates to:
  /// **'{count} Dokumente'**
  String dokumente_count(int count);

  /// No description provided for @verwaltung_dokumenteTile.
  ///
  /// In de, this message translates to:
  /// **'Dokumente'**
  String get verwaltung_dokumenteTile;

  /// No description provided for @verwaltung_eingewoehnungTile.
  ///
  /// In de, this message translates to:
  /// **'Eingewöhnung'**
  String get verwaltung_eingewoehnungTile;

  /// No description provided for @eingewoehnung_title.
  ///
  /// In de, this message translates to:
  /// **'Eingewöhnung'**
  String get eingewoehnung_title;

  /// No description provided for @eingewoehnung_subtitle.
  ///
  /// In de, this message translates to:
  /// **'Eingewöhnungsphase verwalten'**
  String get eingewoehnung_subtitle;

  /// No description provided for @eingewoehnung_count.
  ///
  /// In de, this message translates to:
  /// **'{count} Eingewöhnungen'**
  String eingewoehnung_count(int count);

  /// No description provided for @eingewoehnung_startdatum.
  ///
  /// In de, this message translates to:
  /// **'Startdatum'**
  String get eingewoehnung_startdatum;

  /// No description provided for @eingewoehnung_bezugsperson.
  ///
  /// In de, this message translates to:
  /// **'Bezugsperson'**
  String get eingewoehnung_bezugsperson;

  /// No description provided for @eingewoehnung_phasenFortschritt.
  ///
  /// In de, this message translates to:
  /// **'Phasenfortschritt'**
  String get eingewoehnung_phasenFortschritt;

  /// No description provided for @eingewoehnung_naechstePhase.
  ///
  /// In de, this message translates to:
  /// **'Nächste Phase'**
  String get eingewoehnung_naechstePhase;

  /// No description provided for @eingewoehnung_phaseAendern.
  ///
  /// In de, this message translates to:
  /// **'Phase ändern'**
  String get eingewoehnung_phaseAendern;

  /// No description provided for @eingewoehnung_neueNotiz.
  ///
  /// In de, this message translates to:
  /// **'Neue Tagesnotiz'**
  String get eingewoehnung_neueNotiz;

  /// No description provided for @eingewoehnung_dauer.
  ///
  /// In de, this message translates to:
  /// **'Dauer (Minuten)'**
  String get eingewoehnung_dauer;

  /// No description provided for @eingewoehnung_trennungsverhalten.
  ///
  /// In de, this message translates to:
  /// **'Trennungsverhalten'**
  String get eingewoehnung_trennungsverhalten;

  /// No description provided for @eingewoehnung_essen.
  ///
  /// In de, this message translates to:
  /// **'Essen'**
  String get eingewoehnung_essen;

  /// No description provided for @eingewoehnung_schlaf.
  ///
  /// In de, this message translates to:
  /// **'Schlaf'**
  String get eingewoehnung_schlaf;

  /// No description provided for @eingewoehnung_spiel.
  ///
  /// In de, this message translates to:
  /// **'Spiel'**
  String get eingewoehnung_spiel;

  /// No description provided for @eingewoehnung_stimmung.
  ///
  /// In de, this message translates to:
  /// **'Stimmung'**
  String get eingewoehnung_stimmung;

  /// No description provided for @eingewoehnung_notizenIntern.
  ///
  /// In de, this message translates to:
  /// **'Interne Notizen'**
  String get eingewoehnung_notizenIntern;

  /// No description provided for @eingewoehnung_notizenEltern.
  ///
  /// In de, this message translates to:
  /// **'Notizen für Eltern'**
  String get eingewoehnung_notizenEltern;

  /// No description provided for @eingewoehnung_notizenElternHinweis.
  ///
  /// In de, this message translates to:
  /// **'Diese Notiz ist für die Eltern sichtbar.'**
  String get eingewoehnung_notizenElternHinweis;

  /// No description provided for @eingewoehnung_keineTagesnotizen.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Tagesnotizen vorhanden.'**
  String get eingewoehnung_keineTagesnotizen;

  /// No description provided for @eingewoehnung_elternFeedback.
  ///
  /// In de, this message translates to:
  /// **'Eltern-Feedback'**
  String get eingewoehnung_elternFeedback;

  /// No description provided for @eingewoehnung_feedbackFrage.
  ///
  /// In de, this message translates to:
  /// **'Wie erleben Sie die Eingewöhnung Ihres Kindes?'**
  String get eingewoehnung_feedbackFrage;

  /// No description provided for @eingewoehnung_tage.
  ///
  /// In de, this message translates to:
  /// **'{count} Tage'**
  String eingewoehnung_tage(int count);

  /// No description provided for @eingewoehnung_notizGespeichert.
  ///
  /// In de, this message translates to:
  /// **'Tagesnotiz gespeichert.'**
  String get eingewoehnung_notizGespeichert;

  /// No description provided for @eingewoehnung_phaseGeaendert.
  ///
  /// In de, this message translates to:
  /// **'Phase erfolgreich geändert.'**
  String get eingewoehnung_phaseGeaendert;

  /// No description provided for @eingewoehnung_feedbackGespeichert.
  ///
  /// In de, this message translates to:
  /// **'Feedback gespeichert.'**
  String get eingewoehnung_feedbackGespeichert;

  /// No description provided for @eingewoehnung_keineAktiven.
  ///
  /// In de, this message translates to:
  /// **'Keine aktiven Eingewöhnungen.'**
  String get eingewoehnung_keineAktiven;

  /// No description provided for @eingewoehnung_neueEingewoehnung.
  ///
  /// In de, this message translates to:
  /// **'Neue Eingewöhnung'**
  String get eingewoehnung_neueEingewoehnung;

  /// No description provided for @eingewoehnung_kindAuswaehlen.
  ///
  /// In de, this message translates to:
  /// **'Kind auswählen'**
  String get eingewoehnung_kindAuswaehlen;

  /// No description provided for @eingewoehnung_nurEingewoehnung.
  ///
  /// In de, this message translates to:
  /// **'Nur Kinder mit Status ‚Eingewöhnung\''**
  String get eingewoehnung_nurEingewoehnung;

  /// No description provided for @enum_phaseGrundphase.
  ///
  /// In de, this message translates to:
  /// **'Grundphase'**
  String get enum_phaseGrundphase;

  /// No description provided for @enum_phaseStabilisierung.
  ///
  /// In de, this message translates to:
  /// **'Stabilisierung'**
  String get enum_phaseStabilisierung;

  /// No description provided for @enum_phaseSchlussphase.
  ///
  /// In de, this message translates to:
  /// **'Schlussphase'**
  String get enum_phaseSchlussphase;

  /// No description provided for @enum_phaseAbgeschlossen.
  ///
  /// In de, this message translates to:
  /// **'Abgeschlossen'**
  String get enum_phaseAbgeschlossen;

  /// No description provided for @enum_stimmungSehrGut.
  ///
  /// In de, this message translates to:
  /// **'Sehr gut'**
  String get enum_stimmungSehrGut;

  /// No description provided for @enum_stimmungGut.
  ///
  /// In de, this message translates to:
  /// **'Gut'**
  String get enum_stimmungGut;

  /// No description provided for @enum_stimmungNeutral.
  ///
  /// In de, this message translates to:
  /// **'Neutral'**
  String get enum_stimmungNeutral;

  /// No description provided for @enum_stimmungSchlecht.
  ///
  /// In de, this message translates to:
  /// **'Schlecht'**
  String get enum_stimmungSchlecht;

  /// No description provided for @enum_stimmungSehrSchlecht.
  ///
  /// In de, this message translates to:
  /// **'Sehr schlecht'**
  String get enum_stimmungSehrSchlecht;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en', 'tr', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

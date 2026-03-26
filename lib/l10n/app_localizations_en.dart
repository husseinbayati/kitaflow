// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get common_save => 'Save';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_delete => 'Delete';

  @override
  String get common_edit => 'Edit';

  @override
  String get common_ok => 'OK';

  @override
  String get common_confirm => 'Confirm';

  @override
  String get common_back => 'Back';

  @override
  String get common_next => 'Next';

  @override
  String get common_skip => 'Skip';

  @override
  String get common_close => 'Close';

  @override
  String get common_error => 'Error';

  @override
  String get common_retry => 'Try again';

  @override
  String get common_loading => 'Loading...';

  @override
  String get common_showAll => 'Show all';

  @override
  String get common_noAccess => 'No access';

  @override
  String get common_noAccessDescription =>
      'You do not have permission to access this area.';

  @override
  String get common_requiredField => 'Required field';

  @override
  String get common_all => 'All';

  @override
  String get common_active => 'Active';

  @override
  String get common_inactive => 'Inactive';

  @override
  String get common_add => 'Add';

  @override
  String get common_remove => 'Remove';

  @override
  String get common_create => 'Create';

  @override
  String get common_search => 'Search';

  @override
  String get common_email => 'Email';

  @override
  String get common_phone => 'Phone';

  @override
  String get common_notes => 'Notes';

  @override
  String get common_name => 'Name';

  @override
  String get common_firstName => 'First name';

  @override
  String get common_lastName => 'Last name';

  @override
  String get common_password => 'Password';

  @override
  String get common_date => 'Date';

  @override
  String get common_description => 'Description';

  @override
  String get common_type => 'Type';

  @override
  String get common_group => 'Group';

  @override
  String get common_role => 'Role';

  @override
  String get common_color => 'Colour';

  @override
  String get common_download => 'Download';

  @override
  String get common_send => 'Send';

  @override
  String get common_justNow => 'Just now';

  @override
  String common_minutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String common_hoursAgo(int hours) {
    return '$hours hrs ago';
  }

  @override
  String get common_today => 'Today';

  @override
  String get common_yesterday => 'Yesterday';

  @override
  String common_daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String common_yearsOld(int years) {
    return '$years years';
  }

  @override
  String get common_clock => 'o\'clock';

  @override
  String get auth_appName => 'KitaFlow';

  @override
  String get auth_appInitials => 'KF';

  @override
  String get auth_appTagline => 'Education platform for children aged 0–10';

  @override
  String get auth_appSlogan => 'The education platform for children';

  @override
  String get auth_loginTitle => 'Sign in';

  @override
  String get auth_loginEmail => 'Email';

  @override
  String get auth_loginEmailHint => 'name@example.co.uk';

  @override
  String get auth_loginEmailRequired => 'Please enter your email';

  @override
  String get auth_loginEmailInvalid => 'Please enter a valid email';

  @override
  String get auth_loginPassword => 'Password';

  @override
  String get auth_loginPasswordRequired => 'Please enter your password';

  @override
  String get auth_loginPasswordMinLength => 'At least 8 characters';

  @override
  String get auth_forgotPassword => 'Forgot password?';

  @override
  String get auth_noAccount => 'Don\'t have an account yet?';

  @override
  String get auth_register => 'Register';

  @override
  String get auth_alreadyHaveAccount => 'Already have an account?';

  @override
  String get auth_registerTitle => 'Create account';

  @override
  String get auth_registerSubtitle => 'Create your KitaFlow account';

  @override
  String get auth_registerFirstName => 'First name';

  @override
  String get auth_registerFirstNameHint => 'Your first name';

  @override
  String get auth_registerFirstNameRequired => 'Please enter your first name';

  @override
  String get auth_registerLastName => 'Last name';

  @override
  String get auth_registerLastNameHint => 'Your last name';

  @override
  String get auth_registerLastNameRequired => 'Please enter your last name';

  @override
  String get auth_registerEmailHint => 'your@email.co.uk';

  @override
  String get auth_registerEmailRequired => 'Please enter your email address';

  @override
  String get auth_registerEmailInvalid => 'Please enter a valid email address';

  @override
  String get auth_registerPasswordMinLength => 'At least 8 characters';

  @override
  String get auth_registerPasswordRequired => 'Please enter a password';

  @override
  String get auth_registerPasswordTooShort =>
      'The password must be at least 8 characters long';

  @override
  String get auth_registerPasswordStrengthWeak => 'Weak';

  @override
  String get auth_registerPasswordStrengthMedium => 'Medium';

  @override
  String get auth_registerPasswordStrengthStrong => 'Strong';

  @override
  String get auth_registerConfirmPassword => 'Confirm password';

  @override
  String get auth_registerConfirmPasswordHint => 'Repeat password';

  @override
  String get auth_registerConfirmPasswordRequired =>
      'Please confirm your password';

  @override
  String get auth_registerPasswordMismatch => 'The passwords do not match';

  @override
  String get auth_registerRoleLabel => 'Role';

  @override
  String get auth_registerRoleHint => 'Select role';

  @override
  String get auth_registerRoleRequired => 'Please select a role';

  @override
  String get auth_registerAcceptTerms =>
      'I accept the terms and conditions and privacy policy';

  @override
  String get auth_registerTermsRequired =>
      'You must accept the terms and conditions and privacy policy';

  @override
  String get auth_forgotPasswordTitle => 'Reset password';

  @override
  String get auth_forgotPasswordDescription =>
      'Enter your email address and we will send you a link to reset your password.';

  @override
  String get auth_forgotPasswordSendLink => 'Send link';

  @override
  String get auth_forgotPasswordBackToLogin => 'Back to login';

  @override
  String get auth_forgotPasswordEmailSent => 'Email has been sent!';

  @override
  String get auth_forgotPasswordCheckInbox => 'Check your inbox.';

  @override
  String get auth_verifyEmailTitle => 'Verify email';

  @override
  String get auth_verifyEmailSubtitle => 'Please verify your email address';

  @override
  String get auth_verifyEmailDescription =>
      'We have sent you a verification email. Click the link in the email to activate your account.';

  @override
  String get auth_verifyEmailResend => 'Resend';

  @override
  String auth_verifyEmailResendCountdown(int seconds) {
    return 'Resend (${seconds}s)';
  }

  @override
  String get auth_verifyEmailBackToLogin => 'Back to login';

  @override
  String get auth_verifyEmailResent => 'Email has been resent';

  @override
  String get shell_dashboard => 'Dashboard';

  @override
  String get shell_kinder => 'Children';

  @override
  String get shell_anwesenheit => 'Attendance';

  @override
  String get shell_nachrichten => 'Messages';

  @override
  String get shell_mehr => 'More';

  @override
  String get shell_elternHome => 'Home';

  @override
  String get shell_elternNachrichten => 'Messages';

  @override
  String get shell_elternTermine => 'Appointments';

  @override
  String get shell_elternMeinKind => 'My Child';

  @override
  String get shell_elternMehr => 'More';

  @override
  String get onboarding_institutionTitle => 'Set up institution';

  @override
  String get onboarding_institutionCreate => 'Create institution';

  @override
  String get onboarding_stepType => 'Select institution type';

  @override
  String get onboarding_stepData => 'Institution details';

  @override
  String get onboarding_stepGroups => 'Create groups/classes';

  @override
  String get onboarding_stepStaff => 'Invite staff';

  @override
  String get onboarding_selectTypePrompt =>
      'Please select an institution type.';

  @override
  String get onboarding_nameRequired =>
      'Please enter a name for the institution.';

  @override
  String get onboarding_nameLabel => 'Institution name';

  @override
  String get onboarding_street => 'Street';

  @override
  String get onboarding_zip => 'Postcode';

  @override
  String get onboarding_city => 'City';

  @override
  String get onboarding_state => 'County';

  @override
  String get onboarding_phone => 'Phone';

  @override
  String get onboarding_emailLabel => 'Email';

  @override
  String get onboarding_maxChildren => 'Max. children';

  @override
  String get onboarding_color => 'Colour';

  @override
  String get onboarding_addGroup => 'Add group/class';

  @override
  String get onboarding_addInvitation => 'Add invitation';

  @override
  String get onboarding_creatingInstitution => 'Creating institution...';

  @override
  String get onboarding_parentTitle => 'Parent onboarding';

  @override
  String get onboarding_parentLinkChild => 'Link child';

  @override
  String get onboarding_parentCodeHint => 'Enter the invitation code...';

  @override
  String get onboarding_parentCodeLabel => 'Invitation code';

  @override
  String get onboarding_parentCheckCode => 'Check code';

  @override
  String get onboarding_parentInvitationFound => 'Invitation found!';

  @override
  String get onboarding_parentAcceptInvitation => 'Accept invitation';

  @override
  String get onboarding_parentWelcome => 'Welcome to KitaFlow!';

  @override
  String get onboarding_parentChildLinked =>
      'Your child has been successfully linked.';

  @override
  String get onboarding_parentLetsGo => 'Let\'s go';

  @override
  String get dashboard_title => 'Dashboard';

  @override
  String get dashboard_hints => 'Notices';

  @override
  String get dashboard_mealPlanToday => 'Today\'s meal plan';

  @override
  String get dashboard_messages => 'Messages';

  @override
  String get dashboard_greetingMorning => 'Good morning';

  @override
  String get dashboard_greetingAfternoon => 'Good afternoon';

  @override
  String get dashboard_greetingEvening => 'Good evening';

  @override
  String dashboard_greetingWithName(String greeting, String name) {
    return '$greeting, $name!';
  }

  @override
  String get dashboard_statsPresent => 'Present';

  @override
  String get dashboard_statsUnread => 'Unread';

  @override
  String get dashboard_statsSick => 'Sick';

  @override
  String get dashboard_quickCheckIn => 'Check-in';

  @override
  String get dashboard_quickMessage => 'Message';

  @override
  String get dashboard_quickAddChild => 'Child +';

  @override
  String get dashboard_quickMessages => 'Messages';

  @override
  String get dashboard_quickSickNote => 'Sick note';

  @override
  String get dashboard_noMealPlan => 'No meal plan for today';

  @override
  String get dashboard_noNewMessages => 'No new messages';

  @override
  String dashboard_birthdayAlert(String name) {
    return 'Birthday: $name';
  }

  @override
  String dashboard_birthdayToday(int years) {
    return 'Turns $years years old today!';
  }

  @override
  String dashboard_birthdayUpcoming(int years, String date) {
    return 'Turns $years years old on $date';
  }

  @override
  String get kinder_title => 'Children';

  @override
  String get kinder_search => 'Search children...';

  @override
  String get kinder_notFound => 'No children found';

  @override
  String get kinder_notFoundDescription =>
      'No children were found with the current filters.';

  @override
  String get kinder_addChild => 'Add child';

  @override
  String get kinder_errorOccurred => 'An error has occurred.';

  @override
  String get kinder_formEditTitle => 'Edit child';

  @override
  String get kinder_formNewTitle => 'New child';

  @override
  String get kinder_formFirstName => 'First name *';

  @override
  String get kinder_formLastName => 'Last name *';

  @override
  String get kinder_formFirstNameRequired => 'Please enter first name';

  @override
  String get kinder_formLastNameRequired => 'Please enter last name';

  @override
  String get kinder_formBirthDate => 'Date of birth *';

  @override
  String get kinder_formBirthDateSelect => 'Select date of birth';

  @override
  String get kinder_formBirthDateRequired => 'Please select date of birth';

  @override
  String get kinder_formGender => 'Gender';

  @override
  String get kinder_formGenderSelect => 'Select gender';

  @override
  String get kinder_formGenderMale => 'Male';

  @override
  String get kinder_formGenderFemale => 'Female';

  @override
  String get kinder_formGenderDiverse => 'Diverse';

  @override
  String get kinder_formGroup => 'Group';

  @override
  String get kinder_formGroupSelect => 'Select group';

  @override
  String get kinder_formEntryDate => 'Entry date';

  @override
  String get kinder_formEntryDateSelect => 'Select entry date';

  @override
  String get kinder_formNotes => 'Notes';

  @override
  String get kinder_formNotesHint => 'Special notes, needs, etc.';

  @override
  String get kinder_formSave => 'Save';

  @override
  String get kinder_formCreate => 'Create child';

  @override
  String get kinder_detailNotFound => 'Child not found.';

  @override
  String get kinder_detailDeleteTitle => 'Delete child';

  @override
  String kinder_detailDeleteConfirm(String name) {
    return 'Are you sure you want to delete $name? This action cannot be undone.';
  }

  @override
  String get kinder_detailTabMasterData => 'Master data';

  @override
  String kinder_detailTabAllergies(int count) {
    return 'Allergies ($count)';
  }

  @override
  String kinder_detailTabContacts(int count) {
    return 'Contacts ($count)';
  }

  @override
  String get kinder_detailBirthDate => 'Date of birth';

  @override
  String get kinder_detailGender => 'Gender';

  @override
  String get kinder_detailGroup => 'Group';

  @override
  String get kinder_detailEntryDate => 'Entry date';

  @override
  String get kinder_detailStatus => 'Status';

  @override
  String get kinder_detailNotes => 'Notes';

  @override
  String get kinder_detailNoAllergies => 'No allergies recorded';

  @override
  String get kinder_detailAddAllergyHint => 'Add known allergies...';

  @override
  String get kinder_detailAddAllergy => 'Add allergy';

  @override
  String get kinder_detailRemoveAllergy => 'Remove allergy';

  @override
  String get kinder_detailNoContacts => 'No contact persons';

  @override
  String get kinder_detailAddContactHint => 'Add contact persons...';

  @override
  String get kinder_detailAddContact => 'Add contact';

  @override
  String get kinder_detailRemoveContact => 'Remove contact';

  @override
  String get kinder_detailPickupAuthorized => 'Authorised for pick-up';

  @override
  String get kinder_detailEmergencyContact => 'Emergency contact';

  @override
  String get kinder_allergyFormTitle => 'Add allergy';

  @override
  String get kinder_allergyFormAllergen => 'Allergen *';

  @override
  String get kinder_allergyFormAllergenRequired => 'Please select an allergen';

  @override
  String get kinder_allergyFormSeverity => 'Severity';

  @override
  String get kinder_allergyFormHints => 'Notes';

  @override
  String get kinder_allergyFormHintsPlaceholder =>
      'e.g. reaction, emergency medication';

  @override
  String get kinder_contactFormEditTitle => 'Edit contact';

  @override
  String get kinder_contactFormAddTitle => 'Add contact';

  @override
  String get kinder_contactFormName => 'Name *';

  @override
  String get kinder_contactFormNameRequired => 'Please enter name';

  @override
  String get kinder_contactFormRelation => 'Relationship *';

  @override
  String get kinder_contactFormRelationHint =>
      'e.g. Mother, Father, Grandparents';

  @override
  String get kinder_contactFormRelationRequired => 'Please enter relationship';

  @override
  String get kinder_contactFormPhone => 'Phone';

  @override
  String get kinder_contactFormEmail => 'Email';

  @override
  String get kinder_contactFormPickupAuthorized => 'Authorised for pick-up';

  @override
  String get kinder_contactFormPickupDescription =>
      'May collect the child from the institution';

  @override
  String get kinder_contactFormEmergencyContact => 'Emergency contact';

  @override
  String get kinder_contactFormEmergencyDescription =>
      'Will be contacted in an emergency';

  @override
  String get kinder_contactFormSave => 'Save';

  @override
  String get anwesenheit_title => 'Attendance';

  @override
  String get anwesenheit_all => 'All';

  @override
  String get anwesenheit_markAllPresent => 'Mark all as present';

  @override
  String get anwesenheit_alreadyPickedUp =>
      'Already picked up or reported absent.';

  @override
  String get anwesenheit_allRecorded =>
      'All children have already been recorded.';

  @override
  String anwesenheit_markedPresent(int count) {
    return '$count children marked as present.';
  }

  @override
  String get anwesenheit_notRecorded => 'Not recorded';

  @override
  String anwesenheit_presentSince(String time) {
    return 'Present since $time';
  }

  @override
  String anwesenheit_pickedUp(String time) {
    return 'Picked up $time';
  }

  @override
  String get anwesenheit_statsPresent => 'Present';

  @override
  String get anwesenheit_statsAbsent => 'Absent';

  @override
  String get anwesenheit_statsSick => 'Sick';

  @override
  String get anwesenheit_statsTotal => 'Total';

  @override
  String get anwesenheit_statusDialogTitle => 'Change status';

  @override
  String get anwesenheit_statusDialogNote => 'Note (optional)';

  @override
  String get anwesenheit_statusDialogSetStatus => 'Set status';

  @override
  String get anwesenheit_sickNoteTitle => 'Sick note';

  @override
  String get anwesenheit_sickNoteDescription =>
      'Report your child as sick or excused.';

  @override
  String get anwesenheit_sickNoteDate => 'Date';

  @override
  String get anwesenheit_sickNoteReason => 'Reason *';

  @override
  String get anwesenheit_sickNoteMessage => 'Message to the institution';

  @override
  String get anwesenheit_sickNoteMessageHint =>
      'Optional message to the institution...';

  @override
  String get anwesenheit_sickNoteSend => 'Send sick note';

  @override
  String get nachrichten_title => 'Messages';

  @override
  String get nachrichten_all => 'All';

  @override
  String get nachrichten_noMessages => 'No messages';

  @override
  String get nachrichten_inboxEmpty => 'Your inbox is empty.';

  @override
  String get nachrichten_noSentMessages => 'No sent messages';

  @override
  String get nachrichten_noSentDescription =>
      'You have not sent any messages yet.';

  @override
  String get nachrichten_noImportant => 'No important messages';

  @override
  String get nachrichten_noImportantDescription =>
      'There are no messages marked as important.';

  @override
  String get nachrichten_detailTitle => 'Message';

  @override
  String get nachrichten_detailDeleteTitle => 'Delete message';

  @override
  String get nachrichten_detailDeleteConfirm =>
      'Are you sure you want to permanently delete this message?';

  @override
  String get nachrichten_detailNotFound => 'Message not found.';

  @override
  String get nachrichten_detailAttachments => 'Attachments';

  @override
  String nachrichten_detailReadBy(int read, int total) {
    return 'Read by $read/$total';
  }

  @override
  String get nachrichten_detailDeleteTooltip => 'Delete message';

  @override
  String get nachrichten_formTitle => 'New message';

  @override
  String get nachrichten_formType => 'Type';

  @override
  String get nachrichten_formRecipients => 'Recipients';

  @override
  String get nachrichten_formRecipientsAll => 'All';

  @override
  String get nachrichten_formRecipientsGroup => 'Group';

  @override
  String get nachrichten_formRecipientsIndividual => 'Individual';

  @override
  String get nachrichten_formSelectGroup => 'Select group';

  @override
  String get nachrichten_formSelectGroupHint => 'Please select a group';

  @override
  String get nachrichten_formSelectGroupRequired => 'Please select a group';

  @override
  String get nachrichten_formSelectRecipients => 'Select recipients';

  @override
  String nachrichten_formRecipientsSelected(int count) {
    return '$count recipients selected';
  }

  @override
  String get nachrichten_formSubject => 'Subject';

  @override
  String get nachrichten_formSubjectHint => 'Enter subject';

  @override
  String get nachrichten_formContent => 'Content';

  @override
  String get nachrichten_formContentHint => 'Enter message...';

  @override
  String get nachrichten_formMarkImportant => 'Mark as important';

  @override
  String get nachrichten_formSend => 'Send message';

  @override
  String get nachrichten_recipientDialogTitle => 'Select recipients';

  @override
  String get nachrichten_recipientDialogSearch => 'Search name or role...';

  @override
  String get nachrichten_recipientDialogNone => 'Select none';

  @override
  String get nachrichten_recipientDialogAll => 'Select all';

  @override
  String nachrichten_recipientDialogConfirm(int count) {
    return 'Select $count recipients';
  }

  @override
  String get nachrichten_recipientDialogLoadError =>
      'Profiles could not be loaded.';

  @override
  String get nachrichten_recipientDialogNoProfiles => 'No profiles found.';

  @override
  String nachrichten_recipientDialogNoResults(String query) {
    return 'No results for \"$query\".';
  }

  @override
  String get nachrichten_attachmentDownload => 'Download';

  @override
  String get nachrichten_attachmentRemove => 'Remove';

  @override
  String get essensplan_title => 'Meal Plan';

  @override
  String get essensplan_previousWeek => 'Previous week';

  @override
  String get essensplan_nextWeek => 'Next week';

  @override
  String get essensplan_currentWeek => 'Current week';

  @override
  String get essensplan_noMealPlan => 'No meal plan';

  @override
  String get essensplan_noMealsPlanned =>
      'No meals have been planned for this week yet.';

  @override
  String get essensplan_deleteMeal => 'Delete meal';

  @override
  String get essensplan_formEditTitle => 'Edit meal';

  @override
  String get essensplan_formNewTitle => 'New meal';

  @override
  String get essensplan_formDate => 'Date';

  @override
  String get essensplan_formMealType => 'Meal type';

  @override
  String get essensplan_formDishName => 'Dish';

  @override
  String get essensplan_formDishNameRequired => 'Please enter a dish name';

  @override
  String get essensplan_formDescription => 'Description (optional)';

  @override
  String get essensplan_formAllergens => 'Allergens (EU Regulation 1169/2011)';

  @override
  String get essensplan_formVegetarian => 'Vegetarian';

  @override
  String get essensplan_formVegan => 'Vegan';

  @override
  String get essensplan_formSave => 'Save meal';

  @override
  String essensplan_allergenWarnings(int count) {
    return 'Allergen warnings ($count)';
  }

  @override
  String get essensplan_weekdayMonday => 'Monday';

  @override
  String get essensplan_weekdayTuesday => 'Tuesday';

  @override
  String get essensplan_weekdayWednesday => 'Wednesday';

  @override
  String get essensplan_weekdayThursday => 'Thursday';

  @override
  String get essensplan_weekdayFriday => 'Friday';

  @override
  String get essensplan_weekdaySaturday => 'Saturday';

  @override
  String get essensplan_weekdaySunday => 'Sunday';

  @override
  String get eltern_homeTitle => 'KitaFlow';

  @override
  String get eltern_homeMyChildren => 'My Children';

  @override
  String get eltern_homeNoChildren => 'No children linked yet.';

  @override
  String get eltern_homeQuickActions => 'Quick actions';

  @override
  String get eltern_quickSickNote => 'Sick note';

  @override
  String get eltern_quickMessage => 'Message';

  @override
  String get eltern_quickCalendar => 'Appointments';

  @override
  String get eltern_kindTitle => 'My Child';

  @override
  String get eltern_kindTabProfile => 'Profile';

  @override
  String get eltern_kindTabAttendance => 'Attendance';

  @override
  String get eltern_kindTabAllergies => 'Allergies';

  @override
  String get eltern_kindTabContacts => 'Contacts';

  @override
  String get eltern_kindNoChildSelected => 'No child selected.';

  @override
  String get eltern_kindBirthday => 'Birthday';

  @override
  String get eltern_kindGender => 'Gender';

  @override
  String get eltern_kindStatus => 'Status';

  @override
  String get eltern_kindNoAllergies => 'No allergies recorded.';

  @override
  String get eltern_kindAllergiesTitle => 'Allergies & Intolerances';

  @override
  String get eltern_kindAttendanceTitle => 'Attendance';

  @override
  String get eltern_kindAttendanceLoading => 'Loading attendance calendar...';

  @override
  String get eltern_kindNoContacts => 'No contact persons recorded.';

  @override
  String get eltern_kindContactsTitle => 'Contact Persons';

  @override
  String get eltern_nachrichtenTitle => 'Messages';

  @override
  String get eltern_nachrichtenLoading => 'Loading messages…';

  @override
  String get eltern_nachrichtenEmpty => 'No messages';

  @override
  String get eltern_nachrichtenEmptyDescription =>
      'You have not received any messages yet.';

  @override
  String get termine_title => 'Appointments';

  @override
  String get termine_noAppointments => 'No appointments available.';

  @override
  String get termine_rsvpTitle => 'RSVP';

  @override
  String termine_rsvpFor(String title) {
    return 'For: $title';
  }

  @override
  String get termine_weekdayMon => 'Mon';

  @override
  String get termine_weekdayTue => 'Tue';

  @override
  String get termine_weekdayWed => 'Wed';

  @override
  String get termine_weekdayThu => 'Thu';

  @override
  String get termine_weekdayFri => 'Fri';

  @override
  String get termine_weekdaySat => 'Sat';

  @override
  String get termine_weekdaySun => 'Sun';

  @override
  String get fotos_title => 'Photos';

  @override
  String get fotos_noPhotos => 'No photos available yet.';

  @override
  String get fotos_viewerTitle => 'Photo';

  @override
  String get push_title => 'Push Notifications';

  @override
  String get push_sectionNotifications => 'Notifications';

  @override
  String get push_messages => 'Messages';

  @override
  String get push_messagesDescription => 'New messages and parent letters';

  @override
  String get push_attendance => 'Attendance';

  @override
  String get push_attendanceDescription => 'Changes to attendance status';

  @override
  String get push_appointments => 'Appointments';

  @override
  String get push_appointmentsDescription => 'New appointments and reminders';

  @override
  String get push_mealPlan => 'Meal plan';

  @override
  String get push_mealPlanDescription => 'Changes to the meal plan';

  @override
  String get push_emergency => 'Emergency';

  @override
  String get push_emergencyDescription => 'Important emergency notifications';

  @override
  String get push_sectionQuietHours => 'Quiet hours';

  @override
  String get push_quietHoursDescription =>
      'No notifications during this period';

  @override
  String get push_quietHoursFrom => 'From';

  @override
  String get push_quietHoursTo => 'To';

  @override
  String get verwaltung_title => 'Administration';

  @override
  String get verwaltung_institution => 'Institution';

  @override
  String get verwaltung_groupsTitle => 'Groups & Classes';

  @override
  String verwaltung_groupsCount(int count) {
    return '$count groups';
  }

  @override
  String get verwaltung_staffTitle => 'Staff';

  @override
  String verwaltung_staffCount(int count) {
    return '$count staff members';
  }

  @override
  String get verwaltung_groupsListTitle => 'Groups & Classes';

  @override
  String get verwaltung_groupsEmpty => 'No groups available.';

  @override
  String verwaltung_groupsOccupancyWithMax(int current, int max) {
    return 'Occupancy: $current / $max';
  }

  @override
  String verwaltung_groupsOccupancy(int count) {
    return 'Occupancy: $count children';
  }

  @override
  String get verwaltung_groupsInactive => 'Inactive';

  @override
  String get verwaltung_groupFormEditTitle => 'Edit group';

  @override
  String get verwaltung_groupFormNewTitle => 'New group';

  @override
  String get verwaltung_groupFormName => 'Name';

  @override
  String get verwaltung_groupFormNameRequired => 'Name is required';

  @override
  String get verwaltung_groupFormType => 'Type';

  @override
  String get verwaltung_groupFormTypeGroup => 'Group';

  @override
  String get verwaltung_groupFormTypeClass => 'Class';

  @override
  String get verwaltung_groupFormMaxChildren => 'Max. children';

  @override
  String get verwaltung_groupFormAgeFrom => 'Age from';

  @override
  String get verwaltung_groupFormAgeTo => 'Age to';

  @override
  String get verwaltung_groupFormSchoolYear => 'School year';

  @override
  String get verwaltung_groupFormColor => 'Colour';

  @override
  String get verwaltung_groupFormActive => 'Active';

  @override
  String get verwaltung_groupFormSave => 'Save';

  @override
  String get verwaltung_groupFormCreate => 'Create';

  @override
  String get verwaltung_staffListTitle => 'Staff';

  @override
  String get verwaltung_staffEmpty => 'No staff members available.';

  @override
  String get verwaltung_staffChangeRole => 'Change role';

  @override
  String get verwaltung_staffAssignGroup => 'Assign group';

  @override
  String get verwaltung_staffRemove => 'Remove';

  @override
  String get verwaltung_staffNoGroup => 'No group';

  @override
  String get verwaltung_staffRemoveTitle => 'Remove staff member';

  @override
  String verwaltung_staffRemoveConfirm(String name) {
    return 'Are you sure you want to remove $name from the institution?';
  }

  @override
  String get verwaltung_staffFormTitle => 'Add staff member';

  @override
  String get verwaltung_staffFormEmail => 'Email address';

  @override
  String get verwaltung_staffFormEmailRequired => 'Email is required';

  @override
  String get verwaltung_staffFormEmailInvalid => 'Invalid email address';

  @override
  String get verwaltung_staffFormRole => 'Role';

  @override
  String get verwaltung_staffFormGroup => 'Group (optional)';

  @override
  String get verwaltung_staffFormNoGroup => 'No group';

  @override
  String get verwaltung_staffFormAdd => 'Add';

  @override
  String get verwaltung_staffFormInvitePending =>
      'Staff invitation via email will be implemented in a later phase.';

  @override
  String get verwaltung_institutionFormTitle => 'Edit institution';

  @override
  String get verwaltung_institutionFormSectionGeneral => 'General';

  @override
  String get verwaltung_institutionFormName => 'Institution name';

  @override
  String get verwaltung_institutionFormNameRequired => 'Please enter a name';

  @override
  String get verwaltung_institutionFormType => 'Type';

  @override
  String get verwaltung_institutionFormTypeHint => 'Select institution type';

  @override
  String get verwaltung_institutionFormTypeRequired => 'Please select a type';

  @override
  String get verwaltung_institutionFormSectionAddress => 'Address';

  @override
  String get verwaltung_institutionFormStreet => 'Street & house number';

  @override
  String get verwaltung_institutionFormZip => 'Postcode';

  @override
  String get verwaltung_institutionFormCity => 'City';

  @override
  String get verwaltung_institutionFormState => 'County';

  @override
  String get verwaltung_institutionFormSectionContact => 'Contact';

  @override
  String get verwaltung_institutionFormPhone => 'Phone';

  @override
  String get verwaltung_institutionFormEmail => 'Email';

  @override
  String get verwaltung_institutionFormEmailInvalid =>
      'Please enter a valid email';

  @override
  String get verwaltung_institutionFormWebsite => 'Website';

  @override
  String get verwaltung_institutionFormSaveSuccess =>
      'Institution saved successfully.';

  @override
  String get verwaltung_institutionFormSaveError => 'Error saving.';

  @override
  String get verwaltung_institutionFormLoadError => 'Error loading.';

  @override
  String get enum_roleErzieher => 'Educator';

  @override
  String get enum_roleLehrer => 'Teacher';

  @override
  String get enum_roleLeitung => 'Director';

  @override
  String get enum_roleTraeger => 'Provider';

  @override
  String get enum_roleEltern => 'Parents';

  @override
  String get enum_institutionTypeKrippe => 'Nursery';

  @override
  String get enum_institutionTypeKita => 'Daycare';

  @override
  String get enum_institutionTypeGrundschule => 'Primary School';

  @override
  String get enum_institutionTypeOgs => 'After-School Care';

  @override
  String get enum_institutionTypeHort => 'After-School Centre';

  @override
  String get enum_attendanceAnwesend => 'Present';

  @override
  String get enum_attendanceAbwesend => 'Absent';

  @override
  String get enum_attendanceKrank => 'Sick';

  @override
  String get enum_attendanceUrlaub => 'Holiday';

  @override
  String get enum_attendanceEntschuldigt => 'Excused';

  @override
  String get enum_attendanceUnentschuldigt => 'Unexcused';

  @override
  String get enum_messageTypeNachricht => 'Message';

  @override
  String get enum_messageTypeElternbrief => 'Parent letter';

  @override
  String get enum_messageTypeAnkuendigung => 'Announcement';

  @override
  String get enum_messageTypeNotfall => 'Emergency';

  @override
  String get enum_childStatusAktiv => 'Active';

  @override
  String get enum_childStatusEingewoehnung => 'Settling in';

  @override
  String get enum_childStatusAbgemeldet => 'Deregistered';

  @override
  String get enum_childStatusWarteliste => 'Waiting list';

  @override
  String get enum_mealTypeFruehstueck => 'Breakfast';

  @override
  String get enum_mealTypeMittagessen => 'Lunch';

  @override
  String get enum_mealTypeSnack => 'Snack';

  @override
  String get enum_developmentMotorik => 'Motor skills';

  @override
  String get enum_developmentSprache => 'Language';

  @override
  String get enum_developmentSozialverhalten => 'Social behaviour';

  @override
  String get enum_developmentKognitiv => 'Cognitive development';

  @override
  String get enum_developmentEmotional => 'Emotional development';

  @override
  String get enum_developmentKreativitaet => 'Creativity';

  @override
  String get enum_allergenGluten => 'Gluten';

  @override
  String get enum_allergenKrebstiere => 'Crustaceans';

  @override
  String get enum_allergenEier => 'Eggs';

  @override
  String get enum_allergenFisch => 'Fish';

  @override
  String get enum_allergenErdnuesse => 'Peanuts';

  @override
  String get enum_allergenSoja => 'Soya';

  @override
  String get enum_allergenMilch => 'Milk';

  @override
  String get enum_allergenSchalenfruechte => 'Tree nuts';

  @override
  String get enum_allergenSellerie => 'Celery';

  @override
  String get enum_allergenSenf => 'Mustard';

  @override
  String get enum_allergenSesam => 'Sesame';

  @override
  String get enum_allergenSchwefeldioxid => 'Sulphur dioxide';

  @override
  String get enum_allergenLupinen => 'Lupins';

  @override
  String get enum_allergenWeichtiere => 'Molluscs';

  @override
  String get enum_allergySeverityLeicht => 'Mild';

  @override
  String get enum_allergySeverityMittel => 'Moderate';

  @override
  String get enum_allergySeveritySchwer => 'Severe';

  @override
  String get enum_allergySeverityLebensbedrohlich => 'Life-threatening';

  @override
  String get enum_documentTypeVertrag => 'Contract';

  @override
  String get enum_documentTypeEinverstaendnis => 'Consent form';

  @override
  String get enum_documentTypeAttest => 'Medical certificate';

  @override
  String get enum_documentTypeZeugnis => 'Report';

  @override
  String get enum_documentTypeSonstiges => 'Other';

  @override
  String get enum_nachrichtenTabPosteingang => 'Inbox';

  @override
  String get enum_nachrichtenTabGesendet => 'Sent';

  @override
  String get enum_nachrichtenTabWichtig => 'Important';

  @override
  String get enum_terminTypAllgemein => 'General';

  @override
  String get enum_terminTypElternabend => 'Parents\' evening';

  @override
  String get enum_terminTypFestFeier => 'Celebration';

  @override
  String get enum_terminTypSchliessung => 'Closure';

  @override
  String get enum_terminTypAusflug => 'Excursion';

  @override
  String get enum_terminTypSonstiges => 'Other';

  @override
  String get enum_rsvpZugesagt => 'Accepted';

  @override
  String get enum_rsvpAbgesagt => 'Declined';

  @override
  String get enum_rsvpVielleicht => 'Maybe';

  @override
  String get enum_elternBeziehungMutter => 'Mother';

  @override
  String get enum_elternBeziehungVater => 'Father';

  @override
  String get enum_elternBeziehungSorgeberechtigt => 'Legal guardian';

  @override
  String get dashboard_monthJanuar => 'January';

  @override
  String get dashboard_monthFebruar => 'February';

  @override
  String get dashboard_monthMaerz => 'March';

  @override
  String get dashboard_monthApril => 'April';

  @override
  String get dashboard_monthMai => 'May';

  @override
  String get dashboard_monthJuni => 'June';

  @override
  String get dashboard_monthJuli => 'July';

  @override
  String get dashboard_monthAugust => 'August';

  @override
  String get dashboard_monthSeptember => 'September';

  @override
  String get dashboard_monthOktober => 'October';

  @override
  String get dashboard_monthNovember => 'November';

  @override
  String get dashboard_monthDezember => 'December';

  @override
  String get dashboard_weekdayMontag => 'Monday';

  @override
  String get dashboard_weekdayDienstag => 'Tuesday';

  @override
  String get dashboard_weekdayMittwoch => 'Wednesday';

  @override
  String get dashboard_weekdayDonnerstag => 'Thursday';

  @override
  String get dashboard_weekdayFreitag => 'Friday';

  @override
  String get dashboard_weekdaySamstag => 'Saturday';

  @override
  String get dashboard_weekdaySonntag => 'Sunday';

  @override
  String get verwaltung_rolleDropdownErzieher => 'Educator';

  @override
  String get verwaltung_rolleDropdownLehrer => 'Teacher';

  @override
  String get verwaltung_rolleDropdownLeitung => 'Director';

  @override
  String get common_language => 'Language';

  @override
  String get dokumente_title => 'Documents';

  @override
  String get dokumente_noDocuments => 'No documents yet.';

  @override
  String get dokumente_upload => 'Upload';

  @override
  String get dokumente_download => 'Download';

  @override
  String get dokumente_delete => 'Delete document';

  @override
  String get dokumente_deleteConfirm =>
      'Are you sure you want to delete this document?';

  @override
  String get dokumente_filterAll => 'All';

  @override
  String get dokumente_signed => 'Signed';

  @override
  String get dokumente_unsigned => 'Not signed';

  @override
  String dokumente_signedBy(String name, String date) {
    return 'Signed by $name on $date';
  }

  @override
  String dokumente_validUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String get dokumente_expired => 'Expired';

  @override
  String get dokumente_sign => 'Sign';

  @override
  String get dokumente_signTitle => 'Sign document';

  @override
  String get dokumente_signClear => 'Clear';

  @override
  String get dokumente_signConfirm => 'Confirm signature';

  @override
  String get dokumente_signHint => 'Sign here';

  @override
  String get dokumente_uploadSuccess => 'Document uploaded successfully.';

  @override
  String get dokumente_uploadError => 'Error uploading document.';

  @override
  String get dokumente_deleteSuccess => 'Document deleted successfully.';

  @override
  String get dokumente_signSuccess => 'Document signed successfully.';

  @override
  String get dokumente_pdfGenerate => 'Generate PDF';

  @override
  String get dokumente_pdfPreview => 'PDF preview';

  @override
  String get dokumente_formTitle => 'New document';

  @override
  String get dokumente_formTitel => 'Title';

  @override
  String get dokumente_formTyp => 'Document type';

  @override
  String get dokumente_formBeschreibung => 'Description';

  @override
  String get dokumente_formGueltigBis => 'Valid until';

  @override
  String get dokumente_formKind => 'Assign to child';

  @override
  String get dokumente_formKindOptional => 'No child (general)';

  @override
  String get dokumente_formFile => 'File';

  @override
  String get dokumente_formFileSelect => 'Select file';

  @override
  String dokumente_formFileSelected(String filename) {
    return 'File selected: $filename';
  }

  @override
  String dokumente_count(int count) {
    return '$count documents';
  }

  @override
  String get verwaltung_dokumenteTile => 'Documents';

  @override
  String get verwaltung_eingewoehnungTile => 'Settling-in';

  @override
  String get eingewoehnung_title => 'Settling-in';

  @override
  String get eingewoehnung_subtitle => 'Manage settling-in phase';

  @override
  String eingewoehnung_count(int count) {
    return '$count settling-ins';
  }

  @override
  String get eingewoehnung_startdatum => 'Start date';

  @override
  String get eingewoehnung_bezugsperson => 'Key person';

  @override
  String get eingewoehnung_phasenFortschritt => 'Phase progress';

  @override
  String get eingewoehnung_naechstePhase => 'Next phase';

  @override
  String get eingewoehnung_phaseAendern => 'Change phase';

  @override
  String get eingewoehnung_neueNotiz => 'New daily note';

  @override
  String get eingewoehnung_dauer => 'Duration (minutes)';

  @override
  String get eingewoehnung_trennungsverhalten => 'Separation behaviour';

  @override
  String get eingewoehnung_essen => 'Eating';

  @override
  String get eingewoehnung_schlaf => 'Sleeping';

  @override
  String get eingewoehnung_spiel => 'Playing';

  @override
  String get eingewoehnung_stimmung => 'Mood';

  @override
  String get eingewoehnung_notizenIntern => 'Internal notes';

  @override
  String get eingewoehnung_notizenEltern => 'Notes for parents';

  @override
  String get eingewoehnung_notizenElternHinweis =>
      'This note is visible to parents.';

  @override
  String get eingewoehnung_keineTagesnotizen => 'No daily notes yet.';

  @override
  String get eingewoehnung_elternFeedback => 'Parent feedback';

  @override
  String get eingewoehnung_feedbackFrage =>
      'How are you experiencing your child\'s settling-in?';

  @override
  String eingewoehnung_tage(int count) {
    return '$count days';
  }

  @override
  String get eingewoehnung_notizGespeichert => 'Daily note saved.';

  @override
  String get eingewoehnung_phaseGeaendert => 'Phase changed successfully.';

  @override
  String get eingewoehnung_feedbackGespeichert => 'Feedback saved.';

  @override
  String get eingewoehnung_keineAktiven => 'No active settling-ins.';

  @override
  String get eingewoehnung_neueEingewoehnung => 'New settling-in';

  @override
  String get eingewoehnung_kindAuswaehlen => 'Select child';

  @override
  String get eingewoehnung_nurEingewoehnung =>
      'Only children with status “Settling-in”';

  @override
  String get enum_phaseGrundphase => 'Initial phase';

  @override
  String get enum_phaseStabilisierung => 'Stabilisation';

  @override
  String get enum_phaseSchlussphase => 'Final phase';

  @override
  String get enum_phaseAbgeschlossen => 'Completed';

  @override
  String get enum_stimmungSehrGut => 'Very good';

  @override
  String get enum_stimmungGut => 'Good';

  @override
  String get enum_stimmungNeutral => 'Neutral';

  @override
  String get enum_stimmungSchlecht => 'Bad';

  @override
  String get enum_stimmungSehrSchlecht => 'Very bad';
}

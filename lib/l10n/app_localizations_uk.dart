// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get common_save => 'Зберегти';

  @override
  String get common_cancel => 'Скасувати';

  @override
  String get common_delete => 'Видалити';

  @override
  String get common_edit => 'Редагувати';

  @override
  String get common_ok => 'OK';

  @override
  String get common_confirm => 'Підтвердити';

  @override
  String get common_back => 'Назад';

  @override
  String get common_next => 'Далі';

  @override
  String get common_skip => 'Пропустити';

  @override
  String get common_close => 'Закрити';

  @override
  String get common_error => 'Помилка';

  @override
  String get common_retry => 'Спробувати знову';

  @override
  String get common_loading => 'Завантаження...';

  @override
  String get common_showAll => 'Показати все';

  @override
  String get common_noAccess => 'Немає доступу';

  @override
  String get common_noAccessDescription =>
      'У вас немає дозволу на доступ до цього розділу.';

  @override
  String get common_requiredField => 'Обов\'язкове поле';

  @override
  String get common_all => 'Усі';

  @override
  String get common_active => 'Активний';

  @override
  String get common_inactive => 'Неактивний';

  @override
  String get common_add => 'Додати';

  @override
  String get common_remove => 'Видалити';

  @override
  String get common_create => 'Створити';

  @override
  String get common_search => 'Пошук';

  @override
  String get common_email => 'Ел. пошта';

  @override
  String get common_phone => 'Телефон';

  @override
  String get common_notes => 'Нотатки';

  @override
  String get common_name => 'Ім\'я';

  @override
  String get common_firstName => 'Ім\'я';

  @override
  String get common_lastName => 'Прізвище';

  @override
  String get common_password => 'Пароль';

  @override
  String get common_date => 'Дата';

  @override
  String get common_description => 'Опис';

  @override
  String get common_type => 'Тип';

  @override
  String get common_group => 'Група';

  @override
  String get common_role => 'Роль';

  @override
  String get common_color => 'Колір';

  @override
  String get common_download => 'Завантажити';

  @override
  String get common_send => 'Надіслати';

  @override
  String get common_justNow => 'Щойно';

  @override
  String common_minutesAgo(int minutes) {
    return '$minutes хв. тому';
  }

  @override
  String common_hoursAgo(int hours) {
    return '$hours год. тому';
  }

  @override
  String get common_today => 'Сьогодні';

  @override
  String get common_yesterday => 'Вчора';

  @override
  String common_daysAgo(int days) {
    return '$days днів тому';
  }

  @override
  String common_yearsOld(int years) {
    return '$years років';
  }

  @override
  String get common_clock => 'Година';

  @override
  String get auth_appName => 'KitaFlow';

  @override
  String get auth_appInitials => 'KF';

  @override
  String get auth_appTagline => 'Освітня платформа для дітей від 0 до 10 років';

  @override
  String get auth_appSlogan => 'Освітня платформа для дітей';

  @override
  String get auth_loginTitle => 'Увійти';

  @override
  String get auth_loginEmail => 'Ел. пошта';

  @override
  String get auth_loginEmailHint => 'name@example.com';

  @override
  String get auth_loginEmailRequired => 'Будь ласка, введіть ел. пошту';

  @override
  String get auth_loginEmailInvalid => 'Будь ласка, введіть дійсну ел. пошту';

  @override
  String get auth_loginPassword => 'Пароль';

  @override
  String get auth_loginPasswordRequired => 'Будь ласка, введіть пароль';

  @override
  String get auth_loginPasswordMinLength => 'Мінімум 8 символів';

  @override
  String get auth_forgotPassword => 'Забули пароль?';

  @override
  String get auth_noAccount => 'Ще немає облікового запису?';

  @override
  String get auth_register => 'Зареєструватися';

  @override
  String get auth_alreadyHaveAccount => 'Вже є обліковий запис?';

  @override
  String get auth_registerTitle => 'Створити обліковий запис';

  @override
  String get auth_registerSubtitle => 'Створіть свій обліковий запис KitaFlow';

  @override
  String get auth_registerFirstName => 'Ім\'я';

  @override
  String get auth_registerFirstNameHint => 'Ваше ім\'я';

  @override
  String get auth_registerFirstNameRequired => 'Будь ласка, введіть своє ім\'я';

  @override
  String get auth_registerLastName => 'Прізвище';

  @override
  String get auth_registerLastNameHint => 'Ваше прізвище';

  @override
  String get auth_registerLastNameRequired =>
      'Будь ласка, введіть своє прізвище';

  @override
  String get auth_registerEmailHint => 'your@email.com';

  @override
  String get auth_registerEmailRequired => 'Будь ласка, введіть свою ел. пошту';

  @override
  String get auth_registerEmailInvalid =>
      'Будь ласка, введіть дійсну ел. пошту';

  @override
  String get auth_registerPasswordMinLength => 'Мінімум 8 символів';

  @override
  String get auth_registerPasswordRequired => 'Будь ласка, введіть пароль';

  @override
  String get auth_registerPasswordTooShort =>
      'Пароль має містити щонайменше 8 символів';

  @override
  String get auth_registerPasswordStrengthWeak => 'Слабкий';

  @override
  String get auth_registerPasswordStrengthMedium => 'Середній';

  @override
  String get auth_registerPasswordStrengthStrong => 'Надійний';

  @override
  String get auth_registerConfirmPassword => 'Підтвердити пароль';

  @override
  String get auth_registerConfirmPasswordHint => 'Повторіть пароль';

  @override
  String get auth_registerConfirmPasswordRequired =>
      'Будь ласка, підтвердіть свій пароль';

  @override
  String get auth_registerPasswordMismatch => 'Паролі не збігаються';

  @override
  String get auth_registerRoleLabel => 'Роль';

  @override
  String get auth_registerRoleHint => 'Оберіть роль';

  @override
  String get auth_registerRoleRequired => 'Будь ласка, оберіть роль';

  @override
  String get auth_registerAcceptTerms =>
      'Я приймаю умови використання та політику конфіденційності';

  @override
  String get auth_registerTermsRequired =>
      'Ви повинні прийняти умови використання та політику конфіденційності';

  @override
  String get auth_forgotPasswordTitle => 'Скинути пароль';

  @override
  String get auth_forgotPasswordDescription =>
      'Введіть свою ел. пошту, і ми надішлемо вам посилання для скидання пароля.';

  @override
  String get auth_forgotPasswordSendLink => 'Надіслати посилання';

  @override
  String get auth_forgotPasswordBackToLogin => 'Повернутися до входу';

  @override
  String get auth_forgotPasswordEmailSent => 'Лист надіслано!';

  @override
  String get auth_forgotPasswordCheckInbox =>
      'Перевірте вашу поштову скриньку.';

  @override
  String get auth_verifyEmailTitle => 'Підтвердити ел. пошту';

  @override
  String get auth_verifyEmailSubtitle =>
      'Будь ласка, підтвердіть свою ел. пошту';

  @override
  String get auth_verifyEmailDescription =>
      'Ми надіслали вам лист для підтвердження. Натисніть на посилання в листі, щоб активувати свій обліковий запис.';

  @override
  String get auth_verifyEmailResend => 'Надіслати повторно';

  @override
  String auth_verifyEmailResendCountdown(int seconds) {
    return 'Надіслати повторно ($secondsс)';
  }

  @override
  String get auth_verifyEmailBackToLogin => 'Повернутися до входу';

  @override
  String get auth_verifyEmailResent => 'Лист надіслано повторно';

  @override
  String get shell_dashboard => 'Панель керування';

  @override
  String get shell_kinder => 'Діти';

  @override
  String get shell_anwesenheit => 'Відвідуваність';

  @override
  String get shell_nachrichten => 'Повідомлення';

  @override
  String get shell_mehr => 'Більше';

  @override
  String get shell_elternHome => 'Головна';

  @override
  String get shell_elternNachrichten => 'Повідомлення';

  @override
  String get shell_elternTermine => 'Події';

  @override
  String get shell_elternMeinKind => 'Моя дитина';

  @override
  String get shell_elternMehr => 'Більше';

  @override
  String get onboarding_institutionTitle => 'Налаштування закладу';

  @override
  String get onboarding_institutionCreate => 'Створити заклад';

  @override
  String get onboarding_stepType => 'Оберіть тип закладу';

  @override
  String get onboarding_stepData => 'Дані закладу';

  @override
  String get onboarding_stepGroups => 'Створити групи/класи';

  @override
  String get onboarding_stepStaff => 'Запросити працівників';

  @override
  String get onboarding_selectTypePrompt => 'Будь ласка, оберіть тип закладу.';

  @override
  String get onboarding_nameRequired => 'Будь ласка, введіть назву закладу.';

  @override
  String get onboarding_nameLabel => 'Назва закладу';

  @override
  String get onboarding_street => 'Вулиця';

  @override
  String get onboarding_zip => 'Поштовий індекс';

  @override
  String get onboarding_city => 'Місто';

  @override
  String get onboarding_state => 'Область';

  @override
  String get onboarding_phone => 'Телефон';

  @override
  String get onboarding_emailLabel => 'Ел. пошта';

  @override
  String get onboarding_maxChildren => 'Макс. дітей';

  @override
  String get onboarding_color => 'Колір';

  @override
  String get onboarding_addGroup => 'Додати групу/клас';

  @override
  String get onboarding_addInvitation => 'Додати запрошення';

  @override
  String get onboarding_creatingInstitution => 'Створення закладу...';

  @override
  String get onboarding_parentTitle => 'Реєстрація батьків';

  @override
  String get onboarding_parentLinkChild => 'Прив\'язати дитину';

  @override
  String get onboarding_parentCodeHint => 'Введіть код запрошення...';

  @override
  String get onboarding_parentCodeLabel => 'Код запрошення';

  @override
  String get onboarding_parentCheckCode => 'Перевірити код';

  @override
  String get onboarding_parentInvitationFound => 'Запрошення знайдено!';

  @override
  String get onboarding_parentAcceptInvitation => 'Прийняти запрошення';

  @override
  String get onboarding_parentWelcome => 'Ласкаво просимо до KitaFlow!';

  @override
  String get onboarding_parentChildLinked => 'Вашу дитину успішно прив\'язано.';

  @override
  String get onboarding_parentLetsGo => 'Розпочати';

  @override
  String get dashboard_title => 'Панель керування';

  @override
  String get dashboard_hints => 'Сповіщення';

  @override
  String get dashboard_mealPlanToday => 'Меню на сьогодні';

  @override
  String get dashboard_messages => 'Повідомлення';

  @override
  String get dashboard_greetingMorning => 'Доброго ранку';

  @override
  String get dashboard_greetingAfternoon => 'Доброго дня';

  @override
  String get dashboard_greetingEvening => 'Доброго вечора';

  @override
  String dashboard_greetingWithName(String greeting, String name) {
    return '$greeting, $name!';
  }

  @override
  String get dashboard_statsPresent => 'Присутні';

  @override
  String get dashboard_statsUnread => 'Непрочитані';

  @override
  String get dashboard_statsSick => 'Хворі';

  @override
  String get dashboard_quickCheckIn => 'Реєстрація';

  @override
  String get dashboard_quickMessage => 'Повідомлення';

  @override
  String get dashboard_quickAddChild => 'Дитина +';

  @override
  String get dashboard_quickMessages => 'Повідомлення';

  @override
  String get dashboard_quickSickNote => 'Лікарняний';

  @override
  String get dashboard_noMealPlan => 'На сьогодні меню немає';

  @override
  String get dashboard_noNewMessages => 'Немає нових повідомлень';

  @override
  String dashboard_birthdayAlert(String name) {
    return 'День народження: $name';
  }

  @override
  String dashboard_birthdayToday(int years) {
    return 'Сьогодні виповнюється $years років!';
  }

  @override
  String dashboard_birthdayUpcoming(int years, String date) {
    return 'Виповниться $years років $date';
  }

  @override
  String get kinder_title => 'Діти';

  @override
  String get kinder_search => 'Шукати дітей...';

  @override
  String get kinder_notFound => 'Дітей не знайдено';

  @override
  String get kinder_notFoundDescription =>
      'За поточними фільтрами дітей не знайдено.';

  @override
  String get kinder_addChild => 'Додати дитину';

  @override
  String get kinder_errorOccurred => 'Сталася помилка.';

  @override
  String get kinder_formEditTitle => 'Редагувати дитину';

  @override
  String get kinder_formNewTitle => 'Нова дитина';

  @override
  String get kinder_formFirstName => 'Ім\'я *';

  @override
  String get kinder_formLastName => 'Прізвище *';

  @override
  String get kinder_formFirstNameRequired => 'Будь ласка, введіть ім\'я';

  @override
  String get kinder_formLastNameRequired => 'Будь ласка, введіть прізвище';

  @override
  String get kinder_formBirthDate => 'Дата народження *';

  @override
  String get kinder_formBirthDateSelect => 'Оберіть дату народження';

  @override
  String get kinder_formBirthDateRequired =>
      'Будь ласка, оберіть дату народження';

  @override
  String get kinder_formGender => 'Стать';

  @override
  String get kinder_formGenderSelect => 'Оберіть стать';

  @override
  String get kinder_formGenderMale => 'Хлопчик';

  @override
  String get kinder_formGenderFemale => 'Дівчинка';

  @override
  String get kinder_formGenderDiverse => 'Інше';

  @override
  String get kinder_formGroup => 'Група';

  @override
  String get kinder_formGroupSelect => 'Оберіть групу';

  @override
  String get kinder_formEntryDate => 'Дата вступу';

  @override
  String get kinder_formEntryDateSelect => 'Оберіть дату вступу';

  @override
  String get kinder_formNotes => 'Нотатки';

  @override
  String get kinder_formNotesHint => 'Особливі зауваження, потреби тощо.';

  @override
  String get kinder_formSave => 'Зберегти';

  @override
  String get kinder_formCreate => 'Створити дитину';

  @override
  String get kinder_detailNotFound => 'Дитину не знайдено.';

  @override
  String get kinder_detailDeleteTitle => 'Видалити дитину';

  @override
  String kinder_detailDeleteConfirm(String name) {
    return 'Ви дійсно хочете видалити $name? Цю дію неможливо скасувати.';
  }

  @override
  String get kinder_detailTabMasterData => 'Основні дані';

  @override
  String kinder_detailTabAllergies(int count) {
    return 'Алергії ($count)';
  }

  @override
  String kinder_detailTabContacts(int count) {
    return 'Контакти ($count)';
  }

  @override
  String get kinder_detailBirthDate => 'Дата народження';

  @override
  String get kinder_detailGender => 'Стать';

  @override
  String get kinder_detailGroup => 'Група';

  @override
  String get kinder_detailEntryDate => 'Дата вступу';

  @override
  String get kinder_detailStatus => 'Статус';

  @override
  String get kinder_detailNotes => 'Нотатки';

  @override
  String get kinder_detailNoAllergies => 'Алергій не зареєстровано';

  @override
  String get kinder_detailAddAllergyHint => 'Додайте відомі алергії...';

  @override
  String get kinder_detailAddAllergy => 'Додати алергію';

  @override
  String get kinder_detailRemoveAllergy => 'Видалити алергію';

  @override
  String get kinder_detailNoContacts => 'Немає контактних осіб';

  @override
  String get kinder_detailAddContactHint => 'Додайте контактних осіб...';

  @override
  String get kinder_detailAddContact => 'Додати контакт';

  @override
  String get kinder_detailRemoveContact => 'Видалити контакт';

  @override
  String get kinder_detailPickupAuthorized => 'Має право забирати';

  @override
  String get kinder_detailEmergencyContact => 'Екстрений контакт';

  @override
  String get kinder_allergyFormTitle => 'Додати алергію';

  @override
  String get kinder_allergyFormAllergen => 'Алерген *';

  @override
  String get kinder_allergyFormAllergenRequired =>
      'Будь ласка, оберіть алерген';

  @override
  String get kinder_allergyFormSeverity => 'Ступінь тяжкості';

  @override
  String get kinder_allergyFormHints => 'Примітки';

  @override
  String get kinder_allergyFormHintsPlaceholder =>
      'напр. реакція, невідкладні ліки';

  @override
  String get kinder_contactFormEditTitle => 'Редагувати контакт';

  @override
  String get kinder_contactFormAddTitle => 'Додати контакт';

  @override
  String get kinder_contactFormName => 'Ім\'я *';

  @override
  String get kinder_contactFormNameRequired => 'Будь ласка, введіть ім\'я';

  @override
  String get kinder_contactFormRelation => 'Зв\'язок *';

  @override
  String get kinder_contactFormRelationHint =>
      'напр. мати, батько, бабуся/дідусь';

  @override
  String get kinder_contactFormRelationRequired =>
      'Будь ласка, введіть зв\'язок';

  @override
  String get kinder_contactFormPhone => 'Телефон';

  @override
  String get kinder_contactFormEmail => 'Ел. пошта';

  @override
  String get kinder_contactFormPickupAuthorized => 'Має право забирати';

  @override
  String get kinder_contactFormPickupDescription =>
      'Може забирати дитину із закладу';

  @override
  String get kinder_contactFormEmergencyContact => 'Екстрений контакт';

  @override
  String get kinder_contactFormEmergencyDescription =>
      'Зв\'язуються в екстрених випадках';

  @override
  String get kinder_contactFormSave => 'Зберегти';

  @override
  String get anwesenheit_title => 'Відвідуваність';

  @override
  String get anwesenheit_all => 'Усі';

  @override
  String get anwesenheit_markAllPresent => 'Позначити всіх присутніми';

  @override
  String get anwesenheit_alreadyPickedUp => 'Вже забрано або відсутній.';

  @override
  String get anwesenheit_allRecorded => 'Усі діти вже зареєстровані.';

  @override
  String anwesenheit_markedPresent(int count) {
    return '$count дітей позначено присутніми.';
  }

  @override
  String get anwesenheit_notRecorded => 'Не зареєстровано';

  @override
  String anwesenheit_presentSince(String time) {
    return 'Присутній з $time';
  }

  @override
  String anwesenheit_pickedUp(String time) {
    return 'Забрано $time';
  }

  @override
  String get anwesenheit_statsPresent => 'Присутні';

  @override
  String get anwesenheit_statsAbsent => 'Відсутні';

  @override
  String get anwesenheit_statsSick => 'Хворі';

  @override
  String get anwesenheit_statsTotal => 'Усього';

  @override
  String get anwesenheit_statusDialogTitle => 'Змінити статус';

  @override
  String get anwesenheit_statusDialogNote => 'Примітка (необов\'язково)';

  @override
  String get anwesenheit_statusDialogSetStatus => 'Встановити статус';

  @override
  String get anwesenheit_sickNoteTitle => 'Лікарняний';

  @override
  String get anwesenheit_sickNoteDescription =>
      'Повідомте про хворобу дитини або подайте обґрунтування.';

  @override
  String get anwesenheit_sickNoteDate => 'Дата';

  @override
  String get anwesenheit_sickNoteReason => 'Причина *';

  @override
  String get anwesenheit_sickNoteMessage => 'Повідомлення закладу';

  @override
  String get anwesenheit_sickNoteMessageHint =>
      'Необов\'язкове повідомлення закладу...';

  @override
  String get anwesenheit_sickNoteSend => 'Надіслати лікарняний';

  @override
  String get nachrichten_title => 'Повідомлення';

  @override
  String get nachrichten_all => 'Усі';

  @override
  String get nachrichten_noMessages => 'Немає повідомлень';

  @override
  String get nachrichten_inboxEmpty => 'Ваша скринька порожня.';

  @override
  String get nachrichten_noSentMessages => 'Немає надісланих повідомлень';

  @override
  String get nachrichten_noSentDescription =>
      'Ви ще не надіслали жодного повідомлення.';

  @override
  String get nachrichten_noImportant => 'Немає важливих повідомлень';

  @override
  String get nachrichten_noImportantDescription =>
      'Повідомлень, позначених як важливі, немає.';

  @override
  String get nachrichten_detailTitle => 'Повідомлення';

  @override
  String get nachrichten_detailDeleteTitle => 'Видалити повідомлення';

  @override
  String get nachrichten_detailDeleteConfirm =>
      'Ви дійсно хочете остаточно видалити це повідомлення?';

  @override
  String get nachrichten_detailNotFound => 'Повідомлення не знайдено.';

  @override
  String get nachrichten_detailAttachments => 'Вкладення';

  @override
  String nachrichten_detailReadBy(int read, int total) {
    return 'Прочитано $read/$total';
  }

  @override
  String get nachrichten_detailDeleteTooltip => 'Видалити повідомлення';

  @override
  String get nachrichten_formTitle => 'Нове повідомлення';

  @override
  String get nachrichten_formType => 'Тип';

  @override
  String get nachrichten_formRecipients => 'Одержувачі';

  @override
  String get nachrichten_formRecipientsAll => 'Усі';

  @override
  String get nachrichten_formRecipientsGroup => 'Група';

  @override
  String get nachrichten_formRecipientsIndividual => 'Індивідуально';

  @override
  String get nachrichten_formSelectGroup => 'Оберіть групу';

  @override
  String get nachrichten_formSelectGroupHint => 'Будь ласка, оберіть групу';

  @override
  String get nachrichten_formSelectGroupRequired => 'Будь ласка, оберіть групу';

  @override
  String get nachrichten_formSelectRecipients => 'Оберіть одержувачів';

  @override
  String nachrichten_formRecipientsSelected(int count) {
    return '$count одержувачів обрано';
  }

  @override
  String get nachrichten_formSubject => 'Тема';

  @override
  String get nachrichten_formSubjectHint => 'Введіть тему';

  @override
  String get nachrichten_formContent => 'Зміст';

  @override
  String get nachrichten_formContentHint => 'Введіть повідомлення...';

  @override
  String get nachrichten_formMarkImportant => 'Позначити як важливе';

  @override
  String get nachrichten_formSend => 'Надіслати повідомлення';

  @override
  String get nachrichten_recipientDialogTitle => 'Обрати одержувачів';

  @override
  String get nachrichten_recipientDialogSearch =>
      'Шукати за ім\'ям або роллю...';

  @override
  String get nachrichten_recipientDialogNone => 'Зняти вибір';

  @override
  String get nachrichten_recipientDialogAll => 'Обрати всіх';

  @override
  String nachrichten_recipientDialogConfirm(int count) {
    return 'Обрати $count одержувачів';
  }

  @override
  String get nachrichten_recipientDialogLoadError =>
      'Не вдалося завантажити профілі.';

  @override
  String get nachrichten_recipientDialogNoProfiles => 'Профілів не знайдено.';

  @override
  String nachrichten_recipientDialogNoResults(String query) {
    return 'Результатів за запитом \"$query\" не знайдено.';
  }

  @override
  String get nachrichten_attachmentDownload => 'Завантажити';

  @override
  String get nachrichten_attachmentRemove => 'Видалити';

  @override
  String get essensplan_title => 'Меню';

  @override
  String get essensplan_previousWeek => 'Попередній тиждень';

  @override
  String get essensplan_nextWeek => 'Наступний тиждень';

  @override
  String get essensplan_currentWeek => 'Поточний тиждень';

  @override
  String get essensplan_noMealPlan => 'Меню немає';

  @override
  String get essensplan_noMealsPlanned =>
      'На цей тиждень страви ще не заплановані.';

  @override
  String get essensplan_deleteMeal => 'Видалити страву';

  @override
  String get essensplan_formEditTitle => 'Редагувати страву';

  @override
  String get essensplan_formNewTitle => 'Нова страва';

  @override
  String get essensplan_formDate => 'Дата';

  @override
  String get essensplan_formMealType => 'Тип прийому їжі';

  @override
  String get essensplan_formDishName => 'Страва';

  @override
  String get essensplan_formDishNameRequired =>
      'Будь ласка, введіть назву страви';

  @override
  String get essensplan_formDescription => 'Опис (необов\'язково)';

  @override
  String get essensplan_formAllergens => 'Алергени (Регламент ЄС 1169/2011)';

  @override
  String get essensplan_formVegetarian => 'Вегетаріанська';

  @override
  String get essensplan_formVegan => 'Веганська';

  @override
  String get essensplan_formSave => 'Зберегти страву';

  @override
  String essensplan_allergenWarnings(int count) {
    return 'Попередження про алергени ($count)';
  }

  @override
  String get essensplan_weekdayMonday => 'Понеділок';

  @override
  String get essensplan_weekdayTuesday => 'Вівторок';

  @override
  String get essensplan_weekdayWednesday => 'Середа';

  @override
  String get essensplan_weekdayThursday => 'Четвер';

  @override
  String get essensplan_weekdayFriday => 'П\'ятниця';

  @override
  String get essensplan_weekdaySaturday => 'Субота';

  @override
  String get essensplan_weekdaySunday => 'Неділя';

  @override
  String get eltern_homeTitle => 'KitaFlow';

  @override
  String get eltern_homeMyChildren => 'Мої діти';

  @override
  String get eltern_homeNoChildren => 'Дітей ще не прив\'язано.';

  @override
  String get eltern_homeQuickActions => 'Швидкі дії';

  @override
  String get eltern_quickSickNote => 'Лікарняний';

  @override
  String get eltern_quickMessage => 'Повідомлення';

  @override
  String get eltern_quickCalendar => 'Події';

  @override
  String get eltern_kindTitle => 'Моя дитина';

  @override
  String get eltern_kindTabProfile => 'Профіль';

  @override
  String get eltern_kindTabAttendance => 'Відвідуваність';

  @override
  String get eltern_kindTabAllergies => 'Алергії';

  @override
  String get eltern_kindTabContacts => 'Контакти';

  @override
  String get eltern_kindNoChildSelected => 'Дитину не обрано.';

  @override
  String get eltern_kindBirthday => 'День народження';

  @override
  String get eltern_kindGender => 'Стать';

  @override
  String get eltern_kindStatus => 'Статус';

  @override
  String get eltern_kindNoAllergies => 'Алергій не зареєстровано.';

  @override
  String get eltern_kindAllergiesTitle => 'Алергії та непереносимість';

  @override
  String get eltern_kindAttendanceTitle => 'Відвідуваність';

  @override
  String get eltern_kindAttendanceLoading =>
      'Завантаження календаря відвідуваності...';

  @override
  String get eltern_kindNoContacts => 'Контактних осіб не зареєстровано.';

  @override
  String get eltern_kindContactsTitle => 'Контактні особи';

  @override
  String get eltern_nachrichtenTitle => 'Повідомлення';

  @override
  String get eltern_nachrichtenLoading => 'Завантаження повідомлень…';

  @override
  String get eltern_nachrichtenEmpty => 'Немає повідомлень';

  @override
  String get eltern_nachrichtenEmptyDescription =>
      'Ви ще не отримали жодного повідомлення.';

  @override
  String get termine_title => 'Події';

  @override
  String get termine_noAppointments => 'Подій немає.';

  @override
  String get termine_rsvpTitle => 'Відповідь';

  @override
  String termine_rsvpFor(String title) {
    return 'Для: $title';
  }

  @override
  String get termine_weekdayMon => 'Пн';

  @override
  String get termine_weekdayTue => 'Вт';

  @override
  String get termine_weekdayWed => 'Ср';

  @override
  String get termine_weekdayThu => 'Чт';

  @override
  String get termine_weekdayFri => 'Пт';

  @override
  String get termine_weekdaySat => 'Сб';

  @override
  String get termine_weekdaySun => 'Нд';

  @override
  String get fotos_title => 'Фотографії';

  @override
  String get fotos_noPhotos => 'Фотографій ще немає.';

  @override
  String get fotos_viewerTitle => 'Фото';

  @override
  String get push_title => 'Push-сповіщення';

  @override
  String get push_sectionNotifications => 'Сповіщення';

  @override
  String get push_messages => 'Повідомлення';

  @override
  String get push_messagesDescription => 'Нові повідомлення та листи батькам';

  @override
  String get push_attendance => 'Відвідуваність';

  @override
  String get push_attendanceDescription => 'Зміни статусу відвідуваності';

  @override
  String get push_appointments => 'Події';

  @override
  String get push_appointmentsDescription => 'Нові події та нагадування';

  @override
  String get push_mealPlan => 'Меню';

  @override
  String get push_mealPlanDescription => 'Зміни в меню';

  @override
  String get push_emergency => 'Екстрена ситуація';

  @override
  String get push_emergencyDescription => 'Важливі екстрені сповіщення';

  @override
  String get push_sectionQuietHours => 'Тихі години';

  @override
  String get push_quietHoursDescription => 'Без сповіщень протягом цього часу';

  @override
  String get push_quietHoursFrom => 'З';

  @override
  String get push_quietHoursTo => 'До';

  @override
  String get verwaltung_title => 'Управління';

  @override
  String get verwaltung_institution => 'Заклад';

  @override
  String get verwaltung_groupsTitle => 'Групи та класи';

  @override
  String verwaltung_groupsCount(int count) {
    return '$count груп';
  }

  @override
  String get verwaltung_staffTitle => 'Працівники';

  @override
  String verwaltung_staffCount(int count) {
    return '$count працівників';
  }

  @override
  String get verwaltung_groupsListTitle => 'Групи та класи';

  @override
  String get verwaltung_groupsEmpty => 'Груп немає.';

  @override
  String verwaltung_groupsOccupancyWithMax(int current, int max) {
    return 'Заповненість: $current / $max';
  }

  @override
  String verwaltung_groupsOccupancy(int count) {
    return 'Заповненість: $count дітей';
  }

  @override
  String get verwaltung_groupsInactive => 'Неактивний';

  @override
  String get verwaltung_groupFormEditTitle => 'Редагувати групу';

  @override
  String get verwaltung_groupFormNewTitle => 'Нова група';

  @override
  String get verwaltung_groupFormName => 'Назва';

  @override
  String get verwaltung_groupFormNameRequired => 'Назва обов\'язкова';

  @override
  String get verwaltung_groupFormType => 'Тип';

  @override
  String get verwaltung_groupFormTypeGroup => 'Група';

  @override
  String get verwaltung_groupFormTypeClass => 'Клас';

  @override
  String get verwaltung_groupFormMaxChildren => 'Макс. дітей';

  @override
  String get verwaltung_groupFormAgeFrom => 'Вік від';

  @override
  String get verwaltung_groupFormAgeTo => 'Вік до';

  @override
  String get verwaltung_groupFormSchoolYear => 'Навчальний рік';

  @override
  String get verwaltung_groupFormColor => 'Колір';

  @override
  String get verwaltung_groupFormActive => 'Активний';

  @override
  String get verwaltung_groupFormSave => 'Зберегти';

  @override
  String get verwaltung_groupFormCreate => 'Створити';

  @override
  String get verwaltung_staffListTitle => 'Працівники';

  @override
  String get verwaltung_staffEmpty => 'Працівників немає.';

  @override
  String get verwaltung_staffChangeRole => 'Змінити роль';

  @override
  String get verwaltung_staffAssignGroup => 'Призначити групу';

  @override
  String get verwaltung_staffRemove => 'Видалити';

  @override
  String get verwaltung_staffNoGroup => 'Без групи';

  @override
  String get verwaltung_staffRemoveTitle => 'Видалити працівника';

  @override
  String verwaltung_staffRemoveConfirm(String name) {
    return 'Ви дійсно хочете видалити $name із закладу?';
  }

  @override
  String get verwaltung_staffFormTitle => 'Додати працівника';

  @override
  String get verwaltung_staffFormEmail => 'Ел. пошта';

  @override
  String get verwaltung_staffFormEmailRequired => 'Ел. пошта обов\'язкова';

  @override
  String get verwaltung_staffFormEmailInvalid => 'Недійсна ел. пошта';

  @override
  String get verwaltung_staffFormRole => 'Роль';

  @override
  String get verwaltung_staffFormGroup => 'Група (необов\'язково)';

  @override
  String get verwaltung_staffFormNoGroup => 'Без групи';

  @override
  String get verwaltung_staffFormAdd => 'Додати';

  @override
  String get verwaltung_staffFormInvitePending =>
      'Запрошення працівників електронною поштою буде реалізовано на наступному етапі.';

  @override
  String get verwaltung_institutionFormTitle => 'Редагувати заклад';

  @override
  String get verwaltung_institutionFormSectionGeneral => 'Загальне';

  @override
  String get verwaltung_institutionFormName => 'Назва закладу';

  @override
  String get verwaltung_institutionFormNameRequired =>
      'Будь ласка, введіть назву';

  @override
  String get verwaltung_institutionFormType => 'Тип';

  @override
  String get verwaltung_institutionFormTypeHint => 'Оберіть тип закладу';

  @override
  String get verwaltung_institutionFormTypeRequired =>
      'Будь ласка, оберіть тип';

  @override
  String get verwaltung_institutionFormSectionAddress => 'Адреса';

  @override
  String get verwaltung_institutionFormStreet => 'Вулиця та номер будинку';

  @override
  String get verwaltung_institutionFormZip => 'Поштовий індекс';

  @override
  String get verwaltung_institutionFormCity => 'Місто';

  @override
  String get verwaltung_institutionFormState => 'Область';

  @override
  String get verwaltung_institutionFormSectionContact => 'Контакт';

  @override
  String get verwaltung_institutionFormPhone => 'Телефон';

  @override
  String get verwaltung_institutionFormEmail => 'Ел. пошта';

  @override
  String get verwaltung_institutionFormEmailInvalid =>
      'Будь ласка, введіть дійсну ел. пошту';

  @override
  String get verwaltung_institutionFormWebsite => 'Вебсайт';

  @override
  String get verwaltung_institutionFormSaveSuccess =>
      'Заклад успішно збережено.';

  @override
  String get verwaltung_institutionFormSaveError => 'Помилка збереження.';

  @override
  String get verwaltung_institutionFormLoadError => 'Помилка завантаження.';

  @override
  String get enum_roleErzieher => 'Вихователь';

  @override
  String get enum_roleLehrer => 'Вчитель';

  @override
  String get enum_roleLeitung => 'Керівник';

  @override
  String get enum_roleTraeger => 'Засновник';

  @override
  String get enum_roleEltern => 'Батьки';

  @override
  String get enum_institutionTypeKrippe => 'Ясла';

  @override
  String get enum_institutionTypeKita => 'Дитячий садок';

  @override
  String get enum_institutionTypeGrundschule => 'Початкова школа';

  @override
  String get enum_institutionTypeOgs => 'Група подовженого дня';

  @override
  String get enum_institutionTypeHort => 'Продовжена група';

  @override
  String get enum_attendanceAnwesend => 'Присутній';

  @override
  String get enum_attendanceAbwesend => 'Відсутній';

  @override
  String get enum_attendanceKrank => 'Хворий';

  @override
  String get enum_attendanceUrlaub => 'Відпустка';

  @override
  String get enum_attendanceEntschuldigt => 'З поважною причиною';

  @override
  String get enum_attendanceUnentschuldigt => 'Без поважної причини';

  @override
  String get enum_messageTypeNachricht => 'Повідомлення';

  @override
  String get enum_messageTypeElternbrief => 'Лист батькам';

  @override
  String get enum_messageTypeAnkuendigung => 'Оголошення';

  @override
  String get enum_messageTypeNotfall => 'Екстрена ситуація';

  @override
  String get enum_childStatusAktiv => 'Активний';

  @override
  String get enum_childStatusEingewoehnung => 'Адаптація';

  @override
  String get enum_childStatusAbgemeldet => 'Відраховано';

  @override
  String get enum_childStatusWarteliste => 'Черга очікування';

  @override
  String get enum_mealTypeFruehstueck => 'Сніданок';

  @override
  String get enum_mealTypeMittagessen => 'Обід';

  @override
  String get enum_mealTypeSnack => 'Перекус';

  @override
  String get enum_developmentMotorik => 'Моторика';

  @override
  String get enum_developmentSprache => 'Мовлення';

  @override
  String get enum_developmentSozialverhalten => 'Соціальна поведінка';

  @override
  String get enum_developmentKognitiv => 'Когнітивний розвиток';

  @override
  String get enum_developmentEmotional => 'Емоційний розвиток';

  @override
  String get enum_developmentKreativitaet => 'Креативність';

  @override
  String get enum_allergenGluten => 'Глютен';

  @override
  String get enum_allergenKrebstiere => 'Ракоподібні';

  @override
  String get enum_allergenEier => 'Яйця';

  @override
  String get enum_allergenFisch => 'Риба';

  @override
  String get enum_allergenErdnuesse => 'Арахіс';

  @override
  String get enum_allergenSoja => 'Соя';

  @override
  String get enum_allergenMilch => 'Молоко';

  @override
  String get enum_allergenSchalenfruechte => 'Горіхи';

  @override
  String get enum_allergenSellerie => 'Селера';

  @override
  String get enum_allergenSenf => 'Гірчиця';

  @override
  String get enum_allergenSesam => 'Кунжут';

  @override
  String get enum_allergenSchwefeldioxid => 'Діоксид сірки';

  @override
  String get enum_allergenLupinen => 'Люпин';

  @override
  String get enum_allergenWeichtiere => 'Молюски';

  @override
  String get enum_allergySeverityLeicht => 'Легкий';

  @override
  String get enum_allergySeverityMittel => 'Середній';

  @override
  String get enum_allergySeveritySchwer => 'Тяжкий';

  @override
  String get enum_allergySeverityLebensbedrohlich => 'Загроза життю';

  @override
  String get enum_documentTypeVertrag => 'Договір';

  @override
  String get enum_documentTypeEinverstaendnis => 'Згода';

  @override
  String get enum_documentTypeAttest => 'Довідка';

  @override
  String get enum_documentTypeZeugnis => 'Табель';

  @override
  String get enum_documentTypeSonstiges => 'Інше';

  @override
  String get enum_nachrichtenTabPosteingang => 'Вхідні';

  @override
  String get enum_nachrichtenTabGesendet => 'Надіслані';

  @override
  String get enum_nachrichtenTabWichtig => 'Важливі';

  @override
  String get enum_terminTypAllgemein => 'Загальне';

  @override
  String get enum_terminTypElternabend => 'Батьківські збори';

  @override
  String get enum_terminTypFestFeier => 'Свято/Захід';

  @override
  String get enum_terminTypSchliessung => 'Закриття';

  @override
  String get enum_terminTypAusflug => 'Екскурсія';

  @override
  String get enum_terminTypSonstiges => 'Інше';

  @override
  String get enum_rsvpZugesagt => 'Підтверджено';

  @override
  String get enum_rsvpAbgesagt => 'Відхилено';

  @override
  String get enum_rsvpVielleicht => 'Можливо';

  @override
  String get enum_elternBeziehungMutter => 'Мати';

  @override
  String get enum_elternBeziehungVater => 'Батько';

  @override
  String get enum_elternBeziehungSorgeberechtigt => 'Опікун';

  @override
  String get dashboard_monthJanuar => 'Січень';

  @override
  String get dashboard_monthFebruar => 'Лютий';

  @override
  String get dashboard_monthMaerz => 'Березень';

  @override
  String get dashboard_monthApril => 'Квітень';

  @override
  String get dashboard_monthMai => 'Травень';

  @override
  String get dashboard_monthJuni => 'Червень';

  @override
  String get dashboard_monthJuli => 'Липень';

  @override
  String get dashboard_monthAugust => 'Серпень';

  @override
  String get dashboard_monthSeptember => 'Вересень';

  @override
  String get dashboard_monthOktober => 'Жовтень';

  @override
  String get dashboard_monthNovember => 'Листопад';

  @override
  String get dashboard_monthDezember => 'Грудень';

  @override
  String get dashboard_weekdayMontag => 'Понеділок';

  @override
  String get dashboard_weekdayDienstag => 'Вівторок';

  @override
  String get dashboard_weekdayMittwoch => 'Середа';

  @override
  String get dashboard_weekdayDonnerstag => 'Четвер';

  @override
  String get dashboard_weekdayFreitag => 'П\'ятниця';

  @override
  String get dashboard_weekdaySamstag => 'Субота';

  @override
  String get dashboard_weekdaySonntag => 'Неділя';

  @override
  String get verwaltung_rolleDropdownErzieher => 'Вихователь';

  @override
  String get verwaltung_rolleDropdownLehrer => 'Вчитель';

  @override
  String get verwaltung_rolleDropdownLeitung => 'Керівник';

  @override
  String get common_language => 'Мова';

  @override
  String get dokumente_title => 'Документи';

  @override
  String get dokumente_noDocuments => 'Документів поки немає.';

  @override
  String get dokumente_upload => 'Завантажити';

  @override
  String get dokumente_download => 'Скачати';

  @override
  String get dokumente_delete => 'Видалити документ';

  @override
  String get dokumente_deleteConfirm =>
      'Ви дійсно хочете видалити цей документ?';

  @override
  String get dokumente_filterAll => 'Усі';

  @override
  String get dokumente_signed => 'Підписано';

  @override
  String get dokumente_unsigned => 'Не підписано';

  @override
  String dokumente_signedBy(String name, String date) {
    return 'Підписано $name $date';
  }

  @override
  String dokumente_validUntil(String date) {
    return 'Дійсний до $date';
  }

  @override
  String get dokumente_expired => 'Прострочено';

  @override
  String get dokumente_sign => 'Підписати';

  @override
  String get dokumente_signTitle => 'Підписати документ';

  @override
  String get dokumente_signClear => 'Очистити';

  @override
  String get dokumente_signConfirm => 'Підтвердити підпис';

  @override
  String get dokumente_signHint => 'Підпишіть тут';

  @override
  String get dokumente_uploadSuccess => 'Документ успішно завантажено.';

  @override
  String get dokumente_uploadError => 'Помилка при завантаженні документа.';

  @override
  String get dokumente_deleteSuccess => 'Документ успішно видалено.';

  @override
  String get dokumente_signSuccess => 'Документ успішно підписано.';

  @override
  String get dokumente_pdfGenerate => 'Створити PDF';

  @override
  String get dokumente_pdfPreview => 'Попередній перегляд PDF';

  @override
  String get dokumente_formTitle => 'Новий документ';

  @override
  String get dokumente_formTitel => 'Заголовок';

  @override
  String get dokumente_formTyp => 'Тип документа';

  @override
  String get dokumente_formBeschreibung => 'Опис';

  @override
  String get dokumente_formGueltigBis => 'Дійсний до';

  @override
  String get dokumente_formKind => 'Призначити дитині';

  @override
  String get dokumente_formKindOptional => 'Без дитини (загальний)';

  @override
  String get dokumente_formFile => 'Файл';

  @override
  String get dokumente_formFileSelect => 'Обрати файл';

  @override
  String dokumente_formFileSelected(String filename) {
    return 'Обраний файл: $filename';
  }

  @override
  String dokumente_count(int count) {
    return '$count документів';
  }

  @override
  String get verwaltung_dokumenteTile => 'Документи';

  @override
  String get verwaltung_eingewoehnungTile => 'Адаптація';

  @override
  String get eingewoehnung_title => 'Адаптація';

  @override
  String get eingewoehnung_subtitle => 'Управління фазою адаптації';

  @override
  String eingewoehnung_count(int count) {
    return '$count адаптацій';
  }

  @override
  String get eingewoehnung_startdatum => 'Дата початку';

  @override
  String get eingewoehnung_bezugsperson => 'Контактна особа';

  @override
  String get eingewoehnung_phasenFortschritt => 'Прогрес фаз';

  @override
  String get eingewoehnung_naechstePhase => 'Наступна фаза';

  @override
  String get eingewoehnung_phaseAendern => 'Змінити фазу';

  @override
  String get eingewoehnung_neueNotiz => 'Нова щоденна нотатка';

  @override
  String get eingewoehnung_dauer => 'Тривалість (хвилини)';

  @override
  String get eingewoehnung_trennungsverhalten => 'Поведінка при розлуці';

  @override
  String get eingewoehnung_essen => 'Їжа';

  @override
  String get eingewoehnung_schlaf => 'Сон';

  @override
  String get eingewoehnung_spiel => 'Гра';

  @override
  String get eingewoehnung_stimmung => 'Настрій';

  @override
  String get eingewoehnung_notizenIntern => 'Внутрішні нотатки';

  @override
  String get eingewoehnung_notizenEltern => 'Нотатки для батьків';

  @override
  String get eingewoehnung_notizenElternHinweis =>
      'Ця нотатка видима для батьків.';

  @override
  String get eingewoehnung_keineTagesnotizen => 'Ще немає щоденних нотаток.';

  @override
  String get eingewoehnung_elternFeedback => 'Відгук батьків';

  @override
  String get eingewoehnung_feedbackFrage =>
      'Як ви переживаєте адаптацію вашої дитини?';

  @override
  String eingewoehnung_tage(int count) {
    return '$count днів';
  }

  @override
  String get eingewoehnung_notizGespeichert => 'Щоденну нотатку збережено.';

  @override
  String get eingewoehnung_phaseGeaendert => 'Фазу успішно змінено.';

  @override
  String get eingewoehnung_feedbackGespeichert => 'Відгук збережено.';

  @override
  String get eingewoehnung_keineAktiven => 'Немає активних адаптацій.';

  @override
  String get eingewoehnung_neueEingewoehnung => 'Нова адаптація';

  @override
  String get eingewoehnung_kindAuswaehlen => 'Обрати дитину';

  @override
  String get eingewoehnung_nurEingewoehnung =>
      'Тільки діти зі статусом ‚Адаптація\'';

  @override
  String get enum_phaseGrundphase => 'Основна фаза';

  @override
  String get enum_phaseStabilisierung => 'Стабілізація';

  @override
  String get enum_phaseSchlussphase => 'Завершальна фаза';

  @override
  String get enum_phaseAbgeschlossen => 'Завершено';

  @override
  String get enum_stimmungSehrGut => 'Дуже добре';

  @override
  String get enum_stimmungGut => 'Добре';

  @override
  String get enum_stimmungNeutral => 'Нейтрально';

  @override
  String get enum_stimmungSchlecht => 'Погано';

  @override
  String get enum_stimmungSehrSchlecht => 'Дуже погано';
}

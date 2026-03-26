// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get common_save => 'حفظ';

  @override
  String get common_cancel => 'إلغاء';

  @override
  String get common_delete => 'حذف';

  @override
  String get common_edit => 'تعديل';

  @override
  String get common_ok => 'موافق';

  @override
  String get common_confirm => 'تأكيد';

  @override
  String get common_back => 'رجوع';

  @override
  String get common_next => 'التالي';

  @override
  String get common_skip => 'تخطي';

  @override
  String get common_close => 'إغلاق';

  @override
  String get common_error => 'خطأ';

  @override
  String get common_retry => 'إعادة المحاولة';

  @override
  String get common_loading => 'جارٍ التحميل...';

  @override
  String get common_showAll => 'عرض الكل';

  @override
  String get common_noAccess => 'لا يوجد صلاحية';

  @override
  String get common_noAccessDescription =>
      'ليس لديك صلاحية للوصول إلى هذا القسم.';

  @override
  String get common_requiredField => 'حقل مطلوب';

  @override
  String get common_all => 'الكل';

  @override
  String get common_active => 'نشط';

  @override
  String get common_inactive => 'غير نشط';

  @override
  String get common_add => 'إضافة';

  @override
  String get common_remove => 'إزالة';

  @override
  String get common_create => 'إنشاء';

  @override
  String get common_search => 'بحث';

  @override
  String get common_email => 'البريد الإلكتروني';

  @override
  String get common_phone => 'الهاتف';

  @override
  String get common_notes => 'ملاحظات';

  @override
  String get common_name => 'الاسم';

  @override
  String get common_firstName => 'الاسم الأول';

  @override
  String get common_lastName => 'اسم العائلة';

  @override
  String get common_password => 'كلمة المرور';

  @override
  String get common_date => 'التاريخ';

  @override
  String get common_description => 'الوصف';

  @override
  String get common_type => 'النوع';

  @override
  String get common_group => 'المجموعة';

  @override
  String get common_role => 'الدور';

  @override
  String get common_color => 'اللون';

  @override
  String get common_download => 'تحميل';

  @override
  String get common_send => 'إرسال';

  @override
  String get common_justNow => 'الآن';

  @override
  String common_minutesAgo(int minutes) {
    return 'منذ $minutes دقيقة';
  }

  @override
  String common_hoursAgo(int hours) {
    return 'منذ $hours ساعة';
  }

  @override
  String get common_today => 'اليوم';

  @override
  String get common_yesterday => 'أمس';

  @override
  String common_daysAgo(int days) {
    return 'منذ $days أيام';
  }

  @override
  String common_yearsOld(int years) {
    return '$years سنوات';
  }

  @override
  String get common_clock => 'الساعة';

  @override
  String get auth_appName => 'KitaFlow';

  @override
  String get auth_appInitials => 'KF';

  @override
  String get auth_appTagline => 'منصة تعليمية للأطفال من 0 إلى 10 سنوات';

  @override
  String get auth_appSlogan => 'المنصة التعليمية للأطفال';

  @override
  String get auth_loginTitle => 'تسجيل الدخول';

  @override
  String get auth_loginEmail => 'البريد الإلكتروني';

  @override
  String get auth_loginEmailHint => 'name@example.com';

  @override
  String get auth_loginEmailRequired => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get auth_loginEmailInvalid => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get auth_loginPassword => 'كلمة المرور';

  @override
  String get auth_loginPasswordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get auth_loginPasswordMinLength => '8 أحرف على الأقل';

  @override
  String get auth_forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get auth_noAccount => 'ليس لديك حساب؟';

  @override
  String get auth_register => 'التسجيل';

  @override
  String get auth_alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get auth_registerTitle => 'إنشاء حساب';

  @override
  String get auth_registerSubtitle => 'أنشئ حسابك في KitaFlow';

  @override
  String get auth_registerFirstName => 'الاسم الأول';

  @override
  String get auth_registerFirstNameHint => 'اسمك الأول';

  @override
  String get auth_registerFirstNameRequired => 'يرجى إدخال اسمك الأول';

  @override
  String get auth_registerLastName => 'اسم العائلة';

  @override
  String get auth_registerLastNameHint => 'اسم عائلتك';

  @override
  String get auth_registerLastNameRequired => 'يرجى إدخال اسم العائلة';

  @override
  String get auth_registerEmailHint => 'your@email.com';

  @override
  String get auth_registerEmailRequired => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get auth_registerEmailInvalid => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get auth_registerPasswordMinLength => '8 أحرف على الأقل';

  @override
  String get auth_registerPasswordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get auth_registerPasswordTooShort =>
      'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get auth_registerPasswordStrengthWeak => 'ضعيفة';

  @override
  String get auth_registerPasswordStrengthMedium => 'متوسطة';

  @override
  String get auth_registerPasswordStrengthStrong => 'قوية';

  @override
  String get auth_registerConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get auth_registerConfirmPasswordHint => 'أعد إدخال كلمة المرور';

  @override
  String get auth_registerConfirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get auth_registerPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get auth_registerRoleLabel => 'الدور';

  @override
  String get auth_registerRoleHint => 'اختر الدور';

  @override
  String get auth_registerRoleRequired => 'يرجى اختيار دور';

  @override
  String get auth_registerAcceptTerms =>
      'أوافق على الشروط والأحكام وسياسة الخصوصية';

  @override
  String get auth_registerTermsRequired =>
      'يجب الموافقة على الشروط والأحكام وسياسة الخصوصية';

  @override
  String get auth_forgotPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get auth_forgotPasswordDescription =>
      'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.';

  @override
  String get auth_forgotPasswordSendLink => 'إرسال الرابط';

  @override
  String get auth_forgotPasswordBackToLogin => 'العودة لتسجيل الدخول';

  @override
  String get auth_forgotPasswordEmailSent => 'تم إرسال البريد الإلكتروني!';

  @override
  String get auth_forgotPasswordCheckInbox => 'تحقق من صندوق الوارد.';

  @override
  String get auth_verifyEmailTitle => 'تأكيد البريد الإلكتروني';

  @override
  String get auth_verifyEmailSubtitle => 'يرجى تأكيد بريدك الإلكتروني';

  @override
  String get auth_verifyEmailDescription =>
      'لقد أرسلنا لك بريد تأكيد إلكتروني. انقر على الرابط في البريد لتفعيل حسابك.';

  @override
  String get auth_verifyEmailResend => 'إعادة الإرسال';

  @override
  String auth_verifyEmailResendCountdown(int seconds) {
    return 'إعادة الإرسال ($seconds ثانية)';
  }

  @override
  String get auth_verifyEmailBackToLogin => 'العودة لتسجيل الدخول';

  @override
  String get auth_verifyEmailResent => 'تم إعادة إرسال البريد الإلكتروني';

  @override
  String get shell_dashboard => 'لوحة التحكم';

  @override
  String get shell_kinder => 'الأطفال';

  @override
  String get shell_anwesenheit => 'الحضور';

  @override
  String get shell_nachrichten => 'الرسائل';

  @override
  String get shell_mehr => 'المزيد';

  @override
  String get shell_elternHome => 'الرئيسية';

  @override
  String get shell_elternNachrichten => 'الرسائل';

  @override
  String get shell_elternTermine => 'المواعيد';

  @override
  String get shell_elternMeinKind => 'طفلي';

  @override
  String get shell_elternMehr => 'المزيد';

  @override
  String get onboarding_institutionTitle => 'إعداد المؤسسة';

  @override
  String get onboarding_institutionCreate => 'إنشاء المؤسسة';

  @override
  String get onboarding_stepType => 'اختيار نوع المؤسسة';

  @override
  String get onboarding_stepData => 'بيانات المؤسسة';

  @override
  String get onboarding_stepGroups => 'إنشاء المجموعات/الفصول';

  @override
  String get onboarding_stepStaff => 'دعوة الموظفين';

  @override
  String get onboarding_selectTypePrompt => 'يرجى اختيار نوع المؤسسة.';

  @override
  String get onboarding_nameRequired => 'يرجى إدخال اسم المؤسسة.';

  @override
  String get onboarding_nameLabel => 'اسم المؤسسة';

  @override
  String get onboarding_street => 'الشارع';

  @override
  String get onboarding_zip => 'الرمز البريدي';

  @override
  String get onboarding_city => 'المدينة';

  @override
  String get onboarding_state => 'الولاية';

  @override
  String get onboarding_phone => 'الهاتف';

  @override
  String get onboarding_emailLabel => 'البريد الإلكتروني';

  @override
  String get onboarding_maxChildren => 'الحد الأقصى للأطفال';

  @override
  String get onboarding_color => 'اللون';

  @override
  String get onboarding_addGroup => 'إضافة مجموعة/فصل';

  @override
  String get onboarding_addInvitation => 'إضافة دعوة';

  @override
  String get onboarding_creatingInstitution => 'جارٍ إنشاء المؤسسة...';

  @override
  String get onboarding_parentTitle => 'تسجيل أولياء الأمور';

  @override
  String get onboarding_parentLinkChild => 'ربط الطفل';

  @override
  String get onboarding_parentCodeHint => 'أدخل رمز الدعوة...';

  @override
  String get onboarding_parentCodeLabel => 'رمز الدعوة';

  @override
  String get onboarding_parentCheckCode => 'التحقق من الرمز';

  @override
  String get onboarding_parentInvitationFound => 'تم العثور على الدعوة!';

  @override
  String get onboarding_parentAcceptInvitation => 'قبول الدعوة';

  @override
  String get onboarding_parentWelcome => 'مرحباً بك في KitaFlow!';

  @override
  String get onboarding_parentChildLinked => 'تم ربط طفلك بنجاح.';

  @override
  String get onboarding_parentLetsGo => 'هيا نبدأ';

  @override
  String get dashboard_title => 'لوحة التحكم';

  @override
  String get dashboard_hints => 'تنبيهات';

  @override
  String get dashboard_mealPlanToday => 'قائمة الطعام اليوم';

  @override
  String get dashboard_messages => 'الرسائل';

  @override
  String get dashboard_greetingMorning => 'صباح الخير';

  @override
  String get dashboard_greetingAfternoon => 'مساء الخير';

  @override
  String get dashboard_greetingEvening => 'مساء الخير';

  @override
  String dashboard_greetingWithName(String greeting, String name) {
    return '$greeting، $name!';
  }

  @override
  String get dashboard_statsPresent => 'حاضرون';

  @override
  String get dashboard_statsUnread => 'غير مقروءة';

  @override
  String get dashboard_statsSick => 'مرضى';

  @override
  String get dashboard_quickCheckIn => 'تسجيل حضور';

  @override
  String get dashboard_quickMessage => 'رسالة';

  @override
  String get dashboard_quickAddChild => 'طفل +';

  @override
  String get dashboard_quickMessages => 'الرسائل';

  @override
  String get dashboard_quickSickNote => 'إبلاغ مرضي';

  @override
  String get dashboard_noMealPlan => 'لا توجد قائمة طعام لليوم';

  @override
  String get dashboard_noNewMessages => 'لا توجد رسائل جديدة';

  @override
  String dashboard_birthdayAlert(String name) {
    return 'عيد ميلاد: $name';
  }

  @override
  String dashboard_birthdayToday(int years) {
    return 'يبلغ اليوم $years سنوات!';
  }

  @override
  String dashboard_birthdayUpcoming(int years, String date) {
    return 'يبلغ $years سنوات في $date';
  }

  @override
  String get kinder_title => 'الأطفال';

  @override
  String get kinder_search => 'البحث عن أطفال...';

  @override
  String get kinder_notFound => 'لم يتم العثور على أطفال';

  @override
  String get kinder_notFoundDescription =>
      'لم يتم العثور على أطفال بالفلاتر الحالية.';

  @override
  String get kinder_addChild => 'إضافة طفل';

  @override
  String get kinder_errorOccurred => 'حدث خطأ.';

  @override
  String get kinder_formEditTitle => 'تعديل بيانات الطفل';

  @override
  String get kinder_formNewTitle => 'طفل جديد';

  @override
  String get kinder_formFirstName => 'الاسم الأول *';

  @override
  String get kinder_formLastName => 'اسم العائلة *';

  @override
  String get kinder_formFirstNameRequired => 'يرجى إدخال الاسم الأول';

  @override
  String get kinder_formLastNameRequired => 'يرجى إدخال اسم العائلة';

  @override
  String get kinder_formBirthDate => 'تاريخ الميلاد *';

  @override
  String get kinder_formBirthDateSelect => 'اختيار تاريخ الميلاد';

  @override
  String get kinder_formBirthDateRequired => 'يرجى اختيار تاريخ الميلاد';

  @override
  String get kinder_formGender => 'الجنس';

  @override
  String get kinder_formGenderSelect => 'اختيار الجنس';

  @override
  String get kinder_formGenderMale => 'ذكر';

  @override
  String get kinder_formGenderFemale => 'أنثى';

  @override
  String get kinder_formGenderDiverse => 'متنوع';

  @override
  String get kinder_formGroup => 'المجموعة';

  @override
  String get kinder_formGroupSelect => 'اختيار المجموعة';

  @override
  String get kinder_formEntryDate => 'تاريخ الالتحاق';

  @override
  String get kinder_formEntryDateSelect => 'اختيار تاريخ الالتحاق';

  @override
  String get kinder_formNotes => 'ملاحظات';

  @override
  String get kinder_formNotesHint => 'ملاحظات خاصة، احتياجات، إلخ.';

  @override
  String get kinder_formSave => 'حفظ';

  @override
  String get kinder_formCreate => 'إنشاء ملف الطفل';

  @override
  String get kinder_detailNotFound => 'لم يتم العثور على الطفل.';

  @override
  String get kinder_detailDeleteTitle => 'حذف الطفل';

  @override
  String kinder_detailDeleteConfirm(String name) {
    return 'هل تريد حقاً حذف $name؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get kinder_detailTabMasterData => 'البيانات الأساسية';

  @override
  String kinder_detailTabAllergies(int count) {
    return 'الحساسيات ($count)';
  }

  @override
  String kinder_detailTabContacts(int count) {
    return 'جهات الاتصال ($count)';
  }

  @override
  String get kinder_detailBirthDate => 'تاريخ الميلاد';

  @override
  String get kinder_detailGender => 'الجنس';

  @override
  String get kinder_detailGroup => 'المجموعة';

  @override
  String get kinder_detailEntryDate => 'تاريخ الالتحاق';

  @override
  String get kinder_detailStatus => 'الحالة';

  @override
  String get kinder_detailNotes => 'ملاحظات';

  @override
  String get kinder_detailNoAllergies => 'لا توجد حساسيات مسجلة';

  @override
  String get kinder_detailAddAllergyHint => 'أضف الحساسيات المعروفة...';

  @override
  String get kinder_detailAddAllergy => 'إضافة حساسية';

  @override
  String get kinder_detailRemoveAllergy => 'إزالة الحساسية';

  @override
  String get kinder_detailNoContacts => 'لا توجد جهات اتصال';

  @override
  String get kinder_detailAddContactHint => 'أضف جهات اتصال...';

  @override
  String get kinder_detailAddContact => 'إضافة جهة اتصال';

  @override
  String get kinder_detailRemoveContact => 'إزالة جهة الاتصال';

  @override
  String get kinder_detailPickupAuthorized => 'مخوّل بالاستلام';

  @override
  String get kinder_detailEmergencyContact => 'جهة اتصال طوارئ';

  @override
  String get kinder_allergyFormTitle => 'إضافة حساسية';

  @override
  String get kinder_allergyFormAllergen => 'المادة المسببة للحساسية *';

  @override
  String get kinder_allergyFormAllergenRequired =>
      'يرجى اختيار مادة مسببة للحساسية';

  @override
  String get kinder_allergyFormSeverity => 'درجة الخطورة';

  @override
  String get kinder_allergyFormHints => 'ملاحظات';

  @override
  String get kinder_allergyFormHintsPlaceholder =>
      'مثال: نوع التفاعل، أدوية الطوارئ';

  @override
  String get kinder_contactFormEditTitle => 'تعديل جهة الاتصال';

  @override
  String get kinder_contactFormAddTitle => 'إضافة جهة اتصال';

  @override
  String get kinder_contactFormName => 'الاسم *';

  @override
  String get kinder_contactFormNameRequired => 'يرجى إدخال الاسم';

  @override
  String get kinder_contactFormRelation => 'صلة القرابة *';

  @override
  String get kinder_contactFormRelationHint => 'مثال: أم، أب، أجداد';

  @override
  String get kinder_contactFormRelationRequired => 'يرجى إدخال صلة القرابة';

  @override
  String get kinder_contactFormPhone => 'الهاتف';

  @override
  String get kinder_contactFormEmail => 'البريد الإلكتروني';

  @override
  String get kinder_contactFormPickupAuthorized => 'مخوّل بالاستلام';

  @override
  String get kinder_contactFormPickupDescription =>
      'يحق له استلام الطفل من المؤسسة';

  @override
  String get kinder_contactFormEmergencyContact => 'جهة اتصال طوارئ';

  @override
  String get kinder_contactFormEmergencyDescription =>
      'يتم التواصل معه في حالات الطوارئ';

  @override
  String get kinder_contactFormSave => 'حفظ';

  @override
  String get anwesenheit_title => 'الحضور';

  @override
  String get anwesenheit_all => 'الكل';

  @override
  String get anwesenheit_markAllPresent => 'تسجيل حضور الجميع';

  @override
  String get anwesenheit_alreadyPickedUp =>
      'تم الاستلام أو تم الإبلاغ بالغياب.';

  @override
  String get anwesenheit_allRecorded => 'تم تسجيل جميع الأطفال بالفعل.';

  @override
  String anwesenheit_markedPresent(int count) {
    return 'تم تسجيل حضور $count أطفال.';
  }

  @override
  String get anwesenheit_notRecorded => 'لم يُسجَّل';

  @override
  String anwesenheit_presentSince(String time) {
    return 'حاضر منذ $time';
  }

  @override
  String anwesenheit_pickedUp(String time) {
    return 'تم الاستلام $time';
  }

  @override
  String get anwesenheit_statsPresent => 'حاضرون';

  @override
  String get anwesenheit_statsAbsent => 'غائبون';

  @override
  String get anwesenheit_statsSick => 'مرضى';

  @override
  String get anwesenheit_statsTotal => 'الإجمالي';

  @override
  String get anwesenheit_statusDialogTitle => 'تغيير الحالة';

  @override
  String get anwesenheit_statusDialogNote => 'ملاحظة (اختياري)';

  @override
  String get anwesenheit_statusDialogSetStatus => 'تعيين الحالة';

  @override
  String get anwesenheit_sickNoteTitle => 'إبلاغ مرضي';

  @override
  String get anwesenheit_sickNoteDescription =>
      'أبلغ عن مرض طفلك أو اعتذر عن حضوره.';

  @override
  String get anwesenheit_sickNoteDate => 'التاريخ';

  @override
  String get anwesenheit_sickNoteReason => 'السبب *';

  @override
  String get anwesenheit_sickNoteMessage => 'رسالة إلى المؤسسة';

  @override
  String get anwesenheit_sickNoteMessageHint => 'رسالة اختيارية إلى المؤسسة...';

  @override
  String get anwesenheit_sickNoteSend => 'إرسال الإبلاغ المرضي';

  @override
  String get nachrichten_title => 'الرسائل';

  @override
  String get nachrichten_all => 'الكل';

  @override
  String get nachrichten_noMessages => 'لا توجد رسائل';

  @override
  String get nachrichten_inboxEmpty => 'صندوق الوارد فارغ.';

  @override
  String get nachrichten_noSentMessages => 'لا توجد رسائل مرسلة';

  @override
  String get nachrichten_noSentDescription => 'لم ترسل أي رسائل بعد.';

  @override
  String get nachrichten_noImportant => 'لا توجد رسائل مهمة';

  @override
  String get nachrichten_noImportantDescription =>
      'لا توجد رسائل مُعلَّمة كمهمة.';

  @override
  String get nachrichten_detailTitle => 'رسالة';

  @override
  String get nachrichten_detailDeleteTitle => 'حذف الرسالة';

  @override
  String get nachrichten_detailDeleteConfirm =>
      'هل تريد حقاً حذف هذه الرسالة نهائياً؟';

  @override
  String get nachrichten_detailNotFound => 'لم يتم العثور على الرسالة.';

  @override
  String get nachrichten_detailAttachments => 'المرفقات';

  @override
  String nachrichten_detailReadBy(int read, int total) {
    return 'قرأها $read/$total';
  }

  @override
  String get nachrichten_detailDeleteTooltip => 'حذف الرسالة';

  @override
  String get nachrichten_formTitle => 'رسالة جديدة';

  @override
  String get nachrichten_formType => 'النوع';

  @override
  String get nachrichten_formRecipients => 'المستلمون';

  @override
  String get nachrichten_formRecipientsAll => 'الكل';

  @override
  String get nachrichten_formRecipientsGroup => 'مجموعة';

  @override
  String get nachrichten_formRecipientsIndividual => 'فردي';

  @override
  String get nachrichten_formSelectGroup => 'اختيار المجموعة';

  @override
  String get nachrichten_formSelectGroupHint => 'يرجى اختيار مجموعة';

  @override
  String get nachrichten_formSelectGroupRequired => 'يرجى اختيار مجموعة';

  @override
  String get nachrichten_formSelectRecipients => 'اختيار المستلمين';

  @override
  String nachrichten_formRecipientsSelected(int count) {
    return 'تم اختيار $count مستلمين';
  }

  @override
  String get nachrichten_formSubject => 'الموضوع';

  @override
  String get nachrichten_formSubjectHint => 'أدخل الموضوع';

  @override
  String get nachrichten_formContent => 'المحتوى';

  @override
  String get nachrichten_formContentHint => 'اكتب الرسالة...';

  @override
  String get nachrichten_formMarkImportant => 'تحديد كمهمة';

  @override
  String get nachrichten_formSend => 'إرسال الرسالة';

  @override
  String get nachrichten_recipientDialogTitle => 'اختيار المستلمين';

  @override
  String get nachrichten_recipientDialogSearch => 'البحث بالاسم أو الدور...';

  @override
  String get nachrichten_recipientDialogNone => 'إلغاء تحديد الكل';

  @override
  String get nachrichten_recipientDialogAll => 'تحديد الكل';

  @override
  String nachrichten_recipientDialogConfirm(int count) {
    return 'اختيار $count مستلمين';
  }

  @override
  String get nachrichten_recipientDialogLoadError =>
      'تعذر تحميل الملفات الشخصية.';

  @override
  String get nachrichten_recipientDialogNoProfiles =>
      'لم يتم العثور على ملفات شخصية.';

  @override
  String nachrichten_recipientDialogNoResults(String query) {
    return 'لا توجد نتائج لـ \"$query\".';
  }

  @override
  String get nachrichten_attachmentDownload => 'تحميل';

  @override
  String get nachrichten_attachmentRemove => 'إزالة';

  @override
  String get essensplan_title => 'قائمة الطعام';

  @override
  String get essensplan_previousWeek => 'الأسبوع السابق';

  @override
  String get essensplan_nextWeek => 'الأسبوع التالي';

  @override
  String get essensplan_currentWeek => 'الأسبوع الحالي';

  @override
  String get essensplan_noMealPlan => 'لا توجد قائمة طعام';

  @override
  String get essensplan_noMealsPlanned =>
      'لم يتم تخطيط وجبات لهذا الأسبوع بعد.';

  @override
  String get essensplan_deleteMeal => 'حذف الوجبة';

  @override
  String get essensplan_formEditTitle => 'تعديل الوجبة';

  @override
  String get essensplan_formNewTitle => 'وجبة جديدة';

  @override
  String get essensplan_formDate => 'التاريخ';

  @override
  String get essensplan_formMealType => 'نوع الوجبة';

  @override
  String get essensplan_formDishName => 'اسم الطبق';

  @override
  String get essensplan_formDishNameRequired => 'يرجى إدخال اسم الطبق';

  @override
  String get essensplan_formDescription => 'الوصف (اختياري)';

  @override
  String get essensplan_formAllergens =>
      'مسببات الحساسية (لائحة الاتحاد الأوروبي 1169/2011)';

  @override
  String get essensplan_formVegetarian => 'نباتي';

  @override
  String get essensplan_formVegan => 'نباتي صرف';

  @override
  String get essensplan_formSave => 'حفظ الوجبة';

  @override
  String essensplan_allergenWarnings(int count) {
    return 'تحذيرات الحساسية ($count)';
  }

  @override
  String get essensplan_weekdayMonday => 'الإثنين';

  @override
  String get essensplan_weekdayTuesday => 'الثلاثاء';

  @override
  String get essensplan_weekdayWednesday => 'الأربعاء';

  @override
  String get essensplan_weekdayThursday => 'الخميس';

  @override
  String get essensplan_weekdayFriday => 'الجمعة';

  @override
  String get essensplan_weekdaySaturday => 'السبت';

  @override
  String get essensplan_weekdaySunday => 'الأحد';

  @override
  String get eltern_homeTitle => 'KitaFlow';

  @override
  String get eltern_homeMyChildren => 'أطفالي';

  @override
  String get eltern_homeNoChildren => 'لم يتم ربط أي أطفال بعد.';

  @override
  String get eltern_homeQuickActions => 'إجراءات سريعة';

  @override
  String get eltern_quickSickNote => 'إبلاغ مرضي';

  @override
  String get eltern_quickMessage => 'رسالة';

  @override
  String get eltern_quickCalendar => 'المواعيد';

  @override
  String get eltern_kindTitle => 'طفلي';

  @override
  String get eltern_kindTabProfile => 'الملف الشخصي';

  @override
  String get eltern_kindTabAttendance => 'الحضور';

  @override
  String get eltern_kindTabAllergies => 'الحساسيات';

  @override
  String get eltern_kindTabContacts => 'جهات الاتصال';

  @override
  String get eltern_kindNoChildSelected => 'لم يتم اختيار طفل.';

  @override
  String get eltern_kindBirthday => 'تاريخ الميلاد';

  @override
  String get eltern_kindGender => 'الجنس';

  @override
  String get eltern_kindStatus => 'الحالة';

  @override
  String get eltern_kindNoAllergies => 'لا توجد حساسيات مسجلة.';

  @override
  String get eltern_kindAllergiesTitle => 'الحساسيات وعدم التحمل';

  @override
  String get eltern_kindAttendanceTitle => 'الحضور';

  @override
  String get eltern_kindAttendanceLoading => 'جارٍ تحميل سجل الحضور...';

  @override
  String get eltern_kindNoContacts => 'لا توجد جهات اتصال مسجلة.';

  @override
  String get eltern_kindContactsTitle => 'جهات الاتصال';

  @override
  String get eltern_nachrichtenTitle => 'الرسائل';

  @override
  String get eltern_nachrichtenLoading => 'جارٍ تحميل الرسائل…';

  @override
  String get eltern_nachrichtenEmpty => 'لا توجد رسائل';

  @override
  String get eltern_nachrichtenEmptyDescription => 'لم تتلقَّ أي رسائل بعد.';

  @override
  String get termine_title => 'المواعيد';

  @override
  String get termine_noAppointments => 'لا توجد مواعيد.';

  @override
  String get termine_rsvpTitle => 'الرد على الدعوة';

  @override
  String termine_rsvpFor(String title) {
    return 'بخصوص: $title';
  }

  @override
  String get termine_weekdayMon => 'إث';

  @override
  String get termine_weekdayTue => 'ثل';

  @override
  String get termine_weekdayWed => 'أر';

  @override
  String get termine_weekdayThu => 'خم';

  @override
  String get termine_weekdayFri => 'جم';

  @override
  String get termine_weekdaySat => 'سب';

  @override
  String get termine_weekdaySun => 'أح';

  @override
  String get fotos_title => 'الصور';

  @override
  String get fotos_noPhotos => 'لا توجد صور بعد.';

  @override
  String get fotos_viewerTitle => 'صورة';

  @override
  String get push_title => 'الإشعارات الفورية';

  @override
  String get push_sectionNotifications => 'الإشعارات';

  @override
  String get push_messages => 'الرسائل';

  @override
  String get push_messagesDescription => 'الرسائل الجديدة والنشرات';

  @override
  String get push_attendance => 'الحضور';

  @override
  String get push_attendanceDescription => 'تغييرات في حالة الحضور';

  @override
  String get push_appointments => 'المواعيد';

  @override
  String get push_appointmentsDescription => 'مواعيد جديدة وتذكيرات';

  @override
  String get push_mealPlan => 'قائمة الطعام';

  @override
  String get push_mealPlanDescription => 'تغييرات في قائمة الطعام';

  @override
  String get push_emergency => 'طوارئ';

  @override
  String get push_emergencyDescription => 'إشعارات الطوارئ المهمة';

  @override
  String get push_sectionQuietHours => 'أوقات الهدوء';

  @override
  String get push_quietHoursDescription => 'لن تصلك إشعارات خلال هذه الفترة';

  @override
  String get push_quietHoursFrom => 'من';

  @override
  String get push_quietHoursTo => 'إلى';

  @override
  String get verwaltung_title => 'الإدارة';

  @override
  String get verwaltung_institution => 'المؤسسة';

  @override
  String get verwaltung_groupsTitle => 'المجموعات والفصول';

  @override
  String verwaltung_groupsCount(int count) {
    return '$count مجموعات';
  }

  @override
  String get verwaltung_staffTitle => 'الموظفون';

  @override
  String verwaltung_staffCount(int count) {
    return '$count موظفين';
  }

  @override
  String get verwaltung_groupsListTitle => 'المجموعات والفصول';

  @override
  String get verwaltung_groupsEmpty => 'لا توجد مجموعات.';

  @override
  String verwaltung_groupsOccupancyWithMax(int current, int max) {
    return 'الإشغال: $current / $max';
  }

  @override
  String verwaltung_groupsOccupancy(int count) {
    return 'الإشغال: $count أطفال';
  }

  @override
  String get verwaltung_groupsInactive => 'غير نشط';

  @override
  String get verwaltung_groupFormEditTitle => 'تعديل المجموعة';

  @override
  String get verwaltung_groupFormNewTitle => 'مجموعة جديدة';

  @override
  String get verwaltung_groupFormName => 'الاسم';

  @override
  String get verwaltung_groupFormNameRequired => 'الاسم مطلوب';

  @override
  String get verwaltung_groupFormType => 'النوع';

  @override
  String get verwaltung_groupFormTypeGroup => 'مجموعة';

  @override
  String get verwaltung_groupFormTypeClass => 'فصل';

  @override
  String get verwaltung_groupFormMaxChildren => 'الحد الأقصى للأطفال';

  @override
  String get verwaltung_groupFormAgeFrom => 'العمر من';

  @override
  String get verwaltung_groupFormAgeTo => 'العمر إلى';

  @override
  String get verwaltung_groupFormSchoolYear => 'السنة الدراسية';

  @override
  String get verwaltung_groupFormColor => 'اللون';

  @override
  String get verwaltung_groupFormActive => 'نشط';

  @override
  String get verwaltung_groupFormSave => 'حفظ';

  @override
  String get verwaltung_groupFormCreate => 'إنشاء';

  @override
  String get verwaltung_staffListTitle => 'الموظفون';

  @override
  String get verwaltung_staffEmpty => 'لا يوجد موظفون.';

  @override
  String get verwaltung_staffChangeRole => 'تغيير الدور';

  @override
  String get verwaltung_staffAssignGroup => 'تعيين مجموعة';

  @override
  String get verwaltung_staffRemove => 'إزالة';

  @override
  String get verwaltung_staffNoGroup => 'بدون مجموعة';

  @override
  String get verwaltung_staffRemoveTitle => 'إزالة الموظف';

  @override
  String verwaltung_staffRemoveConfirm(String name) {
    return 'هل تريد حقاً إزالة $name من المؤسسة؟';
  }

  @override
  String get verwaltung_staffFormTitle => 'إضافة موظف';

  @override
  String get verwaltung_staffFormEmail => 'البريد الإلكتروني';

  @override
  String get verwaltung_staffFormEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get verwaltung_staffFormEmailInvalid => 'بريد إلكتروني غير صالح';

  @override
  String get verwaltung_staffFormRole => 'الدور';

  @override
  String get verwaltung_staffFormGroup => 'المجموعة (اختياري)';

  @override
  String get verwaltung_staffFormNoGroup => 'بدون مجموعة';

  @override
  String get verwaltung_staffFormAdd => 'إضافة';

  @override
  String get verwaltung_staffFormInvitePending =>
      'سيتم تنفيذ دعوة الموظفين عبر البريد الإلكتروني في مرحلة لاحقة.';

  @override
  String get verwaltung_institutionFormTitle => 'تعديل المؤسسة';

  @override
  String get verwaltung_institutionFormSectionGeneral => 'عام';

  @override
  String get verwaltung_institutionFormName => 'اسم المؤسسة';

  @override
  String get verwaltung_institutionFormNameRequired => 'يرجى إدخال الاسم';

  @override
  String get verwaltung_institutionFormType => 'النوع';

  @override
  String get verwaltung_institutionFormTypeHint => 'اختيار نوع المؤسسة';

  @override
  String get verwaltung_institutionFormTypeRequired => 'يرجى اختيار النوع';

  @override
  String get verwaltung_institutionFormSectionAddress => 'العنوان';

  @override
  String get verwaltung_institutionFormStreet => 'الشارع ورقم المبنى';

  @override
  String get verwaltung_institutionFormZip => 'الرمز البريدي';

  @override
  String get verwaltung_institutionFormCity => 'المدينة';

  @override
  String get verwaltung_institutionFormState => 'الولاية';

  @override
  String get verwaltung_institutionFormSectionContact => 'التواصل';

  @override
  String get verwaltung_institutionFormPhone => 'الهاتف';

  @override
  String get verwaltung_institutionFormEmail => 'البريد الإلكتروني';

  @override
  String get verwaltung_institutionFormEmailInvalid =>
      'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get verwaltung_institutionFormWebsite => 'الموقع الإلكتروني';

  @override
  String get verwaltung_institutionFormSaveSuccess => 'تم حفظ المؤسسة بنجاح.';

  @override
  String get verwaltung_institutionFormSaveError => 'خطأ أثناء الحفظ.';

  @override
  String get verwaltung_institutionFormLoadError => 'خطأ أثناء التحميل.';

  @override
  String get enum_roleErzieher => 'مربي/ة';

  @override
  String get enum_roleLehrer => 'معلم/ة';

  @override
  String get enum_roleLeitung => 'إدارة';

  @override
  String get enum_roleTraeger => 'جهة راعية';

  @override
  String get enum_roleEltern => 'أولياء الأمور';

  @override
  String get enum_institutionTypeKrippe => 'حضانة';

  @override
  String get enum_institutionTypeKita => 'روضة أطفال';

  @override
  String get enum_institutionTypeGrundschule => 'مدرسة ابتدائية';

  @override
  String get enum_institutionTypeOgs => 'رعاية ما بعد المدرسة';

  @override
  String get enum_institutionTypeHort => 'نادي ما بعد المدرسة';

  @override
  String get enum_attendanceAnwesend => 'حاضر';

  @override
  String get enum_attendanceAbwesend => 'غائب';

  @override
  String get enum_attendanceKrank => 'مريض';

  @override
  String get enum_attendanceUrlaub => 'إجازة';

  @override
  String get enum_attendanceEntschuldigt => 'معذور';

  @override
  String get enum_attendanceUnentschuldigt => 'غير معذور';

  @override
  String get enum_messageTypeNachricht => 'رسالة';

  @override
  String get enum_messageTypeElternbrief => 'نشرة أولياء الأمور';

  @override
  String get enum_messageTypeAnkuendigung => 'إعلان';

  @override
  String get enum_messageTypeNotfall => 'طوارئ';

  @override
  String get enum_childStatusAktiv => 'نشط';

  @override
  String get enum_childStatusEingewoehnung => 'فترة التأقلم';

  @override
  String get enum_childStatusAbgemeldet => 'مسجّل الخروج';

  @override
  String get enum_childStatusWarteliste => 'قائمة الانتظار';

  @override
  String get enum_mealTypeFruehstueck => 'فطور';

  @override
  String get enum_mealTypeMittagessen => 'غداء';

  @override
  String get enum_mealTypeSnack => 'وجبة خفيفة';

  @override
  String get enum_developmentMotorik => 'المهارات الحركية';

  @override
  String get enum_developmentSprache => 'اللغة';

  @override
  String get enum_developmentSozialverhalten => 'السلوك الاجتماعي';

  @override
  String get enum_developmentKognitiv => 'التطور المعرفي';

  @override
  String get enum_developmentEmotional => 'التطور العاطفي';

  @override
  String get enum_developmentKreativitaet => 'الإبداع';

  @override
  String get enum_allergenGluten => 'الغلوتين';

  @override
  String get enum_allergenKrebstiere => 'القشريات';

  @override
  String get enum_allergenEier => 'البيض';

  @override
  String get enum_allergenFisch => 'السمك';

  @override
  String get enum_allergenErdnuesse => 'الفول السوداني';

  @override
  String get enum_allergenSoja => 'الصويا';

  @override
  String get enum_allergenMilch => 'الحليب';

  @override
  String get enum_allergenSchalenfruechte => 'المكسرات';

  @override
  String get enum_allergenSellerie => 'الكرفس';

  @override
  String get enum_allergenSenf => 'الخردل';

  @override
  String get enum_allergenSesam => 'السمسم';

  @override
  String get enum_allergenSchwefeldioxid => 'ثاني أكسيد الكبريت';

  @override
  String get enum_allergenLupinen => 'الترمس';

  @override
  String get enum_allergenWeichtiere => 'الرخويات';

  @override
  String get enum_allergySeverityLeicht => 'خفيف';

  @override
  String get enum_allergySeverityMittel => 'متوسط';

  @override
  String get enum_allergySeveritySchwer => 'شديد';

  @override
  String get enum_allergySeverityLebensbedrohlich => 'مهدد للحياة';

  @override
  String get enum_documentTypeVertrag => 'عقد';

  @override
  String get enum_documentTypeEinverstaendnis => 'إقرار موافقة';

  @override
  String get enum_documentTypeAttest => 'شهادة طبية';

  @override
  String get enum_documentTypeZeugnis => 'شهادة';

  @override
  String get enum_documentTypeSonstiges => 'أخرى';

  @override
  String get enum_nachrichtenTabPosteingang => 'صندوق الوارد';

  @override
  String get enum_nachrichtenTabGesendet => 'المرسلة';

  @override
  String get enum_nachrichtenTabWichtig => 'مهمة';

  @override
  String get enum_terminTypAllgemein => 'عام';

  @override
  String get enum_terminTypElternabend => 'اجتماع أولياء الأمور';

  @override
  String get enum_terminTypFestFeier => 'حفل/احتفال';

  @override
  String get enum_terminTypSchliessung => 'إغلاق';

  @override
  String get enum_terminTypAusflug => 'رحلة';

  @override
  String get enum_terminTypSonstiges => 'أخرى';

  @override
  String get enum_rsvpZugesagt => 'تأكيد الحضور';

  @override
  String get enum_rsvpAbgesagt => 'اعتذار';

  @override
  String get enum_rsvpVielleicht => 'ربما';

  @override
  String get enum_elternBeziehungMutter => 'أم';

  @override
  String get enum_elternBeziehungVater => 'أب';

  @override
  String get enum_elternBeziehungSorgeberechtigt => 'ولي أمر';

  @override
  String get dashboard_monthJanuar => 'يناير';

  @override
  String get dashboard_monthFebruar => 'فبراير';

  @override
  String get dashboard_monthMaerz => 'مارس';

  @override
  String get dashboard_monthApril => 'أبريل';

  @override
  String get dashboard_monthMai => 'مايو';

  @override
  String get dashboard_monthJuni => 'يونيو';

  @override
  String get dashboard_monthJuli => 'يوليو';

  @override
  String get dashboard_monthAugust => 'أغسطس';

  @override
  String get dashboard_monthSeptember => 'سبتمبر';

  @override
  String get dashboard_monthOktober => 'أكتوبر';

  @override
  String get dashboard_monthNovember => 'نوفمبر';

  @override
  String get dashboard_monthDezember => 'ديسمبر';

  @override
  String get dashboard_weekdayMontag => 'الإثنين';

  @override
  String get dashboard_weekdayDienstag => 'الثلاثاء';

  @override
  String get dashboard_weekdayMittwoch => 'الأربعاء';

  @override
  String get dashboard_weekdayDonnerstag => 'الخميس';

  @override
  String get dashboard_weekdayFreitag => 'الجمعة';

  @override
  String get dashboard_weekdaySamstag => 'السبت';

  @override
  String get dashboard_weekdaySonntag => 'الأحد';

  @override
  String get verwaltung_rolleDropdownErzieher => 'مربي/ة';

  @override
  String get verwaltung_rolleDropdownLehrer => 'معلم/ة';

  @override
  String get verwaltung_rolleDropdownLeitung => 'إدارة';

  @override
  String get common_language => 'اللغة';

  @override
  String get dokumente_title => 'المستندات';

  @override
  String get dokumente_noDocuments => 'لا توجد مستندات بعد.';

  @override
  String get dokumente_upload => 'رفع';

  @override
  String get dokumente_download => 'تنزيل';

  @override
  String get dokumente_delete => 'حذف المستند';

  @override
  String get dokumente_deleteConfirm => 'هل تريد حقاً حذف هذا المستند؟';

  @override
  String get dokumente_filterAll => 'الكل';

  @override
  String get dokumente_signed => 'موقّع';

  @override
  String get dokumente_unsigned => 'غير موقّع';

  @override
  String dokumente_signedBy(String name, String date) {
    return 'وقّعه $name في $date';
  }

  @override
  String dokumente_validUntil(String date) {
    return 'صالح حتى $date';
  }

  @override
  String get dokumente_expired => 'منتهي الصلاحية';

  @override
  String get dokumente_sign => 'توقيع';

  @override
  String get dokumente_signTitle => 'توقيع المستند';

  @override
  String get dokumente_signClear => 'مسح';

  @override
  String get dokumente_signConfirm => 'تأكيد التوقيع';

  @override
  String get dokumente_signHint => 'وقّع هنا';

  @override
  String get dokumente_uploadSuccess => 'تم رفع المستند بنجاح.';

  @override
  String get dokumente_uploadError => 'خطأ أثناء رفع المستند.';

  @override
  String get dokumente_deleteSuccess => 'تم حذف المستند بنجاح.';

  @override
  String get dokumente_signSuccess => 'تم توقيع المستند بنجاح.';

  @override
  String get dokumente_pdfGenerate => 'إنشاء PDF';

  @override
  String get dokumente_pdfPreview => 'معاينة PDF';

  @override
  String get dokumente_formTitle => 'مستند جديد';

  @override
  String get dokumente_formTitel => 'العنوان';

  @override
  String get dokumente_formTyp => 'نوع المستند';

  @override
  String get dokumente_formBeschreibung => 'الوصف';

  @override
  String get dokumente_formGueltigBis => 'صالح حتى';

  @override
  String get dokumente_formKind => 'تعيين لطفل';

  @override
  String get dokumente_formKindOptional => 'بدون طفل (عام)';

  @override
  String get dokumente_formFile => 'ملف';

  @override
  String get dokumente_formFileSelect => 'اختيار ملف';

  @override
  String dokumente_formFileSelected(String filename) {
    return 'تم اختيار الملف: $filename';
  }

  @override
  String dokumente_count(int count) {
    return '$count مستندات';
  }

  @override
  String get verwaltung_dokumenteTile => 'المستندات';

  @override
  String get verwaltung_eingewoehnungTile => 'التأقلم';

  @override
  String get eingewoehnung_title => 'التأقلم';

  @override
  String get eingewoehnung_subtitle => 'إدارة مرحلة التأقلم';

  @override
  String eingewoehnung_count(int count) {
    return '$count تأقلمات';
  }

  @override
  String get eingewoehnung_startdatum => 'تاريخ البدء';

  @override
  String get eingewoehnung_bezugsperson => 'الشخص المرجعي';

  @override
  String get eingewoehnung_phasenFortschritt => 'تقدم المراحل';

  @override
  String get eingewoehnung_naechstePhase => 'المرحلة التالية';

  @override
  String get eingewoehnung_phaseAendern => 'تغيير المرحلة';

  @override
  String get eingewoehnung_neueNotiz => 'ملاحظة يومية جديدة';

  @override
  String get eingewoehnung_dauer => 'المدة (بالدقائق)';

  @override
  String get eingewoehnung_trennungsverhalten => 'سلوك الانفصال';

  @override
  String get eingewoehnung_essen => 'الأكل';

  @override
  String get eingewoehnung_schlaf => 'النوم';

  @override
  String get eingewoehnung_spiel => 'اللعب';

  @override
  String get eingewoehnung_stimmung => 'المزاج';

  @override
  String get eingewoehnung_notizenIntern => 'ملاحظات داخلية';

  @override
  String get eingewoehnung_notizenEltern => 'ملاحظات للوالدين';

  @override
  String get eingewoehnung_notizenElternHinweis =>
      'هذه الملاحظة مرئية للوالدين.';

  @override
  String get eingewoehnung_keineTagesnotizen => 'لا توجد ملاحظات يومية بعد.';

  @override
  String get eingewoehnung_elternFeedback => 'ملاحظات الوالدين';

  @override
  String get eingewoehnung_feedbackFrage => 'كيف تختبرون مرحلة تأقلم طفلكم؟';

  @override
  String eingewoehnung_tage(int count) {
    return '$count أيام';
  }

  @override
  String get eingewoehnung_notizGespeichert => 'تم حفظ الملاحظة اليومية.';

  @override
  String get eingewoehnung_phaseGeaendert => 'تم تغيير المرحلة بنجاح.';

  @override
  String get eingewoehnung_feedbackGespeichert => 'تم حفظ الملاحظات.';

  @override
  String get eingewoehnung_keineAktiven => 'لا توجد تأقلمات نشطة.';

  @override
  String get eingewoehnung_neueEingewoehnung => 'تأقلم جديد';

  @override
  String get eingewoehnung_kindAuswaehlen => 'اختيار الطفل';

  @override
  String get eingewoehnung_nurEingewoehnung => 'فقط الأطفال بحالة ‚التأقلم\'';

  @override
  String get enum_phaseGrundphase => 'المرحلة الأساسية';

  @override
  String get enum_phaseStabilisierung => 'الاستقرار';

  @override
  String get enum_phaseSchlussphase => 'المرحلة النهائية';

  @override
  String get enum_phaseAbgeschlossen => 'مكتمل';

  @override
  String get enum_stimmungSehrGut => 'جيد جداً';

  @override
  String get enum_stimmungGut => 'جيد';

  @override
  String get enum_stimmungNeutral => 'محايد';

  @override
  String get enum_stimmungSchlecht => 'سيئ';

  @override
  String get enum_stimmungSehrSchlecht => 'سيئ جداً';
}

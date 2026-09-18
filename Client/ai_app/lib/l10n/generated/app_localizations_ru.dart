// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'REEL — AI Кино- и Фотостудия';

  @override
  String get languageLabel => 'Язык';

  @override
  String get languagePickerTooltip => 'Выбрать язык интерфейса';

  @override
  String get signIn => 'ВОЙТИ';

  @override
  String get signUp => 'РЕГИСТРАЦИЯ';

  @override
  String get getStarted => 'Начать';

  @override
  String get forgot => 'ЗАБЫЛИ';

  @override
  String get resetPassword => 'СБРОС ПАРОЛЯ';

  @override
  String get newPassword => 'НОВЫЙ ПАРОЛЬ';

  @override
  String get credentialsBadge => 'УЧЁТНЫЕ ДАННЫЕ';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · ДОСТУП $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'ВОЙТИ';

  @override
  String get productionAccessRollSignUp => 'РЕГИСТРАЦИЯ';

  @override
  String get productionAccessRollReset => 'СБРОС ПАРОЛЯ';

  @override
  String get productionAccessRollNewPassword => 'НОВЫЙ ПАРОЛЬ';

  @override
  String get authHeadlineSignIn => 'Каждой сцене';

  @override
  String get authHeadlineSignInItalic => 'нужна команда.';

  @override
  String get authSubheadSignIn =>
      'Войдите, чтобы продолжать творить, сохранять работы и управлять своим роллом.';

  @override
  String get authHeadlineSignUp => 'Присоединяйтесь к';

  @override
  String get authHeadlineSignUpItalic => 'производству.';

  @override
  String get authSubheadSignUp =>
      'Создайте аккаунт, чтобы сохранять роллы, следить за ежедневным числом кадров и возвращаться, когда приходит вдохновение.';

  @override
  String get authHeadlineForgot => 'Потеряли';

  @override
  String get authHeadlineForgotItalic => 'плёнку?';

  @override
  String get authSubheadForgot =>
      'Введите ваш email, и мы отправим ссылку для сброса пароля.';

  @override
  String get authHeadlineReset => 'Сделайте';

  @override
  String get authHeadlineResetItalic => 'новый дубль.';

  @override
  String get authSubheadReset =>
      'Создайте новый пароль, чтобы вернуться в своё творческое пространство.';

  @override
  String get inputEmail => 'EMAIL';

  @override
  String get inputEmailHint => 'you@example.com';

  @override
  String get inputPassword => 'ПАРОЛЬ';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'Минимум 8 символов';

  @override
  String get inputFullName => 'ОТОБРАЖАЕМОЕ ИМЯ';

  @override
  String get inputFullNameHint => 'Режиссёр этого ролла';

  @override
  String get inputConfirmPassword => 'ПОДТВЕРЖДЕНИЕ ПАРОЛЯ';

  @override
  String get inputConfirmPasswordHint => 'Введите пароль ещё раз';

  @override
  String get inputResetCode => 'КОД СБРОСА';

  @override
  String get inputResetCodeHint => 'Вставьте код из email';

  @override
  String get inputNewPassword => 'НОВЫЙ ПАРОЛЬ';

  @override
  String get inputNewPasswordHint => 'Минимум 8 символов';

  @override
  String get inputNewPasswordConfirmHint => 'Введите новый пароль ещё раз';

  @override
  String get inputAvatarUrl => 'URL АВАТАРА (НЕОБЯЗАТЕЛЬНО)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Полное имя';

  @override
  String get inputFullNameEditHint => 'Введите ваше полное имя';

  @override
  String get toggleShowPassword => 'Показать пароль';

  @override
  String get toggleHidePassword => 'Скрыть пароль';

  @override
  String get rememberMe => 'Запомнить меня';

  @override
  String get forgotPasswordLink => 'Забыли пароль?';

  @override
  String get signInButton => 'ВОЙТИ В РОЛЛ ►';

  @override
  String get signUpButton => 'НАЧАТЬ РОЛЛ ►';

  @override
  String get forgotButton => 'ОТПРАВИТЬ ССЫЛКУ ►';

  @override
  String get resetPasswordButton => 'СМЕНИТЬ ПАРОЛЬ ►';

  @override
  String get orDivider => 'ИЛИ';

  @override
  String get noAccountPrompt => 'Нет аккаунта? ';

  @override
  String get noAccountLink => 'Зарегистрироваться';

  @override
  String get hasAccountPrompt => 'Уже есть аккаунт? ';

  @override
  String get hasAccountLink => 'Войти';

  @override
  String get forgotRememberedPrompt => 'Вспомнили пароль? ';

  @override
  String get forgotRememberedLink => 'Назад ко входу';

  @override
  String get resetRememberedPrompt => 'Вспомнили пароль? ';

  @override
  String get resetRememberedLink => 'Назад ко входу';

  @override
  String get agreeTermsPrefix => 'Я согласен с ';

  @override
  String get agreeTermsLink => 'Условиями производства';

  @override
  String get agreeTermsSemantic => 'Я согласен с Условиями производства';

  @override
  String get forgotDescription =>
      'Введите email, который вы использовали при регистрации. Код сброса действует 30 минут.';

  @override
  String get statsFooter => 'ВАША СЛЕДУЮЩАЯ СЦЕНА НАЧИНАЕТСЯ ЗДЕСЬ';

  @override
  String get errorEmailPasswordRequired =>
      'Пожалуйста, введите email и пароль.';

  @override
  String get errorAllFieldsRequired => 'Пожалуйста, заполните все поля.';

  @override
  String get errorPasswordTooShort =>
      'Пароль должен содержать минимум 8 символов.';

  @override
  String get errorPasswordMismatch => 'Пароли не совпадают.';

  @override
  String get errorAcceptTerms => 'Пожалуйста, примите условия производства.';

  @override
  String get errorEmailRequired => 'Пожалуйста, введите email.';

  @override
  String get errorResetCodeRequired =>
      'Код сброса обязателен, пароль должен содержать минимум 8 символов.';

  @override
  String get errorGeneric => 'Не удалось подключиться к серверу.';

  @override
  String get errorInvalidEmail =>
      'Введите действительный адрес электронной почты.';

  @override
  String get errorInvalidAvatarUrl =>
      'URL аватара должен начинаться с http:// или https://.';

  @override
  String get errorSignInFailed => 'Неверный email или пароль.';

  @override
  String get errorSignUpFailed => 'Регистрация не удалась.';

  @override
  String get errorForgotFailed =>
      'Не удалось создать ссылку для сброса пароля.';

  @override
  String get errorResetFailed => 'Не удалось сбросить пароль.';

  @override
  String get errorFullNameRequired => 'Пожалуйста, введите полное имя.';

  @override
  String get successSignUp => 'Регистрация прошла успешно! Войдите.';

  @override
  String get successResetPassword => 'Пароль успешно изменён.';

  @override
  String get successForgotEmail => 'Если email существует, ссылка отправлена.';

  @override
  String get successProfileSaved => 'Профиль обновлён!';

  @override
  String get successPasswordChanged => 'Пароль изменён! Войдите снова.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'Не удалось загрузить профиль: $message';
  }

  @override
  String get explore => 'Обзор';

  @override
  String get gallery => 'Галерея';

  @override
  String get faq => 'Вопросы';

  @override
  String get pricing => 'Цены';

  @override
  String get loginPrompt => 'Войдите, прежде чем создавать изображение.';

  @override
  String get emptyPrompt => 'Введите запрос перед нажатием Action.';

  @override
  String get imageOnlySupported =>
      'REEL сейчас поддерживает только text-to-image. Выберите Photo.';

  @override
  String get imageGenerationFailed =>
      'Не удалось создать изображение. Проверьте сервер и модель.';

  @override
  String get noImageReturned => 'Модель не вернула изображение.';

  @override
  String get videoDurationLabel => 'ДЛИТЕЛЬНОСТЬ';

  @override
  String get videoQualityLabel => 'КАЧЕСТВО';

  @override
  String get videoQueuedMessage =>
      'Видео рендерится — это займёт несколько минут. Результат появится здесь.';

  @override
  String get videoGenerationFailed =>
      'Не удалось создать видео. Ваши кредиты были возвращены.';

  @override
  String get videoTimeoutMessage =>
      'Видео занимает больше времени, чем ожидалось. Скоро проверьте «Мой ролл» в профиле.';

  @override
  String get videoReadyLabel => 'Ваше видео готово';

  @override
  String get usageLabelSignedOut => 'Войдите, чтобы начать';

  @override
  String get rtlToggleTooltip => 'Переключить направление LTR / RTL';

  @override
  String get footerTagline =>
      'REEL — создано в темноте, по одному кадру за раз. Превратите строку текста в кадр.';

  @override
  String get productColumn => 'ПРОДУКТ';

  @override
  String get supportColumn => 'ПОДДЕРЖКА';

  @override
  String get signInLink => 'Войти';

  @override
  String get signUpLink => 'Регистрация';

  @override
  String get footerCaption1 =>
      'REEL — СОЗДАНО В ТЕМНОТЕ. ПО ОДНОМУ КАДРУ ЗА РАЗ.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Введите сцену.';

  @override
  String get getTheTake => 'Получите кадр.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Превратите строку текста в кадр — с рамкой, светом и движением за секунды. Видео или фото, один ролл.';

  @override
  String get homeStatLastTake => 'ПОСЛЕДНИЙ КАДР';

  @override
  String get homeStatAspectRatios => 'СООТНОШЕНИЯ';

  @override
  String get homeStatFilmStocks => 'ПЛЁНКИ';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'Опишите вашу сценÑƒ…';

  @override
  String get homeQuickChips =>
      'Бал-маскарад под люстрами | Всадник в песчаной буре | Мастерская марионеток';

  @override
  String get homeStock => 'ПЛЁНКА';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'Создаём кадÑ€…';

  @override
  String get homeGenerate => 'Создать';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Кадр готов · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => 'Не удалось загрузить результат.';

  @override
  String get homeGenerationOpenOriginal => 'Открыть оригинал';

  @override
  String get homeGenerationRegenerate => 'Пересоздать';

  @override
  String get homeGenerationOpenFailed => 'Не удалось открыть оригинал.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'Одна строка текста. Одна готовая сцена.';

  @override
  String get showcaseSubtitle =>
      'Смотрите, как REEL шаг за шагом превращает описание в реальный кадр.';

  @override
  String get showcasePrompt1 =>
      '\"астронавт серфит по красным дюнам Марса, золотой час, широкий план\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"бал-маскарад под люстрами, медленное движение камеры\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"всадник верхом в пыльной буре на закате, трекинг\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Четыре инструмента, один кадр';

  @override
  String get featuresSubtitle =>
      'Всё, что нужно, чтобы пройти путь от строки текста до готового кадра.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Свет, движение камеры и киноязык, выученные на миллионах реальных кадров.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 для широкого экрана, 1:1 для ленты, 9:16 для stories — без переделки с нуля.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — выберите фактуру до нажатия Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'Тот же запрос, та же студия. Фото сейчас; видео — когда будет готово.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Частые вопросы';

  @override
  String get faqSubtitle =>
      'Если остались вопросы, просто напишите команде REEL.';

  @override
  String get faqQ1 => 'Как работает REEL?';

  @override
  String get faqA1 =>
      'Введите описание, выберите соотношение кадра и плёнку. REEL создаёт изображение по нему. Видео в разработке.';

  @override
  String get faqQ2 => 'Чем REEL отличается от других AI-инструментов?';

  @override
  String get faqA2 =>
      'REEL фокусируется на киноязыке — свете, кадрировании и фактуре плёнки — в одной студии.';

  @override
  String get faqQ3 => 'Сколько бесплатных кадров я получаю?';

  @override
  String get faqA3 =>
      'Текущая квота и остаток кредитов отображаются в студии после входа. Смотрите тарифы для активных привилегий.';

  @override
  String get faqQ4 => 'Какие форматы и разрешения поддерживаются?';

  @override
  String get faqA4 =>
      'Изображения поддерживают три соотношения — 16:9, 1:1 и 9:16. Размер зависит от текущей конфигурации.';

  @override
  String get faqQ5 => 'Можно ли использовать результаты в коммерческих целях?';

  @override
  String get faqA5 =>
      'Проверьте Условия производства и привилегии выбранного тарифа перед коммерческим использованием.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Выберите свой темп съёмки';

  @override
  String get plansSubtitle =>
      'Начните бесплатно, переходите выше, когда ролл должен идти дольше.';

  @override
  String get ctaReady => 'Готов к своему';

  @override
  String get ctaReadyItalic => 'первому кадру?';

  @override
  String get ctaBody => 'Бесплатно, без карты — первый кадр за минуту.';

  @override
  String get ctaFreeButton => 'Создать бесплатный аккаунт';

  @override
  String get ctaGalleryButton => 'Открыть галерею';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Свежие кадры';

  @override
  String get contactSheetSubtitle =>
      'Несколько сцен, только что смонтированных сообществом REEL.';

  @override
  String get contactSheetDialogTitle => 'Превью визуального стиля.';

  @override
  String get contactSheetDialogBody => 'Создайте свой кадр в студии.';

  @override
  String get contactSheetClose => 'Закрыть';

  @override
  String get pricingTitle => 'ЦЕНЫ';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Выберите свой темп съёмки';

  @override
  String get pricingSubheading =>
      'Начните бесплатно, переходите выше, когда ролл должен идти дольше.';

  @override
  String get pricingEmpty => 'Сейчас нет активных пакетов.';

  @override
  String get pricingBuyButton => 'КУПИТЬ ПАКЕТ';

  @override
  String get pricingFreeCta => 'Использовать бесплатно';

  @override
  String get pricingSignInFirst => 'Войдите перед покупкой пакета.';

  @override
  String get pricingLoadFailed => 'Не удалось загрузить список пакетов.';

  @override
  String get pricingStripeOpenFailed => 'Не удалось открыть страницу Stripe.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout открыт. Кредиты добавятся автоматически после успешной оплаты.';

  @override
  String get pricingCreditsSuffix => ' КРЕДИТОВ';

  @override
  String get pricingCreditsPerMonth => 'кредитов в месяц';

  @override
  String get pricingPeriodMonthly => '/месяц';

  @override
  String get pricingPeriodYearly => '/год';

  @override
  String get pricingFreePerk =>
      '25 бесплатных кредитов при регистрации — попробуйте студию без риска.';

  @override
  String get profileTitle => 'МОЙ ПРОФИЛЬ';

  @override
  String profileLoadFailed(Object message) {
    return 'Не удалось загрузить профиль: $message';
  }

  @override
  String get profileNotLoaded => 'Не удалось загрузить профиль';

  @override
  String get profileEditButton => 'РЕДАКТИРОВАТЬ';

  @override
  String get profileChangePasswordButton => 'СМЕНИТЬ ПАРОЛЬ';

  @override
  String get profileUsageSection => 'ИСПОЛЬЗОВАНИЕ И КРЕДИТЫ';

  @override
  String get profileCreditBalance => 'Баланс кредитов';

  @override
  String get profileDailyUsage => 'Использовано сегодня';

  @override
  String get profileAccountSection => 'ИНФО АККАУНТА';

  @override
  String get profileUserId => 'ID пользователя';

  @override
  String get profileStatus => 'Статус';

  @override
  String get profileStatusActive => 'Активен';

  @override
  String get profileStatusInactive => 'Неактивен';

  @override
  String get profileMemberSince => 'С нами с';

  @override
  String get profileUnknownName => 'Неизвестно';

  @override
  String get profileUnknownEmail => 'Email отсутствует';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'РЕДАКТИРОВАТЬ';

  @override
  String get editProfileSubhead => 'Обновите информацию профиля';

  @override
  String get editProfileSave => 'СОХРАНИТЬ';

  @override
  String editProfileLoadFailed(Object message) {
    return 'Не удалось загрузить профиль: $message';
  }

  @override
  String get editProfileSaveFailed => 'Не удалось обновить профиль';

  @override
  String get changePasswordTitle => 'СМЕНИТЬ ПАРОЛЬ';

  @override
  String get changePasswordSubhead => 'Введите текущий пароль и выберите новый';

  @override
  String get changePasswordCurrent => 'Текущий пароль';

  @override
  String get changePasswordNew => 'Новый пароль';

  @override
  String get changePasswordConfirm => 'Подтвердите новый пароль';

  @override
  String get changePasswordCurrentRequired => 'Введите текущий пароль';

  @override
  String get changePasswordNewRequired => 'Введите новый пароль';

  @override
  String get changePasswordTooShort =>
      'Пароль должен содержать минимум 8 символов';

  @override
  String get changePasswordConfirmRequired => 'Подтвердите новый пароль';

  @override
  String get changePasswordMismatch => 'Пароли не совпадают';

  @override
  String get changePasswordSubmit => 'СМЕНИТЬ ПАРОЛЬ';

  @override
  String get changePasswordFailed => 'Не удалось сменить пароль';

  @override
  String get libraryTitle => 'Библиотека';

  @override
  String get libraryTabGenerations => 'ГЕНЕРАЦИИ';

  @override
  String get libraryTabCredits => 'КРЕДИТЫ';

  @override
  String get libraryTabPayments => 'ПЛАТЕЖИ';

  @override
  String get libraryReload => 'Обновить';

  @override
  String get librarySignInPrompt => 'ВОЙТИ, ЧТОБЫ УВИДЕТЬ БИБЛИОТЕКУ';

  @override
  String get libraryRetry => 'ПОВТОРИТЬ';

  @override
  String get libraryLoadFailed => 'Не удалось загрузить библиотеку.';

  @override
  String get libraryEmptyGenerations => 'Вы ещё не создавали изображения.';

  @override
  String get libraryEmptyCredits => 'Кредитных операций пока нет.';

  @override
  String get libraryEmptyPayments => 'Платежей пока нет.';

  @override
  String get libraryDeleteDialogTitle => 'Удалить генерацию?';

  @override
  String get libraryDeleteDialogBody =>
      'Удалить эту генерацию? Действие необратимо.';

  @override
  String get libraryDeleteCancel => 'ОТМЕНА';

  @override
  String get libraryDeleteConfirm => 'УДАЛИТЬ';

  @override
  String get libraryDeleteSuccess => 'Генерация удалена';

  @override
  String get libraryDeleteFailed => 'Не удалось удалить генерацию';

  @override
  String get libraryStatusCompleted => 'Готово';

  @override
  String get libraryStatusFailed => 'Ошибка';

  @override
  String get libraryStatusProcessing => 'В обработке';

  @override
  String get libraryStatusPending => 'В ожидании';

  @override
  String get paymentResultSuccess => 'ОПЛАТА УСПЕШНА';

  @override
  String get paymentResultCancel => 'ОПЛАТА ОТМЕНЕНА';

  @override
  String get paymentResultError => 'ОПЛАТА НЕ УДАЛАСЬ';

  @override
  String get paymentResultSuccessMsg =>
      'Платёж успешно обработан. Кредиты добавлены на ваш аккаунт.';

  @override
  String get paymentResultCancelMsg =>
      'Вы отменили платёж. Средства не списывались.';

  @override
  String get paymentResultErrorMsg =>
      'При обработке платежа произошла ошибка. Попробуйте снова или свяжитесь с поддержкой.';

  @override
  String get paymentResultLoadFailed =>
      'Не удалось загрузить информацию об оплате';

  @override
  String get paymentDetailPackage => 'Пакет';

  @override
  String get paymentDetailCredits => 'Кредиты';

  @override
  String get paymentDetailAmount => 'Сумма';

  @override
  String get paymentDetailTransaction => 'Транзакция';

  @override
  String get paymentBackHome => 'НА ГЛАВНУЮ';

  @override
  String get paymentTryAgain => 'ПОВТОРИТЬ';

  @override
  String get termsEyebrow => 'ЮРИДИЧЕСКАЯ ИНФОРМАЦИЯ';

  @override
  String get termsHeadline => 'Условия использования';

  @override
  String get termsSubhead =>
      'Последнее обновление: 10.09.2026 · Применяется ко всему сервису REEL';

  @override
  String get termsBackShort => 'НАЗАД';

  @override
  String get termsBackLong => 'НА ГЛАВНУЮ';

  @override
  String get termsFooterText => 'REEL — СОЗДАНО В ТЕМНОТЕ. КАДР ЗА КАДРОМ.';

  @override
  String get termsAccept => 'Я СОГЛАСЕН';

  @override
  String get termsDecline => 'НАЗАД';

  @override
  String get adminDashboardTitle => 'Панель администратора';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Обзор';

  @override
  String get adminSidebarGenerations => 'Generations';

  @override
  String get adminSidebarUsers => 'Пользователи';

  @override
  String get adminSidebarPayments => 'Платежи';

  @override
  String get adminSidebarSettings => 'Настройки';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Администратор';

  @override
  String get adminMenuTooltip => 'Открыть меню';

  @override
  String get adminRtlTooltip => 'Переключить направление LTR / RTL';

  @override
  String get adminRefreshTooltip => 'Обновить';

  @override
  String get adminSearchUsersHint => 'Поиск пользователей…';

  @override
  String get adminExportTooltip => 'Экспортировать отчёт';

  @override
  String get adminExportLabel => 'ЭКСПОРТ';

  @override
  String get adminExportComingSoon => 'Экспорт отчётов появится скоро.';

  @override
  String get adminNotificationsTooltip => 'Уведомления';

  @override
  String get adminRangeLabel => 'Диапазон';

  @override
  String get adminRangeToday => 'Сегодня';

  @override
  String get adminRange7Days => '7 дней';

  @override
  String get adminRange30Days => '30 дней';

  @override
  String get adminRangeTodayLong => 'сегодня';

  @override
  String get adminRange7DaysLong => 'за 7 дней';

  @override
  String get adminRange30DaysLong => 'за 30 дней';

  @override
  String get adminAutoUpdateNote => 'Автообновление ежедневно в 00:00';

  @override
  String adminKpiTakes(Object range) {
    return 'Кадры $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Активные пользователи — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Выручка — $range';
  }

  @override
  String get adminKpiQueue => 'Очередь рендера';

  @override
  String get adminDailyOutputTitle => 'Выпуск за 7 дней';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return '$ratio16x9 занимает 58% рендеров этой недели, затем 1:1 (24%) и 9:16 (18%).';
  }

  @override
  String get adminStockMixTitle => 'Соотношение стилей';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Недавние рендеры';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Пользователи';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Открыть список';

  @override
  String get adminFleetTitle => 'Очередь и GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter =>
      '3/5 воркеров работают · 1 на обслуживании · 1 простаивает';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'Обработка — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Простой — ждёт следующее задание';

  @override
  String get adminFleetJobMaintenance => 'Плановое обслуживание';

  @override
  String get adminGenerationCompleted => 'Готово';

  @override
  String get adminGenerationProcessing => 'Рендерится';

  @override
  String get adminGenerationFailed => 'Ошибка';

  @override
  String get adminUserStatusActive => 'Активен';

  @override
  String get adminUserStatusInactive => 'Неактивен';

  @override
  String get adminUserStatusBanned => 'Заблокирован';

  @override
  String get adminUserRoleAdmin => 'Админ';

  @override
  String get adminUserRoleUser => 'Пользователь';

  @override
  String get adminSettingsTitle => 'Настройки';

  @override
  String get adminSettingsStudioName => 'Отображаемое имя студии';

  @override
  String get adminSettingsSupportEmail => 'Email поддержки';

  @override
  String get adminSettingsImageCost => 'Стоимость изображения в кредитах';

  @override
  String get adminSettingsVideoCost => 'Стоимость видео в кредитах';

  @override
  String get adminSettingsAlerts => 'Уведомления';

  @override
  String get adminSettingsAlertPayment => 'Уведомлять о неудачных платежах';

  @override
  String get adminSettingsAlertGeneration =>
      'Уведомлять о неудачных генерациях';

  @override
  String get adminSettingsNewsletter => 'Отправлять рассылку';

  @override
  String get adminSettingsMaintenance => 'Режим обслуживания';

  @override
  String get adminSettingsRegistration => 'Разрешить новые регистрации';

  @override
  String get adminSettingsSave => 'СОХРАНИТЬ';

  @override
  String get adminSettingsLoadFailed => 'Не удалось загрузить настройки.';

  @override
  String get adminSettingsSaved => 'Настройки сохранены.';

  @override
  String get adminSettingsSaveFailed => 'Не удалось сохранить настройки.';

  @override
  String get adminPackagesTitle => 'Платежные пакеты';

  @override
  String get adminPackagesEmpty => 'Платежных пакетов пока нет.';

  @override
  String get adminPackagesLoadFailed =>
      'Не удалось загрузить платежные пакеты.';

  @override
  String get adminPackagesNew => 'Новый пакет';

  @override
  String get adminPackagesFeatured => 'Рекомендуемый';

  @override
  String get adminPackagesInactive => 'Неактивен';

  @override
  String get adminPackagesActive => 'Активен';

  @override
  String get adminPaymentsTitle => 'Платежи';

  @override
  String get adminPaymentsEmpty => 'Платежей пока нет.';

  @override
  String get adminPaymentsLoadFailed => 'Не удалось загрузить платежи.';

  @override
  String get adminPaymentsFilterAll => 'Все';

  @override
  String get adminCreditsTitle => 'Кредитные операции';

  @override
  String get adminCreditsEmpty => 'Кредитных операций пока нет.';

  @override
  String get adminCreditsLoadFailed =>
      'Не удалось загрузить кредитные операции.';

  @override
  String get adminUsersTitle => 'Пользователи';

  @override
  String get adminUsersEmpty => 'Пользователи не найдены.';

  @override
  String get adminUsersLoadFailed => 'Не удалось загрузить пользователей.';

  @override
  String get adminUsersSearch => 'Поиск по email или имени';

  @override
  String get adminUsersRefresh => 'Обновить';

  @override
  String get adminUsersReset => 'Сбросить';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get termsTocLabel => 'Содержание';

  @override
  String get termsNoteBox =>
      'Это UI/UX-демонстрация образца условий. Перед публикацией REEL следует получить юридическую экспертизу текста.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'Электронная почта поддержки';

  @override
  String get termsContactButton => 'Связаться с поддержкой';

  @override
  String get termsS01Title => 'Принятие условий';

  @override
  String get termsS01P1 =>
      'Создавая аккаунт или используя любую функцию REEL (генерация изображений, генерация видео, пополнение кредитов, обновление плана), вы соглашаетесь с приведёнными ниже условиями. Если вы не согласны, пожалуйста, прекратите использование сервиса.';

  @override
  String get termsS01P2 =>
      'REEL предназначен для пользователей от 13 лет. Пользователям до 18 лет требуется согласие родителя или законного опекуна.';

  @override
  String get termsS02Title => 'Аккаунт';

  @override
  String get termsS02P1 =>
      'Каждый аккаунт привязан к одному уникальному email-адресу. Вы несёте ответственность за сохранность пароля и за все действия в своём аккаунте.';

  @override
  String get termsS02B1 =>
      'Регистрационные данные (имя, email) должны быть точными и актуальными.';

  @override
  String get termsS02B2 =>
      'REEL может потребовать подтверждение email перед активацией некоторых функций.';

  @override
  String get termsS02B3 =>
      'Аккаунт может находиться в статусе active, inactive или banned в зависимости от истории использования и нарушений.';

  @override
  String get termsS03Title => 'Кредиты и AI-генерация';

  @override
  String get termsS03P1 =>
      'REEL работает на системе кредитов. Каждая генерация изображения или видео (один «take») списывает соответствующее количество кредитов с вашего кошелька, в зависимости от типа, разрешения и длительности.';

  @override
  String get termsS03B1 =>
      'Кредиты списываются, когда запрос на генерацию начинает обрабатываться.';

  @override
  String get termsS03B2 =>
      'Если генерация завершается ошибкой из-за системного сбоя, кредиты возвращаются автоматически.';

  @override
  String get termsS03B3 =>
      'REEL не возвращает кредиты, если запрос провалился из-за нарушения условий (см. Раздел 6).';

  @override
  String get termsS03B4 =>
      'Неиспользованные кредиты месячных/годовых планов не переносятся на следующий период, если не указано иное.';

  @override
  String get termsS04Title => 'Оплата и возврат';

  @override
  String get termsS04P1 =>
      'REEL принимает оплату через Momo, ZaloPay, VNPay, банковский перевод и Stripe (для международных планов). Каждая транзакция фиксируется с собственным ID для отслеживания.';

  @override
  String get termsS04B1 =>
      'Месячные/годовые планы продлеваются автоматически, если вы не отмените их до следующего периода.';

  @override
  String get termsS04B2 =>
      'Запросы на возврат рассматриваются в течение 7 дней после оплаты, при условии, что кредиты плана не были использованы.';

  @override
  String get termsS04B3 =>
      'Разовое пополнение кредитов не подлежит возврату после зачисления в кошелёк.';

  @override
  String get termsS05Title => 'Права на контент';

  @override
  String get termsS05P1 =>
      'Вы сохраняете права на использование контента, созданного вами в REEL, в рамках вашего текущего плана.';

  @override
  String get termsS05B1 =>
      'Бесплатный план: контент содержит водяной знак REEL и предназначен для личного некоммерческого использования.';

  @override
  String get termsS05B2 =>
      'План Pro: контент без водяного знака, разрешено коммерческое использование.';

  @override
  String get termsS05B3 =>
      'REEL не гарантирует оригинальность AI-контента; ответственность за проверку перед коммерческим использованием лежит на вас.';

  @override
  String get termsS06Title => 'Запрещённые действия';

  @override
  String get termsS06P1 =>
      'Запрещается использовать REEL для создания или распространения контента, который:';

  @override
  String get termsS06B1 =>
      'Нарушает действующее законодательство, разжигает насилие, дискриминацию или ненависть.';

  @override
  String get termsS06B2 =>
      'Является порнографическим или связан с несовершеннолетними в любой форме.';

  @override
  String get termsS06B3 =>
      'Выдаёт себя за другое лицо, нарушает приватность или использует чужое изображение без разрешения.';

  @override
  String get termsS06B4 =>
      'Нарушает авторские права, товарные знаки или иные интеллектуальные права третьих лиц.';

  @override
  String get termsS06P2 =>
      'Нарушения могут привести к бану аккаунта без предварительного уведомления и без возврата кредитов или оплаты.';

  @override
  String get termsS07Title => 'Ограничение ответственности';

  @override
  String get termsS07P1 =>
      'Сервис предоставляется «как есть». REEL не гарантирует бесперебойную или безошибочную работу, а также соответствие результатов вашим ожиданиям.';

  @override
  String get termsS07P2 =>
      'В максимально допустимой законом степени REEL не несёт ответственности за косвенный ущерб, возникший в результате использования или невозможности использования сервиса.';

  @override
  String get termsS08Title => 'Прекращение аккаунта';

  @override
  String get termsS08P1 =>
      'Вы можете прекратить использование сервиса и запросить удаление аккаунта в любой момент. REEL может приостановить (inactive) или навсегда заблокировать (banned) аккаунты, нарушающие условия, с учётом тяжести нарушения.';

  @override
  String get termsS09Title => 'Изменения условий';

  @override
  String get termsS09P1 =>
      'REEL может обновлять эти условия. О важных изменениях будет сообщено по email или баннером на главной странице как минимум за 7 дней до их вступления в силу.';

  @override
  String get termsS10Title => 'Контакты';

  @override
  String get termsS10P1 =>
      'Если у вас есть вопросы по этим условиям, пожалуйста, свяжитесь с командой REEL.';

  @override
  String get errorPasswordRequired => 'Введите пароль.';

  @override
  String get errorConfirmPasswordRequired => 'Подтвердите пароль.';

  @override
  String get backToHomeLabel => 'ГЛАВНАЯ';

  @override
  String get backToHomeTooltip => 'На главную';

  @override
  String get profileBackHome => 'На главную';

  @override
  String get profileNavOverview => 'Обзор';

  @override
  String get profileNavMyRoll => 'Мой ролл';

  @override
  String get profileNavSettings => 'Настройки';

  @override
  String get profileNavBilling => 'Тарифы и оплата';

  @override
  String get profileLogout => 'Выйти';

  @override
  String profileWelcomeBack(String name) {
    return 'С возвращением, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'Вот ваш ролл на сегодня.';
  }

  @override
  String get profileStatTotalTakes => 'Всего дублей';

  @override
  String get profileStatFavoriteStock => 'Любимая плёнка';

  @override
  String get profileStatDaysLabel => 'Дней с REEL';

  @override
  String profileStatDaysValue(int n) {
    return '$n дн.';
  }

  @override
  String get profileUpgradePro => 'Перейти на Pro';

  @override
  String get profileRecentActivity => 'Последняя активность';

  @override
  String get profileViewAll => 'Смотреть все →';

  @override
  String get profileMyRollSub => 'Всё, что вы создали в REEL.';

  @override
  String get profileFilterAll => 'Все';

  @override
  String get profileFilterVideo => 'Видео';

  @override
  String get profileFilterPhoto => 'Фото';

  @override
  String get profilePhotoTag => 'Фото';

  @override
  String get profileMyRollEmpty =>
      'Дублей пока нет — создайте свой первый кадр в студии.';

  @override
  String get profileTimeJustNow => 'Только что';

  @override
  String profileTimeMinutesAgo(int n) {
    return '$n мин. назад';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return '$n ч назад';
  }

  @override
  String get profileTimeYesterday => 'Вчера';

  @override
  String profileTimeDaysAgo(int n) {
    return '$n дн. назад';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return '$n нед. назад';
  }

  @override
  String get profileSettingsSub =>
      'Обновите информацию профиля и настройки по умолчанию.';

  @override
  String get profileSectionProfileInfo => 'Информация профиля';

  @override
  String get profileFieldDisplayName => 'Отображаемое имя';

  @override
  String get profileFieldEmail => 'Эл. почта';

  @override
  String get profileSaveChanges => 'Сохранить изменения';

  @override
  String get profileSectionPassword => 'Сменить пароль';

  @override
  String get profileFieldCurrentPassword => 'Текущий пароль';

  @override
  String get profileFieldNewPassword => 'Новый пароль';

  @override
  String get profileFieldConfirmPassword => 'Подтвердите новый пароль';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'Минимум 8 символов';

  @override
  String get profilePwConfirmPlaceholder => 'Введите ещё раз';

  @override
  String get profileUpdatePassword => 'Обновить пароль';

  @override
  String get profilePwShow => 'Показать';

  @override
  String get profilePwHide => 'Скрыть';

  @override
  String get profileSectionPrefs => 'Настройки по умолчанию';

  @override
  String get profilePrefRatio => 'Формат по умолчанию';

  @override
  String get profilePrefRatioDesc =>
      'Применяется при каждом открытии генератора';

  @override
  String get profilePrefStock => 'Плёнка по умолчанию';

  @override
  String get profilePrefStockDesc => 'Стартовый вид ваших кадров';

  @override
  String get profileDangerTitle => 'Опасная зона';

  @override
  String get profileDangerDesc =>
      'Удаление аккаунта удалит весь ваш ролл. Это действие необратимо.';

  @override
  String get profileDeleteAccount => 'Удалить аккаунт';

  @override
  String get profileDeleteNotice =>
      'Удалением аккаунта занимается команда REEL — обратитесь в поддержку.';

  @override
  String get profileBillingSub => 'Управляйте тарифом и способами оплаты.';

  @override
  String get profileCurrentPlan => 'Текущий тариф';

  @override
  String get profilePlanPerMonth => '/ мес.';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '10 кредитов при регистрации';

  @override
  String get profilePlanFreeF2 => 'Водяной знак REEL';

  @override
  String get profilePlanProF1 => 'Пополняйте пакеты кредитов';

  @override
  String get profilePlanProF2 => '4K, без водяного знака';

  @override
  String get profileCurrentTag => 'Используется';

  @override
  String get profileUpgradeShort => 'Улучшить';

  @override
  String get profilePaymentHistory => 'История платежей';

  @override
  String get profileEmptyPayments =>
      'Транзакций пока нет — перейдите на Pro, чтобы начать.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'Информация профиля обновлена!';

  @override
  String get profilePasswordUpdated => 'Пароль обновлён!';

  @override
  String get profileProChip => 'ТАРИФ PRO';

  @override
  String get profileFreeChip => 'БЕСПЛАТНЫЙ ТАРИФ';

  @override
  String get adminSidebarModeration => 'Модерация';

  @override
  String get adminSidebarRevenue => 'Доходы';

  @override
  String get adminSidebarSystem => 'Система';

  @override
  String get adminRoleChip => 'Администратор';

  @override
  String usageCreditsLabel(int balance) {
    return 'Доступно кредитов: $balance';
  }

  @override
  String get homeStatCreditsLeft => 'КРЕДИТОВ';

  @override
  String get profileStatCredits => 'Кредиты';

  @override
  String profileCreditsAvailable(int balance) {
    return 'Доступно кредитов: $balance';
  }

  @override
  String get profileTopUp => 'Пополнить';

  @override
  String get profilePlanPayAsYouGo => '/ оплата за изображение';

  @override
  String profileUsageSpentToday(int spent) {
    return 'Сегодня использовано: $spent';
  }

  @override
  String get profileTopUpHint => 'Пополните баланс, чтобы продолжить.';

  @override
  String get avatarUpdated => 'Аватар обновлён';

  @override
  String get avatarUpdateFailed =>
      'Не удалось загрузить аватар. Попробуйте ещё раз.';

  @override
  String get avatarChangeHint => 'Изменить фото профиля';

  @override
  String get navCreate => 'Create';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeHeadline => 'One prompt box.';

  @override
  String get homeHeadlineAccent => 'Every kind of creation.';

  @override
  String get homeSubheadRedesign =>
      '20 AI tools in one home — pinned tools stay on top, find the rest with search. Long multi-page stories live in Manga Studio: script → split into pages → batch generate.';

  @override
  String get toolsBarLabel => 'Your pins';

  @override
  String get toolsAllButton => 'See all 20 tools';

  @override
  String get toolsSearchHint => 'Find a tool — e.g. manga, voice, 3D, code…';

  @override
  String get toolsCatalogTitle => 'All AI tools';

  @override
  String get toolsCatalogSubtitle =>
      '20 tools · pick one to open its create panel.';

  @override
  String get toolsNoMatch =>
      'No tool matches — try other keywords (voice, 3D, music…).';

  @override
  String toolComingSoon(String name) {
    return '$name is coming soon — only Image & Video are live right now.';
  }

  @override
  String get toolGroupImages => 'Images & Design';

  @override
  String get toolGroupFilm => 'Film & Stories';

  @override
  String get toolGroupAudio => 'Audio & Music';

  @override
  String get toolGroupDocs => 'Long-form & Docs';

  @override
  String get toolGroupTech => 'Tech & Automation';

  @override
  String get panelRatioLabel => 'Aspect ratio';

  @override
  String get panelStyleLabel => 'Style';

  @override
  String get generateImage => 'Generate image';

  @override
  String get generateVideo => 'Generate video';

  @override
  String get panelGenerateGeneric => 'Generate';

  @override
  String get saveToLibraryHint =>
      'Results are saved to your Library automatically.';

  @override
  String get imagePromptHint =>
      'Describe the shot you want… e.g. \'rainy city at night, neon reflecting on wet asphalt, 35mm lens\'';

  @override
  String get videoPromptHint =>
      'Describe the scene… e.g. \'drone gliding over a bamboo forest at dawn, drifting mist, pale golden light\'';

  @override
  String get genericPromptHint => 'Describe what you want to create…';

  @override
  String get comingSoonNote =>
      'This tool is a design preview — live generation is not wired to the server yet.';

  @override
  String get modeImageSub => 'One prompt, one art frame.';

  @override
  String get modeVideoSub => 'Short scenes from your description.';

  @override
  String get modeSpeechSub => 'Turn scripts into natural audio.';

  @override
  String get modeMangaSub => 'Multi-page stories: script → pages → dialogue.';

  @override
  String get badgeNew => 'New';

  @override
  String get librarySearchHint => 'Search by prompt…';

  @override
  String get libraryFilterImage => 'Images';

  @override
  String get libraryFilterVideo => 'Video';

  @override
  String get libraryFilterPinned => 'Pinned';

  @override
  String get librarySelect => 'Select';

  @override
  String librarySelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get libraryBulkDownload => 'Download';

  @override
  String get libraryBulkDownloadSoon => 'Bulk download is coming soon.';

  @override
  String libraryBulkDeleteSuccess(int count) {
    return 'Deleted $count items';
  }

  @override
  String get libraryPinAdded => 'Pinned to your library';

  @override
  String get libraryPinRemoved => 'Pin removed';

  @override
  String get libraryNoMatch => 'No items match your filter or search.';

  @override
  String get authCardSignInTitle => 'Welcome back';

  @override
  String get authCardSignInSub => 'Sign in to keep creating with REEL.';

  @override
  String get authCardSignUpTitle => 'Create account';

  @override
  String get authCardSignUpSub => 'Free forever — upgrade when you need to.';

  @override
  String get authCardResetTitle => 'Enter code & new password';

  @override
  String get authCardResetSub => 'The code is valid for 10 minutes.';

  @override
  String get authShowcaseAccent => 'Twenty kinds of works.';

  @override
  String get authShowcaseSub =>
      'Images, video, voice, multi-page manga, music, 3D, code… — all from the words you write. Sign in to keep creating.';

  @override
  String get authShowcaseMore => '+12 more tools';

  @override
  String get authGiftTitle => '50 welcome credits';

  @override
  String get authGiftSub =>
      '≈ 12 images, or 8 manga pages, or 50 sound effects. No credit card needed.';

  @override
  String get authStatToolsLabel => 'AI tools';

  @override
  String get authStatMangaValue => '1 book';

  @override
  String get authStatMangaLabel => 'Manga = 1 project';

  @override
  String get authStatRatingValue => '4.9★';

  @override
  String get authStatRatingLabel => 'Loved by creators';

  @override
  String get authStatFreeValue => '0đ';

  @override
  String get authStatFreeLabel => 'To start';

  @override
  String get authStatSignupValue => '30s';

  @override
  String get authStatSignupLabel => 'To sign up';

  @override
  String get authMeterEmpty => 'Password strength';

  @override
  String get authMeterWeak => 'WEAK — ADD UPPERCASE / DIGITS';

  @override
  String get authMeterOk => 'PRETTY GOOD';

  @override
  String get authMeterStrong => 'VERY STRONG ✓';

  @override
  String get adminSidebarQueue => 'Generation queue';

  @override
  String get adminSidebarTools => 'AI tools';

  @override
  String get librarySortNewest => 'Newest';

  @override
  String get librarySortOldest => 'Oldest';

  @override
  String get librarySortName => 'Name A–Z';

  @override
  String get librarySortCost => 'Credits ↓';

  @override
  String get libraryCreate => 'Create';

  @override
  String get libraryProjects => '📚 ACTIVE PROJECTS';

  @override
  String get libraryProjectMangaSub =>
      '8/12 pages · Chapter 2 generating · 3 locked characters';

  @override
  String get libraryProjectContinueManga => 'Continue in Manga Studio';

  @override
  String get libraryProjectBookSub =>
      '3/6 chapters · 21,400 words · PDF-EPUB export when done';

  @override
  String get libraryProjectContinueBook => 'Continue writing';

  @override
  String get libraryCollections => 'Collections';

  @override
  String get libraryCollectionsMock =>
      'Mockup — collections sync with the backend';

  @override
  String get libraryNewCollection => 'New collection';

  @override
  String get libraryOther => 'Other';

  @override
  String get libraryTrash => 'Trash';

  @override
  String get libraryTrashMock => 'Trash keeps files for 30 days';
}

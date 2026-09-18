// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'REEL — Estudio de Cine y Foto con IA';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get languagePickerTooltip => 'Elegir idioma de la interfaz';

  @override
  String get signIn => 'INICIAR SESIÓN';

  @override
  String get signUp => 'REGISTRARSE';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get forgot => 'OLVIDÉ';

  @override
  String get resetPassword => 'RESTABLECER CONTRASEÑA';

  @override
  String get newPassword => 'NUEVA CONTRASEÑA';

  @override
  String get credentialsBadge => 'CREDENCIALES';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · ACCESO $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'INICIAR SESIÓN';

  @override
  String get productionAccessRollSignUp => 'REGISTRARSE';

  @override
  String get productionAccessRollReset => 'RESTABLECER CONTRASEÑA';

  @override
  String get productionAccessRollNewPassword => 'NUEVA CONTRASEÑA';

  @override
  String get authHeadlineSignIn => 'Cada escena';

  @override
  String get authHeadlineSignInItalic => 'necesita un reparto.';

  @override
  String get authSubheadSignIn =>
      'Inicia sesión para seguir creando, guardar obras y gestionar tu roll.';

  @override
  String get authHeadlineSignUp => 'Únete a la';

  @override
  String get authHeadlineSignUpItalic => 'producción.';

  @override
  String get authSubheadSignUp =>
      'Crea una cuenta para guardar rolls, llevar el conteo diario de tomas y volver cuando llegue la inspiración.';

  @override
  String get authHeadlineForgot => '¿Perdiste el';

  @override
  String get authHeadlineForgotItalic => 'negativo?';

  @override
  String get authSubheadForgot =>
      'Introduce tu email y enviaremos un enlace para restablecer la contraseña.';

  @override
  String get authHeadlineReset => 'Haz un';

  @override
  String get authHeadlineResetItalic => 'nuevo corte.';

  @override
  String get authSubheadReset =>
      'Crea una nueva contraseña para volver a tu espacio creativo.';

  @override
  String get inputEmail => 'EMAIL';

  @override
  String get inputEmailHint => 'tu@example.com';

  @override
  String get inputPassword => 'CONTRASEÑA';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'Mínimo 8 caracteres';

  @override
  String get inputFullName => 'NOMBRE PARA MOSTRAR';

  @override
  String get inputFullNameHint => 'Director de este roll';

  @override
  String get inputConfirmPassword => 'CONFIRMAR CONTRASEÑA';

  @override
  String get inputConfirmPasswordHint => 'Vuelve a escribir la contraseña';

  @override
  String get inputResetCode => 'CÓDIGO DE RESTABLECIMIENTO';

  @override
  String get inputResetCodeHint => 'Pega el código del email';

  @override
  String get inputNewPassword => 'NUEVA CONTRASEÑA';

  @override
  String get inputNewPasswordHint => 'Mínimo 8 caracteres';

  @override
  String get inputNewPasswordConfirmHint =>
      'Vuelve a escribir la nueva contraseña';

  @override
  String get inputAvatarUrl => 'URL DEL AVATAR (OPCIONAL)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Nombre completo';

  @override
  String get inputFullNameEditHint => 'Introduce tu nombre completo';

  @override
  String get toggleShowPassword => 'Mostrar contraseña';

  @override
  String get toggleHidePassword => 'Ocultar contraseña';

  @override
  String get rememberMe => 'Recuérdame';

  @override
  String get forgotPasswordLink => '¿Olvidaste la contraseña?';

  @override
  String get signInButton => 'ENTRAR AL ROLL ►';

  @override
  String get signUpButton => 'EMPEZAR ROLL ►';

  @override
  String get forgotButton => 'ENVIAR ENLACE ►';

  @override
  String get resetPasswordButton => 'CAMBIAR CONTRASEÑA ►';

  @override
  String get orDivider => 'O';

  @override
  String get noAccountPrompt => '¿No tienes cuenta? ';

  @override
  String get noAccountLink => 'Regístrate';

  @override
  String get hasAccountPrompt => '¿Ya tienes cuenta? ';

  @override
  String get hasAccountLink => 'Iniciar sesión';

  @override
  String get forgotRememberedPrompt => '¿Recordaste la contraseña? ';

  @override
  String get forgotRememberedLink => 'Volver al inicio';

  @override
  String get resetRememberedPrompt => '¿Recordaste la contraseña? ';

  @override
  String get resetRememberedLink => 'Volver al inicio';

  @override
  String get agreeTermsPrefix => 'Acepto los ';

  @override
  String get agreeTermsLink => 'Términos de producción';

  @override
  String get agreeTermsSemantic => 'Acepto los Términos de producción';

  @override
  String get forgotDescription =>
      'Introduce el email con el que te registraste. El código caduca en 30 minutos.';

  @override
  String get statsFooter => 'TU PRÓXIMA ESCENA EMPIEZA AQUÍ';

  @override
  String get errorEmailPasswordRequired => 'Introduce email y contraseña.';

  @override
  String get errorAllFieldsRequired => 'Completa todos los campos.';

  @override
  String get errorPasswordTooShort =>
      'La contraseña debe tener al menos 8 caracteres.';

  @override
  String get errorPasswordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get errorAcceptTerms => 'Acepta los términos de producción.';

  @override
  String get errorEmailRequired => 'Introduce tu email.';

  @override
  String get errorResetCodeRequired =>
      'El código es obligatorio y la contraseña debe tener al menos 8 caracteres.';

  @override
  String get errorGeneric => 'No se puede conectar al servidor.';

  @override
  String get errorInvalidEmail =>
      'Introduce una dirección de correo electrónico válida.';

  @override
  String get errorInvalidAvatarUrl =>
      'La URL del avatar debe comenzar con http:// o https://.';

  @override
  String get errorSignInFailed => 'Email o contraseña incorrectos.';

  @override
  String get errorSignUpFailed => 'Registro fallido.';

  @override
  String get errorForgotFailed => 'No se pudo generar el enlace.';

  @override
  String get errorResetFailed => 'No se pudo restablecer la contraseña.';

  @override
  String get errorFullNameRequired => 'Introduce tu nombre.';

  @override
  String get successSignUp => '¡Registro exitoso! Inicia sesión.';

  @override
  String get successResetPassword => 'Contraseña cambiada con éxito.';

  @override
  String get successForgotEmail => 'Si el email existe, el enlace fue enviado.';

  @override
  String get successProfileSaved => '¡Perfil actualizado!';

  @override
  String get successPasswordChanged =>
      '¡Contraseña cambiada! Inicia sesión de nuevo.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'No se pudo cargar el perfil: $message';
  }

  @override
  String get explore => 'Explorar';

  @override
  String get gallery => 'Galería';

  @override
  String get faq => 'Preguntas';

  @override
  String get pricing => 'Precios';

  @override
  String get loginPrompt => 'Inicia sesión antes de generar una imagen.';

  @override
  String get emptyPrompt => 'Introduce un prompt antes de pulsar Action.';

  @override
  String get imageOnlySupported =>
      'REEL solo admite text-to-image. Elige Photo.';

  @override
  String get imageGenerationFailed =>
      'No se pudo generar la imagen. Revisa el backend y el modelo.';

  @override
  String get noImageReturned => 'El modelo no devolvió una imagen.';

  @override
  String get videoDurationLabel => 'DURACIÓN';

  @override
  String get videoQualityLabel => 'CALIDAD';

  @override
  String get videoQueuedMessage =>
      'El vídeo se está renderizando — tarda unos minutos. El resultado aparecerá aquí.';

  @override
  String get videoGenerationFailed =>
      'La generación del vídeo falló. Tus créditos han sido reembolsados.';

  @override
  String get videoTimeoutMessage =>
      'El vídeo está tardando más de lo esperado. Revisa en un momento Mi roll en tu perfil.';

  @override
  String get videoReadyLabel => 'Tu vídeo está listo';

  @override
  String get usageLabelSignedOut => 'Inicia sesión para empezar';

  @override
  String get rtlToggleTooltip => 'Cambiar dirección LTR / RTL';

  @override
  String get footerTagline =>
      'REEL — desarrollado en la oscuridad, un fotograma a la vez. Convierte una línea de texto en una toma.';

  @override
  String get productColumn => 'PRODUCTO';

  @override
  String get supportColumn => 'SOPORTE';

  @override
  String get signInLink => 'Iniciar sesión';

  @override
  String get signUpLink => 'Registrarse';

  @override
  String get footerCaption1 =>
      'REEL — DESARROLLADO EN LA OSCURIDAD. UN FOTOGRAMA A LA VEZ.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Escribe una escena.';

  @override
  String get getTheTake => 'Obtén la toma.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Convierte una línea de texto en una toma — encuadrada, iluminada y en movimiento en segundos. Vídeo o foto, un solo roll.';

  @override
  String get homeStatLastTake => 'ÚLTIMA TOMA';

  @override
  String get homeStatAspectRatios => 'FORMATOS';

  @override
  String get homeStatFilmStocks => 'FILMS';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'Describe tu escena…';

  @override
  String get homeQuickChips =>
      'Baile de máscaras bajo arañas | Jinete en tormenta de arena | Taller de marionetas';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'Creando toma…';

  @override
  String get homeGenerate => 'Generar';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Toma lista · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => 'No se pudo cargar la imagen.';

  @override
  String get homeGenerationOpenOriginal => 'Abrir original';

  @override
  String get homeGenerationRegenerate => 'Regenerar';

  @override
  String get homeGenerationOpenFailed => 'No se pudo abrir el original.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'Una línea de texto. Una escena completa.';

  @override
  String get showcaseSubtitle =>
      'Mira cómo REEL convierte una descripción en un fotograma real, paso a paso.';

  @override
  String get showcasePrompt1 =>
      '\"astronauta surfeando en las dunas rojas de Marte, hora dorada, plano amplio\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"baile de máscaras bajo arañas, movimiento de cámara lento\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"jinete a caballo en tormenta de arena al atardecer, plano de seguimiento\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Cuatro herramientas, una sola toma';

  @override
  String get featuresSubtitle =>
      'Todo lo necesario para pasar de una línea de texto a un fotograma completo.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Luz, movimiento de cámara y gramática cinematográfica aprendida de millones de fotogramas reales.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 para cine, 1:1 para feed, 9:16 para stories — sin volver a editar desde cero.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — elige la textura antes de Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'El mismo prompt, el mismo estudio. Imágenes ya; vídeo cuando esté listo.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Preguntas frecuentes';

  @override
  String get faqSubtitle => '¿Algo más? Escribe al equipo REEL.';

  @override
  String get faqQ1 => '¿Cómo funciona REEL?';

  @override
  String get faqA1 =>
      'Escribe una descripción, elige un formato y un film stock. REEL genera una imagen. El vídeo está en desarrollo.';

  @override
  String get faqQ2 => '¿Qué diferencia a REEL de otras herramientas de IA?';

  @override
  String get faqA2 =>
      'REEL se centra en el lenguaje cinematográfico — luz, encuadre y film stock — en un único estudio.';

  @override
  String get faqQ3 => '¿Cuántas tomas gratis tengo?';

  @override
  String get faqA3 =>
      'Tu cuota y créditos se muestran en el estudio tras iniciar sesión. Consulta los precios.';

  @override
  String get faqQ4 => '¿Qué formatos y resoluciones hay?';

  @override
  String get faqA4 =>
      'Las imágenes admiten 16:9, 1:1 y 9:16. El tamaño depende de la configuración.';

  @override
  String get faqQ5 => '¿Puedo usar los resultados comercialmente?';

  @override
  String get faqA5 =>
      'Revisa los Términos de producción y los beneficios del plan antes del uso comercial.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Elige tu ritmo de rodaje';

  @override
  String get plansSubtitle =>
      'Empieza gratis, sube cuando tu roll necesite más tiempo.';

  @override
  String get ctaReady => 'Listo para tu';

  @override
  String get ctaReadyItalic => 'primera toma?';

  @override
  String get ctaBody =>
      'Gratis, sin tarjeta — primer fotograma en menos de un minuto.';

  @override
  String get ctaFreeButton => 'Crear cuenta gratis';

  @override
  String get ctaGalleryButton => 'Ver galería';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Últimos fotogramas';

  @override
  String get contactSheetSubtitle =>
      'Algunas escenas que la comunidad REEL acaba de montar.';

  @override
  String get contactSheetDialogTitle => 'Vista previa del estilo visual.';

  @override
  String get contactSheetDialogBody => 'Genera tu propia toma en el estudio.';

  @override
  String get contactSheetClose => 'Cerrar';

  @override
  String get pricingTitle => 'PRECIOS';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Elige tu ritmo de rodaje';

  @override
  String get pricingSubheading =>
      'Empieza gratis, sube cuando tu roll necesite más tiempo.';

  @override
  String get pricingEmpty => 'No hay paquetes activos.';

  @override
  String get pricingBuyButton => 'COMPRAR PAQUETE';

  @override
  String get pricingFreeCta => 'Usar gratis';

  @override
  String get pricingSignInFirst => 'Inicia sesión antes de comprar.';

  @override
  String get pricingLoadFailed => 'No se pudieron cargar los paquetes.';

  @override
  String get pricingStripeOpenFailed => 'No se pudo abrir Stripe.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout abierto. Los créditos se añadirán tras el pago.';

  @override
  String get pricingCreditsSuffix => ' CRÉDITOS';

  @override
  String get pricingCreditsPerMonth => 'créditos al mes';

  @override
  String get pricingPeriodMonthly => '/mes';

  @override
  String get pricingPeriodYearly => '/año';

  @override
  String get pricingFreePerk =>
      '25 créditos gratis al registrarte — prueba el estudio sin compromiso.';

  @override
  String get profileTitle => 'MI PERFIL';

  @override
  String profileLoadFailed(Object message) {
    return 'No se pudo cargar el perfil: $message';
  }

  @override
  String get profileNotLoaded => 'No se pudo cargar el perfil';

  @override
  String get profileEditButton => 'EDITAR PERFIL';

  @override
  String get profileChangePasswordButton => 'CAMBIAR CONTRASEÑA';

  @override
  String get profileUsageSection => 'USO Y CRÉDITOS';

  @override
  String get profileCreditBalance => 'Saldo de créditos';

  @override
  String get profileDailyUsage => 'Uso diario';

  @override
  String get profileAccountSection => 'INFO DE CUENTA';

  @override
  String get profileUserId => 'ID de usuario';

  @override
  String get profileStatus => 'Estado';

  @override
  String get profileStatusActive => 'Activo';

  @override
  String get profileStatusInactive => 'Inactivo';

  @override
  String get profileMemberSince => 'Miembro desde';

  @override
  String get profileUnknownName => 'Desconocido';

  @override
  String get profileUnknownEmail => 'Sin email';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'EDITAR PERFIL';

  @override
  String get editProfileSubhead => 'Actualiza la información de tu perfil';

  @override
  String get editProfileSave => 'GUARDAR';

  @override
  String editProfileLoadFailed(Object message) {
    return 'No se pudo cargar el perfil: $message';
  }

  @override
  String get editProfileSaveFailed => 'No se pudo actualizar el perfil';

  @override
  String get changePasswordTitle => 'CAMBIAR CONTRASEÑA';

  @override
  String get changePasswordSubhead =>
      'Introduce tu contraseña actual y elige una nueva';

  @override
  String get changePasswordCurrent => 'Contraseña actual';

  @override
  String get changePasswordNew => 'Nueva contraseña';

  @override
  String get changePasswordConfirm => 'Confirma la nueva contraseña';

  @override
  String get changePasswordCurrentRequired => 'Introduce la contraseña actual';

  @override
  String get changePasswordNewRequired => 'Introduce una nueva contraseña';

  @override
  String get changePasswordTooShort =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get changePasswordConfirmRequired => 'Confirma la nueva contraseña';

  @override
  String get changePasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get changePasswordSubmit => 'CAMBIAR CONTRASEÑA';

  @override
  String get changePasswordFailed => 'No se pudo cambiar la contraseña';

  @override
  String get libraryTitle => 'Biblioteca';

  @override
  String get libraryTabGenerations => 'GENERACIONES';

  @override
  String get libraryTabCredits => 'CRÉDITOS';

  @override
  String get libraryTabPayments => 'PAGOS';

  @override
  String get libraryReload => 'Recargar';

  @override
  String get librarySignInPrompt => 'INICIA SESIÓN PARA VER LA BIBLIOTECA';

  @override
  String get libraryRetry => 'REINTENTAR';

  @override
  String get libraryLoadFailed => 'No se pudo cargar la biblioteca.';

  @override
  String get libraryEmptyGenerations => 'Aún no has creado imágenes.';

  @override
  String get libraryEmptyCredits => 'Sin movimientos de crédito.';

  @override
  String get libraryEmptyPayments => 'Sin pagos.';

  @override
  String get libraryDeleteDialogTitle => '¿Eliminar generación?';

  @override
  String get libraryDeleteDialogBody =>
      '¿Seguro que quieres eliminar esta generación? No se puede deshacer.';

  @override
  String get libraryDeleteCancel => 'CANCELAR';

  @override
  String get libraryDeleteConfirm => 'ELIMINAR';

  @override
  String get libraryDeleteSuccess => 'Generación eliminada';

  @override
  String get libraryDeleteFailed => 'No se pudo eliminar';

  @override
  String get libraryStatusCompleted => 'Completada';

  @override
  String get libraryStatusFailed => 'Fallida';

  @override
  String get libraryStatusProcessing => 'Procesando';

  @override
  String get libraryStatusPending => 'En espera';

  @override
  String get paymentResultSuccess => 'PAGO EXITOSO';

  @override
  String get paymentResultCancel => 'PAGO CANCELADO';

  @override
  String get paymentResultError => 'PAGO FALLIDO';

  @override
  String get paymentResultSuccessMsg =>
      'Tu pago fue procesado. Los créditos se añadieron a tu cuenta.';

  @override
  String get paymentResultCancelMsg =>
      'Cancelaste el pago. No se realizó ningún cargo.';

  @override
  String get paymentResultErrorMsg =>
      'Ocurrió un error. Inténtalo de nuevo o contacta con soporte.';

  @override
  String get paymentResultLoadFailed =>
      'No se pudo cargar la información del pago';

  @override
  String get paymentDetailPackage => 'Paquete';

  @override
  String get paymentDetailCredits => 'Créditos';

  @override
  String get paymentDetailAmount => 'Monto';

  @override
  String get paymentDetailTransaction => 'Transacción';

  @override
  String get paymentBackHome => 'VOLVER AL INICIO';

  @override
  String get paymentTryAgain => 'REINTENTAR';

  @override
  String get termsEyebrow => 'LEGAL';

  @override
  String get termsHeadline => 'Términos de servicio';

  @override
  String get termsSubhead =>
      'Última actualización: 10/09/2026 · Aplica a todo el servicio REEL';

  @override
  String get termsBackShort => 'VOLVER';

  @override
  String get termsBackLong => 'AL INICIO';

  @override
  String get termsFooterText =>
      'REEL — DESARROLLADO EN LA OSCURIDAD. UN FRAME A LA VEZ.';

  @override
  String get termsAccept => 'ACEPTO';

  @override
  String get termsDecline => 'VOLVER';

  @override
  String get adminDashboardTitle => 'Panel admin';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Resumen';

  @override
  String get adminSidebarGenerations => 'Generaciones';

  @override
  String get adminSidebarUsers => 'Usuarios';

  @override
  String get adminSidebarPayments => 'Pagos';

  @override
  String get adminSidebarSettings => 'Ajustes';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Administrador';

  @override
  String get adminMenuTooltip => 'Abrir menú';

  @override
  String get adminRtlTooltip => 'Cambiar LTR / RTL';

  @override
  String get adminRefreshTooltip => 'Actualizar';

  @override
  String get adminSearchUsersHint => 'Buscar usuarios…';

  @override
  String get adminExportTooltip => 'Exportar informe';

  @override
  String get adminExportLabel => 'EXPORTAR';

  @override
  String get adminExportComingSoon =>
      'La exportación de informes llegará pronto.';

  @override
  String get adminNotificationsTooltip => 'Notificaciones';

  @override
  String get adminRangeLabel => 'Rango';

  @override
  String get adminRangeToday => 'Hoy';

  @override
  String get adminRange7Days => '7 días';

  @override
  String get adminRange30Days => '30 días';

  @override
  String get adminRangeTodayLong => 'hoy';

  @override
  String get adminRange7DaysLong => 'en 7 días';

  @override
  String get adminRange30DaysLong => 'en 30 días';

  @override
  String get adminAutoUpdateNote => 'Auto-actualización diaria a las 00:00';

  @override
  String adminKpiTakes(Object range) {
    return 'Tomas $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Usuarios activos — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Ingresos — $range';
  }

  @override
  String get adminKpiQueue => 'Cola de render';

  @override
  String get adminDailyOutputTitle => 'Producción de 7 días';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return 'El $ratio16x9 representa el 58% de los renders de la semana, seguido de 1:1 (24%) y 9:16 (18%).';
  }

  @override
  String get adminStockMixTitle => 'Mix por estilo';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Renders recientes';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Usuarios';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Abrir lista';

  @override
  String get adminFleetTitle => 'Cola y GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter =>
      '3/5 workers activos · 1 en mantenimiento · 1 idle';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'Procesando — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Idle — esperando próximo trabajo';

  @override
  String get adminFleetJobMaintenance => 'Mantenimiento programado';

  @override
  String get adminGenerationCompleted => 'Completada';

  @override
  String get adminGenerationProcessing => 'Renderizando';

  @override
  String get adminGenerationFailed => 'Fallida';

  @override
  String get adminUserStatusActive => 'Activo';

  @override
  String get adminUserStatusInactive => 'Inactivo';

  @override
  String get adminUserStatusBanned => 'Bloqueado';

  @override
  String get adminUserRoleAdmin => 'Admin';

  @override
  String get adminUserRoleUser => 'Usuario';

  @override
  String get adminSettingsTitle => 'Ajustes';

  @override
  String get adminSettingsStudioName => 'Nombre del estudio';

  @override
  String get adminSettingsSupportEmail => 'Email de soporte';

  @override
  String get adminSettingsImageCost => 'Coste por imagen';

  @override
  String get adminSettingsVideoCost => 'Coste por vídeo';

  @override
  String get adminSettingsAlerts => 'Alertas';

  @override
  String get adminSettingsAlertPayment => 'Notificar pagos fallidos';

  @override
  String get adminSettingsAlertGeneration => 'Notificar generaciones fallidas';

  @override
  String get adminSettingsNewsletter => 'Enviar newsletter';

  @override
  String get adminSettingsMaintenance => 'Modo mantenimiento';

  @override
  String get adminSettingsRegistration => 'Permitir registros';

  @override
  String get adminSettingsSave => 'GUARDAR';

  @override
  String get adminSettingsLoadFailed => 'No se pudieron cargar los ajustes.';

  @override
  String get adminSettingsSaved => 'Ajustes guardados.';

  @override
  String get adminSettingsSaveFailed => 'No se pudieron guardar los ajustes.';

  @override
  String get adminPackagesTitle => 'Paquetes de pago';

  @override
  String get adminPackagesEmpty => 'Sin paquetes.';

  @override
  String get adminPackagesLoadFailed => 'No se pudieron cargar los paquetes.';

  @override
  String get adminPackagesNew => 'Nuevo paquete';

  @override
  String get adminPackagesFeatured => 'Destacado';

  @override
  String get adminPackagesInactive => 'Inactivo';

  @override
  String get adminPackagesActive => 'Activo';

  @override
  String get adminPaymentsTitle => 'Pagos';

  @override
  String get adminPaymentsEmpty => 'Sin pagos.';

  @override
  String get adminPaymentsLoadFailed => 'No se pudieron cargar los pagos.';

  @override
  String get adminPaymentsFilterAll => 'Todos';

  @override
  String get adminCreditsTitle => 'Movimientos de crédito';

  @override
  String get adminCreditsEmpty => 'Sin movimientos.';

  @override
  String get adminCreditsLoadFailed => 'No se pudieron cargar los movimientos.';

  @override
  String get adminUsersTitle => 'Usuarios';

  @override
  String get adminUsersEmpty => 'Sin usuarios.';

  @override
  String get adminUsersLoadFailed => 'No se pudieron cargar los usuarios.';

  @override
  String get adminUsersSearch => 'Buscar por email o nombre';

  @override
  String get adminUsersRefresh => 'Actualizar';

  @override
  String get adminUsersReset => 'Reiniciar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get termsTocLabel => 'Contenido';

  @override
  String get termsNoteBox =>
      'Esto es una maqueta UI/UX de contenido de ejemplo. Antes de cualquier publicación oficial, REEL debe revisar el texto con un asesor legal.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'Correo de soporte';

  @override
  String get termsContactButton => 'Contactar soporte';

  @override
  String get termsS01Title => 'Aceptación de los términos';

  @override
  String get termsS01P1 =>
      'Al crear una cuenta o usar cualquier función de REEL (generación de imágenes, generación de video, recarga de créditos, upgrade de plan), aceptas los términos siguientes. Si no estás de acuerdo, deja de usar el servicio.';

  @override
  String get termsS01P2 =>
      'REEL está dirigido a usuarios de 13 años o más. Los usuarios menores de 18 necesitan el consentimiento de un padre o tutor legal.';

  @override
  String get termsS02Title => 'Cuenta';

  @override
  String get termsS02P1 =>
      'Cada cuenta está vinculada a una dirección de correo única. Eres responsable de mantener la confidencialidad de tu contraseña y de toda la actividad bajo tu cuenta.';

  @override
  String get termsS02B1 =>
      'Los datos de registro (nombre, correo) deben ser exactos y estar actualizados.';

  @override
  String get termsS02B2 =>
      'REEL puede requerir verificación de correo antes de activar ciertas funciones.';

  @override
  String get termsS02B3 =>
      'Las cuentas pueden estar activas, inactivas o baneadas según el historial de uso y las infracciones.';

  @override
  String get termsS03Title => 'Créditos y generación con IA';

  @override
  String get termsS03P1 =>
      'REEL funciona con un sistema de créditos. Cada generación de imagen o video (un \"take\") descuenta los créditos correspondientes de tu monedero, según el tipo, resolución y duración.';

  @override
  String get termsS03B1 =>
      'Los créditos se descuentan cuando la solicitud de generación comienza a procesarse.';

  @override
  String get termsS03B2 =>
      'Si una generación falla por un error del sistema, los créditos se reembolsan automáticamente.';

  @override
  String get termsS03B3 =>
      'REEL no reembolsa créditos si la solicitud falla por infringir los términos (ver Sección 6).';

  @override
  String get termsS03B4 =>
      'Los créditos no usados de planes mensuales/anuales no se trasladan al siguiente ciclo, salvo aviso en contrario.';

  @override
  String get termsS04Title => 'Pago y reembolso';

  @override
  String get termsS04P1 =>
      'REEL acepta pagos a través de Momo, ZaloPay, VNPay, transferencia bancaria y Stripe (para planes internacionales). Cada transacción se registra con su propio ID para trazabilidad.';

  @override
  String get termsS04B1 =>
      'Los planes mensuales/anuales se renuevan automáticamente salvo que los canceles antes del siguiente ciclo.';

  @override
  String get termsS04B2 =>
      'Las solicitudes de reembolso se evalúan en un plazo de 7 días desde el pago, siempre que no se hayan usado los créditos del plan.';

  @override
  String get termsS04B3 =>
      'Las recargas únicas de créditos no son reembolsables una vez abonadas en el monedero.';

  @override
  String get termsS05Title => 'Propiedad del contenido';

  @override
  String get termsS05P1 =>
      'Conservas los derechos de uso sobre el contenido que creas en REEL, dentro del alcance de tu plan actual.';

  @override
  String get termsS05B1 =>
      'Plan Free: el contenido lleva marca de agua REEL y es solo para uso personal no comercial.';

  @override
  String get termsS05B2 =>
      'Plan Pro: el contenido no lleva marca de agua y puede usarse comercialmente.';

  @override
  String get termsS05B3 =>
      'REEL no garantiza la originalidad del contenido generado por IA; la verificación antes del uso comercial es tu responsabilidad.';

  @override
  String get termsS06Title => 'Conducta prohibida';

  @override
  String get termsS06P1 =>
      'No debes usar REEL para crear o distribuir contenido que:';

  @override
  String get termsS06B1 =>
      'Viole la ley vigente, incite a la violencia, discriminación u odio.';

  @override
  String get termsS06B2 =>
      'Sea pornográfico o involucre menores de cualquier forma.';

  @override
  String get termsS06B3 =>
      'Suplante a otra persona, invada la privacidad o use la imagen de alguien sin permiso.';

  @override
  String get termsS06B4 =>
      'Infrinja derechos de autor, marcas u otros derechos de propiedad intelectual de terceros.';

  @override
  String get termsS06P2 =>
      'Las infracciones pueden llevar al baneo de la cuenta sin previo aviso y sin reembolso de créditos o pagos.';

  @override
  String get termsS07Title => 'Limitación de responsabilidad';

  @override
  String get termsS07P1 =>
      'El servicio se proporciona \"tal cual\". REEL no garantiza un servicio ininterrumpido o sin errores, ni que cada resultado cumpla tus expectativas.';

  @override
  String get termsS07P2 =>
      'Hasta el máximo permitido por la ley, REEL no se hace responsable de daños indirectos derivados del uso o la imposibilidad de usar el servicio.';

  @override
  String get termsS08Title => 'Terminación de la cuenta';

  @override
  String get termsS08P1 =>
      'Puedes dejar de usar el servicio y solicitar la eliminación de tu cuenta en cualquier momento. REEL puede suspender (inactive) o bloquear permanentemente (banned) las cuentas que violen los términos, considerando la gravedad de la infracción.';

  @override
  String get termsS09Title => 'Cambios a los términos';

  @override
  String get termsS09P1 =>
      'REEL puede actualizar estos términos. Los cambios importantes se comunicarán por correo o un banner en la página principal al menos 7 días antes de su entrada en vigor.';

  @override
  String get termsS10Title => 'Contacto';

  @override
  String get termsS10P1 =>
      'Si tienes preguntas sobre estos términos, contacta con el equipo de REEL.';

  @override
  String get errorPasswordRequired => 'Introduce tu contraseña.';

  @override
  String get errorConfirmPasswordRequired => 'Confirma tu contraseña.';

  @override
  String get backToHomeLabel => 'INICIO';

  @override
  String get backToHomeTooltip => 'Volver al inicio';

  @override
  String get profileBackHome => 'Volver al inicio';

  @override
  String get profileNavOverview => 'Resumen';

  @override
  String get profileNavMyRoll => 'Mi roll';

  @override
  String get profileNavSettings => 'Ajustes';

  @override
  String get profileNavBilling => 'Planes y facturación';

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String profileWelcomeBack(String name) {
    return 'Bienvenido de nuevo, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'Este es tu roll de hoy.';
  }

  @override
  String get profileStatTotalTakes => 'Tomas totales';

  @override
  String get profileStatFavoriteStock => 'Stock favorito';

  @override
  String get profileStatDaysLabel => 'Días con REEL';

  @override
  String profileStatDaysValue(int n) {
    return '$n días';
  }

  @override
  String get profileUpgradePro => 'Mejorar a Pro';

  @override
  String get profileRecentActivity => 'Actividad reciente';

  @override
  String get profileViewAll => 'Ver todo →';

  @override
  String get profileMyRollSub => 'Todo lo que has generado en REEL.';

  @override
  String get profileFilterAll => 'Todos';

  @override
  String get profileFilterVideo => 'Vídeo';

  @override
  String get profileFilterPhoto => 'Foto';

  @override
  String get profilePhotoTag => 'Foto';

  @override
  String get profileMyRollEmpty =>
      'Aún no hay tomas — genera tu primer fotograma en el estudio.';

  @override
  String get profileTimeJustNow => 'Justo ahora';

  @override
  String profileTimeMinutesAgo(int n) {
    return 'hace $n min';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return 'hace $n h';
  }

  @override
  String get profileTimeYesterday => 'Ayer';

  @override
  String profileTimeDaysAgo(int n) {
    return 'hace $n días';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return 'hace $n semanas';
  }

  @override
  String get profileSettingsSub =>
      'Actualiza tu información de perfil y tus preferencias predeterminadas.';

  @override
  String get profileSectionProfileInfo => 'Información del perfil';

  @override
  String get profileFieldDisplayName => 'Nombre visible';

  @override
  String get profileFieldEmail => 'Correo electrónico';

  @override
  String get profileSaveChanges => 'Guardar cambios';

  @override
  String get profileSectionPassword => 'Cambiar contraseña';

  @override
  String get profileFieldCurrentPassword => 'Contraseña actual';

  @override
  String get profileFieldNewPassword => 'Nueva contraseña';

  @override
  String get profileFieldConfirmPassword => 'Confirmar nueva contraseña';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'Mínimo 8 caracteres';

  @override
  String get profilePwConfirmPlaceholder => 'Escríbela de nuevo';

  @override
  String get profileUpdatePassword => 'Actualizar contraseña';

  @override
  String get profilePwShow => 'Mostrar';

  @override
  String get profilePwHide => 'Ocultar';

  @override
  String get profileSectionPrefs => 'Preferencias predeterminadas';

  @override
  String get profilePrefRatio => 'Relación de aspecto predeterminada';

  @override
  String get profilePrefRatioDesc =>
      'Se aplica cada vez que abres el generador';

  @override
  String get profilePrefStock => 'Stock predeterminado';

  @override
  String get profilePrefStockDesc => 'El aspecto inicial de tus fotogramas';

  @override
  String get profileDangerTitle => 'Zona de peligro';

  @override
  String get profileDangerDesc =>
      'Eliminar tu cuenta borra todo tu roll. No se puede deshacer.';

  @override
  String get profileDeleteAccount => 'Eliminar cuenta';

  @override
  String get profileDeleteNotice =>
      'La eliminación de la cuenta la gestiona el equipo de REEL — contacta con soporte para solicitarla.';

  @override
  String get profileBillingSub => 'Gestiona tu plan y tus métodos de pago.';

  @override
  String get profileCurrentPlan => 'Plan actual';

  @override
  String get profilePlanPerMonth => '/ mes';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '10 créditos de regalo';

  @override
  String get profilePlanFreeF2 => 'Marca de agua de REEL';

  @override
  String get profilePlanProF1 => 'Recarga paquetes de créditos';

  @override
  String get profilePlanProF2 => '4K, sin marca de agua';

  @override
  String get profileCurrentTag => 'En uso';

  @override
  String get profileUpgradeShort => 'Mejorar';

  @override
  String get profilePaymentHistory => 'Historial de pagos';

  @override
  String get profileEmptyPayments =>
      'Aún no hay transacciones — mejora a Pro para empezar.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => '¡Información del perfil actualizada!';

  @override
  String get profilePasswordUpdated => '¡Contraseña actualizada!';

  @override
  String get profileProChip => 'PLAN PRO';

  @override
  String get profileFreeChip => 'PLAN GRATUITO';

  @override
  String get adminSidebarModeration => 'Moderación';

  @override
  String get adminSidebarRevenue => 'Ingresos';

  @override
  String get adminSidebarSystem => 'Sistema';

  @override
  String get adminRoleChip => 'Administrador';

  @override
  String usageCreditsLabel(int balance) {
    return '$balance créditos disponibles';
  }

  @override
  String get homeStatCreditsLeft => 'CRÉDITOS';

  @override
  String get profileStatCredits => 'Créditos';

  @override
  String profileCreditsAvailable(int balance) {
    return '$balance créditos disponibles';
  }

  @override
  String get profileTopUp => 'Recargar';

  @override
  String get profilePlanPayAsYouGo => '/ paga por imagen';

  @override
  String profileUsageSpentToday(int spent) {
    return '$spent créditos usados hoy';
  }

  @override
  String get profileTopUpHint => 'Recarga créditos para seguir creando.';

  @override
  String get avatarUpdated => 'Avatar actualizado';

  @override
  String get avatarUpdateFailed =>
      'No se pudo subir el avatar. Inténtalo de nuevo.';

  @override
  String get avatarChangeHint => 'Cambiar foto de perfil';

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

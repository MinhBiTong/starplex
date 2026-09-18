// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'REEL — Studio Cinema e Foto IA';

  @override
  String get languageLabel => 'Lingua';

  @override
  String get languagePickerTooltip => 'Scegli lingua interfaccia';

  @override
  String get signIn => 'ACCEDI';

  @override
  String get signUp => 'REGISTRATI';

  @override
  String get getStarted => 'Inizia';

  @override
  String get forgot => 'DIMENTICATA';

  @override
  String get resetPassword => 'REIMPOSTA PASSWORD';

  @override
  String get newPassword => 'NUOVA PASSWORD';

  @override
  String get credentialsBadge => 'CREDENZIALI';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · ACCESSO $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'ACCEDI';

  @override
  String get productionAccessRollSignUp => 'REGISTRATI';

  @override
  String get productionAccessRollReset => 'REIMPOSTA PASSWORD';

  @override
  String get productionAccessRollNewPassword => 'NUOVA PASSWORD';

  @override
  String get authHeadlineSignIn => 'Ogni scena';

  @override
  String get authHeadlineSignInItalic => 'ha bisogno di un cast.';

  @override
  String get authSubheadSignIn =>
      'Accedi per continuare a creare, salvare le opere e gestire il tuo roll.';

  @override
  String get authHeadlineSignUp => 'Unisciti alla';

  @override
  String get authHeadlineSignUpItalic => 'produzione.';

  @override
  String get authSubheadSignUp =>
      'Crea un account per salvare i roll, monitorare le take giornaliere e tornare quando arriva l\'ispirazione.';

  @override
  String get authHeadlineForgot => 'Hai perso il';

  @override
  String get authHeadlineForgotItalic => 'negativo?';

  @override
  String get authSubheadForgot =>
      'Inserisci la tua email e ti invieremo un link per reimpostare la password.';

  @override
  String get authHeadlineReset => 'Fai un';

  @override
  String get authHeadlineResetItalic => 'nuovo taglio.';

  @override
  String get authSubheadReset =>
      'Crea una nuova password per tornare nel tuo spazio creativo.';

  @override
  String get inputEmail => 'EMAIL';

  @override
  String get inputEmailHint => 'tu@example.com';

  @override
  String get inputPassword => 'PASSWORD';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'Almeno 8 caratteri';

  @override
  String get inputFullName => 'NOME VISUALIZZATO';

  @override
  String get inputFullNameHint => 'Regista di questo roll';

  @override
  String get inputConfirmPassword => 'CONFERMA PASSWORD';

  @override
  String get inputConfirmPasswordHint => 'Reinserisci la password';

  @override
  String get inputResetCode => 'CODICE DI RESET';

  @override
  String get inputResetCodeHint => 'Incolla il codice ricevuto via email';

  @override
  String get inputNewPassword => 'NUOVA PASSWORD';

  @override
  String get inputNewPasswordHint => 'Almeno 8 caratteri';

  @override
  String get inputNewPasswordConfirmHint => 'Reinserisci la nuova password';

  @override
  String get inputAvatarUrl => 'URL AVATAR (OPZIONALE)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Nome completo';

  @override
  String get inputFullNameEditHint => 'Inserisci il tuo nome completo';

  @override
  String get toggleShowPassword => 'Mostra password';

  @override
  String get toggleHidePassword => 'Nascondi password';

  @override
  String get rememberMe => 'Ricordami';

  @override
  String get forgotPasswordLink => 'Password dimenticata?';

  @override
  String get signInButton => 'ENTRA NEL ROLL ►';

  @override
  String get signUpButton => 'INIZIA IL ROLL ►';

  @override
  String get forgotButton => 'INVIA LINK ►';

  @override
  String get resetPasswordButton => 'CAMBIA PASSWORD ►';

  @override
  String get orDivider => 'O';

  @override
  String get noAccountPrompt => 'Non hai un account? ';

  @override
  String get noAccountLink => 'Registrati';

  @override
  String get hasAccountPrompt => 'Hai già un account? ';

  @override
  String get hasAccountLink => 'Accedi';

  @override
  String get forgotRememberedPrompt => 'Hai ricordato la password? ';

  @override
  String get forgotRememberedLink => 'Torna al login';

  @override
  String get resetRememberedPrompt => 'Hai ricordato la password? ';

  @override
  String get resetRememberedLink => 'Torna al login';

  @override
  String get agreeTermsPrefix => 'Accetto i ';

  @override
  String get agreeTermsLink => 'Termini di Produzione';

  @override
  String get agreeTermsSemantic => 'Accetto i Termini di Produzione';

  @override
  String get forgotDescription =>
      'Inserisci l\'email usata per registrarti. Il codice è valido 30 minuti.';

  @override
  String get statsFooter => 'LA TUA PROSSIMA SCENA INIZIA QUI';

  @override
  String get errorEmailPasswordRequired => 'Inserisci email e password.';

  @override
  String get errorAllFieldsRequired => 'Compila tutti i campi.';

  @override
  String get errorPasswordTooShort =>
      'La password deve contenere almeno 8 caratteri.';

  @override
  String get errorPasswordMismatch => 'Le password non corrispondono.';

  @override
  String get errorAcceptTerms => 'Accetta i Termini di Produzione.';

  @override
  String get errorEmailRequired => 'Inserisci la tua email.';

  @override
  String get errorResetCodeRequired =>
      'Codice obbligatorio e password di almeno 8 caratteri.';

  @override
  String get errorGeneric => 'Impossibile connettersi al server.';

  @override
  String get errorInvalidEmail => 'Inserisci un indirizzo email valido.';

  @override
  String get errorInvalidAvatarUrl =>
      'L\'URL dell\'avatar deve iniziare con http:// o https://.';

  @override
  String get errorSignInFailed => 'Email o password errate.';

  @override
  String get errorSignUpFailed => 'Registrazione fallita.';

  @override
  String get errorForgotFailed => 'Impossibile creare il link.';

  @override
  String get errorResetFailed => 'Impossibile reimpostare la password.';

  @override
  String get errorFullNameRequired => 'Inserisci il tuo nome.';

  @override
  String get successSignUp => 'Registrazione completata! Accedi.';

  @override
  String get successResetPassword => 'Password modificata.';

  @override
  String get successForgotEmail =>
      'Se l\'email esiste, il link è stato inviato.';

  @override
  String get successProfileSaved => 'Profilo aggiornato!';

  @override
  String get successPasswordChanged => 'Password cambiata! Accedi di nuovo.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'Impossibile caricare il profilo: $message';
  }

  @override
  String get explore => 'Esplora';

  @override
  String get gallery => 'Galleria';

  @override
  String get faq => 'FAQ';

  @override
  String get pricing => 'Prezzi';

  @override
  String get loginPrompt => 'Accedi prima di generare un\'immagine.';

  @override
  String get emptyPrompt => 'Inserisci un prompt prima di premere Action.';

  @override
  String get imageOnlySupported =>
      'REEL supporta solo text-to-image. Scegli Photo.';

  @override
  String get imageGenerationFailed =>
      'Impossibile generare l\'immagine. Controlla backend e modello.';

  @override
  String get noImageReturned => 'Il modello non ha restituito un\'immagine.';

  @override
  String get videoDurationLabel => 'DURATA';

  @override
  String get videoQualityLabel => 'QUALITÀ';

  @override
  String get videoQueuedMessage =>
      'Il video è in rendering — richiede qualche minuto. Il risultato apparirà qui.';

  @override
  String get videoGenerationFailed =>
      'Generazione del video non riuscita. I tuoi crediti sono stati rimborsati.';

  @override
  String get videoTimeoutMessage =>
      'Il video sta richiedendo più tempo del previsto. Tra poco controlla Il mio roll nel tuo profilo.';

  @override
  String get videoReadyLabel => 'Il tuo video è pronto';

  @override
  String get usageLabelSignedOut => 'Accedi per iniziare';

  @override
  String get rtlToggleTooltip => 'Cambia direzione LTR / RTL';

  @override
  String get footerTagline =>
      'REEL — sviluppato nel buio, un fotogramma alla volta. Trasforma una riga di testo in una scena.';

  @override
  String get productColumn => 'PRODOTTO';

  @override
  String get supportColumn => 'SUPPORTO';

  @override
  String get signInLink => 'Accedi';

  @override
  String get signUpLink => 'Registrati';

  @override
  String get footerCaption1 =>
      'REEL — SVILUPPATO NEL BUIO. UN FOTOGRAMMA ALLA VOLTA.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Scrivi una scena.';

  @override
  String get getTheTake => 'Ottieni la take.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Trasforma una riga di testo in una scena — inquadrata, illuminata e in movimento in pochi secondi. Video o foto, un solo roll.';

  @override
  String get homeStatLastTake => 'ULTIMA TAKE';

  @override
  String get homeStatAspectRatios => 'FORMATI';

  @override
  String get homeStatFilmStocks => 'FILM';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'Descrivi la tua scena…';

  @override
  String get homeQuickChips =>
      'Ballo in maschera sotto i lampadari | Cavaliere nella tempesta di sabbia | Laboratorio di marionette';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'Creo la take…';

  @override
  String get homeGenerate => 'Genera';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Take completata · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => 'Impossibile caricare il risultato.';

  @override
  String get homeGenerationOpenOriginal => 'Apri originale';

  @override
  String get homeGenerationRegenerate => 'Rigenera';

  @override
  String get homeGenerationOpenFailed => 'Impossibile aprire l\'originale.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'Una riga di testo. Una scena completa.';

  @override
  String get showcaseSubtitle =>
      'Guarda REEL trasformare una descrizione in un fotogramma reale, passo dopo passo.';

  @override
  String get showcasePrompt1 =>
      '\"astronauta fa surf sulle dune rosse di Marte, ora d\'oro, campo lungo\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"ballo in maschera sotto lampadari, movimento di camera lento\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"cavaliere a cavallo nella tempesta di sabbia al tramonto, tracking shot\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Quattro strumenti, una sola scena';

  @override
  String get featuresSubtitle =>
      'Tutto ciò che serve per passare da una riga di testo a un fotogramma completo.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Luce, movimento di camera e grammatica cinematografica appresi da milioni di fotogrammi reali.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 panoramico, 1:1 feed, 9:16 story — niente da rifare da zero.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — scegli la texture prima di Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'Lo stesso prompt, lo stesso studio. Immagini ora; video quando sarà pronto.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Domande frequenti';

  @override
  String get faqSubtitle => 'Altre domande? Scrivi al team REEL.';

  @override
  String get faqQ1 => 'Come funziona REEL?';

  @override
  String get faqA1 =>
      'Scrivi una descrizione, scegli formato e film stock. REEL genera un\'immagine. Il video è in sviluppo.';

  @override
  String get faqQ2 => 'Cosa differenzia REEL da altri strumenti IA?';

  @override
  String get faqA2 =>
      'REEL si concentra sul linguaggio cinematografico — luce, inquadratura e film stock — in un unico studio.';

  @override
  String get faqQ3 => 'Quante take gratuite ho?';

  @override
  String get faqA3 =>
      'Quota e crediti sono mostrati nello studio dopo l\'accesso. Vedi i prezzi per i vantaggi.';

  @override
  String get faqQ4 => 'Quali formati e risoluzioni?';

  @override
  String get faqA4 =>
      'Le immagini supportano 16:9, 1:1 e 9:16. La dimensione dipende dalla configurazione.';

  @override
  String get faqQ5 => 'Posso usare i risultati commercialmente?';

  @override
  String get faqA5 =>
      'Controlla i Termini di Produzione e i vantaggi del piano scelto prima dell\'uso commerciale.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Scegli il tuo ritmo';

  @override
  String get plansSubtitle =>
      'Inizia gratis, fai l\'upgrade quando il roll ha bisogno di più tempo.';

  @override
  String get ctaReady => 'Pronto per la tua';

  @override
  String get ctaReadyItalic => 'prima take?';

  @override
  String get ctaBody =>
      'Gratis, senza carta — primo fotogramma in meno di un minuto.';

  @override
  String get ctaFreeButton => 'Crea account gratis';

  @override
  String get ctaGalleryButton => 'Vedi galleria';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Ultimi fotogrammi';

  @override
  String get contactSheetSubtitle =>
      'Alcune scene appena montate dalla community REEL.';

  @override
  String get contactSheetDialogTitle => 'Anteprima dello stile visivo.';

  @override
  String get contactSheetDialogBody => 'Genera la tua take nello studio.';

  @override
  String get contactSheetClose => 'Chiudi';

  @override
  String get pricingTitle => 'PREZZI';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Scegli il tuo ritmo';

  @override
  String get pricingSubheading =>
      'Inizia gratis, fai l\'upgrade quando il roll ha bisogno di più tempo.';

  @override
  String get pricingEmpty => 'Nessun pacchetto attivo.';

  @override
  String get pricingBuyButton => 'ACQUISTA PACCHETTO';

  @override
  String get pricingFreeCta => 'Usa gratis';

  @override
  String get pricingSignInFirst => 'Accedi prima di acquistare.';

  @override
  String get pricingLoadFailed => 'Impossibile caricare i pacchetti.';

  @override
  String get pricingStripeOpenFailed => 'Impossibile aprire Stripe.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout aperto. Crediti aggiunti dopo il pagamento.';

  @override
  String get pricingCreditsSuffix => ' CREDITI';

  @override
  String get pricingCreditsPerMonth => 'crediti al mese';

  @override
  String get pricingPeriodMonthly => '/mese';

  @override
  String get pricingPeriodYearly => '/anno';

  @override
  String get pricingFreePerk =>
      '25 crediti gratis alla registrazione — prova lo studio senza pensieri.';

  @override
  String get profileTitle => 'MIO PROFILO';

  @override
  String profileLoadFailed(Object message) {
    return 'Impossibile caricare il profilo: $message';
  }

  @override
  String get profileNotLoaded => 'Impossibile caricare il profilo';

  @override
  String get profileEditButton => 'MODIFICA PROFILO';

  @override
  String get profileChangePasswordButton => 'CAMBIA PASSWORD';

  @override
  String get profileUsageSection => 'USO E CREDITI';

  @override
  String get profileCreditBalance => 'Saldo crediti';

  @override
  String get profileDailyUsage => 'Uso giornaliero';

  @override
  String get profileAccountSection => 'INFO ACCOUNT';

  @override
  String get profileUserId => 'ID utente';

  @override
  String get profileStatus => 'Stato';

  @override
  String get profileStatusActive => 'Attivo';

  @override
  String get profileStatusInactive => 'Inattivo';

  @override
  String get profileMemberSince => 'Membro da';

  @override
  String get profileUnknownName => 'Sconosciuto';

  @override
  String get profileUnknownEmail => 'Nessuna email';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'MODIFICA PROFILO';

  @override
  String get editProfileSubhead => 'Aggiorna le informazioni del profilo';

  @override
  String get editProfileSave => 'SALVA';

  @override
  String editProfileLoadFailed(Object message) {
    return 'Impossibile caricare il profilo: $message';
  }

  @override
  String get editProfileSaveFailed => 'Impossibile aggiornare il profilo';

  @override
  String get changePasswordTitle => 'CAMBIA PASSWORD';

  @override
  String get changePasswordSubhead =>
      'Inserisci la password attuale e scegline una nuova';

  @override
  String get changePasswordCurrent => 'Password attuale';

  @override
  String get changePasswordNew => 'Nuova password';

  @override
  String get changePasswordConfirm => 'Conferma la nuova password';

  @override
  String get changePasswordCurrentRequired => 'Inserisci la password attuale';

  @override
  String get changePasswordNewRequired => 'Inserisci una nuova password';

  @override
  String get changePasswordTooShort => 'Almeno 8 caratteri';

  @override
  String get changePasswordConfirmRequired => 'Conferma la nuova password';

  @override
  String get changePasswordMismatch => 'Le password non corrispondono';

  @override
  String get changePasswordSubmit => 'CAMBIA PASSWORD';

  @override
  String get changePasswordFailed => 'Impossibile cambiare la password';

  @override
  String get libraryTitle => 'Biblioteca';

  @override
  String get libraryTabGenerations => 'GENERAZIONI';

  @override
  String get libraryTabCredits => 'CREDITI';

  @override
  String get libraryTabPayments => 'PAGAMENTI';

  @override
  String get libraryReload => 'Ricarica';

  @override
  String get librarySignInPrompt => 'ACCEDI PER VEDERE LA BIBLIOTECA';

  @override
  String get libraryRetry => 'RIPROVA';

  @override
  String get libraryLoadFailed => 'Impossibile caricare la biblioteca.';

  @override
  String get libraryEmptyGenerations => 'Non hai ancora creato immagini.';

  @override
  String get libraryEmptyCredits => 'Nessuna operazione di credito.';

  @override
  String get libraryEmptyPayments => 'Nessun pagamento.';

  @override
  String get libraryDeleteDialogTitle => 'Eliminare la generazione?';

  @override
  String get libraryDeleteDialogBody =>
      'Sicuro di voler eliminare? Operazione irreversibile.';

  @override
  String get libraryDeleteCancel => 'ANNULLA';

  @override
  String get libraryDeleteConfirm => 'ELIMINA';

  @override
  String get libraryDeleteSuccess => 'Generazione eliminata';

  @override
  String get libraryDeleteFailed => 'Impossibile eliminare';

  @override
  String get libraryStatusCompleted => 'Completata';

  @override
  String get libraryStatusFailed => 'Fallita';

  @override
  String get libraryStatusProcessing => 'In elaborazione';

  @override
  String get libraryStatusPending => 'In attesa';

  @override
  String get paymentResultSuccess => 'PAGAMENTO RIUSCITO';

  @override
  String get paymentResultCancel => 'PAGAMENTO ANNULLATO';

  @override
  String get paymentResultError => 'PAGAMENTO FALLITO';

  @override
  String get paymentResultSuccessMsg =>
      'Il pagamento è stato elaborato. Crediti aggiunti al tuo account.';

  @override
  String get paymentResultCancelMsg =>
      'Hai annullato il pagamento. Nessun addebito.';

  @override
  String get paymentResultErrorMsg =>
      'Errore durante l\'elaborazione. Riprova o contatta il supporto.';

  @override
  String get paymentResultLoadFailed =>
      'Impossibile caricare le info di pagamento';

  @override
  String get paymentDetailPackage => 'Pacchetto';

  @override
  String get paymentDetailCredits => 'Crediti';

  @override
  String get paymentDetailAmount => 'Importo';

  @override
  String get paymentDetailTransaction => 'Transazione';

  @override
  String get paymentBackHome => 'TORNA ALLA HOME';

  @override
  String get paymentTryAgain => 'RIPROVA';

  @override
  String get termsEyebrow => 'LEGALE';

  @override
  String get termsHeadline => 'Termini di servizio';

  @override
  String get termsSubhead =>
      'Ultimo aggiornamento: 10/09/2026 · Si applica all\'intero servizio REEL';

  @override
  String get termsBackShort => 'INDIETRO';

  @override
  String get termsBackLong => 'ALLA HOME';

  @override
  String get termsFooterText =>
      'REEL — SVILUPPATO NEL BUIO. UN FRAME ALLA VOLTA.';

  @override
  String get termsAccept => 'ACCETTO';

  @override
  String get termsDecline => 'INDIETRO';

  @override
  String get adminDashboardTitle => 'Pannello Admin';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Panoramica';

  @override
  String get adminSidebarGenerations => 'Generazioni';

  @override
  String get adminSidebarUsers => 'Utenti';

  @override
  String get adminSidebarPayments => 'Pagamenti';

  @override
  String get adminSidebarSettings => 'Impostazioni';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Amministratore';

  @override
  String get adminMenuTooltip => 'Apri menu';

  @override
  String get adminRtlTooltip => 'Cambia LTR / RTL';

  @override
  String get adminRefreshTooltip => 'Aggiorna';

  @override
  String get adminSearchUsersHint => 'Cerca utenti…';

  @override
  String get adminExportTooltip => 'Esporta report';

  @override
  String get adminExportLabel => 'ESPORTA';

  @override
  String get adminExportComingSoon =>
      'L\'esportazione dei report arriva presto.';

  @override
  String get adminNotificationsTooltip => 'Notifiche';

  @override
  String get adminRangeLabel => 'Intervallo';

  @override
  String get adminRangeToday => 'Oggi';

  @override
  String get adminRange7Days => '7 giorni';

  @override
  String get adminRange30Days => '30 giorni';

  @override
  String get adminRangeTodayLong => 'oggi';

  @override
  String get adminRange7DaysLong => 'in 7 giorni';

  @override
  String get adminRange30DaysLong => 'in 30 giorni';

  @override
  String get adminAutoUpdateNote => 'Aggiornamento automatico alle 00:00';

  @override
  String adminKpiTakes(Object range) {
    return 'Take $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Utenti attivi — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Ricavi — $range';
  }

  @override
  String get adminKpiQueue => 'Coda render';

  @override
  String get adminDailyOutputTitle => 'Output 7 giorni';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return 'Il $ratio16x9 rappresenta il 58% dei render della settimana, seguito da 1:1 (24%) e 9:16 (18%).';
  }

  @override
  String get adminStockMixTitle => 'Mix per stile';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Render recenti';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Utenti';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Apri lista';

  @override
  String get adminFleetTitle => 'Coda e GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter =>
      '3/5 worker attivi · 1 in manutenzione · 1 idle';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'Elaborazione — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Idle — in attesa del prossimo lavoro';

  @override
  String get adminFleetJobMaintenance => 'Manutenzione programmata';

  @override
  String get adminGenerationCompleted => 'Completata';

  @override
  String get adminGenerationProcessing => 'Render in corso';

  @override
  String get adminGenerationFailed => 'Fallita';

  @override
  String get adminUserStatusActive => 'Attivo';

  @override
  String get adminUserStatusInactive => 'Inattivo';

  @override
  String get adminUserStatusBanned => 'Bandito';

  @override
  String get adminUserRoleAdmin => 'Admin';

  @override
  String get adminUserRoleUser => 'Utente';

  @override
  String get adminSettingsTitle => 'Impostazioni';

  @override
  String get adminSettingsStudioName => 'Nome studio';

  @override
  String get adminSettingsSupportEmail => 'Email supporto';

  @override
  String get adminSettingsImageCost => 'Costo per immagine';

  @override
  String get adminSettingsVideoCost => 'Costo per video';

  @override
  String get adminSettingsAlerts => 'Avvisi';

  @override
  String get adminSettingsAlertPayment => 'Avvisa su pagamenti falliti';

  @override
  String get adminSettingsAlertGeneration => 'Avvisa su generazioni fallite';

  @override
  String get adminSettingsNewsletter => 'Invia newsletter';

  @override
  String get adminSettingsMaintenance => 'Modalità manutenzione';

  @override
  String get adminSettingsRegistration => 'Consenti registrazioni';

  @override
  String get adminSettingsSave => 'SALVA';

  @override
  String get adminSettingsLoadFailed => 'Impossibile caricare le impostazioni.';

  @override
  String get adminSettingsSaved => 'Impostazioni salvate.';

  @override
  String get adminSettingsSaveFailed => 'Impossibile salvare.';

  @override
  String get adminPackagesTitle => 'Pacchetti di pagamento';

  @override
  String get adminPackagesEmpty => 'Nessun pacchetto.';

  @override
  String get adminPackagesLoadFailed => 'Impossibile caricare i pacchetti.';

  @override
  String get adminPackagesNew => 'Nuovo pacchetto';

  @override
  String get adminPackagesFeatured => 'In evidenza';

  @override
  String get adminPackagesInactive => 'Inattivo';

  @override
  String get adminPackagesActive => 'Attivo';

  @override
  String get adminPaymentsTitle => 'Pagamenti';

  @override
  String get adminPaymentsEmpty => 'Nessun pagamento.';

  @override
  String get adminPaymentsLoadFailed => 'Impossibile caricare i pagamenti.';

  @override
  String get adminPaymentsFilterAll => 'Tutti';

  @override
  String get adminCreditsTitle => 'Movimenti credito';

  @override
  String get adminCreditsEmpty => 'Nessun movimento.';

  @override
  String get adminCreditsLoadFailed => 'Impossibile caricare i movimenti.';

  @override
  String get adminUsersTitle => 'Utenti';

  @override
  String get adminUsersEmpty => 'Nessun utente.';

  @override
  String get adminUsersLoadFailed => 'Impossibile caricare gli utenti.';

  @override
  String get adminUsersSearch => 'Cerca per email o nome';

  @override
  String get adminUsersRefresh => 'Aggiorna';

  @override
  String get adminUsersReset => 'Reset';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get termsTocLabel => 'Indice';

  @override
  String get termsNoteBox =>
      'Questa è una maquette UI/UX di termini di esempio. Prima di qualsiasi pubblicazione ufficiale, REEL dovrebbe far revisionare il testo da un legale.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'Email di supporto';

  @override
  String get termsContactButton => 'Contatta supporto';

  @override
  String get termsS01Title => 'Accettazione dei termini';

  @override
  String get termsS01P1 =>
      'Creando un account o utilizzando qualsiasi funzionalità di REEL (generazione immagini, generazione video, ricarica crediti, upgrade del piano), accetti i termini seguenti. Se non sei d\'accordo, smetti di usare il servizio.';

  @override
  String get termsS01P2 =>
      'REEL è destinato a utenti di almeno 13 anni. Gli utenti sotto i 18 anni necessitano del consenso di un genitore o tutore legale.';

  @override
  String get termsS02Title => 'Account';

  @override
  String get termsS02P1 =>
      'Ogni account è associato a un indirizzo email unico. Sei responsabile della riservatezza della password e di ogni attività svolta con il tuo account.';

  @override
  String get termsS02B1 =>
      'I dati di registrazione (nome, email) devono essere corretti e aggiornati.';

  @override
  String get termsS02B2 =>
      'REEL può richiedere la verifica dell\'email prima di attivare alcune funzionalità.';

  @override
  String get termsS02B3 =>
      'Gli account possono essere attivi, inattivi o banditi in base alla cronologia d\'uso e alle violazioni.';

  @override
  String get termsS03Title => 'Crediti e generazione IA';

  @override
  String get termsS03P1 =>
      'REEL funziona con un sistema di crediti. Ogni generazione di immagine o video (un \"take\") sottrae i crediti corrispondenti dal tuo portafoglio, in base a tipo, risoluzione e durata.';

  @override
  String get termsS03B1 =>
      'I crediti vengono detratti quando la richiesta di generazione inizia l\'elaborazione.';

  @override
  String get termsS03B2 =>
      'Se una generazione fallisce per un errore di sistema, i crediti vengono rimborsati automaticamente.';

  @override
  String get termsS03B3 =>
      'REEL non rimborsa i crediti se la richiesta fallisce perché viola i termini (vedi Sezione 6).';

  @override
  String get termsS03B4 =>
      'I crediti non utilizzati dei piani mensili/annuali non vengono riportati al ciclo successivo, salvo diversa indicazione.';

  @override
  String get termsS04Title => 'Pagamento e rimborso';

  @override
  String get termsS04P1 =>
      'REEL accetta pagamenti tramite Momo, ZaloPay, VNPay, bonifico bancario e Stripe (per piani internazionali). Ogni transazione è registrata con un ID univoco per la tracciabilità.';

  @override
  String get termsS04B1 =>
      'I piani mensili/annuali si rinnovano automaticamente, salvo disdetta prima del ciclo successivo.';

  @override
  String get termsS04B2 =>
      'Le richieste di rimborso vengono valutate entro 7 giorni dal pagamento, a condizione che i crediti del piano non siano stati usati.';

  @override
  String get termsS04B3 =>
      'Le ricariche una tantum di crediti non sono rimborsabili una volta accreditate nel portafoglio.';

  @override
  String get termsS05Title => 'Proprietà del contenuto';

  @override
  String get termsS05P1 =>
      'Mantieni i diritti d\'uso sul contenuto che crei su REEL, nei limiti del tuo piano attuale.';

  @override
  String get termsS05B1 =>
      'Piano Free: il contenuto ha il watermark REEL ed è per uso personale non commerciale.';

  @override
  String get termsS05B2 =>
      'Piano Pro: il contenuto è senza watermark e può essere usato commercialmente.';

  @override
  String get termsS05B3 =>
      'REEL non garantisce l\'originalità del contenuto generato dall\'IA; la verifica prima dell\'uso commerciale è tua responsabilità.';

  @override
  String get termsS06Title => 'Comportamenti vietati';

  @override
  String get termsS06P1 =>
      'Non devi usare REEL per creare o diffondere contenuti che:';

  @override
  String get termsS06B1 =>
      'Violino la legge vigente, incitino alla violenza, discriminazione o odio.';

  @override
  String get termsS06B2 =>
      'Siano pornografici o coinvolgano minori in qualsiasi forma.';

  @override
  String get termsS06B3 =>
      'Imitino altre persone, violino la privacy o usino l\'immagine altrui senza permesso.';

  @override
  String get termsS06B4 =>
      'Violino copyright, marchi o altri diritti di proprietà intellettuale di terzi.';

  @override
  String get termsS06P2 =>
      'Le violazioni possono portare al ban dell\'account senza preavviso e senza rimborso di crediti o pagamenti.';

  @override
  String get termsS07Title => 'Limitazione di responsabilità';

  @override
  String get termsS07P1 =>
      'Il servizio è fornito \"così com\'è\". REEL non garantisce un servizio ininterrotto o esente da errori, né che ogni risultato soddisfi le tue aspettative.';

  @override
  String get termsS07P2 =>
      'Nei limiti massimi consentiti dalla legge, REEL non è responsabile per danni indiretti derivanti dall\'uso o dall\'impossibilità di usare il servizio.';

  @override
  String get termsS08Title => 'Termine dell\'account';

  @override
  String get termsS08P1 =>
      'Puoi smettere di usare il servizio e chiedere la cancellazione del tuo account in qualsiasi momento. REEL può sospendere (inactive) o bloccare permanentemente (banned) gli account che violano i termini, considerando la gravità della violazione.';

  @override
  String get termsS09Title => 'Modifiche ai termini';

  @override
  String get termsS09P1 =>
      'REEL può aggiornare questi termini. Le modifiche importanti saranno comunicate via email o banner sulla homepage almeno 7 giorni prima della loro entrata in vigore.';

  @override
  String get termsS10Title => 'Contatti';

  @override
  String get termsS10P1 =>
      'Per domande su questi termini, contatta il team REEL.';

  @override
  String get errorPasswordRequired => 'Inserisci la tua password.';

  @override
  String get errorConfirmPasswordRequired => 'Conferma la tua password.';

  @override
  String get backToHomeLabel => 'HOME';

  @override
  String get backToHomeTooltip => 'Torna alla home';

  @override
  String get profileBackHome => 'Torna alla home';

  @override
  String get profileNavOverview => 'Panoramica';

  @override
  String get profileNavMyRoll => 'Il mio roll';

  @override
  String get profileNavSettings => 'Impostazioni';

  @override
  String get profileNavBilling => 'Piani e fatturazione';

  @override
  String get profileLogout => 'Esci';

  @override
  String profileWelcomeBack(String name) {
    return 'Bentornato, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'Ecco il tuo roll di oggi.';
  }

  @override
  String get profileStatTotalTakes => 'Take totali';

  @override
  String get profileStatFavoriteStock => 'Stock preferito';

  @override
  String get profileStatDaysLabel => 'Giorni con REEL';

  @override
  String profileStatDaysValue(int n) {
    return '$n giorni';
  }

  @override
  String get profileUpgradePro => 'Passa a Pro';

  @override
  String get profileRecentActivity => 'Attività recente';

  @override
  String get profileViewAll => 'Vedi tutto →';

  @override
  String get profileMyRollSub => 'Tutto ciò che hai generato su REEL.';

  @override
  String get profileFilterAll => 'Tutti';

  @override
  String get profileFilterVideo => 'Video';

  @override
  String get profileFilterPhoto => 'Foto';

  @override
  String get profilePhotoTag => 'Foto';

  @override
  String get profileMyRollEmpty =>
      'Ancora nessun take — genera il tuo primo fotogramma nello studio.';

  @override
  String get profileTimeJustNow => 'Proprio ora';

  @override
  String profileTimeMinutesAgo(int n) {
    return '$n min fa';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return '$n h fa';
  }

  @override
  String get profileTimeYesterday => 'Ieri';

  @override
  String profileTimeDaysAgo(int n) {
    return '$n giorni fa';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return '$n settimane fa';
  }

  @override
  String get profileSettingsSub =>
      'Aggiorna le informazioni del profilo e le preferenze predefinite.';

  @override
  String get profileSectionProfileInfo => 'Informazioni profilo';

  @override
  String get profileFieldDisplayName => 'Nome visualizzato';

  @override
  String get profileFieldEmail => 'Email';

  @override
  String get profileSaveChanges => 'Salva modifiche';

  @override
  String get profileSectionPassword => 'Cambia password';

  @override
  String get profileFieldCurrentPassword => 'Password attuale';

  @override
  String get profileFieldNewPassword => 'Nuova password';

  @override
  String get profileFieldConfirmPassword => 'Conferma nuova password';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'Almeno 8 caratteri';

  @override
  String get profilePwConfirmPlaceholder => 'Riscrivila';

  @override
  String get profileUpdatePassword => 'Aggiorna password';

  @override
  String get profilePwShow => 'Mostra';

  @override
  String get profilePwHide => 'Nascondi';

  @override
  String get profileSectionPrefs => 'Preferenze predefinite';

  @override
  String get profilePrefRatio => 'Proporzioni predefinite';

  @override
  String get profilePrefRatioDesc =>
      'Applicato ogni volta che apri il generatore';

  @override
  String get profilePrefStock => 'Stock predefinito';

  @override
  String get profilePrefStockDesc => 'L\'aspetto iniziale dei tuoi fotogrammi';

  @override
  String get profileDangerTitle => 'Zona di pericolo';

  @override
  String get profileDangerDesc =>
      'Eliminando l\'account rimuovi tutto il tuo roll. L\'operazione non può essere annullata.';

  @override
  String get profileDeleteAccount => 'Elimina account';

  @override
  String get profileDeleteNotice =>
      'L\'eliminazione dell\'account è gestita dal team REEL — contatta l\'assistenza per richiederla.';

  @override
  String get profileBillingSub =>
      'Gestisci il tuo piano e i metodi di pagamento.';

  @override
  String get profileCurrentPlan => 'Piano attuale';

  @override
  String get profilePlanPerMonth => '/ mese';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '10 crediti iniziali';

  @override
  String get profilePlanFreeF2 => 'Filigrana REEL';

  @override
  String get profilePlanProF1 => 'Ricarica pacchetti di crediti';

  @override
  String get profilePlanProF2 => '4K, senza filigrana';

  @override
  String get profileCurrentTag => 'In uso';

  @override
  String get profileUpgradeShort => 'Upgrade';

  @override
  String get profilePaymentHistory => 'Storico pagamenti';

  @override
  String get profileEmptyPayments =>
      'Ancora nessuna transazione — passa a Pro per iniziare.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'Informazioni del profilo aggiornate!';

  @override
  String get profilePasswordUpdated => 'Password aggiornata!';

  @override
  String get profileProChip => 'PIANO PRO';

  @override
  String get profileFreeChip => 'PIANO GRATUITO';

  @override
  String get adminSidebarModeration => 'Moderazione';

  @override
  String get adminSidebarRevenue => 'Ricavi';

  @override
  String get adminSidebarSystem => 'Sistema';

  @override
  String get adminRoleChip => 'Amministratore';

  @override
  String usageCreditsLabel(int balance) {
    return '$balance crediti disponibili';
  }

  @override
  String get homeStatCreditsLeft => 'CREDITI';

  @override
  String get profileStatCredits => 'Crediti';

  @override
  String profileCreditsAvailable(int balance) {
    return '$balance crediti disponibili';
  }

  @override
  String get profileTopUp => 'Ricarica';

  @override
  String get profilePlanPayAsYouGo => '/ pagamento per immagine';

  @override
  String profileUsageSpentToday(int spent) {
    return '$spent crediti usati oggi';
  }

  @override
  String get profileTopUpHint => 'Ricarica crediti per continuare a creare.';

  @override
  String get avatarUpdated => 'Avatar aggiornato';

  @override
  String get avatarUpdateFailed => 'Caricamento avatar non riuscito. Riprova.';

  @override
  String get avatarChangeHint => 'Cambia foto profilo';

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

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'REEL — KI-Film- und Fotostudio';

  @override
  String get languageLabel => 'Sprache';

  @override
  String get languagePickerTooltip => 'Oberflächensprache wählen';

  @override
  String get signIn => 'ANMELDEN';

  @override
  String get signUp => 'REGISTRIEREN';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get forgot => 'VERGESSEN';

  @override
  String get resetPassword => 'PASSWORT ZURÜCKSETZEN';

  @override
  String get newPassword => 'NEUES PASSWORT';

  @override
  String get credentialsBadge => 'ZUGANGSDATEN';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · ZUGRIFF $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'ANMELDEN';

  @override
  String get productionAccessRollSignUp => 'REGISTRIEREN';

  @override
  String get productionAccessRollReset => 'PASSWORT ZURÜCKSETZEN';

  @override
  String get productionAccessRollNewPassword => 'NEUES PASSWORT';

  @override
  String get authHeadlineSignIn => 'Jede Szene';

  @override
  String get authHeadlineSignInItalic => 'braucht eine Besetzung.';

  @override
  String get authSubheadSignIn =>
      'Melde dich an, um weiter zu gestalten, Werke zu speichern und deinen Roll zu verwalten.';

  @override
  String get authHeadlineSignUp => 'Mach mit bei der';

  @override
  String get authHeadlineSignUpItalic => 'Produktion.';

  @override
  String get authSubheadSignUp =>
      'Erstelle ein Konto, um Rolls zu speichern, tägliche Takes zu verfolgen und zurückzukommen, wenn die Inspiration vorbeischaut.';

  @override
  String get authHeadlineForgot => 'Negativ';

  @override
  String get authHeadlineForgotItalic => 'verloren?';

  @override
  String get authSubheadForgot =>
      'Gib deine E-Mail ein, und wir senden einen Link zum Zurücksetzen des Passworts.';

  @override
  String get authHeadlineReset => 'Mach einen';

  @override
  String get authHeadlineResetItalic => 'neuen Schnitt.';

  @override
  String get authSubheadReset =>
      'Lege ein neues Passwort fest, um in deinen Kreativraum zurückzukehren.';

  @override
  String get inputEmail => 'E-MAIL';

  @override
  String get inputEmailHint => 'you@example.com';

  @override
  String get inputPassword => 'PASSWORT';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'Mindestens 8 Zeichen';

  @override
  String get inputFullName => 'ANZEIGENAME';

  @override
  String get inputFullNameHint => 'Regisseur:in dieses Rolls';

  @override
  String get inputConfirmPassword => 'PASSWORT BESTÄTIGEN';

  @override
  String get inputConfirmPasswordHint => 'Passwort erneut eingeben';

  @override
  String get inputResetCode => 'ZURÜCKSETZ-CODE';

  @override
  String get inputResetCodeHint => 'Code aus der E-Mail einfügen';

  @override
  String get inputNewPassword => 'NEUES PASSWORT';

  @override
  String get inputNewPasswordHint => 'Mindestens 8 Zeichen';

  @override
  String get inputNewPasswordConfirmHint => 'Neues Passwort erneut eingeben';

  @override
  String get inputAvatarUrl => 'AVATAR-URL (OPTIONAL)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Voller Name';

  @override
  String get inputFullNameEditHint => 'Gib deinen vollen Namen ein';

  @override
  String get toggleShowPassword => 'Passwort anzeigen';

  @override
  String get toggleHidePassword => 'Passwort verbergen';

  @override
  String get rememberMe => 'Angemeldet bleiben';

  @override
  String get forgotPasswordLink => 'Passwort vergessen?';

  @override
  String get signInButton => 'ROLL STARTEN ►';

  @override
  String get signUpButton => 'ROLL BEGINNEN ►';

  @override
  String get forgotButton => 'LINK SENDEN ►';

  @override
  String get resetPasswordButton => 'PASSWORT ÄNDERN ►';

  @override
  String get orDivider => 'ODER';

  @override
  String get noAccountPrompt => 'Noch kein Konto? ';

  @override
  String get noAccountLink => 'Jetzt registrieren';

  @override
  String get hasAccountPrompt => 'Schon ein Konto? ';

  @override
  String get hasAccountLink => 'Anmelden';

  @override
  String get forgotRememberedPrompt => 'Passwort wieder eingefallen? ';

  @override
  String get forgotRememberedLink => 'Zur Anmeldung';

  @override
  String get resetRememberedPrompt => 'Passwort wieder eingefallen? ';

  @override
  String get resetRememberedLink => 'Zur Anmeldung';

  @override
  String get agreeTermsPrefix => 'Ich stimme den ';

  @override
  String get agreeTermsLink => 'Produktionsbedingungen';

  @override
  String get agreeTermsSemantic => 'Ich stimme den Produktionsbedingungen zu';

  @override
  String get forgotDescription =>
      'Gib die E-Mail deiner Registrierung ein. Der Code ist 30 Minuten gültig.';

  @override
  String get statsFooter => 'DEINE NÄCHSTE SZENE BEGINNT HIER';

  @override
  String get errorEmailPasswordRequired => 'Bitte gib E-Mail und Passwort ein.';

  @override
  String get errorAllFieldsRequired => 'Bitte fülle alle Felder aus.';

  @override
  String get errorPasswordTooShort =>
      'Passwort muss mindestens 8 Zeichen haben.';

  @override
  String get errorPasswordMismatch => 'Passwörter stimmen nicht überein.';

  @override
  String get errorAcceptTerms => 'Bitte stimme den Produktionsbedingungen zu.';

  @override
  String get errorEmailRequired => 'Bitte gib eine E-Mail ein.';

  @override
  String get errorResetCodeRequired =>
      'Code ist erforderlich, Passwort muss mindestens 8 Zeichen haben.';

  @override
  String get errorGeneric => 'Keine Verbindung zum Server möglich.';

  @override
  String get errorInvalidEmail => 'Bitte gib eine gültige E-Mail-Adresse ein.';

  @override
  String get errorInvalidAvatarUrl =>
      'Avatar-URL muss mit http:// oder https:// beginnen.';

  @override
  String get errorSignInFailed => 'Falsche E-Mail oder Passwort.';

  @override
  String get errorSignUpFailed => 'Registrierung fehlgeschlagen.';

  @override
  String get errorForgotFailed => 'Reset-Link konnte nicht erstellt werden.';

  @override
  String get errorResetFailed => 'Passwort konnte nicht zurückgesetzt werden.';

  @override
  String get errorFullNameRequired => 'Bitte gib deinen Namen ein.';

  @override
  String get successSignUp => 'Registrierung erfolgreich! Bitte anmelden.';

  @override
  String get successResetPassword => 'Passwort erfolgreich geändert.';

  @override
  String get successForgotEmail =>
      'Wenn die E-Mail existiert, wurde der Link gesendet.';

  @override
  String get successProfileSaved => 'Profil aktualisiert!';

  @override
  String get successPasswordChanged =>
      'Passwort geändert! Bitte erneut anmelden.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'Profil konnte nicht geladen werden: $message';
  }

  @override
  String get explore => 'Erkunden';

  @override
  String get gallery => 'Galerie';

  @override
  String get faq => 'FAQ';

  @override
  String get pricing => 'Preise';

  @override
  String get loginPrompt => 'Bitte melde dich an, bevor du ein Bild erstellst.';

  @override
  String get emptyPrompt =>
      'Bitte gib einen Prompt ein, bevor du Action drückst.';

  @override
  String get imageOnlySupported =>
      'REEL unterstützt aktuell nur text-to-image. Bitte wähle Photo.';

  @override
  String get imageGenerationFailed =>
      'Bild konnte nicht erstellt werden. Prüfe Backend und Modell.';

  @override
  String get noImageReturned => 'Modell hat kein Bild zurückgegeben.';

  @override
  String get videoDurationLabel => 'DAUER';

  @override
  String get videoQualityLabel => 'QUALITÄT';

  @override
  String get videoQueuedMessage =>
      'Das Video wird gerendert — das dauert einige Minuten. Das Ergebnis erscheint hier.';

  @override
  String get videoGenerationFailed =>
      'Videogenerierung fehlgeschlagen. Deine Credits wurden erstattet.';

  @override
  String get videoTimeoutMessage =>
      'Das Video dauert länger als erwartet. Schau gleich unter Mein Roll in deinem Profil nach.';

  @override
  String get videoReadyLabel => 'Dein Video ist fertig';

  @override
  String get usageLabelSignedOut => 'Anmelden, um zu starten';

  @override
  String get rtlToggleTooltip => 'Layout-Richtung LTR / RTL umschalten';

  @override
  String get footerTagline =>
      'REEL — im Dunkeln entwickelt, ein Bild nach dem anderen. Verwandle eine Textzeile in eine Aufnahme.';

  @override
  String get productColumn => 'PRODUKT';

  @override
  String get supportColumn => 'SUPPORT';

  @override
  String get signInLink => 'Anmelden';

  @override
  String get signUpLink => 'Registrieren';

  @override
  String get footerCaption1 =>
      'REEL — IM DUNKELN ENTWICKELT. EIN BILD NACH DEM ANDEREN.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Tippe eine Szene.';

  @override
  String get getTheTake => 'Hol dir den Take.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Verwandle eine Textzeile in eine Aufnahme — mit Rahmen, Licht und Bewegung in Sekunden. Video oder Standbild, ein Roll.';

  @override
  String get homeStatLastTake => 'LETZTER TAKE';

  @override
  String get homeStatAspectRatios => 'SEITENVERHÄLTNISSE';

  @override
  String get homeStatFilmStocks => 'FILM STOCKS';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'Beschreibe deine Szene…';

  @override
  String get homeQuickChips =>
      'Maskenball unter Lüstern | Reiter im Sandsturm | Marionetten-Werkstatt';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'Take wird erstellt…';

  @override
  String get homeGenerate => 'Erstellen';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Take fertig · $ratio';
  }

  @override
  String get homeGenerationErrorLoad =>
      'Ergebnisbild konnte nicht geladen werden.';

  @override
  String get homeGenerationOpenOriginal => 'Original öffnen';

  @override
  String get homeGenerationRegenerate => 'Neu erstellen';

  @override
  String get homeGenerationOpenFailed =>
      'Original konnte nicht geöffnet werden.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'Eine Textzeile. Eine komplette Szene.';

  @override
  String get showcaseSubtitle =>
      'Sieh, wie REEL eine Beschreibung Schritt für Schritt in ein echtes Bild verwandelt.';

  @override
  String get showcasePrompt1 =>
      '\"Astronaut beim Surfen auf den roten Marsdünen, goldene Stunde, Weitwinkel\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"Maskenball unter Lüstern, langsame Kamerabewegung\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"Reiter im Sandsturm in der Dämmerung, Tracking-Shot\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Vier Werkzeuge, eine Aufnahme';

  @override
  String get featuresSubtitle =>
      'Alles, was du brauchst, um von einer Textzeile zum fertigen Bild zu kommen.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Licht, Kamerabewegung und cineastische Grammatik aus Millionen echter Bilder.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 für Breitbild, 1:1 für Feed, 9:16 für Storys — kein Neuschnitt nötig.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — wähle die Textur vor Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'Derselbe Prompt, dasselbe Studio. Bilder sofort; Video, wenn es bereit ist.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Häufige Fragen';

  @override
  String get faqSubtitle => 'Noch etwas offen? Schreib dem REEL-Team.';

  @override
  String get faqQ1 => 'Wie funktioniert REEL?';

  @override
  String get faqA1 =>
      'Tippe eine Beschreibung, wähle Seitenverhältnis und Film Stock. REEL erzeugt ein Bild. Video ist in Entwicklung.';

  @override
  String get faqQ2 => 'Was unterscheidet REEL von anderen KI-Tools?';

  @override
  String get faqA2 =>
      'REEL fokussiert auf cineastische Sprache — Licht, Bildaufbau und Film-Stock — in einem Studio.';

  @override
  String get faqQ3 => 'Wie viele kostenlose Takes bekomme ich?';

  @override
  String get faqA3 =>
      'Aktuelles Kontingent und Credits siehst du im Studio nach dem Login. Details in den Preisen.';

  @override
  String get faqQ4 => 'Welche Formate und Auflösungen gibt es?';

  @override
  String get faqA4 =>
      'Bilder unterstützen 16:9, 1:1 und 9:16. Größe hängt von der Konfiguration ab.';

  @override
  String get faqQ5 => 'Kann ich Ergebnisse kommerziell nutzen?';

  @override
  String get faqA5 =>
      'Prüfe die Produktionsbedingungen und Vorteile deines Tarifs vor kommerzieller Nutzung.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Wähle dein Drehtempo';

  @override
  String get plansSubtitle =>
      'Starte kostenlos, upgrade, wenn dein Roll länger laufen soll.';

  @override
  String get ctaReady => 'Bereit für deinen';

  @override
  String get ctaReadyItalic => 'ersten Take?';

  @override
  String get ctaBody =>
      'Kostenlos, ohne Kreditkarte — erstes Bild in unter einer Minute.';

  @override
  String get ctaFreeButton => 'Kostenloses Konto erstellen';

  @override
  String get ctaGalleryButton => 'Galerie ansehen';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Aktuelle Bilder';

  @override
  String get contactSheetSubtitle =>
      'Ein paar Szenen, die die REEL-Community gerade fertiggestellt hat.';

  @override
  String get contactSheetDialogTitle => 'Vorschau des Bildstils.';

  @override
  String get contactSheetDialogBody =>
      'Erstelle deinen eigenen Take im Studio.';

  @override
  String get contactSheetClose => 'Schließen';

  @override
  String get pricingTitle => 'PREISE';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Wähle dein Drehtempo';

  @override
  String get pricingSubheading =>
      'Starte kostenlos, upgrade, wenn dein Roll länger laufen soll.';

  @override
  String get pricingEmpty => 'Aktuell keine aktiven Pakete.';

  @override
  String get pricingBuyButton => 'PAKET KAUFEN';

  @override
  String get pricingFreeCta => 'Kostenlos nutzen';

  @override
  String get pricingSignInFirst => 'Bitte melde dich vor dem Kauf an.';

  @override
  String get pricingLoadFailed => 'Pakete konnten nicht geladen werden.';

  @override
  String get pricingStripeOpenFailed =>
      'Stripe-Seite konnte nicht geöffnet werden.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout geöffnet. Credits werden nach erfolgreicher Zahlung automatisch gutgeschrieben.';

  @override
  String get pricingCreditsSuffix => ' CREDITS';

  @override
  String get pricingCreditsPerMonth => 'Credits pro Monat';

  @override
  String get pricingPeriodMonthly => '/Monat';

  @override
  String get pricingPeriodYearly => '/Jahr';

  @override
  String get pricingFreePerk =>
      '25 gratis Credits bei der Registrierung — teste das Studio ganz ohne Risiko.';

  @override
  String get profileTitle => 'MEIN PROFIL';

  @override
  String profileLoadFailed(Object message) {
    return 'Profil konnte nicht geladen werden: $message';
  }

  @override
  String get profileNotLoaded =>
      'Profilinformationen konnten nicht geladen werden';

  @override
  String get profileEditButton => 'PROFIL BEARBEITEN';

  @override
  String get profileChangePasswordButton => 'PASSWORT ÄNDERN';

  @override
  String get profileUsageSection => 'NUTZUNG & CREDITS';

  @override
  String get profileCreditBalance => 'Credit-Saldo';

  @override
  String get profileDailyUsage => 'Heute verwendet';

  @override
  String get profileAccountSection => 'KONTO-INFO';

  @override
  String get profileUserId => 'Benutzer-ID';

  @override
  String get profileStatus => 'Status';

  @override
  String get profileStatusActive => 'Aktiv';

  @override
  String get profileStatusInactive => 'Inaktiv';

  @override
  String get profileMemberSince => 'Mitglied seit';

  @override
  String get profileUnknownName => 'Unbekannt';

  @override
  String get profileUnknownEmail => 'Keine E-Mail';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'PROFIL BEARBEITEN';

  @override
  String get editProfileSubhead => 'Aktualisiere deine Profilinformationen';

  @override
  String get editProfileSave => 'SPEICHERN';

  @override
  String editProfileLoadFailed(Object message) {
    return 'Profil konnte nicht geladen werden: $message';
  }

  @override
  String get editProfileSaveFailed => 'Profil konnte nicht aktualisiert werden';

  @override
  String get changePasswordTitle => 'PASSWORT ÄNDERN';

  @override
  String get changePasswordSubhead =>
      'Gib dein aktuelles Passwort ein und wähle ein neues';

  @override
  String get changePasswordCurrent => 'Aktuelles Passwort';

  @override
  String get changePasswordNew => 'Neues Passwort';

  @override
  String get changePasswordConfirm => 'Neues Passwort bestätigen';

  @override
  String get changePasswordCurrentRequired =>
      'Bitte aktuelles Passwort eingeben';

  @override
  String get changePasswordNewRequired => 'Bitte neues Passwort eingeben';

  @override
  String get changePasswordTooShort =>
      'Passwort muss mindestens 8 Zeichen haben';

  @override
  String get changePasswordConfirmRequired => 'Bitte neues Passwort bestätigen';

  @override
  String get changePasswordMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get changePasswordSubmit => 'PASSWORT ÄNDERN';

  @override
  String get changePasswordFailed => 'Passwort konnte nicht geändert werden';

  @override
  String get libraryTitle => 'Bibliothek';

  @override
  String get libraryTabGenerations => 'GENERIERUNGEN';

  @override
  String get libraryTabCredits => 'CREDITS';

  @override
  String get libraryTabPayments => 'ZAHLUNGEN';

  @override
  String get libraryReload => 'Neu laden';

  @override
  String get librarySignInPrompt => 'ANMELDEN, UM BIBLIOTHEK ZU SEHEN';

  @override
  String get libraryRetry => 'ERNEUT VERSUCHEN';

  @override
  String get libraryLoadFailed => 'Bibliothek konnte nicht geladen werden.';

  @override
  String get libraryEmptyGenerations => 'Du hast noch keine Bilder erstellt.';

  @override
  String get libraryEmptyCredits => 'Noch keine Credit-Transaktionen.';

  @override
  String get libraryEmptyPayments => 'Noch keine Zahlungen.';

  @override
  String get libraryDeleteDialogTitle => 'Generierung löschen?';

  @override
  String get libraryDeleteDialogBody =>
      'Diese Generierung wirklich löschen? Das kann nicht rückgängig gemacht werden.';

  @override
  String get libraryDeleteCancel => 'ABBRECHEN';

  @override
  String get libraryDeleteConfirm => 'LÖSCHEN';

  @override
  String get libraryDeleteSuccess => 'Generierung gelöscht';

  @override
  String get libraryDeleteFailed => 'Generierung konnte nicht gelöscht werden';

  @override
  String get libraryStatusCompleted => 'Fertig';

  @override
  String get libraryStatusFailed => 'Fehler';

  @override
  String get libraryStatusProcessing => 'In Verarbeitung';

  @override
  String get libraryStatusPending => 'Wartet';

  @override
  String get paymentResultSuccess => 'ZAHLUNG ERFOLGREICH';

  @override
  String get paymentResultCancel => 'ZAHLUNG ABGEBROCHEN';

  @override
  String get paymentResultError => 'ZAHLUNG FEHLGESCHLAGEN';

  @override
  String get paymentResultSuccessMsg =>
      'Deine Zahlung wurde verarbeitet. Credits wurden deinem Konto gutgeschrieben.';

  @override
  String get paymentResultCancelMsg =>
      'Du hast die Zahlung abgebrochen. Es wurde nichts belastet.';

  @override
  String get paymentResultErrorMsg =>
      'Bei der Zahlung ist ein Fehler aufgetreten. Bitte erneut versuchen oder Support kontaktieren.';

  @override
  String get paymentResultLoadFailed =>
      'Zahlungsinformationen konnten nicht geladen werden';

  @override
  String get paymentDetailPackage => 'Paket';

  @override
  String get paymentDetailCredits => 'Credits';

  @override
  String get paymentDetailAmount => 'Betrag';

  @override
  String get paymentDetailTransaction => 'Transaktion';

  @override
  String get paymentBackHome => 'ZUR STARTSEITE';

  @override
  String get paymentTryAgain => 'ERNEUT VERSUCHEN';

  @override
  String get termsEyebrow => 'RECHTLICHES';

  @override
  String get termsHeadline => 'Nutzungsbedingungen';

  @override
  String get termsSubhead =>
      'Zuletzt aktualisiert: 10.09.2026 · Gilt für den gesamten REEL-Service';

  @override
  String get termsBackShort => 'ZURÜCK';

  @override
  String get termsBackLong => 'ZUR STARTSEITE';

  @override
  String get termsFooterText => 'REEL — IM DUNKELN ENTWICKELT. BILD FÜR BILD.';

  @override
  String get termsAccept => 'ICH STIMME ZU';

  @override
  String get termsDecline => 'ZURÜCK';

  @override
  String get adminDashboardTitle => 'Admin-Dashboard';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Übersicht';

  @override
  String get adminSidebarGenerations => 'Generierungen';

  @override
  String get adminSidebarUsers => 'Benutzer';

  @override
  String get adminSidebarPayments => 'Zahlungen';

  @override
  String get adminSidebarSettings => 'Einstellungen';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Administrator';

  @override
  String get adminMenuTooltip => 'Menü öffnen';

  @override
  String get adminRtlTooltip => 'Layout-Richtung LTR / RTL umschalten';

  @override
  String get adminRefreshTooltip => 'Neu laden';

  @override
  String get adminSearchUsersHint => 'Nutzer suchen…';

  @override
  String get adminExportTooltip => 'Bericht exportieren';

  @override
  String get adminExportLabel => 'EXPORT';

  @override
  String get adminExportComingSoon => 'Der Berichtsexport kommt bald.';

  @override
  String get adminNotificationsTooltip => 'Benachrichtigungen';

  @override
  String get adminRangeLabel => 'Bereich';

  @override
  String get adminRangeToday => 'Heute';

  @override
  String get adminRange7Days => '7 Tage';

  @override
  String get adminRange30Days => '30 Tage';

  @override
  String get adminRangeTodayLong => 'heute';

  @override
  String get adminRange7DaysLong => 'in den letzten 7 Tagen';

  @override
  String get adminRange30DaysLong => 'in den letzten 30 Tagen';

  @override
  String get adminAutoUpdateNote => 'Tägliche Auto-Aktualisierung um 00:00';

  @override
  String adminKpiTakes(Object range) {
    return 'Takes $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Aktive Benutzer — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Umsatz — $range';
  }

  @override
  String get adminKpiQueue => 'Render-Warteschlange';

  @override
  String get adminDailyOutputTitle => 'Output der letzten 7 Tage';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return 'Der $ratio16x9-Anteil macht 58 % der Renders dieser Woche aus — gefolgt von 1:1 (24 %) und 9:16 (18 %).';
  }

  @override
  String get adminStockMixTitle => 'Stilverhältnis';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Letzte Renders';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Benutzer';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Liste öffnen';

  @override
  String get adminFleetTitle => 'Warteschlange & GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter => '3/5 Worker laufen · 1 Wartung · 1 idle';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'Verarbeitung — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Idle — wartet auf nächsten Job';

  @override
  String get adminFleetJobMaintenance => 'Geplante Wartung';

  @override
  String get adminGenerationCompleted => 'Fertig';

  @override
  String get adminGenerationProcessing => 'Rendert';

  @override
  String get adminGenerationFailed => 'Fehler';

  @override
  String get adminUserStatusActive => 'Aktiv';

  @override
  String get adminUserStatusInactive => 'Inaktiv';

  @override
  String get adminUserStatusBanned => 'Gebannt';

  @override
  String get adminUserRoleAdmin => 'Admin';

  @override
  String get adminUserRoleUser => 'Benutzer';

  @override
  String get adminSettingsTitle => 'Einstellungen';

  @override
  String get adminSettingsStudioName => 'Studio-Anzeigename';

  @override
  String get adminSettingsSupportEmail => 'Support-E-Mail';

  @override
  String get adminSettingsImageCost => 'Credit-Kosten pro Bild';

  @override
  String get adminSettingsVideoCost => 'Credit-Kosten pro Video';

  @override
  String get adminSettingsAlerts => 'Warnungen';

  @override
  String get adminSettingsAlertPayment => 'Bei Zahlungsfehlern benachrichtigen';

  @override
  String get adminSettingsAlertGeneration =>
      'Bei Generierungsfehlern benachrichtigen';

  @override
  String get adminSettingsNewsletter => 'Newsletter senden';

  @override
  String get adminSettingsMaintenance => 'Wartungsmodus';

  @override
  String get adminSettingsRegistration => 'Neue Registrierungen erlauben';

  @override
  String get adminSettingsSave => 'SPEICHERN';

  @override
  String get adminSettingsLoadFailed =>
      'Einstellungen konnten nicht geladen werden.';

  @override
  String get adminSettingsSaved => 'Einstellungen gespeichert.';

  @override
  String get adminSettingsSaveFailed =>
      'Einstellungen konnten nicht gespeichert werden.';

  @override
  String get adminPackagesTitle => 'Zahlungspakete';

  @override
  String get adminPackagesEmpty => 'Noch keine Pakete.';

  @override
  String get adminPackagesLoadFailed => 'Pakete konnten nicht geladen werden.';

  @override
  String get adminPackagesNew => 'Neues Paket';

  @override
  String get adminPackagesFeatured => 'Empfohlen';

  @override
  String get adminPackagesInactive => 'Inaktiv';

  @override
  String get adminPackagesActive => 'Aktiv';

  @override
  String get adminPaymentsTitle => 'Zahlungen';

  @override
  String get adminPaymentsEmpty => 'Noch keine Zahlungen.';

  @override
  String get adminPaymentsLoadFailed =>
      'Zahlungen konnten nicht geladen werden.';

  @override
  String get adminPaymentsFilterAll => 'Alle';

  @override
  String get adminCreditsTitle => 'Credit-Transaktionen';

  @override
  String get adminCreditsEmpty => 'Noch keine Credit-Transaktionen.';

  @override
  String get adminCreditsLoadFailed =>
      'Credit-Transaktionen konnten nicht geladen werden.';

  @override
  String get adminUsersTitle => 'Benutzer';

  @override
  String get adminUsersEmpty => 'Keine Benutzer gefunden.';

  @override
  String get adminUsersLoadFailed => 'Benutzer konnten nicht geladen werden.';

  @override
  String get adminUsersSearch => 'Nach E-Mail oder Name suchen';

  @override
  String get adminUsersRefresh => 'Neu laden';

  @override
  String get adminUsersReset => 'Zurücksetzen';

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonClose => 'Schließen';

  @override
  String get termsTocLabel => 'Inhalt';

  @override
  String get termsNoteBox =>
      'Dies ist ein UI/UX-Entwurf mit Beispieltext. Vor einer offiziellen Veröffentlichung sollte REEL den Text rechtlich prüfen lassen.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'Support-E-Mail';

  @override
  String get termsContactButton => 'Support kontaktieren';

  @override
  String get termsS01Title => 'Annahme der Bedingungen';

  @override
  String get termsS01P1 =>
      'Mit der Erstellung eines Kontos oder der Nutzung einer Funktion von REEL (Bildgenerierung, Videogenerierung, Credit-Aufladung, Plan-Upgrade) stimmen Sie den folgenden Bedingungen zu. Wenn Sie nicht einverstanden sind, nutzen Sie den Dienst bitte nicht weiter.';

  @override
  String get termsS01P2 =>
      'REEL richtet sich an Nutzer ab 13 Jahren. Nutzer unter 18 Jahren benötigen die Zustimmung eines Elternteils oder Erziehungsberechtigten.';

  @override
  String get termsS02Title => 'Konto';

  @override
  String get termsS02P1 =>
      'Jedes Konto ist an eine eindeutige E-Mail-Adresse gebunden. Sie sind für die Geheimhaltung Ihres Passworts und alle Aktivitäten unter Ihrem Konto verantwortlich.';

  @override
  String get termsS02B1 =>
      'Registrierungsdaten (Name, E-Mail) müssen korrekt und aktuell sein.';

  @override
  String get termsS02B2 =>
      'REEL kann eine E-Mail-Verifikation verlangen, bevor bestimmte Funktionen freigeschaltet werden.';

  @override
  String get termsS02B3 =>
      'Konten können je nach Nutzungsverlauf und Verstößen aktiv, inaktiv oder gebannt sein.';

  @override
  String get termsS03Title => 'Credits & KI-Generierung';

  @override
  String get termsS03P1 =>
      'REEL arbeitet mit einem Credit-System. Jede Bild- oder Videogenerierung (ein „Take\") zieht die entsprechenden Credits aus Ihrer Wallet ab, je nach Typ, Auflösung und Dauer.';

  @override
  String get termsS03B1 =>
      'Credits werden abgezogen, sobald die Generierungsanfrage startet.';

  @override
  String get termsS03B2 =>
      'Schlägt eine Generierung wegen eines Systemfehlers fehl, werden die Credits automatisch erstattet.';

  @override
  String get termsS03B3 =>
      'REEL erstattet keine Credits, wenn die Anfrage wegen Verstoßes gegen die Bedingungen fehlschlägt (siehe Abschnitt 6).';

  @override
  String get termsS03B4 =>
      'Nicht verwendete Credits aus Monats-/Jahresplänen werden nicht auf den nächsten Zyklus übertragen, sofern nicht anders angegeben.';

  @override
  String get termsS04Title => 'Zahlung & Erstattung';

  @override
  String get termsS04P1 =>
      'REEL akzeptiert Zahlungen über Momo, ZaloPay, VNPay, Banküberweisung und Stripe (für internationale Pläne). Jede Transaktion erhält eine eigene ID zur Nachverfolgung.';

  @override
  String get termsS04B1 =>
      'Monats-/Jahrespläne werden automatisch verlängert, sofern Sie nicht vor dem nächsten Zyklus kündigen.';

  @override
  String get termsS04B2 =>
      'Erstattungsanfragen werden innerhalb von 7 Tagen nach Zahlung geprüft, sofern die Plan-Credits nicht verbraucht wurden.';

  @override
  String get termsS04B3 =>
      'Einmalige Credit-Aufladungen sind nach Gutschrift nicht erstattbar.';

  @override
  String get termsS05Title => 'Inhaltsrechte';

  @override
  String get termsS05P1 =>
      'Sie behalten Nutzungsrechte an den Inhalten, die Sie auf REEL erstellen, im Rahmen Ihres aktuellen Plans.';

  @override
  String get termsS05B1 =>
      'Free-Plan: Inhalte tragen ein REEL-Wasserzeichen und sind für den persönlichen, nicht-kommerziellen Gebrauch.';

  @override
  String get termsS05B2 =>
      'Pro-Plan: Inhalte haben kein Wasserzeichen und dürfen kommerziell genutzt werden.';

  @override
  String get termsS05B3 =>
      'REEL garantiert nicht, dass KI-generierte Inhalte originell sind; die Prüfung vor kommerzieller Nutzung liegt bei Ihnen.';

  @override
  String get termsS06Title => 'Verbotenes Verhalten';

  @override
  String get termsS06P1 =>
      'Sie dürfen REEL nicht zur Erstellung oder Verbreitung von Inhalten verwenden, die:';

  @override
  String get termsS06B1 =>
      'Geltendes Recht verletzen, zu Gewalt, Diskriminierung oder Hass aufrufen.';

  @override
  String get termsS06B2 =>
      'Pornografisch sind oder Minderjährige in irgendeiner Form betreffen.';

  @override
  String get termsS06B3 =>
      'Andere Personen imitieren, die Privatsphäre verletzen oder Bilder ohne Erlaubnis verwenden.';

  @override
  String get termsS06B4 =>
      'Urheber-, Marken- oder andere Schutzrechte Dritter verletzen.';

  @override
  String get termsS06P2 =>
      'Verstöße können ohne Vorwarnung zur Sperrung des Kontos führen; Credits und Gebühren werden nicht erstattet.';

  @override
  String get termsS07Title => 'Haftungsbeschränkung';

  @override
  String get termsS07P1 =>
      'Der Dienst wird „wie besehen\" bereitgestellt. REEL garantiert keinen ununterbrochenen oder fehlerfreien Betrieb und nicht, dass jedes Ergebnis Ihren Erwartungen entspricht.';

  @override
  String get termsS07P2 =>
      'Im gesetzlich maximal zulässigen Umfang haftet REEL nicht für indirekte Schäden, die aus der Nutzung oder Nicht-Nutzung des Dienstes entstehen.';

  @override
  String get termsS08Title => 'Kontoschließung';

  @override
  String get termsS08P1 =>
      'Sie können die Nutzung jederzeit beenden und die Löschung Ihres Kontos verlangen. REEL kann Konten, die gegen die Bedingungen verstoßen, vorübergehend (inactive) oder dauerhaft (banned) sperren, wobei die Schwere des Verstoßes berücksichtigt wird.';

  @override
  String get termsS09Title => 'Änderungen der Bedingungen';

  @override
  String get termsS09P1 =>
      'REEL kann diese Bedingungen aktualisieren. Wichtige Änderungen werden per E-Mail oder über ein Banner auf der Startseite mindestens 7 Tage vor dem Inkrafttreten mitgeteilt.';

  @override
  String get termsS10Title => 'Kontakt';

  @override
  String get termsS10P1 =>
      'Bei Fragen zu diesen Bedingungen wenden Sie sich bitte an das REEL-Team.';

  @override
  String get errorPasswordRequired => 'Bitte gib dein Passwort ein.';

  @override
  String get errorConfirmPasswordRequired => 'Bitte bestätige dein Passwort.';

  @override
  String get backToHomeLabel => 'START';

  @override
  String get backToHomeTooltip => 'Zur Startseite';

  @override
  String get profileBackHome => 'Zurück zur Startseite';

  @override
  String get profileNavOverview => 'Übersicht';

  @override
  String get profileNavMyRoll => 'Mein Roll';

  @override
  String get profileNavSettings => 'Einstellungen';

  @override
  String get profileNavBilling => 'Tarife & Abrechnung';

  @override
  String get profileLogout => 'Abmelden';

  @override
  String profileWelcomeBack(String name) {
    return 'Willkommen zurück, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'Hier ist dein Roll für heute.';
  }

  @override
  String get profileStatTotalTakes => 'Takes gesamt';

  @override
  String get profileStatFavoriteStock => 'Lieblingsstock';

  @override
  String get profileStatDaysLabel => 'Tage mit REEL';

  @override
  String profileStatDaysValue(int n) {
    return '$n Tage';
  }

  @override
  String get profileUpgradePro => 'Auf Pro upgraden';

  @override
  String get profileRecentActivity => 'Letzte Aktivität';

  @override
  String get profileViewAll => 'Alle ansehen →';

  @override
  String get profileMyRollSub => 'Alles, was du auf REEL erstellt hast.';

  @override
  String get profileFilterAll => 'Alle';

  @override
  String get profileFilterVideo => 'Video';

  @override
  String get profileFilterPhoto => 'Foto';

  @override
  String get profilePhotoTag => 'Foto';

  @override
  String get profileMyRollEmpty =>
      'Noch keine Takes — erstelle deinen ersten Frame im Studio.';

  @override
  String get profileTimeJustNow => 'Gerade eben';

  @override
  String profileTimeMinutesAgo(int n) {
    return 'vor $n Min.';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return 'vor $n Std.';
  }

  @override
  String get profileTimeYesterday => 'Gestern';

  @override
  String profileTimeDaysAgo(int n) {
    return 'vor $n Tagen';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return 'vor $n Wochen';
  }

  @override
  String get profileSettingsSub =>
      'Aktualisiere deine Profilinformationen und Standardeinstellungen.';

  @override
  String get profileSectionProfileInfo => 'Profilinformationen';

  @override
  String get profileFieldDisplayName => 'Anzeigename';

  @override
  String get profileFieldEmail => 'E-Mail';

  @override
  String get profileSaveChanges => 'Änderungen speichern';

  @override
  String get profileSectionPassword => 'Passwort ändern';

  @override
  String get profileFieldCurrentPassword => 'Aktuelles Passwort';

  @override
  String get profileFieldNewPassword => 'Neues Passwort';

  @override
  String get profileFieldConfirmPassword => 'Neues Passwort bestätigen';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'Mindestens 8 Zeichen';

  @override
  String get profilePwConfirmPlaceholder => 'Erneut eingeben';

  @override
  String get profileUpdatePassword => 'Passwort aktualisieren';

  @override
  String get profilePwShow => 'Anzeigen';

  @override
  String get profilePwHide => 'Ausblenden';

  @override
  String get profileSectionPrefs => 'Standardeinstellungen';

  @override
  String get profilePrefRatio => 'Standard-Seitenverhältnis';

  @override
  String get profilePrefRatioDesc =>
      'Gilt jedes Mal, wenn du den Generator öffnest';

  @override
  String get profilePrefStock => 'Standard-Stock';

  @override
  String get profilePrefStockDesc => 'Der Look für deine Frames';

  @override
  String get profileDangerTitle => 'Gefahrenzone';

  @override
  String get profileDangerDesc =>
      'Beim Löschen deines Kontos wird dein gesamter Roll entfernt. Das kann nicht rückgängig gemacht werden.';

  @override
  String get profileDeleteAccount => 'Konto löschen';

  @override
  String get profileDeleteNotice =>
      'Die Kontolöschung übernimmt das REEL-Team — wende dich dazu an den Support.';

  @override
  String get profileBillingSub => 'Verwalte deinen Tarif und Zahlungsmethoden.';

  @override
  String get profileCurrentPlan => 'Aktueller Tarif';

  @override
  String get profilePlanPerMonth => '/ Monat';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '10 Credits zum Start';

  @override
  String get profilePlanFreeF2 => 'REEL-Wasserzeichen';

  @override
  String get profilePlanProF1 => 'Credit-Pakete nach Bedarf';

  @override
  String get profilePlanProF2 => '4K, ohne Wasserzeichen';

  @override
  String get profileCurrentTag => 'In Verwendung';

  @override
  String get profileUpgradeShort => 'Upgraden';

  @override
  String get profilePaymentHistory => 'Zahlungsverlauf';

  @override
  String get profileEmptyPayments =>
      'Noch keine Transaktionen — upgrade auf Pro, um loszulegen.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'Profilinformationen aktualisiert!';

  @override
  String get profilePasswordUpdated => 'Passwort aktualisiert!';

  @override
  String get profileProChip => 'PRO-TARIF';

  @override
  String get profileFreeChip => 'GRATIS-TARIF';

  @override
  String get adminSidebarModeration => 'Moderation';

  @override
  String get adminSidebarRevenue => 'Umsatz';

  @override
  String get adminSidebarSystem => 'System';

  @override
  String get adminRoleChip => 'Administrator';

  @override
  String usageCreditsLabel(int balance) {
    return '$balance Credits verfügbar';
  }

  @override
  String get homeStatCreditsLeft => 'GUTHABEN';

  @override
  String get profileStatCredits => 'Credits';

  @override
  String profileCreditsAvailable(int balance) {
    return '$balance Credits verfügbar';
  }

  @override
  String get profileTopUp => 'Aufladen';

  @override
  String get profilePlanPayAsYouGo => '/ Zahlung pro Bild';

  @override
  String profileUsageSpentToday(int spent) {
    return '$spent Credits heute genutzt';
  }

  @override
  String get profileTopUpHint => 'Lade Credits auf, um weiter zu erstellen.';

  @override
  String get avatarUpdated => 'Avatar aktualisiert';

  @override
  String get avatarUpdateFailed =>
      'Avatar-Upload fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get avatarChangeHint => 'Profilbild ändern';

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

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'REEL — Studio Cinéma & Photo IA';

  @override
  String get languageLabel => 'Langue';

  @override
  String get languagePickerTooltip => 'Choisir la langue de l\'interface';

  @override
  String get signIn => 'CONNEXION';

  @override
  String get signUp => 'INSCRIPTION';

  @override
  String get getStarted => 'Commencer';

  @override
  String get forgot => 'OUBLI';

  @override
  String get resetPassword => 'RÉINITIALISER LE MOT DE PASSE';

  @override
  String get newPassword => 'NOUVEAU MOT DE PASSE';

  @override
  String get credentialsBadge => 'IDENTIFIANTS';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · ACCÈS $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'CONNEXION';

  @override
  String get productionAccessRollSignUp => 'INSCRIPTION';

  @override
  String get productionAccessRollReset => 'RÉINITIALISER LE MOT DE PASSE';

  @override
  String get productionAccessRollNewPassword => 'NOUVEAU MOT DE PASSE';

  @override
  String get authHeadlineSignIn => 'Chaque scène';

  @override
  String get authHeadlineSignInItalic => 'a besoin d\'une distribution.';

  @override
  String get authSubheadSignIn =>
      'Connectez-vous pour continuer à créer, sauvegarder vos œuvres et gérer votre roll.';

  @override
  String get authHeadlineSignUp => 'Rejoignez la';

  @override
  String get authHeadlineSignUpItalic => 'production.';

  @override
  String get authSubheadSignUp =>
      'Créez un compte pour sauvegarder vos rolls, suivre vos prises quotidiennes et revenir quand l\'inspiration passe.';

  @override
  String get authHeadlineForgot => 'Vous avez perdu';

  @override
  String get authHeadlineForgotItalic => 'le négatif ?';

  @override
  String get authSubheadForgot =>
      'Saisissez votre e-mail pour recevoir un lien de réinitialisation.';

  @override
  String get authHeadlineReset => 'Faites une';

  @override
  String get authHeadlineResetItalic => 'nouvelle coupe.';

  @override
  String get authSubheadReset =>
      'Créez un nouveau mot de passe pour revenir dans votre espace créatif.';

  @override
  String get inputEmail => 'E-MAIL';

  @override
  String get inputEmailHint => 'vous@example.com';

  @override
  String get inputPassword => 'MOT DE PASSE';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'Au moins 8 caractères';

  @override
  String get inputFullName => 'NOM AFFICHÉ';

  @override
  String get inputFullNameHint => 'Réalisateur de ce roll';

  @override
  String get inputConfirmPassword => 'CONFIRMER LE MOT DE PASSE';

  @override
  String get inputConfirmPasswordHint => 'Retapez le mot de passe';

  @override
  String get inputResetCode => 'CODE DE RÉINITIALISATION';

  @override
  String get inputResetCodeHint => 'Coller le code reçu par e-mail';

  @override
  String get inputNewPassword => 'NOUVEAU MOT DE PASSE';

  @override
  String get inputNewPasswordHint => 'Au moins 8 caractères';

  @override
  String get inputNewPasswordConfirmHint => 'Retapez le nouveau mot de passe';

  @override
  String get inputAvatarUrl => 'URL DE L\'AVATAR (OPTIONNEL)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Nom complet';

  @override
  String get inputFullNameEditHint => 'Entrez votre nom complet';

  @override
  String get toggleShowPassword => 'Afficher le mot de passe';

  @override
  String get toggleHidePassword => 'Masquer le mot de passe';

  @override
  String get rememberMe => 'Se souvenir de moi';

  @override
  String get forgotPasswordLink => 'Mot de passe oublié ?';

  @override
  String get signInButton => 'ENTRER DANS LE ROLL ►';

  @override
  String get signUpButton => 'DÉMARRER LE ROLL ►';

  @override
  String get forgotButton => 'ENVOYER LE LIEN ►';

  @override
  String get resetPasswordButton => 'CHANGER LE MOT DE PASSE ►';

  @override
  String get orDivider => 'OU';

  @override
  String get noAccountPrompt => 'Pas encore de compte ? ';

  @override
  String get noAccountLink => 'Inscrivez-vous';

  @override
  String get hasAccountPrompt => 'Déjà un compte ? ';

  @override
  String get hasAccountLink => 'Se connecter';

  @override
  String get forgotRememberedPrompt => 'Mot de passe retrouvé ? ';

  @override
  String get forgotRememberedLink => 'Retour à la connexion';

  @override
  String get resetRememberedPrompt => 'Mot de passe retrouvé ? ';

  @override
  String get resetRememberedLink => 'Retour à la connexion';

  @override
  String get agreeTermsPrefix => 'J\'accepte les ';

  @override
  String get agreeTermsLink => 'Conditions de production';

  @override
  String get agreeTermsSemantic => 'J\'accepte les Conditions de production';

  @override
  String get forgotDescription =>
      'Saisissez l\'e-mail utilisé lors de votre inscription. Le code est valide 30 minutes.';

  @override
  String get statsFooter => 'VOTRE PROCHAINE SCÈNE COMMENCE ICI';

  @override
  String get errorEmailPasswordRequired =>
      'Veuillez saisir l\'e-mail et le mot de passe.';

  @override
  String get errorAllFieldsRequired => 'Veuillez remplir tous les champs.';

  @override
  String get errorPasswordTooShort =>
      'Le mot de passe doit contenir au moins 8 caractères.';

  @override
  String get errorPasswordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get errorAcceptTerms =>
      'Veuillez accepter les conditions de production.';

  @override
  String get errorEmailRequired => 'Veuillez saisir un e-mail.';

  @override
  String get errorResetCodeRequired =>
      'Code requis et mot de passe d\'au moins 8 caractères.';

  @override
  String get errorGeneric => 'Connexion au serveur impossible.';

  @override
  String get errorInvalidEmail => 'Veuillez saisir une adresse e-mail valide.';

  @override
  String get errorInvalidAvatarUrl =>
      'L\'URL de l\'avatar doit commencer par http:// ou https://.';

  @override
  String get errorSignInFailed => 'E-mail ou mot de passe incorrect.';

  @override
  String get errorSignUpFailed => 'Échec de l\'inscription.';

  @override
  String get errorForgotFailed =>
      'Impossible de créer le lien de réinitialisation.';

  @override
  String get errorResetFailed => 'Impossible de réinitialiser le mot de passe.';

  @override
  String get errorFullNameRequired => 'Veuillez saisir votre nom.';

  @override
  String get successSignUp => 'Inscription réussie ! Connectez-vous.';

  @override
  String get successResetPassword => 'Mot de passe modifié.';

  @override
  String get successForgotEmail => 'Si l\'e-mail existe, le lien a été envoyé.';

  @override
  String get successProfileSaved => 'Profil mis à jour !';

  @override
  String get successPasswordChanged =>
      'Mot de passe modifié ! Reconnectez-vous.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'Impossible de charger le profil : $message';
  }

  @override
  String get explore => 'Explorer';

  @override
  String get gallery => 'Galerie';

  @override
  String get faq => 'FAQ';

  @override
  String get pricing => 'Tarifs';

  @override
  String get loginPrompt => 'Connectez-vous avant de générer une image.';

  @override
  String get emptyPrompt => 'Saisissez un prompt avant d\'appuyer sur Action.';

  @override
  String get imageOnlySupported =>
      'REEL ne prend actuellement en charge que text-to-image. Choisissez Photo.';

  @override
  String get imageGenerationFailed =>
      'Impossible de générer l\'image. Vérifiez le backend et le modèle.';

  @override
  String get noImageReturned => 'Le modèle n\'a pas renvoyé d\'image.';

  @override
  String get videoDurationLabel => 'DURÉE';

  @override
  String get videoQualityLabel => 'QUALITÉ';

  @override
  String get videoQueuedMessage =>
      'La vidéo est en cours de rendu — cela prend quelques minutes. Le résultat apparaîtra ici.';

  @override
  String get videoGenerationFailed =>
      'La génération de la vidéo a échoué. Vos crédits ont été remboursés.';

  @override
  String get videoTimeoutMessage =>
      'La vidéo prend plus de temps que prévu. Consultez d\'ici peu Mon roll dans votre profil.';

  @override
  String get videoReadyLabel => 'Votre vidéo est prête';

  @override
  String get usageLabelSignedOut => 'Connectez-vous pour commencer';

  @override
  String get rtlToggleTooltip => 'Basculer la disposition LTR / RTL';

  @override
  String get footerTagline =>
      'REEL — développé dans l\'obscurité, une image à la fois. Transformez une ligne de texte en un plan.';

  @override
  String get productColumn => 'PRODUIT';

  @override
  String get supportColumn => 'SUPPORT';

  @override
  String get signInLink => 'Connexion';

  @override
  String get signUpLink => 'Inscription';

  @override
  String get footerCaption1 =>
      'REEL — DÉVELOPPÉ DANS L\'OBSCURITÉ. UNE IMAGE À LA FOIS.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Tapez une scène.';

  @override
  String get getTheTake => 'Obtenez la prise.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Transformez une ligne de texte en plan — cadré, éclairé et animé en quelques secondes. Vidéo ou image, un seul roll.';

  @override
  String get homeStatLastTake => 'DERNIÈRE PRISE';

  @override
  String get homeStatAspectRatios => 'FORMATS';

  @override
  String get homeStatFilmStocks => 'FILMS';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'Décrivez votre scène…';

  @override
  String get homeQuickChips =>
      'Bal masqué sous les lustres | Cavalier dans la tempête de sable | Atelier de marionnettes';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'Création de la prise…';

  @override
  String get homeGenerate => 'Générer';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Prise terminée · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => 'Impossible de charger l\'image.';

  @override
  String get homeGenerationOpenOriginal => 'Ouvrir l\'original';

  @override
  String get homeGenerationRegenerate => 'Régénérer';

  @override
  String get homeGenerationOpenFailed => 'Impossible d\'ouvrir l\'original.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'Une ligne de texte. Une scène complète.';

  @override
  String get showcaseSubtitle =>
      'Voyez REEL transformer une description en image, étape par étape.';

  @override
  String get showcasePrompt1 =>
      '\"astronaut surfant sur les dunes rouges de Mars, heure dorée, plan large\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"bal masqué sous les lustres, mouvement de caméra lent\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"cavalier à cheval dans une tempête de sable au crépuscule, plan de poursuite\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Quatre outils, un seul plan';

  @override
  String get featuresSubtitle =>
      'Tout ce qu\'il faut pour passer d\'une ligne de texte à un cadre complet.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Lumière, mouvements de caméra et grammaire cinématographique appris sur des millions d\'images réelles.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 grand écran, 1:1 feed, 9:16 story — pas besoin de tout refaire.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — choisissez la texture avant Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'Même prompt, même studio. Images maintenant ; vidéo quand ce sera prêt.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Questions fréquentes';

  @override
  String get faqSubtitle => 'Une autre question ? Écrivez à l\'équipe REEL.';

  @override
  String get faqQ1 => 'Comment fonctionne REEL ?';

  @override
  String get faqA1 =>
      'Tapez une description, choisissez un format et un film stock. REEL génère une image. La vidéo est en développement.';

  @override
  String get faqQ2 => 'En quoi REEL est différent des autres outils IA ?';

  @override
  String get faqA2 =>
      'REEL se concentre sur le langage cinématographique — lumière, cadrage et film stock — dans un seul studio.';

  @override
  String get faqQ3 => 'Combien de prises gratuites ai-je ?';

  @override
  String get faqA3 =>
      'Votre quota et vos crédits s\'affichent dans le studio après connexion. Voir les tarifs pour les avantages.';

  @override
  String get faqQ4 => 'Quels formats et résolutions ?';

  @override
  String get faqA4 =>
      'Les images supportent 16:9, 1:1 et 9:16. La taille dépend de la configuration.';

  @override
  String get faqQ5 => 'Puis-je utiliser les résultats commercialement ?';

  @override
  String get faqA5 =>
      'Vérifiez les Conditions de production et les avantages de votre plan avant tout usage commercial.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Choisissez votre rythme de tournage';

  @override
  String get plansSubtitle =>
      'Commencez gratuitement, passez à la vitesse supérieure quand votre roll doit durer.';

  @override
  String get ctaReady => 'Prêt pour votre';

  @override
  String get ctaReadyItalic => 'première prise ?';

  @override
  String get ctaBody =>
      'Gratuit, sans carte bancaire — première image en moins d\'une minute.';

  @override
  String get ctaFreeButton => 'Créer un compte gratuit';

  @override
  String get ctaGalleryButton => 'Voir la galerie';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Dernières images';

  @override
  String get contactSheetSubtitle =>
      'Quelques scènes que la communauté REEL vient de monter.';

  @override
  String get contactSheetDialogTitle => 'Aperçu du style visuel.';

  @override
  String get contactSheetDialogBody =>
      'Générez votre propre prise dans le studio.';

  @override
  String get contactSheetClose => 'Fermer';

  @override
  String get pricingTitle => 'TARIFS';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Choisissez votre rythme de tournage';

  @override
  String get pricingSubheading =>
      'Commencez gratuitement, passez à la vitesse supérieure quand votre roll doit durer.';

  @override
  String get pricingEmpty => 'Aucun package actif pour le moment.';

  @override
  String get pricingBuyButton => 'ACHETER LE PACKAGE';

  @override
  String get pricingFreeCta => 'Utiliser gratuitement';

  @override
  String get pricingSignInFirst => 'Connectez-vous avant d\'acheter.';

  @override
  String get pricingLoadFailed => 'Impossible de charger les packages.';

  @override
  String get pricingStripeOpenFailed => 'Impossible d\'ouvrir Stripe.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout ouvert. Les crédits seront ajoutés automatiquement.';

  @override
  String get pricingCreditsSuffix => ' CRÉDITS';

  @override
  String get pricingCreditsPerMonth => 'crédits par mois';

  @override
  String get pricingPeriodMonthly => '/mois';

  @override
  String get pricingPeriodYearly => '/an';

  @override
  String get pricingFreePerk =>
      '25 crédits offerts à l\'inscription — essayez le studio en toute sérénité.';

  @override
  String get profileTitle => 'MON PROFIL';

  @override
  String profileLoadFailed(Object message) {
    return 'Impossible de charger le profil : $message';
  }

  @override
  String get profileNotLoaded => 'Impossible de charger le profil';

  @override
  String get profileEditButton => 'MODIFIER';

  @override
  String get profileChangePasswordButton => 'MOT DE PASSE';

  @override
  String get profileUsageSection => 'USAGE & CRÉDITS';

  @override
  String get profileCreditBalance => 'Solde crédits';

  @override
  String get profileDailyUsage => 'Usage du jour';

  @override
  String get profileAccountSection => 'INFOS DU COMPTE';

  @override
  String get profileUserId => 'ID utilisateur';

  @override
  String get profileStatus => 'Statut';

  @override
  String get profileStatusActive => 'Actif';

  @override
  String get profileStatusInactive => 'Inactif';

  @override
  String get profileMemberSince => 'Membre depuis';

  @override
  String get profileUnknownName => 'Inconnu';

  @override
  String get profileUnknownEmail => 'Pas d\'e-mail';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'MODIFIER LE PROFIL';

  @override
  String get editProfileSubhead => 'Mettez à jour vos informations';

  @override
  String get editProfileSave => 'ENREGISTRER';

  @override
  String editProfileLoadFailed(Object message) {
    return 'Impossible de charger le profil : $message';
  }

  @override
  String get editProfileSaveFailed => 'Impossible de mettre à jour le profil';

  @override
  String get changePasswordTitle => 'CHANGER LE MOT DE PASSE';

  @override
  String get changePasswordSubhead =>
      'Saisissez votre mot de passe actuel puis un nouveau';

  @override
  String get changePasswordCurrent => 'Mot de passe actuel';

  @override
  String get changePasswordNew => 'Nouveau mot de passe';

  @override
  String get changePasswordConfirm => 'Confirmer le nouveau mot de passe';

  @override
  String get changePasswordCurrentRequired =>
      'Saisissez le mot de passe actuel';

  @override
  String get changePasswordNewRequired => 'Saisissez un nouveau mot de passe';

  @override
  String get changePasswordTooShort => 'Au moins 8 caractères';

  @override
  String get changePasswordConfirmRequired =>
      'Confirmez le nouveau mot de passe';

  @override
  String get changePasswordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get changePasswordSubmit => 'CHANGER LE MOT DE PASSE';

  @override
  String get changePasswordFailed => 'Impossible de changer le mot de passe';

  @override
  String get libraryTitle => 'Bibliothèque';

  @override
  String get libraryTabGenerations => 'GÉNÉRATIONS';

  @override
  String get libraryTabCredits => 'CRÉDITS';

  @override
  String get libraryTabPayments => 'PAIEMENTS';

  @override
  String get libraryReload => 'Recharger';

  @override
  String get librarySignInPrompt => 'CONNECTEZ-VOUS POUR VOIR LA BIBLIOTHÈQUE';

  @override
  String get libraryRetry => 'RÉESSAYER';

  @override
  String get libraryLoadFailed => 'Impossible de charger la bibliothèque.';

  @override
  String get libraryEmptyGenerations =>
      'Vous n\'avez encore créé aucune image.';

  @override
  String get libraryEmptyCredits => 'Aucune opération de crédit.';

  @override
  String get libraryEmptyPayments => 'Aucun paiement.';

  @override
  String get libraryDeleteDialogTitle => 'Supprimer la génération ?';

  @override
  String get libraryDeleteDialogBody =>
      'Supprimer cette génération ? Action irréversible.';

  @override
  String get libraryDeleteCancel => 'ANNULER';

  @override
  String get libraryDeleteConfirm => 'SUPPRIMER';

  @override
  String get libraryDeleteSuccess => 'Génération supprimée';

  @override
  String get libraryDeleteFailed => 'Impossible de supprimer la génération';

  @override
  String get libraryStatusCompleted => 'Terminée';

  @override
  String get libraryStatusFailed => 'Échec';

  @override
  String get libraryStatusProcessing => 'En cours';

  @override
  String get libraryStatusPending => 'En attente';

  @override
  String get paymentResultSuccess => 'PAIEMENT RÉUSSI';

  @override
  String get paymentResultCancel => 'PAIEMENT ANNULÉ';

  @override
  String get paymentResultError => 'PAIEMENT ÉCHOUÉ';

  @override
  String get paymentResultSuccessMsg =>
      'Votre paiement a été traité. Les crédits ont été ajoutés à votre compte.';

  @override
  String get paymentResultCancelMsg =>
      'Vous avez annulé le paiement. Aucun débit n\'a eu lieu.';

  @override
  String get paymentResultErrorMsg =>
      'Une erreur s\'est produite. Réessayez ou contactez le support.';

  @override
  String get paymentResultLoadFailed =>
      'Impossible de charger les informations de paiement';

  @override
  String get paymentDetailPackage => 'Package';

  @override
  String get paymentDetailCredits => 'Crédits';

  @override
  String get paymentDetailAmount => 'Montant';

  @override
  String get paymentDetailTransaction => 'Transaction';

  @override
  String get paymentBackHome => 'ACCUEIL';

  @override
  String get paymentTryAgain => 'RÉESSAYER';

  @override
  String get termsEyebrow => 'LÉGAL';

  @override
  String get termsHeadline => 'Conditions d\'utilisation';

  @override
  String get termsSubhead =>
      'Dernière mise à jour : 10/09/2026 · Applicable à l\'ensemble du service REEL';

  @override
  String get termsBackShort => 'RETOUR';

  @override
  String get termsBackLong => 'À L\'ACCUEIL';

  @override
  String get termsFooterText =>
      'REEL — DÉVELOPPÉ DANS L\'OBSCURITÉ. UNE IMAGE À LA FOIS.';

  @override
  String get termsAccept => 'J\'ACCEPTE';

  @override
  String get termsDecline => 'RETOUR';

  @override
  String get adminDashboardTitle => 'Tableau de bord admin';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Aperçu';

  @override
  String get adminSidebarGenerations => 'Générations';

  @override
  String get adminSidebarUsers => 'Utilisateurs';

  @override
  String get adminSidebarPayments => 'Paiements';

  @override
  String get adminSidebarSettings => 'Paramètres';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Administrateur';

  @override
  String get adminMenuTooltip => 'Ouvrir le menu';

  @override
  String get adminRtlTooltip => 'Basculer LTR / RTL';

  @override
  String get adminRefreshTooltip => 'Actualiser';

  @override
  String get adminSearchUsersHint => 'Rechercher des utilisateurs…';

  @override
  String get adminExportTooltip => 'Exporter le rapport';

  @override
  String get adminExportLabel => 'EXPORTER';

  @override
  String get adminExportComingSoon =>
      'L\'exportation de rapports arrive bientôt.';

  @override
  String get adminNotificationsTooltip => 'Notifications';

  @override
  String get adminRangeLabel => 'Plage';

  @override
  String get adminRangeToday => 'Aujourd\'hui';

  @override
  String get adminRange7Days => '7 jours';

  @override
  String get adminRange30Days => '30 jours';

  @override
  String get adminRangeTodayLong => 'aujourd\'hui';

  @override
  String get adminRange7DaysLong => 'sur 7 jours';

  @override
  String get adminRange30DaysLong => 'sur 30 jours';

  @override
  String get adminAutoUpdateNote =>
      'Mise à jour automatique chaque jour à 00:00';

  @override
  String adminKpiTakes(Object range) {
    return 'Prises $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Utilisateurs actifs — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Revenus — $range';
  }

  @override
  String get adminKpiQueue => 'File de rendu';

  @override
  String get adminDailyOutputTitle => 'Sortie sur 7 jours';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return 'Le $ratio16x9 représente 58% des rendus de la semaine, suivi du 1:1 (24%) et 9:16 (18%).';
  }

  @override
  String get adminStockMixTitle => 'Répartition des styles';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Renders récents';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Utilisateurs';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Ouvrir la liste';

  @override
  String get adminFleetTitle => 'File & GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter =>
      '3/5 workers actifs · 1 en maintenance · 1 idle';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'Traitement — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Idle — en attente du prochain job';

  @override
  String get adminFleetJobMaintenance => 'Maintenance planifiée';

  @override
  String get adminGenerationCompleted => 'Terminée';

  @override
  String get adminGenerationProcessing => 'Rendu en cours';

  @override
  String get adminGenerationFailed => 'Échec';

  @override
  String get adminUserStatusActive => 'Actif';

  @override
  String get adminUserStatusInactive => 'Inactif';

  @override
  String get adminUserStatusBanned => 'Banni';

  @override
  String get adminUserRoleAdmin => 'Admin';

  @override
  String get adminUserRoleUser => 'Utilisateur';

  @override
  String get adminSettingsTitle => 'Paramètres';

  @override
  String get adminSettingsStudioName => 'Nom affiché du studio';

  @override
  String get adminSettingsSupportEmail => 'E-mail support';

  @override
  String get adminSettingsImageCost => 'Coût en crédits / image';

  @override
  String get adminSettingsVideoCost => 'Coût en crédits / vidéo';

  @override
  String get adminSettingsAlerts => 'Alertes';

  @override
  String get adminSettingsAlertPayment => 'Notifier paiements échoués';

  @override
  String get adminSettingsAlertGeneration => 'Notifier générations échouées';

  @override
  String get adminSettingsNewsletter => 'Envoyer la newsletter';

  @override
  String get adminSettingsMaintenance => 'Mode maintenance';

  @override
  String get adminSettingsRegistration => 'Autoriser les inscriptions';

  @override
  String get adminSettingsSave => 'ENREGISTRER';

  @override
  String get adminSettingsLoadFailed => 'Impossible de charger les paramètres.';

  @override
  String get adminSettingsSaved => 'Paramètres enregistrés.';

  @override
  String get adminSettingsSaveFailed => 'Impossible d\'enregistrer.';

  @override
  String get adminPackagesTitle => 'Packages de paiement';

  @override
  String get adminPackagesEmpty => 'Aucun package.';

  @override
  String get adminPackagesLoadFailed => 'Impossible de charger les packages.';

  @override
  String get adminPackagesNew => 'Nouveau package';

  @override
  String get adminPackagesFeatured => 'En vedette';

  @override
  String get adminPackagesInactive => 'Inactif';

  @override
  String get adminPackagesActive => 'Actif';

  @override
  String get adminPaymentsTitle => 'Paiements';

  @override
  String get adminPaymentsEmpty => 'Aucun paiement.';

  @override
  String get adminPaymentsLoadFailed => 'Impossible de charger les paiements.';

  @override
  String get adminPaymentsFilterAll => 'Tous';

  @override
  String get adminCreditsTitle => 'Opérations de crédit';

  @override
  String get adminCreditsEmpty => 'Aucune opération.';

  @override
  String get adminCreditsLoadFailed => 'Impossible de charger les opérations.';

  @override
  String get adminUsersTitle => 'Utilisateurs';

  @override
  String get adminUsersEmpty => 'Aucun utilisateur.';

  @override
  String get adminUsersLoadFailed => 'Impossible de charger les utilisateurs.';

  @override
  String get adminUsersSearch => 'Rechercher par e-mail ou nom';

  @override
  String get adminUsersRefresh => 'Actualiser';

  @override
  String get adminUsersReset => 'Réinitialiser';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get termsTocLabel => 'Sommaire';

  @override
  String get termsNoteBox =>
      'Ceci est une maquette UI/UX d\'un exemple de conditions. Avant toute publication officielle, REEL devrait faire relire le texte par un conseiller juridique.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'E-mail d\'assistance';

  @override
  String get termsContactButton => 'Contacter l\'assistance';

  @override
  String get termsS01Title => 'Acceptation des conditions';

  @override
  String get termsS01P1 =>
      'En créant un compte ou en utilisant toute fonctionnalité de REEL (génération d\'images, de vidéos, recharge de crédits, mise à niveau du plan), vous acceptez les conditions ci-dessous. Si vous n\'êtes pas d\'accord, veuillez cesser d\'utiliser le service.';

  @override
  String get termsS01P2 =>
      'REEL est destiné aux utilisateurs âgés de 13 ans et plus. Les utilisateurs de moins de 18 ans ont besoin du consentement d\'un parent ou d\'un tuteur légal.';

  @override
  String get termsS02Title => 'Compte';

  @override
  String get termsS02P1 =>
      'Chaque compte est lié à une adresse e-mail unique. Vous êtes responsable de la confidentialité de votre mot de passe et de toute activité effectuée sous votre compte.';

  @override
  String get termsS02B1 =>
      'Les informations d\'inscription (nom, e-mail) doivent être exactes et à jour.';

  @override
  String get termsS02B2 =>
      'REEL peut exiger une vérification de l\'e-mail avant d\'activer certaines fonctionnalités.';

  @override
  String get termsS02B3 =>
      'Les comptes peuvent être actifs, inactifs ou bannis selon l\'historique d\'utilisation et les éventuelles violations.';

  @override
  String get termsS03Title => 'Crédits & génération IA';

  @override
  String get termsS03P1 =>
      'REEL fonctionne avec un système de crédits. Chaque génération d\'image ou de vidéo (un « take ») déduit les crédits correspondants de votre portefeuille, selon le type, la résolution et la durée.';

  @override
  String get termsS03B1 =>
      'Les crédits sont déduits lorsque la demande de génération commence à être traitée.';

  @override
  String get termsS03B2 =>
      'En cas d\'échec dû à une erreur système, les crédits sont remboursés automatiquement.';

  @override
  String get termsS03B3 =>
      'REEL ne rembourse pas les crédits si la demande échoue parce qu\'elle viole les conditions (voir Section 6).';

  @override
  String get termsS03B4 =>
      'Les crédits non utilisés des plans mensuels/annuels ne sont pas reportés, sauf indication contraire.';

  @override
  String get termsS04Title => 'Paiement & remboursement';

  @override
  String get termsS04P1 =>
      'REEL accepte les paiements via Momo, ZaloPay, VNPay, virement bancaire et Stripe (pour les plans internationaux). Chaque transaction est enregistrée avec son propre identifiant pour la traçabilité.';

  @override
  String get termsS04B1 =>
      'Les plans mensuels/annuels se renouvellent automatiquement sauf résiliation avant le prochain cycle.';

  @override
  String get termsS04B2 =>
      'Les demandes de remboursement sont examinées sous 7 jours après le paiement, à condition que les crédits du plan n\'aient pas été utilisés.';

  @override
  String get termsS04B3 =>
      'Les recharges de crédits uniques ne sont pas remboursables une fois les crédits ajoutés au portefeuille.';

  @override
  String get termsS05Title => 'Propriété du contenu';

  @override
  String get termsS05P1 =>
      'Vous conservez les droits d\'utilisation sur le contenu que vous créez sur REEL, dans le cadre de votre plan actuel.';

  @override
  String get termsS05B1 =>
      'Plan Free : le contenu porte un filigrane REEL et est réservé à un usage personnel non commercial.';

  @override
  String get termsS05B2 =>
      'Plan Pro : le contenu est sans filigrane et peut être utilisé à des fins commerciales.';

  @override
  String get termsS05B3 =>
      'REEL ne garantit pas l\'originalité du contenu généré par IA ; la vérification avant usage commercial vous incombe.';

  @override
  String get termsS06Title => 'Comportements interdits';

  @override
  String get termsS06P1 =>
      'Vous ne devez pas utiliser REEL pour créer ou diffuser du contenu qui :';

  @override
  String get termsS06B1 =>
      'Viole la loi en vigueur, incite à la violence, à la discrimination ou à la haine.';

  @override
  String get termsS06B2 =>
      'Est pornographique ou implique des mineurs sous quelque forme que ce soit.';

  @override
  String get termsS06B3 =>
      'Imite quelqu\'un d\'autre, viole la vie privée ou utilise l\'image de quelqu\'un sans autorisation.';

  @override
  String get termsS06B4 =>
      'Enfreint le droit d\'auteur, les marques ou tout autre droit de propriété intellectuelle de tiers.';

  @override
  String get termsS06P2 =>
      'Les violations peuvent entraîner le bannissement du compte sans préavis et sans remboursement des crédits ou frais payés.';

  @override
  String get termsS07Title => 'Limitation de responsabilité';

  @override
  String get termsS07P1 =>
      'Le service est fourni « en l\'état ». REEL ne garantit pas un service ininterrompu ou sans erreur, ni que chaque résultat réponde à vos attentes.';

  @override
  String get termsS07P2 =>
      'Dans les limites autorisées par la loi, REEL n\'est pas responsable des dommages indirects résultant de l\'utilisation ou de l\'impossibilité d\'utiliser le service.';

  @override
  String get termsS08Title => 'Résiliation du compte';

  @override
  String get termsS08P1 =>
      'Vous pouvez cesser d\'utiliser le service et demander la suppression de votre compte à tout moment. REEL peut suspendre (inactive) ou verrouiller définitivement (banned) les comptes qui violent les conditions, en tenant compte de la gravité de la violation.';

  @override
  String get termsS09Title => 'Modifications des conditions';

  @override
  String get termsS09P1 =>
      'REEL peut mettre à jour ces conditions. Les changements importants seront communiqués par e-mail ou par une bannière sur la page d\'accueil au moins 7 jours avant leur entrée en vigueur.';

  @override
  String get termsS10Title => 'Contact';

  @override
  String get termsS10P1 =>
      'Si vous avez des questions concernant ces conditions, veuillez contacter l\'équipe REEL.';

  @override
  String get errorPasswordRequired => 'Veuillez saisir votre mot de passe.';

  @override
  String get errorConfirmPasswordRequired =>
      'Veuillez confirmer votre mot de passe.';

  @override
  String get backToHomeLabel => 'ACCUEIL';

  @override
  String get backToHomeTooltip => 'Retour à l\'accueil';

  @override
  String get profileBackHome => 'Retour à l\'accueil';

  @override
  String get profileNavOverview => 'Aperçu';

  @override
  String get profileNavMyRoll => 'Mon roll';

  @override
  String get profileNavSettings => 'Paramètres';

  @override
  String get profileNavBilling => 'Offres et facturation';

  @override
  String get profileLogout => 'Se déconnecter';

  @override
  String profileWelcomeBack(String name) {
    return 'Bon retour, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'Voici votre roll du jour.';
  }

  @override
  String get profileStatTotalTakes => 'Prises au total';

  @override
  String get profileStatFavoriteStock => 'Pellicule favorite';

  @override
  String get profileStatDaysLabel => 'Jours avec REEL';

  @override
  String profileStatDaysValue(int n) {
    return '$n jours';
  }

  @override
  String get profileUpgradePro => 'Passer à Pro';

  @override
  String get profileRecentActivity => 'Activité récente';

  @override
  String get profileViewAll => 'Tout voir →';

  @override
  String get profileMyRollSub => 'Tout ce que vous avez généré sur REEL.';

  @override
  String get profileFilterAll => 'Tous';

  @override
  String get profileFilterVideo => 'Vidéo';

  @override
  String get profileFilterPhoto => 'Photo';

  @override
  String get profilePhotoTag => 'Photo';

  @override
  String get profileMyRollEmpty =>
      'Aucune prise pour l\'instant — générez votre première image dans le studio.';

  @override
  String get profileTimeJustNow => 'À l\'instant';

  @override
  String profileTimeMinutesAgo(int n) {
    return 'il y a $n min';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return 'il y a $n h';
  }

  @override
  String get profileTimeYesterday => 'Hier';

  @override
  String profileTimeDaysAgo(int n) {
    return 'il y a $n jours';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return 'il y a $n semaines';
  }

  @override
  String get profileSettingsSub =>
      'Mettez à jour vos informations de profil et vos préférences par défaut.';

  @override
  String get profileSectionProfileInfo => 'Informations du profil';

  @override
  String get profileFieldDisplayName => 'Nom affiché';

  @override
  String get profileFieldEmail => 'E-mail';

  @override
  String get profileSaveChanges => 'Enregistrer les modifications';

  @override
  String get profileSectionPassword => 'Changer de mot de passe';

  @override
  String get profileFieldCurrentPassword => 'Mot de passe actuel';

  @override
  String get profileFieldNewPassword => 'Nouveau mot de passe';

  @override
  String get profileFieldConfirmPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'Au moins 8 caractères';

  @override
  String get profilePwConfirmPlaceholder => 'Saisissez-le à nouveau';

  @override
  String get profileUpdatePassword => 'Mettre à jour le mot de passe';

  @override
  String get profilePwShow => 'Afficher';

  @override
  String get profilePwHide => 'Masquer';

  @override
  String get profileSectionPrefs => 'Préférences par défaut';

  @override
  String get profilePrefRatio => 'Format par défaut';

  @override
  String get profilePrefRatioDesc =>
      'Appliqué à chaque ouverture du générateur';

  @override
  String get profilePrefStock => 'Pellicule par défaut';

  @override
  String get profilePrefStockDesc => 'Le rendu initial de vos images';

  @override
  String get profileDangerTitle => 'Zone de danger';

  @override
  String get profileDangerDesc =>
      'Supprimer votre compte efface tout votre roll. Cette action est irréversible.';

  @override
  String get profileDeleteAccount => 'Supprimer le compte';

  @override
  String get profileDeleteNotice =>
      'La suppression du compte est gérée par l\'équipe REEL — contactez le support pour en faire la demande.';

  @override
  String get profileBillingSub =>
      'Gérez votre offre et vos moyens de paiement.';

  @override
  String get profileCurrentPlan => 'Offre actuelle';

  @override
  String get profilePlanPerMonth => '/ mois';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '10 crédits offerts';

  @override
  String get profilePlanFreeF2 => 'Filigrane REEL';

  @override
  String get profilePlanProF1 => 'Rechargez des packs de crédits';

  @override
  String get profilePlanProF2 => '4K, sans filigrane';

  @override
  String get profileCurrentTag => 'En cours';

  @override
  String get profileUpgradeShort => 'Améliorer';

  @override
  String get profilePaymentHistory => 'Historique des paiements';

  @override
  String get profileEmptyPayments =>
      'Aucune transaction pour l\'instant — passez à Pro pour commencer.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'Informations de profil mises à jour !';

  @override
  String get profilePasswordUpdated => 'Mot de passe mis à jour !';

  @override
  String get profileProChip => 'OFFRE PRO';

  @override
  String get profileFreeChip => 'OFFRE GRATUITE';

  @override
  String get adminSidebarModeration => 'Modération';

  @override
  String get adminSidebarRevenue => 'Revenus';

  @override
  String get adminSidebarSystem => 'Système';

  @override
  String get adminRoleChip => 'Administrateur';

  @override
  String usageCreditsLabel(int balance) {
    return '$balance crédits disponibles';
  }

  @override
  String get homeStatCreditsLeft => 'CRÉDITS';

  @override
  String get profileStatCredits => 'Crédits';

  @override
  String profileCreditsAvailable(int balance) {
    return '$balance crédits disponibles';
  }

  @override
  String get profileTopUp => 'Recharger';

  @override
  String get profilePlanPayAsYouGo => '/ payez à l\'usage';

  @override
  String profileUsageSpentToday(int spent) {
    return '$spent crédits utilisés aujourd\'hui';
  }

  @override
  String get profileTopUpHint => 'Rechargez vos crédits pour continuer.';

  @override
  String get avatarUpdated => 'Avatar mis à jour';

  @override
  String get avatarUpdateFailed => 'Échec de l\'envoi de l\'avatar. Réessayez.';

  @override
  String get avatarChangeHint => 'Changer la photo de profil';

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

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'REEL — AI Film & Photo Studio'**
  String get appTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languagePickerTooltip.
  ///
  /// In en, this message translates to:
  /// **'Choose interface language'**
  String get languagePickerTooltip;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get signUp;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @forgot.
  ///
  /// In en, this message translates to:
  /// **'FORGOT'**
  String get forgot;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'RESET PASSWORD'**
  String get resetPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'NEW PASSWORD'**
  String get newPassword;

  /// No description provided for @credentialsBadge.
  ///
  /// In en, this message translates to:
  /// **'CREDENTIALS'**
  String get credentialsBadge;

  /// No description provided for @productionAccessRoll.
  ///
  /// In en, this message translates to:
  /// **'PRODUCTION REEL · ACCESS {mode} · ROLL A'**
  String productionAccessRoll(Object mode);

  /// No description provided for @productionAccessRollSignIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get productionAccessRollSignIn;

  /// No description provided for @productionAccessRollSignUp.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get productionAccessRollSignUp;

  /// No description provided for @productionAccessRollReset.
  ///
  /// In en, this message translates to:
  /// **'RESET PASSWORD'**
  String get productionAccessRollReset;

  /// No description provided for @productionAccessRollNewPassword.
  ///
  /// In en, this message translates to:
  /// **'NEW PASSWORD'**
  String get productionAccessRollNewPassword;

  /// No description provided for @authHeadlineSignIn.
  ///
  /// In en, this message translates to:
  /// **'Every scene'**
  String get authHeadlineSignIn;

  /// No description provided for @authHeadlineSignInItalic.
  ///
  /// In en, this message translates to:
  /// **'needs a cast.'**
  String get authHeadlineSignInItalic;

  /// No description provided for @authSubheadSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep creating, save your works and manage your library.'**
  String get authSubheadSignIn;

  /// No description provided for @authHeadlineSignUp.
  ///
  /// In en, this message translates to:
  /// **'Join the'**
  String get authHeadlineSignUp;

  /// No description provided for @authHeadlineSignUpItalic.
  ///
  /// In en, this message translates to:
  /// **'production.'**
  String get authHeadlineSignUpItalic;

  /// No description provided for @authSubheadSignUp.
  ///
  /// In en, this message translates to:
  /// **'Create an account to save your works, track credits and pick up whenever inspiration shows up.'**
  String get authSubheadSignUp;

  /// No description provided for @authHeadlineForgot.
  ///
  /// In en, this message translates to:
  /// **'Lost the'**
  String get authHeadlineForgot;

  /// No description provided for @authHeadlineForgotItalic.
  ///
  /// In en, this message translates to:
  /// **'negative?'**
  String get authHeadlineForgotItalic;

  /// No description provided for @authSubheadForgot.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send a password reset link.'**
  String get authSubheadForgot;

  /// No description provided for @authHeadlineReset.
  ///
  /// In en, this message translates to:
  /// **'Make a'**
  String get authHeadlineReset;

  /// No description provided for @authHeadlineResetItalic.
  ///
  /// In en, this message translates to:
  /// **'new cut.'**
  String get authHeadlineResetItalic;

  /// No description provided for @authSubheadReset.
  ///
  /// In en, this message translates to:
  /// **'Create a new password to step back into your creative space.'**
  String get authSubheadReset;

  /// No description provided for @inputEmail.
  ///
  /// In en, this message translates to:
  /// **'EMAIL'**
  String get inputEmail;

  /// No description provided for @inputEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get inputEmailHint;

  /// No description provided for @inputPassword.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get inputPassword;

  /// No description provided for @inputPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'**********'**
  String get inputPasswordHint;

  /// No description provided for @inputPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get inputPasswordShort;

  /// No description provided for @inputFullName.
  ///
  /// In en, this message translates to:
  /// **'DISPLAY NAME'**
  String get inputFullName;

  /// No description provided for @inputFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Director of this production'**
  String get inputFullNameHint;

  /// No description provided for @inputConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM PASSWORD'**
  String get inputConfirmPassword;

  /// No description provided for @inputConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get inputConfirmPasswordHint;

  /// No description provided for @inputResetCode.
  ///
  /// In en, this message translates to:
  /// **'RESET CODE'**
  String get inputResetCode;

  /// No description provided for @inputResetCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the code from your email'**
  String get inputResetCodeHint;

  /// No description provided for @inputNewPassword.
  ///
  /// In en, this message translates to:
  /// **'NEW PASSWORD'**
  String get inputNewPassword;

  /// No description provided for @inputNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get inputNewPasswordHint;

  /// No description provided for @inputNewPasswordConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter the new password'**
  String get inputNewPasswordConfirmHint;

  /// No description provided for @inputAvatarUrl.
  ///
  /// In en, this message translates to:
  /// **'AVATAR URL (OPTIONAL)'**
  String get inputAvatarUrl;

  /// No description provided for @inputAvatarUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://example.com/avatar.jpg'**
  String get inputAvatarUrlHint;

  /// No description provided for @inputFullNameEdit.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get inputFullNameEdit;

  /// No description provided for @inputFullNameEditHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get inputFullNameEditHint;

  /// No description provided for @toggleShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get toggleShowPassword;

  /// No description provided for @toggleHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get toggleHidePassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLink;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN ►'**
  String get signInButton;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT ►'**
  String get signUpButton;

  /// No description provided for @forgotButton.
  ///
  /// In en, this message translates to:
  /// **'SEND LINK ►'**
  String get forgotButton;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'RESET PASSWORD ►'**
  String get resetPasswordButton;

  /// No description provided for @orDivider.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get orDivider;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccountPrompt;

  /// No description provided for @noAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up now'**
  String get noAccountLink;

  /// No description provided for @hasAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get hasAccountPrompt;

  /// No description provided for @hasAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get hasAccountLink;

  /// No description provided for @forgotRememberedPrompt.
  ///
  /// In en, this message translates to:
  /// **'Remembered your password? '**
  String get forgotRememberedPrompt;

  /// No description provided for @forgotRememberedLink.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get forgotRememberedLink;

  /// No description provided for @resetRememberedPrompt.
  ///
  /// In en, this message translates to:
  /// **'Remembered your password? '**
  String get resetRememberedPrompt;

  /// No description provided for @resetRememberedLink.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get resetRememberedLink;

  /// No description provided for @agreeTermsPrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get agreeTermsPrefix;

  /// No description provided for @agreeTermsLink.
  ///
  /// In en, this message translates to:
  /// **'Production Terms'**
  String get agreeTermsLink;

  /// No description provided for @agreeTermsSemantic.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Production Terms'**
  String get agreeTermsSemantic;

  /// No description provided for @forgotDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the email you signed up with. The reset code is valid for 30 minutes.'**
  String get forgotDescription;

  /// No description provided for @statsFooter.
  ///
  /// In en, this message translates to:
  /// **'YOUR NEXT SCENE STARTS HERE'**
  String get statsFooter;

  /// No description provided for @errorEmailPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password.'**
  String get errorEmailPasswordRequired;

  /// No description provided for @errorAllFieldsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all the fields.'**
  String get errorAllFieldsRequired;

  /// No description provided for @errorPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get errorPasswordTooShort;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Confirmation password does not match.'**
  String get errorPasswordMismatch;

  /// No description provided for @errorAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the production terms.'**
  String get errorAcceptTerms;

  /// No description provided for @errorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get errorEmailRequired;

  /// No description provided for @errorResetCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Reset code is required and password must be at least 8 characters.'**
  String get errorResetCodeRequired;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Cannot connect to the server.'**
  String get errorGeneric;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get errorInvalidEmail;

  /// No description provided for @errorInvalidAvatarUrl.
  ///
  /// In en, this message translates to:
  /// **'Avatar URL must start with http:// or https://.'**
  String get errorInvalidAvatarUrl;

  /// No description provided for @errorSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password.'**
  String get errorSignInFailed;

  /// No description provided for @errorSignUpFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign-up failed.'**
  String get errorSignUpFailed;

  /// No description provided for @errorForgotFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not generate the password reset link.'**
  String get errorForgotFailed;

  /// No description provided for @errorResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not reset the password.'**
  String get errorResetFailed;

  /// No description provided for @errorFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name.'**
  String get errorFullNameRequired;

  /// No description provided for @successSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign-up successful! Please sign in.'**
  String get successSignUp;

  /// No description provided for @successResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed successfully.'**
  String get successResetPassword;

  /// No description provided for @successForgotEmail.
  ///
  /// In en, this message translates to:
  /// **'If the email exists, a link has been sent.'**
  String get successForgotEmail;

  /// No description provided for @successProfileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get successProfileSaved;

  /// No description provided for @successPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully! Please sign in again.'**
  String get successPasswordChanged;

  /// No description provided for @successProfileLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile: {message}'**
  String successProfileLoadFailed(Object message);

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @loginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please sign in before generating an image.'**
  String get loginPrompt;

  /// No description provided for @emptyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter a prompt before pressing Action.'**
  String get emptyPrompt;

  /// No description provided for @imageOnlySupported.
  ///
  /// In en, this message translates to:
  /// **'REEL currently supports text-to-image only. Please choose Photo.'**
  String get imageOnlySupported;

  /// No description provided for @imageGenerationFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not generate the image. Check the backend and model.'**
  String get imageGenerationFailed;

  /// No description provided for @noImageReturned.
  ///
  /// In en, this message translates to:
  /// **'Model did not return an image.'**
  String get noImageReturned;

  /// No description provided for @videoDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'DURATION'**
  String get videoDurationLabel;

  /// No description provided for @videoQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'QUALITY'**
  String get videoQualityLabel;

  /// No description provided for @videoQueuedMessage.
  ///
  /// In en, this message translates to:
  /// **'Video is rendering — this takes a few minutes. The result will appear here.'**
  String get videoQueuedMessage;

  /// No description provided for @videoGenerationFailed.
  ///
  /// In en, this message translates to:
  /// **'Video generation failed. Your credits were refunded.'**
  String get videoGenerationFailed;

  /// No description provided for @videoTimeoutMessage.
  ///
  /// In en, this message translates to:
  /// **'The video is taking longer than expected. Check your Library in your profile shortly.'**
  String get videoTimeoutMessage;

  /// No description provided for @videoReadyLabel.
  ///
  /// In en, this message translates to:
  /// **'Your video is ready'**
  String get videoReadyLabel;

  /// No description provided for @usageLabelSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Sign in to get started'**
  String get usageLabelSignedOut;

  /// No description provided for @rtlToggleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle layout direction LTR / RTL'**
  String get rtlToggleTooltip;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'REEL — developed in the dark, one frame at a time. Turn a line of text into a shot.'**
  String get footerTagline;

  /// No description provided for @productColumn.
  ///
  /// In en, this message translates to:
  /// **'PRODUCT'**
  String get productColumn;

  /// No description provided for @supportColumn.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get supportColumn;

  /// No description provided for @signInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInLink;

  /// No description provided for @signUpLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpLink;

  /// No description provided for @footerCaption1.
  ///
  /// In en, this message translates to:
  /// **'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.'**
  String get footerCaption1;

  /// No description provided for @footerCaption2.
  ///
  /// In en, this message translates to:
  /// **'© 2026 REEL STUDIO'**
  String get footerCaption2;

  /// No description provided for @typeAScene.
  ///
  /// In en, this message translates to:
  /// **'Type a scene.'**
  String get typeAScene;

  /// No description provided for @getTheTake.
  ///
  /// In en, this message translates to:
  /// **'Get the take.'**
  String get getTheTake;

  /// No description provided for @homeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'AI FILM & PHOTO STUDIO'**
  String get homeEyebrow;

  /// No description provided for @homeSubhead.
  ///
  /// In en, this message translates to:
  /// **'Turn a line of text into a shot — framed, lit and moving in seconds. Video or still, one roll.'**
  String get homeSubhead;

  /// No description provided for @homeStatLastTake.
  ///
  /// In en, this message translates to:
  /// **'LAST TAKE'**
  String get homeStatLastTake;

  /// No description provided for @homeStatAspectRatios.
  ///
  /// In en, this message translates to:
  /// **'ASPECT RATIOS'**
  String get homeStatAspectRatios;

  /// No description provided for @homeStatFilmStocks.
  ///
  /// In en, this message translates to:
  /// **'FILM STOCKS'**
  String get homeStatFilmStocks;

  /// No description provided for @homeMetaProduction.
  ///
  /// In en, this message translates to:
  /// **'PRODUCTION  REEL   ·   SCENE  01 — {format}   ·   ROLL  A'**
  String homeMetaProduction(Object format);

  /// No description provided for @homeSceneFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your scene…'**
  String get homeSceneFieldHint;

  /// No description provided for @homeQuickChips.
  ///
  /// In en, this message translates to:
  /// **'Masquerade under chandeliers | Knight in a dust storm | Marionette workshop'**
  String get homeQuickChips;

  /// No description provided for @homeStock.
  ///
  /// In en, this message translates to:
  /// **'STOCK'**
  String get homeStock;

  /// No description provided for @homeStockOptions.
  ///
  /// In en, this message translates to:
  /// **'Cinematic | Documentary | Studio | Animated'**
  String get homeStockOptions;

  /// No description provided for @homeFormat.
  ///
  /// In en, this message translates to:
  /// **'Video | Photo'**
  String get homeFormat;

  /// No description provided for @homeRatio.
  ///
  /// In en, this message translates to:
  /// **'16:9 | 1:1 | 9:16'**
  String get homeRatio;

  /// No description provided for @homeGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating…'**
  String get homeGenerating;

  /// No description provided for @homeGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get homeGenerate;

  /// No description provided for @homeGenerationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Generation complete · {ratio}'**
  String homeGenerationSuccess(Object ratio);

  /// No description provided for @homeGenerationErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load the result image.'**
  String get homeGenerationErrorLoad;

  /// No description provided for @homeGenerationOpenOriginal.
  ///
  /// In en, this message translates to:
  /// **'Open original'**
  String get homeGenerationOpenOriginal;

  /// No description provided for @homeGenerationRegenerate.
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get homeGenerationRegenerate;

  /// No description provided for @homeGenerationOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the original image.'**
  String get homeGenerationOpenFailed;

  /// No description provided for @showcaseEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FROM PROMPT TO TAKE'**
  String get showcaseEyebrow;

  /// No description provided for @showcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'One line of text. One complete scene.'**
  String get showcaseTitle;

  /// No description provided for @showcaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Watch REEL turn a description into a real frame, step by step.'**
  String get showcaseSubtitle;

  /// No description provided for @showcasePrompt1.
  ///
  /// In en, this message translates to:
  /// **'\"astronaut surfing across the red dunes of mars, golden hour, wide shot\"'**
  String get showcasePrompt1;

  /// No description provided for @showcaseMeta1.
  ///
  /// In en, this message translates to:
  /// **'Cinematic · 16:9'**
  String get showcaseMeta1;

  /// No description provided for @showcasePrompt2.
  ///
  /// In en, this message translates to:
  /// **'\"masquerade ball under chandeliers, slow camera move\"'**
  String get showcasePrompt2;

  /// No description provided for @showcaseMeta2.
  ///
  /// In en, this message translates to:
  /// **'Cinematic · 9:16'**
  String get showcaseMeta2;

  /// No description provided for @showcasePrompt3.
  ///
  /// In en, this message translates to:
  /// **'\"rider on horseback in a dust storm at dusk, tracking shot\"'**
  String get showcasePrompt3;

  /// No description provided for @showcaseMeta3.
  ///
  /// In en, this message translates to:
  /// **'Documentary · 16:9'**
  String get showcaseMeta3;

  /// No description provided for @featuresEyebrow.
  ///
  /// In en, this message translates to:
  /// **'ONE ROLL, EVERY FORMAT'**
  String get featuresEyebrow;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Four tools, one shot'**
  String get featuresTitle;

  /// No description provided for @featuresSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything you need to go from a line of text to a complete frame.'**
  String get featuresSubtitle;

  /// No description provided for @feature1Title.
  ///
  /// In en, this message translates to:
  /// **'Cinematic engine'**
  String get feature1Title;

  /// No description provided for @feature1Body.
  ///
  /// In en, this message translates to:
  /// **'Lighting, camera moves and cinematic grammar learned from millions of real frames.'**
  String get feature1Body;

  /// No description provided for @feature2Title.
  ///
  /// In en, this message translates to:
  /// **'Any frame, any ratio'**
  String get feature2Title;

  /// No description provided for @feature2Body.
  ///
  /// In en, this message translates to:
  /// **'16:9 for widescreen, 1:1 for feeds, 9:16 for stories — no need to re-edit from scratch.'**
  String get feature2Body;

  /// No description provided for @feature3Title.
  ///
  /// In en, this message translates to:
  /// **'Four film stocks'**
  String get feature3Title;

  /// No description provided for @feature3Body.
  ///
  /// In en, this message translates to:
  /// **'Cinematic, Documentary, Studio, Animated — pick your texture before you press Generate.'**
  String get feature3Body;

  /// No description provided for @feature4Title.
  ///
  /// In en, this message translates to:
  /// **'Stills or motion, one flow'**
  String get feature4Title;

  /// No description provided for @feature4Body.
  ///
  /// In en, this message translates to:
  /// **'The same prompt, the same studio. Still images today; motion when ready.'**
  String get feature4Body;

  /// No description provided for @faqEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqEyebrow;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get faqTitle;

  /// No description provided for @faqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Anything else, just message the REEL team.'**
  String get faqSubtitle;

  /// No description provided for @faqQ1.
  ///
  /// In en, this message translates to:
  /// **'How does REEL work?'**
  String get faqQ1;

  /// No description provided for @faqA1.
  ///
  /// In en, this message translates to:
  /// **'Type a description, choose a frame ratio and a film stock. REEL generates an image from it. Motion features are on the way.'**
  String get faqA1;

  /// No description provided for @faqQ2.
  ///
  /// In en, this message translates to:
  /// **'How is REEL different from other AI video tools?'**
  String get faqQ2;

  /// No description provided for @faqA2.
  ///
  /// In en, this message translates to:
  /// **'REEL focuses on cinematic language — lighting, framing and film stock — inside one creative studio.'**
  String get faqA2;

  /// No description provided for @faqQ3.
  ///
  /// In en, this message translates to:
  /// **'How many free takes do I get?'**
  String get faqQ3;

  /// No description provided for @faqA3.
  ///
  /// In en, this message translates to:
  /// **'Your current quota and remaining credits are shown in the studio once you\'re signed in. Check the pricing page for active plan benefits.'**
  String get faqA3;

  /// No description provided for @faqQ4.
  ///
  /// In en, this message translates to:
  /// **'Which formats and resolutions are supported?'**
  String get faqQ4;

  /// No description provided for @faqA4.
  ///
  /// In en, this message translates to:
  /// **'Images support three ratios — 16:9, 1:1 and 9:16. Output size depends on the current generation configuration.'**
  String get faqA4;

  /// No description provided for @faqQ5.
  ///
  /// In en, this message translates to:
  /// **'Can I use the results commercially?'**
  String get faqQ5;

  /// No description provided for @faqA5.
  ///
  /// In en, this message translates to:
  /// **'Check the Production Terms and the benefits of the plan you pick before using results commercially.'**
  String get faqA5;

  /// No description provided for @plansEyebrow.
  ///
  /// In en, this message translates to:
  /// **'PLANS'**
  String get plansEyebrow;

  /// No description provided for @plansTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick your shooting pace'**
  String get plansTitle;

  /// No description provided for @plansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start free, upgrade whenever you need to create more.'**
  String get plansSubtitle;

  /// No description provided for @ctaReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for your'**
  String get ctaReady;

  /// No description provided for @ctaReadyItalic.
  ///
  /// In en, this message translates to:
  /// **'first take?'**
  String get ctaReadyItalic;

  /// No description provided for @ctaBody.
  ///
  /// In en, this message translates to:
  /// **'Free, no credit card — first frame in under a minute.'**
  String get ctaBody;

  /// No description provided for @ctaFreeButton.
  ///
  /// In en, this message translates to:
  /// **'Create a free account'**
  String get ctaFreeButton;

  /// No description provided for @ctaGalleryButton.
  ///
  /// In en, this message translates to:
  /// **'View gallery'**
  String get ctaGalleryButton;

  /// No description provided for @contactSheetEyebrow.
  ///
  /// In en, this message translates to:
  /// **'CONTACT SHEET — ROLL A'**
  String get contactSheetEyebrow;

  /// No description provided for @contactSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Latest frames'**
  String get contactSheetTitle;

  /// No description provided for @contactSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A few scenes the REEL community just finished editing.'**
  String get contactSheetSubtitle;

  /// No description provided for @contactSheetDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview of visual style.'**
  String get contactSheetDialogTitle;

  /// No description provided for @contactSheetDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Generate your own take inside the studio.'**
  String get contactSheetDialogBody;

  /// No description provided for @contactSheetClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get contactSheetClose;

  /// No description provided for @pricingTitle.
  ///
  /// In en, this message translates to:
  /// **'PRICING'**
  String get pricingTitle;

  /// No description provided for @pricingEyebrow.
  ///
  /// In en, this message translates to:
  /// **'PLANS'**
  String get pricingEyebrow;

  /// No description provided for @pricingHeading.
  ///
  /// In en, this message translates to:
  /// **'Pick your shooting pace'**
  String get pricingHeading;

  /// No description provided for @pricingSubheading.
  ///
  /// In en, this message translates to:
  /// **'Start free, upgrade whenever you need to create more.'**
  String get pricingSubheading;

  /// No description provided for @pricingEmpty.
  ///
  /// In en, this message translates to:
  /// **'No active packages right now.'**
  String get pricingEmpty;

  /// No description provided for @pricingBuyButton.
  ///
  /// In en, this message translates to:
  /// **'Open Studio'**
  String get pricingBuyButton;

  /// No description provided for @pricingFreeCta.
  ///
  /// In en, this message translates to:
  /// **'Use for free'**
  String get pricingFreeCta;

  /// No description provided for @pricingSignInFirst.
  ///
  /// In en, this message translates to:
  /// **'Please sign in before buying a package.'**
  String get pricingSignInFirst;

  /// No description provided for @pricingLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load the packages.'**
  String get pricingLoadFailed;

  /// No description provided for @pricingStripeOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the Stripe payment page.'**
  String get pricingStripeOpenFailed;

  /// No description provided for @pricingStripeOpened.
  ///
  /// In en, this message translates to:
  /// **'Stripe Checkout opened. Credits will be added automatically after a successful payment.'**
  String get pricingStripeOpened;

  /// No description provided for @pricingCreditsSuffix.
  ///
  /// In en, this message translates to:
  /// **' CREDITS'**
  String get pricingCreditsSuffix;

  /// No description provided for @pricingCreditsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'credits per month'**
  String get pricingCreditsPerMonth;

  /// No description provided for @pricingPeriodMonthly.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get pricingPeriodMonthly;

  /// No description provided for @pricingPeriodYearly.
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get pricingPeriodYearly;

  /// No description provided for @pricingFreePerk.
  ///
  /// In en, this message translates to:
  /// **'50 free credits every month — try every tool in the studio.'**
  String get pricingFreePerk;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'MY PROFILE'**
  String get profileTitle;

  /// No description provided for @profileLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile: {message}'**
  String profileLoadFailed(Object message);

  /// No description provided for @profileNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile information'**
  String get profileNotLoaded;

  /// No description provided for @profileEditButton.
  ///
  /// In en, this message translates to:
  /// **'EDIT PROFILE'**
  String get profileEditButton;

  /// No description provided for @profileChangePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'CHANGE PASSWORD'**
  String get profileChangePasswordButton;

  /// No description provided for @profileUsageSection.
  ///
  /// In en, this message translates to:
  /// **'USAGE & CREDITS'**
  String get profileUsageSection;

  /// No description provided for @profileCreditBalance.
  ///
  /// In en, this message translates to:
  /// **'Credit Balance'**
  String get profileCreditBalance;

  /// No description provided for @profileDailyUsage.
  ///
  /// In en, this message translates to:
  /// **'Daily Usage'**
  String get profileDailyUsage;

  /// No description provided for @profileAccountSection.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT INFO'**
  String get profileAccountSection;

  /// No description provided for @profileUserId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get profileUserId;

  /// No description provided for @profileStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get profileStatus;

  /// No description provided for @profileStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileStatusActive;

  /// No description provided for @profileStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get profileStatusInactive;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get profileMemberSince;

  /// No description provided for @profileUnknownName.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get profileUnknownName;

  /// No description provided for @profileUnknownEmail.
  ///
  /// In en, this message translates to:
  /// **'No email'**
  String get profileUnknownEmail;

  /// No description provided for @profileUnknownInitial.
  ///
  /// In en, this message translates to:
  /// **'U'**
  String get profileUnknownInitial;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'EDIT PROFILE'**
  String get editProfileTitle;

  /// No description provided for @editProfileSubhead.
  ///
  /// In en, this message translates to:
  /// **'Update your profile information'**
  String get editProfileSubhead;

  /// No description provided for @editProfileSave.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get editProfileSave;

  /// No description provided for @editProfileLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load profile: {message}'**
  String editProfileLoadFailed(Object message);

  /// No description provided for @editProfileSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update profile'**
  String get editProfileSaveFailed;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'CHANGE PASSWORD'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordSubhead.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password and choose a new one'**
  String get changePasswordSubhead;

  /// No description provided for @changePasswordCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get changePasswordCurrent;

  /// No description provided for @changePasswordNew.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get changePasswordNew;

  /// No description provided for @changePasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get changePasswordConfirm;

  /// No description provided for @changePasswordCurrentRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password'**
  String get changePasswordCurrentRequired;

  /// No description provided for @changePasswordNewRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get changePasswordNewRequired;

  /// No description provided for @changePasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get changePasswordTooShort;

  /// No description provided for @changePasswordConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get changePasswordConfirmRequired;

  /// No description provided for @changePasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get changePasswordMismatch;

  /// No description provided for @changePasswordSubmit.
  ///
  /// In en, this message translates to:
  /// **'CHANGE PASSWORD'**
  String get changePasswordSubmit;

  /// No description provided for @changePasswordFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not change the password'**
  String get changePasswordFailed;

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTitle;

  /// No description provided for @libraryTabGenerations.
  ///
  /// In en, this message translates to:
  /// **'GENERATIONS'**
  String get libraryTabGenerations;

  /// No description provided for @libraryTabCredits.
  ///
  /// In en, this message translates to:
  /// **'CREDITS'**
  String get libraryTabCredits;

  /// No description provided for @libraryTabPayments.
  ///
  /// In en, this message translates to:
  /// **'PAYMENTS'**
  String get libraryTabPayments;

  /// No description provided for @libraryReload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get libraryReload;

  /// No description provided for @librarySignInPrompt.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN TO VIEW YOUR LIBRARY'**
  String get librarySignInPrompt;

  /// No description provided for @libraryRetry.
  ///
  /// In en, this message translates to:
  /// **'RETRY'**
  String get libraryRetry;

  /// No description provided for @libraryLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load your library.'**
  String get libraryLoadFailed;

  /// No description provided for @libraryEmptyGenerations.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t generated any images yet.'**
  String get libraryEmptyGenerations;

  /// No description provided for @libraryEmptyCredits.
  ///
  /// In en, this message translates to:
  /// **'No credit transactions yet.'**
  String get libraryEmptyCredits;

  /// No description provided for @libraryEmptyPayments.
  ///
  /// In en, this message translates to:
  /// **'No payments yet.'**
  String get libraryEmptyPayments;

  /// No description provided for @libraryDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Generation?'**
  String get libraryDeleteDialogTitle;

  /// No description provided for @libraryDeleteDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this generation? This action cannot be undone.'**
  String get libraryDeleteDialogBody;

  /// No description provided for @libraryDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get libraryDeleteCancel;

  /// No description provided for @libraryDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get libraryDeleteConfirm;

  /// No description provided for @libraryDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Generation deleted successfully'**
  String get libraryDeleteSuccess;

  /// No description provided for @libraryDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete generation'**
  String get libraryDeleteFailed;

  /// No description provided for @libraryStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get libraryStatusCompleted;

  /// No description provided for @libraryStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get libraryStatusFailed;

  /// No description provided for @libraryStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get libraryStatusProcessing;

  /// No description provided for @libraryStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get libraryStatusPending;

  /// No description provided for @paymentResultSuccess.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT SUCCESSFUL'**
  String get paymentResultSuccess;

  /// No description provided for @paymentResultCancel.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT CANCELLED'**
  String get paymentResultCancel;

  /// No description provided for @paymentResultError.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT FAILED'**
  String get paymentResultError;

  /// No description provided for @paymentResultSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Your payment has been processed successfully. Credits have been added to your account.'**
  String get paymentResultSuccessMsg;

  /// No description provided for @paymentResultCancelMsg.
  ///
  /// In en, this message translates to:
  /// **'You cancelled the payment. No charges were made to your account.'**
  String get paymentResultCancelMsg;

  /// No description provided for @paymentResultErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing your payment. Please try again or contact support.'**
  String get paymentResultErrorMsg;

  /// No description provided for @paymentResultLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load payment information'**
  String get paymentResultLoadFailed;

  /// No description provided for @paymentDetailPackage.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get paymentDetailPackage;

  /// No description provided for @paymentDetailCredits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get paymentDetailCredits;

  /// No description provided for @paymentDetailAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get paymentDetailAmount;

  /// No description provided for @paymentDetailTransaction.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get paymentDetailTransaction;

  /// No description provided for @paymentBackHome.
  ///
  /// In en, this message translates to:
  /// **'BACK TO HOME'**
  String get paymentBackHome;

  /// No description provided for @paymentTryAgain.
  ///
  /// In en, this message translates to:
  /// **'TRY AGAIN'**
  String get paymentTryAgain;

  /// No description provided for @termsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'LEGAL'**
  String get termsEyebrow;

  /// No description provided for @termsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsHeadline;

  /// No description provided for @termsSubhead.
  ///
  /// In en, this message translates to:
  /// **'Last updated: 10/09/2026 · Applies to the entire REEL service'**
  String get termsSubhead;

  /// No description provided for @termsBackShort.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get termsBackShort;

  /// No description provided for @termsBackLong.
  ///
  /// In en, this message translates to:
  /// **'BACK TO HOME'**
  String get termsBackLong;

  /// No description provided for @termsFooterText.
  ///
  /// In en, this message translates to:
  /// **'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.'**
  String get termsFooterText;

  /// No description provided for @termsAccept.
  ///
  /// In en, this message translates to:
  /// **'I AGREE'**
  String get termsAccept;

  /// No description provided for @termsDecline.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get termsDecline;

  /// No description provided for @adminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @adminBadge.
  ///
  /// In en, this message translates to:
  /// **'ADMIN'**
  String get adminBadge;

  /// No description provided for @adminWorkspaceLabel.
  ///
  /// In en, this message translates to:
  /// **'WORKSPACE'**
  String get adminWorkspaceLabel;

  /// No description provided for @adminSidebarOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get adminSidebarOverview;

  /// No description provided for @adminSidebarGenerations.
  ///
  /// In en, this message translates to:
  /// **'Generations'**
  String get adminSidebarGenerations;

  /// No description provided for @adminSidebarUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminSidebarUsers;

  /// No description provided for @adminSidebarPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get adminSidebarPayments;

  /// No description provided for @adminSidebarSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get adminSidebarSettings;

  /// No description provided for @adminBreadcrumbRoot.
  ///
  /// In en, this message translates to:
  /// **'REEL STUDIO ADMIN'**
  String get adminBreadcrumbRoot;

  /// No description provided for @adminDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminDefaultName;

  /// No description provided for @adminFallbackRole.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get adminFallbackRole;

  /// No description provided for @adminMenuTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get adminMenuTooltip;

  /// No description provided for @adminRtlTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle layout direction LTR / RTL'**
  String get adminRtlTooltip;

  /// No description provided for @adminRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get adminRefreshTooltip;

  /// No description provided for @adminSearchUsersHint.
  ///
  /// In en, this message translates to:
  /// **'Search users…'**
  String get adminSearchUsersHint;

  /// No description provided for @adminExportTooltip.
  ///
  /// In en, this message translates to:
  /// **'Export report'**
  String get adminExportTooltip;

  /// No description provided for @adminExportLabel.
  ///
  /// In en, this message translates to:
  /// **'EXPORT'**
  String get adminExportLabel;

  /// No description provided for @adminExportComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Report export is coming soon.'**
  String get adminExportComingSoon;

  /// No description provided for @adminNotificationsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get adminNotificationsTooltip;

  /// No description provided for @adminRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get adminRangeLabel;

  /// No description provided for @adminRangeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get adminRangeToday;

  /// No description provided for @adminRange7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get adminRange7Days;

  /// No description provided for @adminRange30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get adminRange30Days;

  /// No description provided for @adminRangeTodayLong.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get adminRangeTodayLong;

  /// No description provided for @adminRange7DaysLong.
  ///
  /// In en, this message translates to:
  /// **'in the last 7 days'**
  String get adminRange7DaysLong;

  /// No description provided for @adminRange30DaysLong.
  ///
  /// In en, this message translates to:
  /// **'in the last 30 days'**
  String get adminRange30DaysLong;

  /// No description provided for @adminAutoUpdateNote.
  ///
  /// In en, this message translates to:
  /// **'Auto-updates daily at 00:00'**
  String get adminAutoUpdateNote;

  /// No description provided for @adminKpiTakes.
  ///
  /// In en, this message translates to:
  /// **'Generations — {range}'**
  String adminKpiTakes(Object range);

  /// No description provided for @adminKpiUsers.
  ///
  /// In en, this message translates to:
  /// **'Active users — {range}'**
  String adminKpiUsers(Object range);

  /// No description provided for @adminKpiRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue — {range}'**
  String adminKpiRevenue(Object range);

  /// No description provided for @adminKpiQueue.
  ///
  /// In en, this message translates to:
  /// **'Render queue'**
  String get adminKpiQueue;

  /// No description provided for @adminDailyOutputTitle.
  ///
  /// In en, this message translates to:
  /// **'7-day output'**
  String get adminDailyOutputTitle;

  /// No description provided for @adminDailyOutputEyebrow.
  ///
  /// In en, this message translates to:
  /// **'DAILY OUTPUT'**
  String get adminDailyOutputEyebrow;

  /// No description provided for @adminDailyOutputFooter.
  ///
  /// In en, this message translates to:
  /// **'The {ratio16x9} share makes up 58% of this week\'s renders — followed by 1:1 (24%) and 9:16 (18%).'**
  String adminDailyOutputFooter(Object ratio16x9);

  /// No description provided for @adminStockMixTitle.
  ///
  /// In en, this message translates to:
  /// **'Style ratio'**
  String get adminStockMixTitle;

  /// No description provided for @adminStockMixEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FILM STOCK MIX'**
  String get adminStockMixEyebrow;

  /// No description provided for @adminRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent renders'**
  String get adminRecentTitle;

  /// No description provided for @adminRecentEyebrow.
  ///
  /// In en, this message translates to:
  /// **'CONTACT SHEET · LIVE'**
  String get adminRecentEyebrow;

  /// No description provided for @adminUsersPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminUsersPanelTitle;

  /// No description provided for @adminUsersPanelEyebrow.
  ///
  /// In en, this message translates to:
  /// **'ROSTER'**
  String get adminUsersPanelEyebrow;

  /// No description provided for @adminUsersOpenList.
  ///
  /// In en, this message translates to:
  /// **'Open list'**
  String get adminUsersOpenList;

  /// No description provided for @adminFleetTitle.
  ///
  /// In en, this message translates to:
  /// **'Queue & GPU'**
  String get adminFleetTitle;

  /// No description provided for @adminFleetEyebrow.
  ///
  /// In en, this message translates to:
  /// **'RENDER FLEET'**
  String get adminFleetEyebrow;

  /// No description provided for @adminFleetFooter.
  ///
  /// In en, this message translates to:
  /// **'3/5 workers running · 1 in maintenance · 1 idle'**
  String get adminFleetFooter;

  /// No description provided for @adminFleetJobProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing — {prompt}'**
  String adminFleetJobProcessing(Object prompt);

  /// No description provided for @adminFleetJobIdle.
  ///
  /// In en, this message translates to:
  /// **'Idle — waiting for the next job'**
  String get adminFleetJobIdle;

  /// No description provided for @adminFleetJobMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Scheduled maintenance'**
  String get adminFleetJobMaintenance;

  /// No description provided for @adminGenerationCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get adminGenerationCompleted;

  /// No description provided for @adminGenerationProcessing.
  ///
  /// In en, this message translates to:
  /// **'Rendering'**
  String get adminGenerationProcessing;

  /// No description provided for @adminGenerationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get adminGenerationFailed;

  /// No description provided for @adminUserStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminUserStatusActive;

  /// No description provided for @adminUserStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminUserStatusInactive;

  /// No description provided for @adminUserStatusBanned.
  ///
  /// In en, this message translates to:
  /// **'Banned'**
  String get adminUserStatusBanned;

  /// No description provided for @adminUserRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminUserRoleAdmin;

  /// No description provided for @adminUserRoleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get adminUserRoleUser;

  /// No description provided for @adminSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get adminSettingsTitle;

  /// No description provided for @adminSettingsStudioName.
  ///
  /// In en, this message translates to:
  /// **'Studio display name'**
  String get adminSettingsStudioName;

  /// No description provided for @adminSettingsSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'Support email'**
  String get adminSettingsSupportEmail;

  /// No description provided for @adminSettingsImageCost.
  ///
  /// In en, this message translates to:
  /// **'Credit cost per image'**
  String get adminSettingsImageCost;

  /// No description provided for @adminSettingsVideoCost.
  ///
  /// In en, this message translates to:
  /// **'Credit cost per video'**
  String get adminSettingsVideoCost;

  /// No description provided for @adminSettingsAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get adminSettingsAlerts;

  /// No description provided for @adminSettingsAlertPayment.
  ///
  /// In en, this message translates to:
  /// **'Notify on failed payments'**
  String get adminSettingsAlertPayment;

  /// No description provided for @adminSettingsAlertGeneration.
  ///
  /// In en, this message translates to:
  /// **'Notify on failed generations'**
  String get adminSettingsAlertGeneration;

  /// No description provided for @adminSettingsNewsletter.
  ///
  /// In en, this message translates to:
  /// **'Send newsletter'**
  String get adminSettingsNewsletter;

  /// No description provided for @adminSettingsMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance mode'**
  String get adminSettingsMaintenance;

  /// No description provided for @adminSettingsRegistration.
  ///
  /// In en, this message translates to:
  /// **'Allow new sign-ups'**
  String get adminSettingsRegistration;

  /// No description provided for @adminSettingsSave.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get adminSettingsSave;

  /// No description provided for @adminSettingsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load settings.'**
  String get adminSettingsLoadFailed;

  /// No description provided for @adminSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully.'**
  String get adminSettingsSaved;

  /// No description provided for @adminSettingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save settings.'**
  String get adminSettingsSaveFailed;

  /// No description provided for @adminPackagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment packages'**
  String get adminPackagesTitle;

  /// No description provided for @adminPackagesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No payment packages yet.'**
  String get adminPackagesEmpty;

  /// No description provided for @adminPackagesLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load payment packages.'**
  String get adminPackagesLoadFailed;

  /// No description provided for @adminPackagesNew.
  ///
  /// In en, this message translates to:
  /// **'New package'**
  String get adminPackagesNew;

  /// No description provided for @adminPackagesFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get adminPackagesFeatured;

  /// No description provided for @adminPackagesInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminPackagesInactive;

  /// No description provided for @adminPackagesActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminPackagesActive;

  /// No description provided for @adminPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get adminPaymentsTitle;

  /// No description provided for @adminPaymentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No payments yet.'**
  String get adminPaymentsEmpty;

  /// No description provided for @adminPaymentsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load payments.'**
  String get adminPaymentsLoadFailed;

  /// No description provided for @adminPaymentsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get adminPaymentsFilterAll;

  /// No description provided for @adminCreditsTitle.
  ///
  /// In en, this message translates to:
  /// **'Credit transactions'**
  String get adminCreditsTitle;

  /// No description provided for @adminCreditsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No credit transactions yet.'**
  String get adminCreditsEmpty;

  /// No description provided for @adminCreditsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load credit transactions.'**
  String get adminCreditsLoadFailed;

  /// No description provided for @adminUsersTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminUsersTitle;

  /// No description provided for @adminUsersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No users found.'**
  String get adminUsersEmpty;

  /// No description provided for @adminUsersLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load users.'**
  String get adminUsersLoadFailed;

  /// No description provided for @adminUsersSearch.
  ///
  /// In en, this message translates to:
  /// **'Search by email or name'**
  String get adminUsersSearch;

  /// No description provided for @adminUsersRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get adminUsersRefresh;

  /// No description provided for @adminUsersReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get adminUsersReset;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @termsTocLabel.
  ///
  /// In en, this message translates to:
  /// **'Contents'**
  String get termsTocLabel;

  /// No description provided for @termsNoteBox.
  ///
  /// In en, this message translates to:
  /// **'This is a UI/UX mock-up of sample terms content. Before any official publication, REEL should have the text reviewed by counsel to ensure compliance with current law.'**
  String get termsNoteBox;

  /// No description provided for @termsContactEmail.
  ///
  /// In en, this message translates to:
  /// **'support@reel.studio'**
  String get termsContactEmail;

  /// No description provided for @termsContactLabel.
  ///
  /// In en, this message translates to:
  /// **'Support email'**
  String get termsContactLabel;

  /// No description provided for @termsContactButton.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get termsContactButton;

  /// No description provided for @termsS01Title.
  ///
  /// In en, this message translates to:
  /// **'Acceptance of terms'**
  String get termsS01Title;

  /// No description provided for @termsS01P1.
  ///
  /// In en, this message translates to:
  /// **'By creating an account or using any REEL feature (image generation, video generation, top-up credit, plan upgrade), you agree to the terms below. If you disagree, please stop using the service.'**
  String get termsS01P1;

  /// No description provided for @termsS01P2.
  ///
  /// In en, this message translates to:
  /// **'REEL is for users aged 13 and over. Users under 18 need the consent of a parent or legal guardian.'**
  String get termsS01P2;

  /// No description provided for @termsS02Title.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get termsS02Title;

  /// No description provided for @termsS02P1.
  ///
  /// In en, this message translates to:
  /// **'Each account is tied to one unique email address. You are responsible for keeping your password confidential and for every activity that occurs under your account.'**
  String get termsS02P1;

  /// No description provided for @termsS02B1.
  ///
  /// In en, this message translates to:
  /// **'Registration details (name, email) must be accurate and kept up to date.'**
  String get termsS02B1;

  /// No description provided for @termsS02B2.
  ///
  /// In en, this message translates to:
  /// **'REEL may require email verification before activating certain features.'**
  String get termsS02B2;

  /// No description provided for @termsS02B3.
  ///
  /// In en, this message translates to:
  /// **'Accounts may be active, inactive or banned depending on usage history and any violations.'**
  String get termsS02B3;

  /// No description provided for @termsS03Title.
  ///
  /// In en, this message translates to:
  /// **'Credit & AI generation'**
  String get termsS03Title;

  /// No description provided for @termsS03P1.
  ///
  /// In en, this message translates to:
  /// **'REEL runs on a credit system. Every image or video generation deducts the corresponding credit from your wallet, depending on type, resolution and duration.'**
  String get termsS03P1;

  /// No description provided for @termsS03B1.
  ///
  /// In en, this message translates to:
  /// **'Credits are deducted when the generation request begins processing.'**
  String get termsS03B1;

  /// No description provided for @termsS03B2.
  ///
  /// In en, this message translates to:
  /// **'If a generation fails due to a system error, the credits are automatically refunded.'**
  String get termsS03B2;

  /// No description provided for @termsS03B3.
  ///
  /// In en, this message translates to:
  /// **'REEL does not refund credits when a request fails because it violated the terms (see Section 6).'**
  String get termsS03B3;

  /// No description provided for @termsS03B4.
  ///
  /// In en, this message translates to:
  /// **'Unused credits from monthly/yearly plans do not roll over to the next cycle unless stated otherwise.'**
  String get termsS03B4;

  /// No description provided for @termsS04Title.
  ///
  /// In en, this message translates to:
  /// **'Payment & refund'**
  String get termsS04Title;

  /// No description provided for @termsS04P1.
  ///
  /// In en, this message translates to:
  /// **'REEL accepts payment via Momo, ZaloPay, VNPay, bank transfer and Stripe (for international plans). Every transaction is recorded with its own ID for traceability.'**
  String get termsS04P1;

  /// No description provided for @termsS04B1.
  ///
  /// In en, this message translates to:
  /// **'Monthly/yearly plans auto-renew unless you cancel before the next cycle.'**
  String get termsS04B1;

  /// No description provided for @termsS04B2.
  ///
  /// In en, this message translates to:
  /// **'Refund requests are considered within 7 days of payment, provided the plan credits were not used.'**
  String get termsS04B2;

  /// No description provided for @termsS04B3.
  ///
  /// In en, this message translates to:
  /// **'One-time credit top-ups are non-refundable once the credits have been added to your wallet.'**
  String get termsS04B3;

  /// No description provided for @termsS05Title.
  ///
  /// In en, this message translates to:
  /// **'Content ownership'**
  String get termsS05Title;

  /// No description provided for @termsS05P1.
  ///
  /// In en, this message translates to:
  /// **'You retain usage rights to the content you create on REEL, within the scope of your current plan.'**
  String get termsS05P1;

  /// No description provided for @termsS05B1.
  ///
  /// In en, this message translates to:
  /// **'Free plan: output carries a REEL watermark and is for personal, non-commercial use.'**
  String get termsS05B1;

  /// No description provided for @termsS05B2.
  ///
  /// In en, this message translates to:
  /// **'Pro plan: output has no watermark and may be used commercially.'**
  String get termsS05B2;

  /// No description provided for @termsS05B3.
  ///
  /// In en, this message translates to:
  /// **'REEL does not warrant that AI output is original; you are responsible for checking it before commercial use.'**
  String get termsS05B3;

  /// No description provided for @termsS06Title.
  ///
  /// In en, this message translates to:
  /// **'Prohibited conduct'**
  String get termsS06Title;

  /// No description provided for @termsS06P1.
  ///
  /// In en, this message translates to:
  /// **'You must not use REEL to create or distribute content that:'**
  String get termsS06P1;

  /// No description provided for @termsS06B1.
  ///
  /// In en, this message translates to:
  /// **'Violates current law, incites violence, discrimination or hate speech.'**
  String get termsS06B1;

  /// No description provided for @termsS06B2.
  ///
  /// In en, this message translates to:
  /// **'Is pornographic or involves minors in any form.'**
  String get termsS06B2;

  /// No description provided for @termsS06B3.
  ///
  /// In en, this message translates to:
  /// **'Impersonates others, invades privacy or uses someone\'s likeness without permission.'**
  String get termsS06B3;

  /// No description provided for @termsS06B4.
  ///
  /// In en, this message translates to:
  /// **'Infringes copyright, trademark or other intellectual-property rights of third parties.'**
  String get termsS06B4;

  /// No description provided for @termsS06P2.
  ///
  /// In en, this message translates to:
  /// **'Violations may lead to an account being banned without prior notice and with no refund of credits or fees paid.'**
  String get termsS06P2;

  /// No description provided for @termsS07Title.
  ///
  /// In en, this message translates to:
  /// **'Limitation of liability'**
  String get termsS07Title;

  /// No description provided for @termsS07P1.
  ///
  /// In en, this message translates to:
  /// **'The service is provided \"as is\". REEL does not guarantee uninterrupted or error-free service, nor that every result will meet your expectations.'**
  String get termsS07P1;

  /// No description provided for @termsS07P2.
  ///
  /// In en, this message translates to:
  /// **'To the maximum extent permitted by law, REEL is not liable for indirect damages arising from your use of or inability to use the service.'**
  String get termsS07P2;

  /// No description provided for @termsS08Title.
  ///
  /// In en, this message translates to:
  /// **'Account termination'**
  String get termsS08Title;

  /// No description provided for @termsS08P1.
  ///
  /// In en, this message translates to:
  /// **'You may stop using the service and request deletion of your account at any time. REEL may suspend (inactive) or permanently lock (banned) accounts that violate the terms, after considering the severity of the violation.'**
  String get termsS08P1;

  /// No description provided for @termsS09Title.
  ///
  /// In en, this message translates to:
  /// **'Changes to terms'**
  String get termsS09Title;

  /// No description provided for @termsS09P1.
  ///
  /// In en, this message translates to:
  /// **'REEL may update these terms over time. Important changes will be communicated by email or a banner on the homepage at least 7 days before they take effect.'**
  String get termsS09P1;

  /// No description provided for @termsS10Title.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get termsS10Title;

  /// No description provided for @termsS10P1.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about these terms, please contact the REEL team.'**
  String get termsS10P1;

  /// No description provided for @errorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get errorPasswordRequired;

  /// No description provided for @errorConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password.'**
  String get errorConfirmPasswordRequired;

  /// No description provided for @backToHomeLabel.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get backToHomeLabel;

  /// No description provided for @backToHomeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Return to home'**
  String get backToHomeTooltip;

  /// No description provided for @profileBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get profileBackHome;

  /// No description provided for @profileNavOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get profileNavOverview;

  /// No description provided for @profileNavMyRoll.
  ///
  /// In en, this message translates to:
  /// **'My works'**
  String get profileNavMyRoll;

  /// No description provided for @profileNavSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileNavSettings;

  /// No description provided for @profileNavBilling.
  ///
  /// In en, this message translates to:
  /// **'Plans & Billing'**
  String get profileNavBilling;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name} 👋'**
  String profileWelcomeBack(String name);

  /// No description provided for @profileWelcomeSub.
  ///
  /// In en, this message translates to:
  /// **'You\'ve been with REEL for {days} days.'**
  String profileWelcomeSub(int days);

  /// No description provided for @profileStatTotalTakes.
  ///
  /// In en, this message translates to:
  /// **'Total works'**
  String get profileStatTotalTakes;

  /// No description provided for @profileStatFavoriteStock.
  ///
  /// In en, this message translates to:
  /// **'Top tool'**
  String get profileStatFavoriteStock;

  /// No description provided for @profileStatDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Days with REEL'**
  String get profileStatDaysLabel;

  /// No description provided for @profileStatDaysValue.
  ///
  /// In en, this message translates to:
  /// **'{n} days'**
  String profileStatDaysValue(int n);

  /// No description provided for @profileUpgradePro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get profileUpgradePro;

  /// No description provided for @profileRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent generations'**
  String get profileRecentActivity;

  /// No description provided for @profileViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all →'**
  String get profileViewAll;

  /// No description provided for @profileMyRollSub.
  ///
  /// In en, this message translates to:
  /// **'Everything you\'ve created on REEL.'**
  String get profileMyRollSub;

  /// No description provided for @profileFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get profileFilterAll;

  /// No description provided for @profileFilterVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get profileFilterVideo;

  /// No description provided for @profileFilterPhoto.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get profileFilterPhoto;

  /// No description provided for @profilePhotoTag.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get profilePhotoTag;

  /// No description provided for @profileMyRollEmpty.
  ///
  /// In en, this message translates to:
  /// **'No works yet — create your first one in the Studio.'**
  String get profileMyRollEmpty;

  /// No description provided for @profileTimeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get profileTimeJustNow;

  /// No description provided for @profileTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{n} min ago'**
  String profileTimeMinutesAgo(int n);

  /// No description provided for @profileTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{n} h ago'**
  String profileTimeHoursAgo(int n);

  /// No description provided for @profileTimeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get profileTimeYesterday;

  /// No description provided for @profileTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{n} days ago'**
  String profileTimeDaysAgo(int n);

  /// No description provided for @profileTimeWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{n} weeks ago'**
  String profileTimeWeeksAgo(int n);

  /// No description provided for @profileSettingsSub.
  ///
  /// In en, this message translates to:
  /// **'Update your profile information and default preferences.'**
  String get profileSettingsSub;

  /// No description provided for @profileSectionProfileInfo.
  ///
  /// In en, this message translates to:
  /// **'Profile information'**
  String get profileSectionProfileInfo;

  /// No description provided for @profileFieldDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get profileFieldDisplayName;

  /// No description provided for @profileFieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileFieldEmail;

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get profileSaveChanges;

  /// No description provided for @profileSectionPassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get profileSectionPassword;

  /// No description provided for @profileFieldCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get profileFieldCurrentPassword;

  /// No description provided for @profileFieldNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get profileFieldNewPassword;

  /// No description provided for @profileFieldConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get profileFieldConfirmPassword;

  /// No description provided for @profilePwPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'••••••••••'**
  String get profilePwPlaceholder;

  /// No description provided for @profilePwNewPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get profilePwNewPlaceholder;

  /// No description provided for @profilePwConfirmPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type it again'**
  String get profilePwConfirmPlaceholder;

  /// No description provided for @profileUpdatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get profileUpdatePassword;

  /// No description provided for @profilePwShow.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get profilePwShow;

  /// No description provided for @profilePwHide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get profilePwHide;

  /// No description provided for @profileSectionPrefs.
  ///
  /// In en, this message translates to:
  /// **'Default preferences'**
  String get profileSectionPrefs;

  /// No description provided for @profilePrefRatio.
  ///
  /// In en, this message translates to:
  /// **'Default aspect ratio'**
  String get profilePrefRatio;

  /// No description provided for @profilePrefRatioDesc.
  ///
  /// In en, this message translates to:
  /// **'Applied every time you open the generator'**
  String get profilePrefRatioDesc;

  /// No description provided for @profilePrefStock.
  ///
  /// In en, this message translates to:
  /// **'Default style'**
  String get profilePrefStock;

  /// No description provided for @profilePrefStockDesc.
  ///
  /// In en, this message translates to:
  /// **'Starting style for your generations'**
  String get profilePrefStockDesc;

  /// No description provided for @profileDangerTitle.
  ///
  /// In en, this message translates to:
  /// **'Danger zone'**
  String get profileDangerTitle;

  /// No description provided for @profileDangerDesc.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account removes all of your works. It cannot be undone.'**
  String get profileDangerDesc;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteNotice.
  ///
  /// In en, this message translates to:
  /// **'Account deletion is handled by the REEL team — contact support to request it.'**
  String get profileDeleteNotice;

  /// No description provided for @profileBillingSub.
  ///
  /// In en, this message translates to:
  /// **'Manage your plan and payment methods.'**
  String get profileBillingSub;

  /// No description provided for @profileCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current plan'**
  String get profileCurrentPlan;

  /// No description provided for @profilePlanPerMonth.
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get profilePlanPerMonth;

  /// No description provided for @profilePlanFreePrice.
  ///
  /// In en, this message translates to:
  /// **'0đ'**
  String get profilePlanFreePrice;

  /// No description provided for @profilePlanProPrice.
  ///
  /// In en, this message translates to:
  /// **'199.000đ'**
  String get profilePlanProPrice;

  /// No description provided for @profilePlanFreeF1.
  ///
  /// In en, this message translates to:
  /// **'50 credits / month'**
  String get profilePlanFreeF1;

  /// No description provided for @profilePlanFreeF2.
  ///
  /// In en, this message translates to:
  /// **'Includes REEL watermark'**
  String get profilePlanFreeF2;

  /// No description provided for @profilePlanProF1.
  ///
  /// In en, this message translates to:
  /// **'2,000 credits / month'**
  String get profilePlanProF1;

  /// No description provided for @profilePlanProF2.
  ///
  /// In en, this message translates to:
  /// **'4K, no watermark'**
  String get profilePlanProF2;

  /// No description provided for @profileCurrentTag.
  ///
  /// In en, this message translates to:
  /// **'In use'**
  String get profileCurrentTag;

  /// No description provided for @profileUpgradeShort.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get profileUpgradeShort;

  /// No description provided for @profilePaymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get profilePaymentHistory;

  /// No description provided for @profileEmptyPayments.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet — upgrade to Pro to get started.'**
  String get profileEmptyPayments;

  /// No description provided for @profileFooter.
  ///
  /// In en, this message translates to:
  /// **'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.'**
  String get profileFooter;

  /// No description provided for @profileSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile information updated!'**
  String get profileSettingsSaved;

  /// No description provided for @profilePasswordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated!'**
  String get profilePasswordUpdated;

  /// No description provided for @profileProChip.
  ///
  /// In en, this message translates to:
  /// **'PRO PLAN'**
  String get profileProChip;

  /// No description provided for @profileFreeChip.
  ///
  /// In en, this message translates to:
  /// **'FREE PLAN'**
  String get profileFreeChip;

  /// No description provided for @adminSidebarModeration.
  ///
  /// In en, this message translates to:
  /// **'Moderation'**
  String get adminSidebarModeration;

  /// No description provided for @adminSidebarRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get adminSidebarRevenue;

  /// No description provided for @adminSidebarSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get adminSidebarSystem;

  /// No description provided for @adminRoleChip.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get adminRoleChip;

  /// No description provided for @usageCreditsLabel.
  ///
  /// In en, this message translates to:
  /// **'{balance} credits available'**
  String usageCreditsLabel(int balance);

  /// No description provided for @homeStatCreditsLeft.
  ///
  /// In en, this message translates to:
  /// **'CREDITS LEFT'**
  String get homeStatCreditsLeft;

  /// No description provided for @profileStatCredits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get profileStatCredits;

  /// No description provided for @profileCreditsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{balance} credits available'**
  String profileCreditsAvailable(int balance);

  /// No description provided for @profileTopUp.
  ///
  /// In en, this message translates to:
  /// **'Top up'**
  String get profileTopUp;

  /// No description provided for @profilePlanPayAsYouGo.
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get profilePlanPayAsYouGo;

  /// No description provided for @profileUsageSpentToday.
  ///
  /// In en, this message translates to:
  /// **'{spent} credits used today'**
  String profileUsageSpentToday(int spent);

  /// No description provided for @profileTopUpHint.
  ///
  /// In en, this message translates to:
  /// **'Top up your balance to keep generating.'**
  String get profileTopUpHint;

  /// No description provided for @avatarUpdated.
  ///
  /// In en, this message translates to:
  /// **'Avatar updated'**
  String get avatarUpdated;

  /// No description provided for @avatarUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not upload avatar. Please try again.'**
  String get avatarUpdateFailed;

  /// No description provided for @avatarChangeHint.
  ///
  /// In en, this message translates to:
  /// **'Change profile picture'**
  String get avatarChangeHint;

  /// No description provided for @navCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get navCreate;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'One prompt box.'**
  String get homeHeadline;

  /// No description provided for @homeHeadlineAccent.
  ///
  /// In en, this message translates to:
  /// **'Every kind of creation.'**
  String get homeHeadlineAccent;

  /// No description provided for @homeSubheadRedesign.
  ///
  /// In en, this message translates to:
  /// **'20 AI tools in one home — pinned tools stay on top, find the rest with search. Long multi-page stories live in Manga Studio: script → split into pages → batch generate.'**
  String get homeSubheadRedesign;

  /// No description provided for @toolsBarLabel.
  ///
  /// In en, this message translates to:
  /// **'Your pins'**
  String get toolsBarLabel;

  /// No description provided for @toolsAllButton.
  ///
  /// In en, this message translates to:
  /// **'See all 20 tools'**
  String get toolsAllButton;

  /// No description provided for @toolsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Find a tool — e.g. manga, voice, 3D, code…'**
  String get toolsSearchHint;

  /// No description provided for @toolsCatalogTitle.
  ///
  /// In en, this message translates to:
  /// **'All AI tools'**
  String get toolsCatalogTitle;

  /// No description provided for @toolsCatalogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'20 tools · pick one to open its create panel.'**
  String get toolsCatalogSubtitle;

  /// No description provided for @toolsNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No tool matches — try other keywords (voice, 3D, music…).'**
  String get toolsNoMatch;

  /// No description provided for @toolComingSoon.
  ///
  /// In en, this message translates to:
  /// **'{name} is coming soon — only Image & Video are live right now.'**
  String toolComingSoon(String name);

  /// No description provided for @toolGroupImages.
  ///
  /// In en, this message translates to:
  /// **'Images & Design'**
  String get toolGroupImages;

  /// No description provided for @toolGroupFilm.
  ///
  /// In en, this message translates to:
  /// **'Film & Stories'**
  String get toolGroupFilm;

  /// No description provided for @toolGroupAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio & Music'**
  String get toolGroupAudio;

  /// No description provided for @toolGroupDocs.
  ///
  /// In en, this message translates to:
  /// **'Long-form & Docs'**
  String get toolGroupDocs;

  /// No description provided for @toolGroupTech.
  ///
  /// In en, this message translates to:
  /// **'Tech & Automation'**
  String get toolGroupTech;

  /// No description provided for @panelRatioLabel.
  ///
  /// In en, this message translates to:
  /// **'Aspect ratio'**
  String get panelRatioLabel;

  /// No description provided for @panelStyleLabel.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get panelStyleLabel;

  /// No description provided for @generateImage.
  ///
  /// In en, this message translates to:
  /// **'Generate image'**
  String get generateImage;

  /// No description provided for @generateVideo.
  ///
  /// In en, this message translates to:
  /// **'Generate video'**
  String get generateVideo;

  /// No description provided for @panelGenerateGeneric.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get panelGenerateGeneric;

  /// No description provided for @saveToLibraryHint.
  ///
  /// In en, this message translates to:
  /// **'Results are saved to your Library automatically.'**
  String get saveToLibraryHint;

  /// No description provided for @imagePromptHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the shot you want… e.g. \'rainy city at night, neon reflecting on wet asphalt, 35mm lens\''**
  String get imagePromptHint;

  /// No description provided for @videoPromptHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the scene… e.g. \'drone gliding over a bamboo forest at dawn, drifting mist, pale golden light\''**
  String get videoPromptHint;

  /// No description provided for @genericPromptHint.
  ///
  /// In en, this message translates to:
  /// **'Describe what you want to create…'**
  String get genericPromptHint;

  /// No description provided for @comingSoonNote.
  ///
  /// In en, this message translates to:
  /// **'This tool is a design preview — live generation is not wired to the server yet.'**
  String get comingSoonNote;

  /// No description provided for @modeImageSub.
  ///
  /// In en, this message translates to:
  /// **'One prompt, one art frame.'**
  String get modeImageSub;

  /// No description provided for @modeVideoSub.
  ///
  /// In en, this message translates to:
  /// **'Short scenes from your description.'**
  String get modeVideoSub;

  /// No description provided for @modeSpeechSub.
  ///
  /// In en, this message translates to:
  /// **'Turn scripts into natural audio.'**
  String get modeSpeechSub;

  /// No description provided for @modeMangaSub.
  ///
  /// In en, this message translates to:
  /// **'Multi-page stories: script → pages → dialogue.'**
  String get modeMangaSub;

  /// No description provided for @badgeNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get badgeNew;

  /// No description provided for @librarySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by prompt…'**
  String get librarySearchHint;

  /// No description provided for @libraryFilterImage.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get libraryFilterImage;

  /// No description provided for @libraryFilterVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get libraryFilterVideo;

  /// No description provided for @libraryFilterPinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get libraryFilterPinned;

  /// No description provided for @librarySelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get librarySelect;

  /// No description provided for @librarySelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String librarySelectedCount(int count);

  /// No description provided for @libraryBulkDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get libraryBulkDownload;

  /// No description provided for @libraryBulkDownloadSoon.
  ///
  /// In en, this message translates to:
  /// **'Bulk download is coming soon.'**
  String get libraryBulkDownloadSoon;

  /// No description provided for @libraryBulkDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Deleted {count} items'**
  String libraryBulkDeleteSuccess(int count);

  /// No description provided for @libraryPinAdded.
  ///
  /// In en, this message translates to:
  /// **'Pinned to your library'**
  String get libraryPinAdded;

  /// No description provided for @libraryPinRemoved.
  ///
  /// In en, this message translates to:
  /// **'Pin removed'**
  String get libraryPinRemoved;

  /// No description provided for @libraryNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No items match your filter or search.'**
  String get libraryNoMatch;

  /// No description provided for @authCardSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authCardSignInTitle;

  /// No description provided for @authCardSignInSub.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep creating with REEL.'**
  String get authCardSignInSub;

  /// No description provided for @authCardSignUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCardSignUpTitle;

  /// No description provided for @authCardSignUpSub.
  ///
  /// In en, this message translates to:
  /// **'Free forever — upgrade when you need to.'**
  String get authCardSignUpSub;

  /// No description provided for @authCardResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter code & new password'**
  String get authCardResetTitle;

  /// No description provided for @authCardResetSub.
  ///
  /// In en, this message translates to:
  /// **'The code is valid for 10 minutes.'**
  String get authCardResetSub;

  /// No description provided for @authShowcaseAccent.
  ///
  /// In en, this message translates to:
  /// **'Twenty kinds of works.'**
  String get authShowcaseAccent;

  /// No description provided for @authShowcaseSub.
  ///
  /// In en, this message translates to:
  /// **'Images, video, voice, multi-page manga, music, 3D, code… — all from the words you write. Sign in to keep creating.'**
  String get authShowcaseSub;

  /// No description provided for @authShowcaseMore.
  ///
  /// In en, this message translates to:
  /// **'+12 more tools'**
  String get authShowcaseMore;

  /// No description provided for @authGiftTitle.
  ///
  /// In en, this message translates to:
  /// **'50 welcome credits'**
  String get authGiftTitle;

  /// No description provided for @authGiftSub.
  ///
  /// In en, this message translates to:
  /// **'≈ 12 images, or 8 manga pages, or 50 sound effects. No credit card needed.'**
  String get authGiftSub;

  /// No description provided for @authStatToolsLabel.
  ///
  /// In en, this message translates to:
  /// **'AI tools'**
  String get authStatToolsLabel;

  /// No description provided for @authStatMangaValue.
  ///
  /// In en, this message translates to:
  /// **'1 book'**
  String get authStatMangaValue;

  /// No description provided for @authStatMangaLabel.
  ///
  /// In en, this message translates to:
  /// **'Manga = 1 project'**
  String get authStatMangaLabel;

  /// No description provided for @authStatRatingValue.
  ///
  /// In en, this message translates to:
  /// **'4.9★'**
  String get authStatRatingValue;

  /// No description provided for @authStatRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loved by creators'**
  String get authStatRatingLabel;

  /// No description provided for @authStatFreeValue.
  ///
  /// In en, this message translates to:
  /// **'0đ'**
  String get authStatFreeValue;

  /// No description provided for @authStatFreeLabel.
  ///
  /// In en, this message translates to:
  /// **'To start'**
  String get authStatFreeLabel;

  /// No description provided for @authStatSignupValue.
  ///
  /// In en, this message translates to:
  /// **'30s'**
  String get authStatSignupValue;

  /// No description provided for @authStatSignupLabel.
  ///
  /// In en, this message translates to:
  /// **'To sign up'**
  String get authStatSignupLabel;

  /// No description provided for @authMeterEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password strength'**
  String get authMeterEmpty;

  /// No description provided for @authMeterWeak.
  ///
  /// In en, this message translates to:
  /// **'WEAK — ADD UPPERCASE / DIGITS'**
  String get authMeterWeak;

  /// No description provided for @authMeterOk.
  ///
  /// In en, this message translates to:
  /// **'PRETTY GOOD'**
  String get authMeterOk;

  /// No description provided for @authMeterStrong.
  ///
  /// In en, this message translates to:
  /// **'VERY STRONG ✓'**
  String get authMeterStrong;

  /// No description provided for @adminSidebarQueue.
  ///
  /// In en, this message translates to:
  /// **'Generation queue'**
  String get adminSidebarQueue;

  /// No description provided for @adminSidebarTools.
  ///
  /// In en, this message translates to:
  /// **'AI tools'**
  String get adminSidebarTools;

  /// No description provided for @librarySortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get librarySortNewest;

  /// No description provided for @librarySortOldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get librarySortOldest;

  /// No description provided for @librarySortName.
  ///
  /// In en, this message translates to:
  /// **'Name A–Z'**
  String get librarySortName;

  /// No description provided for @librarySortCost.
  ///
  /// In en, this message translates to:
  /// **'Credits ↓'**
  String get librarySortCost;

  /// No description provided for @libraryCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get libraryCreate;

  /// No description provided for @libraryProjects.
  ///
  /// In en, this message translates to:
  /// **'📚 ACTIVE PROJECTS'**
  String get libraryProjects;

  /// No description provided for @libraryProjectMangaSub.
  ///
  /// In en, this message translates to:
  /// **'8/12 pages · Chapter 2 generating · 3 locked characters'**
  String get libraryProjectMangaSub;

  /// No description provided for @libraryProjectContinueManga.
  ///
  /// In en, this message translates to:
  /// **'Continue in Manga Studio'**
  String get libraryProjectContinueManga;

  /// No description provided for @libraryProjectBookSub.
  ///
  /// In en, this message translates to:
  /// **'3/6 chapters · 21,400 words · PDF-EPUB export when done'**
  String get libraryProjectBookSub;

  /// No description provided for @libraryProjectContinueBook.
  ///
  /// In en, this message translates to:
  /// **'Continue writing'**
  String get libraryProjectContinueBook;

  /// No description provided for @libraryCollections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get libraryCollections;

  /// No description provided for @libraryCollectionsMock.
  ///
  /// In en, this message translates to:
  /// **'Mockup — collections sync with the backend'**
  String get libraryCollectionsMock;

  /// No description provided for @libraryNewCollection.
  ///
  /// In en, this message translates to:
  /// **'New collection'**
  String get libraryNewCollection;

  /// No description provided for @libraryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get libraryOther;

  /// No description provided for @libraryTrash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get libraryTrash;

  /// No description provided for @libraryTrashMock.
  ///
  /// In en, this message translates to:
  /// **'Trash keeps files for 30 days'**
  String get libraryTrashMock;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

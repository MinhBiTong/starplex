// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'REEL — AI Film & Photo Studio';

  @override
  String get languageLabel => 'Language';

  @override
  String get languagePickerTooltip => 'Choose interface language';

  @override
  String get signIn => 'SIGN IN';

  @override
  String get signUp => 'SIGN UP';

  @override
  String get getStarted => 'Get started';

  @override
  String get forgot => 'FORGOT';

  @override
  String get resetPassword => 'RESET PASSWORD';

  @override
  String get newPassword => 'NEW PASSWORD';

  @override
  String get credentialsBadge => 'CREDENTIALS';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · ACCESS $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'SIGN IN';

  @override
  String get productionAccessRollSignUp => 'SIGN UP';

  @override
  String get productionAccessRollReset => 'RESET PASSWORD';

  @override
  String get productionAccessRollNewPassword => 'NEW PASSWORD';

  @override
  String get authHeadlineSignIn => 'Every scene';

  @override
  String get authHeadlineSignInItalic => 'needs a cast.';

  @override
  String get authSubheadSignIn =>
      'Sign in to keep creating, save your works and manage your library.';

  @override
  String get authHeadlineSignUp => 'Join the';

  @override
  String get authHeadlineSignUpItalic => 'production.';

  @override
  String get authSubheadSignUp =>
      'Create an account to save your works, track credits and pick up whenever inspiration shows up.';

  @override
  String get authHeadlineForgot => 'Lost the';

  @override
  String get authHeadlineForgotItalic => 'negative?';

  @override
  String get authSubheadForgot =>
      'Enter your email and we\'ll send a password reset link.';

  @override
  String get authHeadlineReset => 'Make a';

  @override
  String get authHeadlineResetItalic => 'new cut.';

  @override
  String get authSubheadReset =>
      'Create a new password to step back into your creative space.';

  @override
  String get inputEmail => 'EMAIL';

  @override
  String get inputEmailHint => 'you@example.com';

  @override
  String get inputPassword => 'PASSWORD';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'At least 8 characters';

  @override
  String get inputFullName => 'DISPLAY NAME';

  @override
  String get inputFullNameHint => 'Director of this production';

  @override
  String get inputConfirmPassword => 'CONFIRM PASSWORD';

  @override
  String get inputConfirmPasswordHint => 'Re-enter password';

  @override
  String get inputResetCode => 'RESET CODE';

  @override
  String get inputResetCodeHint => 'Paste the code from your email';

  @override
  String get inputNewPassword => 'NEW PASSWORD';

  @override
  String get inputNewPasswordHint => 'At least 8 characters';

  @override
  String get inputNewPasswordConfirmHint => 'Re-enter the new password';

  @override
  String get inputAvatarUrl => 'AVATAR URL (OPTIONAL)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Full Name';

  @override
  String get inputFullNameEditHint => 'Enter your full name';

  @override
  String get toggleShowPassword => 'Show password';

  @override
  String get toggleHidePassword => 'Hide password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPasswordLink => 'Forgot password?';

  @override
  String get signInButton => 'SIGN IN ►';

  @override
  String get signUpButton => 'CREATE ACCOUNT ►';

  @override
  String get forgotButton => 'SEND LINK ►';

  @override
  String get resetPasswordButton => 'RESET PASSWORD ►';

  @override
  String get orDivider => 'OR';

  @override
  String get noAccountPrompt => 'Don\'t have an account? ';

  @override
  String get noAccountLink => 'Sign up now';

  @override
  String get hasAccountPrompt => 'Already have an account? ';

  @override
  String get hasAccountLink => 'Sign in';

  @override
  String get forgotRememberedPrompt => 'Remembered your password? ';

  @override
  String get forgotRememberedLink => 'Back to sign in';

  @override
  String get resetRememberedPrompt => 'Remembered your password? ';

  @override
  String get resetRememberedLink => 'Back to sign in';

  @override
  String get agreeTermsPrefix => 'I agree to the ';

  @override
  String get agreeTermsLink => 'Production Terms';

  @override
  String get agreeTermsSemantic => 'I agree to the Production Terms';

  @override
  String get forgotDescription =>
      'Enter the email you signed up with. The reset code is valid for 30 minutes.';

  @override
  String get statsFooter => 'YOUR NEXT SCENE STARTS HERE';

  @override
  String get errorEmailPasswordRequired =>
      'Please enter your email and password.';

  @override
  String get errorAllFieldsRequired => 'Please fill in all the fields.';

  @override
  String get errorPasswordTooShort => 'Password must be at least 8 characters.';

  @override
  String get errorPasswordMismatch => 'Confirmation password does not match.';

  @override
  String get errorAcceptTerms => 'Please accept the production terms.';

  @override
  String get errorEmailRequired => 'Please enter your email.';

  @override
  String get errorResetCodeRequired =>
      'Reset code is required and password must be at least 8 characters.';

  @override
  String get errorGeneric => 'Cannot connect to the server.';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address.';

  @override
  String get errorInvalidAvatarUrl =>
      'Avatar URL must start with http:// or https://.';

  @override
  String get errorSignInFailed => 'Wrong email or password.';

  @override
  String get errorSignUpFailed => 'Sign-up failed.';

  @override
  String get errorForgotFailed => 'Could not generate the password reset link.';

  @override
  String get errorResetFailed => 'Could not reset the password.';

  @override
  String get errorFullNameRequired => 'Please enter your full name.';

  @override
  String get successSignUp => 'Sign-up successful! Please sign in.';

  @override
  String get successResetPassword =>
      'Your password has been changed successfully.';

  @override
  String get successForgotEmail => 'If the email exists, a link has been sent.';

  @override
  String get successProfileSaved => 'Profile updated successfully!';

  @override
  String get successPasswordChanged =>
      'Password changed successfully! Please sign in again.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'Could not load profile: $message';
  }

  @override
  String get explore => 'Explore';

  @override
  String get gallery => 'Gallery';

  @override
  String get faq => 'FAQ';

  @override
  String get pricing => 'Pricing';

  @override
  String get loginPrompt => 'Please sign in before generating an image.';

  @override
  String get emptyPrompt => 'Please enter a prompt before pressing Action.';

  @override
  String get imageOnlySupported =>
      'REEL currently supports text-to-image only. Please choose Photo.';

  @override
  String get imageGenerationFailed =>
      'Could not generate the image. Check the backend and model.';

  @override
  String get noImageReturned => 'Model did not return an image.';

  @override
  String get videoDurationLabel => 'DURATION';

  @override
  String get videoQualityLabel => 'QUALITY';

  @override
  String get videoQueuedMessage =>
      'Video is rendering — this takes a few minutes. The result will appear here.';

  @override
  String get videoGenerationFailed =>
      'Video generation failed. Your credits were refunded.';

  @override
  String get videoTimeoutMessage =>
      'The video is taking longer than expected. Check your Library in your profile shortly.';

  @override
  String get videoReadyLabel => 'Your video is ready';

  @override
  String get usageLabelSignedOut => 'Sign in to get started';

  @override
  String get rtlToggleTooltip => 'Toggle layout direction LTR / RTL';

  @override
  String get footerTagline =>
      'REEL — developed in the dark, one frame at a time. Turn a line of text into a shot.';

  @override
  String get productColumn => 'PRODUCT';

  @override
  String get supportColumn => 'SUPPORT';

  @override
  String get signInLink => 'Sign in';

  @override
  String get signUpLink => 'Sign up';

  @override
  String get footerCaption1 =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Type a scene.';

  @override
  String get getTheTake => 'Get the take.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Turn a line of text into a shot — framed, lit and moving in seconds. Video or still, one roll.';

  @override
  String get homeStatLastTake => 'LAST TAKE';

  @override
  String get homeStatAspectRatios => 'ASPECT RATIOS';

  @override
  String get homeStatFilmStocks => 'FILM STOCKS';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'Describe your scene…';

  @override
  String get homeQuickChips =>
      'Masquerade under chandeliers | Knight in a dust storm | Marionette workshop';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'Generating…';

  @override
  String get homeGenerate => 'Generate';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Generation complete · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => 'Could not load the result image.';

  @override
  String get homeGenerationOpenOriginal => 'Open original';

  @override
  String get homeGenerationRegenerate => 'Regenerate';

  @override
  String get homeGenerationOpenFailed => 'Could not open the original image.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'One line of text. One complete scene.';

  @override
  String get showcaseSubtitle =>
      'Watch REEL turn a description into a real frame, step by step.';

  @override
  String get showcasePrompt1 =>
      '\"astronaut surfing across the red dunes of mars, golden hour, wide shot\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"masquerade ball under chandeliers, slow camera move\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"rider on horseback in a dust storm at dusk, tracking shot\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Four tools, one shot';

  @override
  String get featuresSubtitle =>
      'Everything you need to go from a line of text to a complete frame.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Lighting, camera moves and cinematic grammar learned from millions of real frames.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 for widescreen, 1:1 for feeds, 9:16 for stories — no need to re-edit from scratch.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — pick your texture before you press Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'The same prompt, the same studio. Still images today; motion when ready.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Frequently asked questions';

  @override
  String get faqSubtitle => 'Anything else, just message the REEL team.';

  @override
  String get faqQ1 => 'How does REEL work?';

  @override
  String get faqA1 =>
      'Type a description, choose a frame ratio and a film stock. REEL generates an image from it. Motion features are on the way.';

  @override
  String get faqQ2 => 'How is REEL different from other AI video tools?';

  @override
  String get faqA2 =>
      'REEL focuses on cinematic language — lighting, framing and film stock — inside one creative studio.';

  @override
  String get faqQ3 => 'How many free takes do I get?';

  @override
  String get faqA3 =>
      'Your current quota and remaining credits are shown in the studio once you\'re signed in. Check the pricing page for active plan benefits.';

  @override
  String get faqQ4 => 'Which formats and resolutions are supported?';

  @override
  String get faqA4 =>
      'Images support three ratios — 16:9, 1:1 and 9:16. Output size depends on the current generation configuration.';

  @override
  String get faqQ5 => 'Can I use the results commercially?';

  @override
  String get faqA5 =>
      'Check the Production Terms and the benefits of the plan you pick before using results commercially.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Pick your shooting pace';

  @override
  String get plansSubtitle =>
      'Start free, upgrade whenever you need to create more.';

  @override
  String get ctaReady => 'Ready for your';

  @override
  String get ctaReadyItalic => 'first take?';

  @override
  String get ctaBody => 'Free, no credit card — first frame in under a minute.';

  @override
  String get ctaFreeButton => 'Create a free account';

  @override
  String get ctaGalleryButton => 'View gallery';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Latest frames';

  @override
  String get contactSheetSubtitle =>
      'A few scenes the REEL community just finished editing.';

  @override
  String get contactSheetDialogTitle => 'Preview of visual style.';

  @override
  String get contactSheetDialogBody =>
      'Generate your own take inside the studio.';

  @override
  String get contactSheetClose => 'Close';

  @override
  String get pricingTitle => 'PRICING';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Pick your shooting pace';

  @override
  String get pricingSubheading =>
      'Start free, upgrade whenever you need to create more.';

  @override
  String get pricingEmpty => 'No active packages right now.';

  @override
  String get pricingBuyButton => 'Open Studio';

  @override
  String get pricingFreeCta => 'Use for free';

  @override
  String get pricingSignInFirst => 'Please sign in before buying a package.';

  @override
  String get pricingLoadFailed => 'Could not load the packages.';

  @override
  String get pricingStripeOpenFailed =>
      'Could not open the Stripe payment page.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout opened. Credits will be added automatically after a successful payment.';

  @override
  String get pricingCreditsSuffix => ' CREDITS';

  @override
  String get pricingCreditsPerMonth => 'credits per month';

  @override
  String get pricingPeriodMonthly => '/month';

  @override
  String get pricingPeriodYearly => '/year';

  @override
  String get pricingFreePerk =>
      '50 free credits every month — try every tool in the studio.';

  @override
  String get profileTitle => 'MY PROFILE';

  @override
  String profileLoadFailed(Object message) {
    return 'Could not load profile: $message';
  }

  @override
  String get profileNotLoaded => 'Could not load profile information';

  @override
  String get profileEditButton => 'EDIT PROFILE';

  @override
  String get profileChangePasswordButton => 'CHANGE PASSWORD';

  @override
  String get profileUsageSection => 'USAGE & CREDITS';

  @override
  String get profileCreditBalance => 'Credit Balance';

  @override
  String get profileDailyUsage => 'Daily Usage';

  @override
  String get profileAccountSection => 'ACCOUNT INFO';

  @override
  String get profileUserId => 'User ID';

  @override
  String get profileStatus => 'Status';

  @override
  String get profileStatusActive => 'Active';

  @override
  String get profileStatusInactive => 'Inactive';

  @override
  String get profileMemberSince => 'Member Since';

  @override
  String get profileUnknownName => 'Unknown';

  @override
  String get profileUnknownEmail => 'No email';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'EDIT PROFILE';

  @override
  String get editProfileSubhead => 'Update your profile information';

  @override
  String get editProfileSave => 'SAVE CHANGES';

  @override
  String editProfileLoadFailed(Object message) {
    return 'Could not load profile: $message';
  }

  @override
  String get editProfileSaveFailed => 'Could not update profile';

  @override
  String get changePasswordTitle => 'CHANGE PASSWORD';

  @override
  String get changePasswordSubhead =>
      'Enter your current password and choose a new one';

  @override
  String get changePasswordCurrent => 'Current Password';

  @override
  String get changePasswordNew => 'New Password';

  @override
  String get changePasswordConfirm => 'Confirm New Password';

  @override
  String get changePasswordCurrentRequired =>
      'Please enter your current password';

  @override
  String get changePasswordNewRequired => 'Please enter a new password';

  @override
  String get changePasswordTooShort => 'Password must be at least 8 characters';

  @override
  String get changePasswordConfirmRequired =>
      'Please confirm your new password';

  @override
  String get changePasswordMismatch => 'Passwords do not match';

  @override
  String get changePasswordSubmit => 'CHANGE PASSWORD';

  @override
  String get changePasswordFailed => 'Could not change the password';

  @override
  String get libraryTitle => 'Library';

  @override
  String get libraryTabGenerations => 'GENERATIONS';

  @override
  String get libraryTabCredits => 'CREDITS';

  @override
  String get libraryTabPayments => 'PAYMENTS';

  @override
  String get libraryReload => 'Reload';

  @override
  String get librarySignInPrompt => 'SIGN IN TO VIEW YOUR LIBRARY';

  @override
  String get libraryRetry => 'RETRY';

  @override
  String get libraryLoadFailed => 'Could not load your library.';

  @override
  String get libraryEmptyGenerations =>
      'You haven\'t generated any images yet.';

  @override
  String get libraryEmptyCredits => 'No credit transactions yet.';

  @override
  String get libraryEmptyPayments => 'No payments yet.';

  @override
  String get libraryDeleteDialogTitle => 'Delete Generation?';

  @override
  String get libraryDeleteDialogBody =>
      'Are you sure you want to delete this generation? This action cannot be undone.';

  @override
  String get libraryDeleteCancel => 'CANCEL';

  @override
  String get libraryDeleteConfirm => 'DELETE';

  @override
  String get libraryDeleteSuccess => 'Generation deleted successfully';

  @override
  String get libraryDeleteFailed => 'Failed to delete generation';

  @override
  String get libraryStatusCompleted => 'Completed';

  @override
  String get libraryStatusFailed => 'Failed';

  @override
  String get libraryStatusProcessing => 'Processing';

  @override
  String get libraryStatusPending => 'Pending';

  @override
  String get paymentResultSuccess => 'PAYMENT SUCCESSFUL';

  @override
  String get paymentResultCancel => 'PAYMENT CANCELLED';

  @override
  String get paymentResultError => 'PAYMENT FAILED';

  @override
  String get paymentResultSuccessMsg =>
      'Your payment has been processed successfully. Credits have been added to your account.';

  @override
  String get paymentResultCancelMsg =>
      'You cancelled the payment. No charges were made to your account.';

  @override
  String get paymentResultErrorMsg =>
      'An error occurred while processing your payment. Please try again or contact support.';

  @override
  String get paymentResultLoadFailed => 'Could not load payment information';

  @override
  String get paymentDetailPackage => 'Package';

  @override
  String get paymentDetailCredits => 'Credits';

  @override
  String get paymentDetailAmount => 'Amount';

  @override
  String get paymentDetailTransaction => 'Transaction';

  @override
  String get paymentBackHome => 'BACK TO HOME';

  @override
  String get paymentTryAgain => 'TRY AGAIN';

  @override
  String get termsEyebrow => 'LEGAL';

  @override
  String get termsHeadline => 'Terms of Service';

  @override
  String get termsSubhead =>
      'Last updated: 10/09/2026 · Applies to the entire REEL service';

  @override
  String get termsBackShort => 'BACK';

  @override
  String get termsBackLong => 'BACK TO HOME';

  @override
  String get termsFooterText =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get termsAccept => 'I AGREE';

  @override
  String get termsDecline => 'BACK';

  @override
  String get adminDashboardTitle => 'Admin Dashboard';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Overview';

  @override
  String get adminSidebarGenerations => 'Generations';

  @override
  String get adminSidebarUsers => 'Users';

  @override
  String get adminSidebarPayments => 'Payments';

  @override
  String get adminSidebarSettings => 'Settings';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Administrator';

  @override
  String get adminMenuTooltip => 'Open menu';

  @override
  String get adminRtlTooltip => 'Toggle layout direction LTR / RTL';

  @override
  String get adminRefreshTooltip => 'Refresh';

  @override
  String get adminSearchUsersHint => 'Search users…';

  @override
  String get adminExportTooltip => 'Export report';

  @override
  String get adminExportLabel => 'EXPORT';

  @override
  String get adminExportComingSoon => 'Report export is coming soon.';

  @override
  String get adminNotificationsTooltip => 'Notifications';

  @override
  String get adminRangeLabel => 'Range';

  @override
  String get adminRangeToday => 'Today';

  @override
  String get adminRange7Days => 'Last 7 days';

  @override
  String get adminRange30Days => 'Last 30 days';

  @override
  String get adminRangeTodayLong => 'today';

  @override
  String get adminRange7DaysLong => 'in the last 7 days';

  @override
  String get adminRange30DaysLong => 'in the last 30 days';

  @override
  String get adminAutoUpdateNote => 'Auto-updates daily at 00:00';

  @override
  String adminKpiTakes(Object range) {
    return 'Generations — $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Active users — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Revenue — $range';
  }

  @override
  String get adminKpiQueue => 'Render queue';

  @override
  String get adminDailyOutputTitle => '7-day output';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return 'The $ratio16x9 share makes up 58% of this week\'s renders — followed by 1:1 (24%) and 9:16 (18%).';
  }

  @override
  String get adminStockMixTitle => 'Style ratio';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Recent renders';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Users';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Open list';

  @override
  String get adminFleetTitle => 'Queue & GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter =>
      '3/5 workers running · 1 in maintenance · 1 idle';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'Processing — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Idle — waiting for the next job';

  @override
  String get adminFleetJobMaintenance => 'Scheduled maintenance';

  @override
  String get adminGenerationCompleted => 'Completed';

  @override
  String get adminGenerationProcessing => 'Rendering';

  @override
  String get adminGenerationFailed => 'Failed';

  @override
  String get adminUserStatusActive => 'Active';

  @override
  String get adminUserStatusInactive => 'Inactive';

  @override
  String get adminUserStatusBanned => 'Banned';

  @override
  String get adminUserRoleAdmin => 'Admin';

  @override
  String get adminUserRoleUser => 'User';

  @override
  String get adminSettingsTitle => 'Settings';

  @override
  String get adminSettingsStudioName => 'Studio display name';

  @override
  String get adminSettingsSupportEmail => 'Support email';

  @override
  String get adminSettingsImageCost => 'Credit cost per image';

  @override
  String get adminSettingsVideoCost => 'Credit cost per video';

  @override
  String get adminSettingsAlerts => 'Alerts';

  @override
  String get adminSettingsAlertPayment => 'Notify on failed payments';

  @override
  String get adminSettingsAlertGeneration => 'Notify on failed generations';

  @override
  String get adminSettingsNewsletter => 'Send newsletter';

  @override
  String get adminSettingsMaintenance => 'Maintenance mode';

  @override
  String get adminSettingsRegistration => 'Allow new sign-ups';

  @override
  String get adminSettingsSave => 'SAVE CHANGES';

  @override
  String get adminSettingsLoadFailed => 'Could not load settings.';

  @override
  String get adminSettingsSaved => 'Settings saved successfully.';

  @override
  String get adminSettingsSaveFailed => 'Could not save settings.';

  @override
  String get adminPackagesTitle => 'Payment packages';

  @override
  String get adminPackagesEmpty => 'No payment packages yet.';

  @override
  String get adminPackagesLoadFailed => 'Could not load payment packages.';

  @override
  String get adminPackagesNew => 'New package';

  @override
  String get adminPackagesFeatured => 'Featured';

  @override
  String get adminPackagesInactive => 'Inactive';

  @override
  String get adminPackagesActive => 'Active';

  @override
  String get adminPaymentsTitle => 'Payments';

  @override
  String get adminPaymentsEmpty => 'No payments yet.';

  @override
  String get adminPaymentsLoadFailed => 'Could not load payments.';

  @override
  String get adminPaymentsFilterAll => 'All';

  @override
  String get adminCreditsTitle => 'Credit transactions';

  @override
  String get adminCreditsEmpty => 'No credit transactions yet.';

  @override
  String get adminCreditsLoadFailed => 'Could not load credit transactions.';

  @override
  String get adminUsersTitle => 'Users';

  @override
  String get adminUsersEmpty => 'No users found.';

  @override
  String get adminUsersLoadFailed => 'Could not load users.';

  @override
  String get adminUsersSearch => 'Search by email or name';

  @override
  String get adminUsersRefresh => 'Refresh';

  @override
  String get adminUsersReset => 'Reset';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSave => 'Save';

  @override
  String get commonClose => 'Close';

  @override
  String get termsTocLabel => 'Contents';

  @override
  String get termsNoteBox =>
      'This is a UI/UX mock-up of sample terms content. Before any official publication, REEL should have the text reviewed by counsel to ensure compliance with current law.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'Support email';

  @override
  String get termsContactButton => 'Contact support';

  @override
  String get termsS01Title => 'Acceptance of terms';

  @override
  String get termsS01P1 =>
      'By creating an account or using any REEL feature (image generation, video generation, top-up credit, plan upgrade), you agree to the terms below. If you disagree, please stop using the service.';

  @override
  String get termsS01P2 =>
      'REEL is for users aged 13 and over. Users under 18 need the consent of a parent or legal guardian.';

  @override
  String get termsS02Title => 'Account';

  @override
  String get termsS02P1 =>
      'Each account is tied to one unique email address. You are responsible for keeping your password confidential and for every activity that occurs under your account.';

  @override
  String get termsS02B1 =>
      'Registration details (name, email) must be accurate and kept up to date.';

  @override
  String get termsS02B2 =>
      'REEL may require email verification before activating certain features.';

  @override
  String get termsS02B3 =>
      'Accounts may be active, inactive or banned depending on usage history and any violations.';

  @override
  String get termsS03Title => 'Credit & AI generation';

  @override
  String get termsS03P1 =>
      'REEL runs on a credit system. Every image or video generation deducts the corresponding credit from your wallet, depending on type, resolution and duration.';

  @override
  String get termsS03B1 =>
      'Credits are deducted when the generation request begins processing.';

  @override
  String get termsS03B2 =>
      'If a generation fails due to a system error, the credits are automatically refunded.';

  @override
  String get termsS03B3 =>
      'REEL does not refund credits when a request fails because it violated the terms (see Section 6).';

  @override
  String get termsS03B4 =>
      'Unused credits from monthly/yearly plans do not roll over to the next cycle unless stated otherwise.';

  @override
  String get termsS04Title => 'Payment & refund';

  @override
  String get termsS04P1 =>
      'REEL accepts payment via Momo, ZaloPay, VNPay, bank transfer and Stripe (for international plans). Every transaction is recorded with its own ID for traceability.';

  @override
  String get termsS04B1 =>
      'Monthly/yearly plans auto-renew unless you cancel before the next cycle.';

  @override
  String get termsS04B2 =>
      'Refund requests are considered within 7 days of payment, provided the plan credits were not used.';

  @override
  String get termsS04B3 =>
      'One-time credit top-ups are non-refundable once the credits have been added to your wallet.';

  @override
  String get termsS05Title => 'Content ownership';

  @override
  String get termsS05P1 =>
      'You retain usage rights to the content you create on REEL, within the scope of your current plan.';

  @override
  String get termsS05B1 =>
      'Free plan: output carries a REEL watermark and is for personal, non-commercial use.';

  @override
  String get termsS05B2 =>
      'Pro plan: output has no watermark and may be used commercially.';

  @override
  String get termsS05B3 =>
      'REEL does not warrant that AI output is original; you are responsible for checking it before commercial use.';

  @override
  String get termsS06Title => 'Prohibited conduct';

  @override
  String get termsS06P1 =>
      'You must not use REEL to create or distribute content that:';

  @override
  String get termsS06B1 =>
      'Violates current law, incites violence, discrimination or hate speech.';

  @override
  String get termsS06B2 => 'Is pornographic or involves minors in any form.';

  @override
  String get termsS06B3 =>
      'Impersonates others, invades privacy or uses someone\'s likeness without permission.';

  @override
  String get termsS06B4 =>
      'Infringes copyright, trademark or other intellectual-property rights of third parties.';

  @override
  String get termsS06P2 =>
      'Violations may lead to an account being banned without prior notice and with no refund of credits or fees paid.';

  @override
  String get termsS07Title => 'Limitation of liability';

  @override
  String get termsS07P1 =>
      'The service is provided \"as is\". REEL does not guarantee uninterrupted or error-free service, nor that every result will meet your expectations.';

  @override
  String get termsS07P2 =>
      'To the maximum extent permitted by law, REEL is not liable for indirect damages arising from your use of or inability to use the service.';

  @override
  String get termsS08Title => 'Account termination';

  @override
  String get termsS08P1 =>
      'You may stop using the service and request deletion of your account at any time. REEL may suspend (inactive) or permanently lock (banned) accounts that violate the terms, after considering the severity of the violation.';

  @override
  String get termsS09Title => 'Changes to terms';

  @override
  String get termsS09P1 =>
      'REEL may update these terms over time. Important changes will be communicated by email or a banner on the homepage at least 7 days before they take effect.';

  @override
  String get termsS10Title => 'Contact';

  @override
  String get termsS10P1 =>
      'If you have any questions about these terms, please contact the REEL team.';

  @override
  String get errorPasswordRequired => 'Please enter your password.';

  @override
  String get errorConfirmPasswordRequired => 'Please confirm your password.';

  @override
  String get backToHomeLabel => 'HOME';

  @override
  String get backToHomeTooltip => 'Return to home';

  @override
  String get profileBackHome => 'Back to home';

  @override
  String get profileNavOverview => 'Overview';

  @override
  String get profileNavMyRoll => 'My works';

  @override
  String get profileNavSettings => 'Settings';

  @override
  String get profileNavBilling => 'Plans & Billing';

  @override
  String get profileLogout => 'Log out';

  @override
  String profileWelcomeBack(String name) {
    return 'Welcome back, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'You\'ve been with REEL for $days days.';
  }

  @override
  String get profileStatTotalTakes => 'Total works';

  @override
  String get profileStatFavoriteStock => 'Top tool';

  @override
  String get profileStatDaysLabel => 'Days with REEL';

  @override
  String profileStatDaysValue(int n) {
    return '$n days';
  }

  @override
  String get profileUpgradePro => 'Upgrade to Pro';

  @override
  String get profileRecentActivity => 'Recent generations';

  @override
  String get profileViewAll => 'View all →';

  @override
  String get profileMyRollSub => 'Everything you\'ve created on REEL.';

  @override
  String get profileFilterAll => 'All';

  @override
  String get profileFilterVideo => 'Video';

  @override
  String get profileFilterPhoto => 'Images';

  @override
  String get profilePhotoTag => 'Photo';

  @override
  String get profileMyRollEmpty =>
      'No works yet — create your first one in the Studio.';

  @override
  String get profileTimeJustNow => 'Just now';

  @override
  String profileTimeMinutesAgo(int n) {
    return '$n min ago';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return '$n h ago';
  }

  @override
  String get profileTimeYesterday => 'Yesterday';

  @override
  String profileTimeDaysAgo(int n) {
    return '$n days ago';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return '$n weeks ago';
  }

  @override
  String get profileSettingsSub =>
      'Update your profile information and default preferences.';

  @override
  String get profileSectionProfileInfo => 'Profile information';

  @override
  String get profileFieldDisplayName => 'Display name';

  @override
  String get profileFieldEmail => 'Email';

  @override
  String get profileSaveChanges => 'Save changes';

  @override
  String get profileSectionPassword => 'Change password';

  @override
  String get profileFieldCurrentPassword => 'Current password';

  @override
  String get profileFieldNewPassword => 'New password';

  @override
  String get profileFieldConfirmPassword => 'Confirm new password';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'At least 8 characters';

  @override
  String get profilePwConfirmPlaceholder => 'Type it again';

  @override
  String get profileUpdatePassword => 'Update password';

  @override
  String get profilePwShow => 'Show';

  @override
  String get profilePwHide => 'Hide';

  @override
  String get profileSectionPrefs => 'Default preferences';

  @override
  String get profilePrefRatio => 'Default aspect ratio';

  @override
  String get profilePrefRatioDesc =>
      'Applied every time you open the generator';

  @override
  String get profilePrefStock => 'Default style';

  @override
  String get profilePrefStockDesc => 'Starting style for your generations';

  @override
  String get profileDangerTitle => 'Danger zone';

  @override
  String get profileDangerDesc =>
      'Deleting your account removes all of your works. It cannot be undone.';

  @override
  String get profileDeleteAccount => 'Delete account';

  @override
  String get profileDeleteNotice =>
      'Account deletion is handled by the REEL team — contact support to request it.';

  @override
  String get profileBillingSub => 'Manage your plan and payment methods.';

  @override
  String get profileCurrentPlan => 'Current plan';

  @override
  String get profilePlanPerMonth => '/ month';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '199.000đ';

  @override
  String get profilePlanFreeF1 => '50 credits / month';

  @override
  String get profilePlanFreeF2 => 'Includes REEL watermark';

  @override
  String get profilePlanProF1 => '2,000 credits / month';

  @override
  String get profilePlanProF2 => '4K, no watermark';

  @override
  String get profileCurrentTag => 'In use';

  @override
  String get profileUpgradeShort => 'Upgrade';

  @override
  String get profilePaymentHistory => 'Payment history';

  @override
  String get profileEmptyPayments =>
      'No transactions yet — upgrade to Pro to get started.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'Profile information updated!';

  @override
  String get profilePasswordUpdated => 'Password updated!';

  @override
  String get profileProChip => 'PRO PLAN';

  @override
  String get profileFreeChip => 'FREE PLAN';

  @override
  String get adminSidebarModeration => 'Moderation';

  @override
  String get adminSidebarRevenue => 'Revenue';

  @override
  String get adminSidebarSystem => 'System';

  @override
  String get adminRoleChip => 'Administrator';

  @override
  String usageCreditsLabel(int balance) {
    return '$balance credits available';
  }

  @override
  String get homeStatCreditsLeft => 'CREDITS LEFT';

  @override
  String get profileStatCredits => 'Credits';

  @override
  String profileCreditsAvailable(int balance) {
    return '$balance credits available';
  }

  @override
  String get profileTopUp => 'Top up';

  @override
  String get profilePlanPayAsYouGo => '/ month';

  @override
  String profileUsageSpentToday(int spent) {
    return '$spent credits used today';
  }

  @override
  String get profileTopUpHint => 'Top up your balance to keep generating.';

  @override
  String get avatarUpdated => 'Avatar updated';

  @override
  String get avatarUpdateFailed => 'Could not upload avatar. Please try again.';

  @override
  String get avatarChangeHint => 'Change profile picture';

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

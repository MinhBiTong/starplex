// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'REEL — AI 영í™”·사진 스튜디오';

  @override
  String get languageLabel => '언어';

  @override
  String get languagePickerTooltip => '인터페이스 언어 선택';

  @override
  String get signIn => '로그인';

  @override
  String get signUp => '회원가입';

  @override
  String get getStarted => '시작하기';

  @override
  String get forgot => '비밀번호 찾기';

  @override
  String get resetPassword => '비밀번호 재설정';

  @override
  String get newPassword => '새 비밀번호';

  @override
  String get credentialsBadge => '인증 정보';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · 접근 $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => '로그인';

  @override
  String get productionAccessRollSignUp => '회원가입';

  @override
  String get productionAccessRollReset => '비밀번호 재설정';

  @override
  String get productionAccessRollNewPassword => '새 비밀번호';

  @override
  String get authHeadlineSignIn => '모든 장면에는';

  @override
  String get authHeadlineSignInItalic => '캐스팅이 필요합니다.';

  @override
  String get authSubheadSignIn => '로그인하고 계속 작업하고, 작품을 저장하고, 롤을 관리하세요.';

  @override
  String get authHeadlineSignUp => '프로덕션에';

  @override
  String get authHeadlineSignUpItalic => '참여하세요.';

  @override
  String get authSubheadSignUp =>
      '계정을 만들어 롤을 저장하고, 매일의 테이크를 추적하고, 영감이 떠오를 때 다시 돌아오세요.';

  @override
  String get authHeadlineForgot => '네거를';

  @override
  String get authHeadlineForgotItalic => '잃어버렸나요?';

  @override
  String get authSubheadForgot => '이메일을 입력하시면 비밀번호 재설정 링크를 보내드립니다.';

  @override
  String get authHeadlineReset => '새로운';

  @override
  String get authHeadlineResetItalic => '컷을 만드세요.';

  @override
  String get authSubheadReset => '새 비밀번호로 창작 공간으로 돌아가세요.';

  @override
  String get inputEmail => '이메일';

  @override
  String get inputEmailHint => 'you@example.com';

  @override
  String get inputPassword => '비밀번호';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => '최소 8자';

  @override
  String get inputFullName => '표시 이름';

  @override
  String get inputFullNameHint => '이 롤의 감독';

  @override
  String get inputConfirmPassword => '비밀번호 확인';

  @override
  String get inputConfirmPasswordHint => '비밀번호 다시 입력';

  @override
  String get inputResetCode => '재설정 코드';

  @override
  String get inputResetCodeHint => '이메일의 코드를 붙여넣기';

  @override
  String get inputNewPassword => '새 비밀번호';

  @override
  String get inputNewPasswordHint => '최소 8자';

  @override
  String get inputNewPasswordConfirmHint => '새 비밀번호 다시 입력';

  @override
  String get inputAvatarUrl => '아바타 URL (선택)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => '이름';

  @override
  String get inputFullNameEditHint => '이름을 입력하세요';

  @override
  String get toggleShowPassword => '비밀번호 표시';

  @override
  String get toggleHidePassword => '비밀번호 숨김';

  @override
  String get rememberMe => '로그인 상태 유지';

  @override
  String get forgotPasswordLink => '비밀번호를 잊으셨나요?';

  @override
  String get signInButton => '롤 시작 ►';

  @override
  String get signUpButton => '롤 만들기 ►';

  @override
  String get forgotButton => '링크 보내기 ►';

  @override
  String get resetPasswordButton => '비밀번호 변경 ►';

  @override
  String get orDivider => '또는';

  @override
  String get noAccountPrompt => '계정이 없으신가요? ';

  @override
  String get noAccountLink => '지금 가입';

  @override
  String get hasAccountPrompt => '이미 계정이 있나요? ';

  @override
  String get hasAccountLink => '로그인';

  @override
  String get forgotRememberedPrompt => '비밀번호를 기억하셨나요? ';

  @override
  String get forgotRememberedLink => '로그인으로 돌아가기';

  @override
  String get resetRememberedPrompt => '비밀번호를 기억하셨나요? ';

  @override
  String get resetRememberedLink => '로그인으로 돌아가기';

  @override
  String get agreeTermsPrefix => '저는 ';

  @override
  String get agreeTermsLink => '제작 약관';

  @override
  String get agreeTermsSemantic => '제작 약관에 동의합니다';

  @override
  String get forgotDescription => '가입할 때 사용한 이메일을 입력하세요. 코드는 30분 동안 유효합니다.';

  @override
  String get statsFooter => '다음 장면은 여기서 시작됩니다';

  @override
  String get errorEmailPasswordRequired => '이메일과 비밀번호를 입력하세요.';

  @override
  String get errorAllFieldsRequired => '모든 항목을 입력하세요.';

  @override
  String get errorPasswordTooShort => '비밀번호는 최소 8자여야 합니다.';

  @override
  String get errorPasswordMismatch => '비밀번호가 일치하지 않습니다.';

  @override
  String get errorAcceptTerms => '제작 약관에 동의하세요.';

  @override
  String get errorEmailRequired => '이메일을 입력하세요.';

  @override
  String get errorResetCodeRequired => '코드를 입력하고 비밀번호는 8자 이상이어야 합니다.';

  @override
  String get errorGeneric => '서버에 연결할 수 없습니다.';

  @override
  String get errorInvalidEmail => '유효한 이메일 주소를 입력해 주세요.';

  @override
  String get errorInvalidAvatarUrl => '아바타 URL은 http:// 또는 https://로 시작해야 합니다.';

  @override
  String get errorSignInFailed => '이메일 또는 비밀번호가 올바르지 않습니다.';

  @override
  String get errorSignUpFailed => '가입 실패.';

  @override
  String get errorForgotFailed => '재설정 링크를 만들 수 없습니다.';

  @override
  String get errorResetFailed => '비밀번호를 재설정할 수 없습니다.';

  @override
  String get errorFullNameRequired => '이름을 입력하세요.';

  @override
  String get successSignUp => '가입 완료! 로그인하세요.';

  @override
  String get successResetPassword => '비밀번호가 변경되었습니다.';

  @override
  String get successForgotEmail => '이메일이 존재하면 링크를 보냈습니다.';

  @override
  String get successProfileSaved => '프로필이 업데이트되었습니다!';

  @override
  String get successPasswordChanged => '비밀번호가 변경되었습니다! 다시 로그인하세요.';

  @override
  String successProfileLoadFailed(Object message) {
    return '프로필을 불러올 수 없습니다: $message';
  }

  @override
  String get explore => '둘러보기';

  @override
  String get gallery => '갤러리';

  @override
  String get faq => 'FAQ';

  @override
  String get pricing => '요금제';

  @override
  String get loginPrompt => '이미지를 생성하기 전에 로그인하세요.';

  @override
  String get emptyPrompt => 'Action을 누르기 전에 프롬프트를 입력하세요.';

  @override
  String get imageOnlySupported =>
      'REEL은 현재 text-to-image만 지원합니다. Photo를 선택하세요.';

  @override
  String get imageGenerationFailed => '이미지를 생성할 수 없습니다. 백엔드와 모델을 확인하세요.';

  @override
  String get noImageReturned => '모델이 이미지를 반환하지 않았습니다.';

  @override
  String get videoDurationLabel => '길이';

  @override
  String get videoQualityLabel => '화질';

  @override
  String get videoQueuedMessage =>
      '영상을 렌더링하는 중입니다. 몇 분 정도 걸립니다. 결과가 여기에 표시됩니다.';

  @override
  String get videoGenerationFailed => '영상 생성에 실패했습니다. 크레딧은 환불되었습니다.';

  @override
  String get videoTimeoutMessage =>
      '영상 생성이 예상보다 오래 걸리고 있습니다. 잠시 후 프로필의 내 롤을 확인해 주세요.';

  @override
  String get videoReadyLabel => '영상이 준비되었습니다';

  @override
  String get usageLabelSignedOut => '로그인하여 시작';

  @override
  String get rtlToggleTooltip => 'LTR / RTL 레이아웃 전환';

  @override
  String get footerTagline => 'REEL — 어둠 속에서 개발, 한 프레임씩. 한 줄의 텍스트를 한 장면으로.';

  @override
  String get productColumn => '제품';

  @override
  String get supportColumn => '지원';

  @override
  String get signInLink => '로그인';

  @override
  String get signUpLink => '가입';

  @override
  String get footerCaption1 => 'REEL — 어둠 속에서 개발. 한 프레임씩.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => '장면을 입력하세요.';

  @override
  String get getTheTake => '테이크를 받으세요.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      '한 줄의 텍스트를 수 초 안에 구ë„·조ëª…·움직임이 있는 샷으로. 영상이든 사진이든, 한 롤로.';

  @override
  String get homeStatLastTake => '마지막 테이크';

  @override
  String get homeStatAspectRatios => '화면 비율';

  @override
  String get homeStatFilmStocks => '필름';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => '장면을 묘사하세ìš”…';

  @override
  String get homeQuickChips => '샹들리에 아래 가면무도회 | 모래 폭풍 속의 기사 | 마리오네트 공방';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => '테이크 생성 ì¤‘…';

  @override
  String get homeGenerate => '생성';

  @override
  String homeGenerationSuccess(Object ratio) {
    return '테이크 완료 · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => '결과 이미지를 불러올 수 없습니다.';

  @override
  String get homeGenerationOpenOriginal => '원본 열기';

  @override
  String get homeGenerationRegenerate => '재생성';

  @override
  String get homeGenerationOpenFailed => '원본을 열 수 없습니다.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => '한 줄의 텍스트. 하나의 완성된 장면.';

  @override
  String get showcaseSubtitle => 'REEL이 설명을 실제 프레임으로 바꾸는 과정을 단계별로 확인하세요.';

  @override
  String get showcasePrompt1 => '\"화성의 붉은 사구에서 서핑하는 우주비행사, 골든아워, 와이드 샷\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 => '\"샹들리에 아래 가면무도회, 느린 카메라 무브\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 => '\"황혼의 모래 폭풍을 가로지르는 기수, 트래킹 샷\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => '네 가지 도구, 하나의 샷';

  @override
  String get featuresSubtitle => '한 줄의 텍스트에서 완성된 프레임까지 필요한 모든 것.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body => '수백만 실제 프레임에서 학습한 조명, 카메라 무브, 영화 문법.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body => '16:9 와이드, 1:1 피드, 9:16 스토리 — 처음부터 다시 만들 필요 없음.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — Generate 전에 텍스처를 선택하세요.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body => '같은 프롬프트, 같은 스튜디오. 지금은 이미지, 준비되면 영상.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => '자주 묻는 질문';

  @override
  String get faqSubtitle => '더 궁금한 점이 있으시면 REEL 팀에 메시지를 남기세요.';

  @override
  String get faqQ1 => 'REEL은 어떻게 작동하나요?';

  @override
  String get faqA1 =>
      '설명을 입력하고 화면 비율과 필름을 선택하세요. REEL이 이미지를 생성합니다. 영상 기능은 개발 중입니다.';

  @override
  String get faqQ2 => 'REEL은 다른 AI 영상 도구와 어떻게 다른가요?';

  @override
  String get faqA2 => 'REEL은 조명, 구도, 필름감이라는 영화 언어에 집중하는 단일 스튜디오입니다.';

  @override
  String get faqQ3 => '무료 테이크는 몇 개인가요?';

  @override
  String get faqA3 => '로그인 후 스튜디오에서 현재 한도와 크레딧을 확인할 수 있습니다.';

  @override
  String get faqQ4 => '지원되는 포맷과 해상도는?';

  @override
  String get faqA4 => '이미지는 16:9, 1:1, 9:16을 지원합니다. 출력 크기는 설정에 따라 다릅니다.';

  @override
  String get faqQ5 => '상업적으로 사용할 수 있나요?';

  @override
  String get faqA5 => '상업적 사용 전에 제작 약관과 플랜 혜택을 확인하세요.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => '촬영 속도를 선택하세요';

  @override
  String get plansSubtitle => '무료로 시작하고 롤이 길어질 때 업그레이드하세요.';

  @override
  String get ctaReady => '당신의';

  @override
  String get ctaReadyItalic => '첫 테이크를 시작하세요.';

  @override
  String get ctaBody => '무료, 신용카드 불필요 — 1분 이내 첫 프레임.';

  @override
  String get ctaFreeButton => '무료 계정 만들기';

  @override
  String get ctaGalleryButton => '갤러리 보기';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => '최신 프레임';

  @override
  String get contactSheetSubtitle => 'REEL 커뮤니티가 방금 편집한 몇 가지 장면.';

  @override
  String get contactSheetDialogTitle => '비주얼 스타일 미리보기.';

  @override
  String get contactSheetDialogBody => '스튜디오에서 나만의 테이크를 생성하세요.';

  @override
  String get contactSheetClose => '닫기';

  @override
  String get pricingTitle => '요금제';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => '촬영 속도를 선택하세요';

  @override
  String get pricingSubheading => '무료로 시작하고, 롤을 더 오래 굴리고 싶을 때 업그레이드하세요.';

  @override
  String get pricingEmpty => '현재 활성 패키지가 없습니다.';

  @override
  String get pricingBuyButton => '패키지 구매';

  @override
  String get pricingFreeCta => '무료로 사용';

  @override
  String get pricingSignInFirst => '구매 전 로그인하세요.';

  @override
  String get pricingLoadFailed => '패키지를 불러올 수 없습니다.';

  @override
  String get pricingStripeOpenFailed => 'Stripe 페이지를 열 수 없습니다.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout이 열렸습니다. 결제 완료 후 크레딧이 자동 적립됩니다.';

  @override
  String get pricingCreditsSuffix => ' 크레딧';

  @override
  String get pricingCreditsPerMonth => '매월 크레딧';

  @override
  String get pricingPeriodMonthly => '/월';

  @override
  String get pricingPeriodYearly => '/년';

  @override
  String get pricingFreePerk => '가입 시 크레딧 25개를 무료로 드립니다. 부담 없이 스튜디오를 사용해 보세요.';

  @override
  String get profileTitle => '내 프로필';

  @override
  String profileLoadFailed(Object message) {
    return '프로필을 불러올 수 없습니다: $message';
  }

  @override
  String get profileNotLoaded => '프로필 정보를 불러올 수 없습니다';

  @override
  String get profileEditButton => '프로필 편집';

  @override
  String get profileChangePasswordButton => '비밀번호 변경';

  @override
  String get profileUsageSection => '사용량 & 크레딧';

  @override
  String get profileCreditBalance => '크레딧 잔액';

  @override
  String get profileDailyUsage => '오늘 사용량';

  @override
  String get profileAccountSection => '계정 정보';

  @override
  String get profileUserId => '사용자 ID';

  @override
  String get profileStatus => '상태';

  @override
  String get profileStatusActive => '활성';

  @override
  String get profileStatusInactive => '비활성';

  @override
  String get profileMemberSince => '가입일';

  @override
  String get profileUnknownName => '알 수 없음';

  @override
  String get profileUnknownEmail => '이메일 없음';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => '프로필 편집';

  @override
  String get editProfileSubhead => '프로필 정보를 업데이트하세요';

  @override
  String get editProfileSave => '변경 저장';

  @override
  String editProfileLoadFailed(Object message) {
    return '프로필을 불러올 수 없습니다: $message';
  }

  @override
  String get editProfileSaveFailed => '프로필을 업데이트할 수 없습니다';

  @override
  String get changePasswordTitle => '비밀번호 변경';

  @override
  String get changePasswordSubhead => '현재 비밀번호를 입력하고 새 비밀번호를 설정하세요';

  @override
  String get changePasswordCurrent => '현재 비밀번호';

  @override
  String get changePasswordNew => '새 비밀번호';

  @override
  String get changePasswordConfirm => '새 비밀번호 확인';

  @override
  String get changePasswordCurrentRequired => '현재 비밀번호를 입력하세요';

  @override
  String get changePasswordNewRequired => '새 비밀번호를 입력하세요';

  @override
  String get changePasswordTooShort => '비밀번호는 최소 8자';

  @override
  String get changePasswordConfirmRequired => '새 비밀번호를 확인하세요';

  @override
  String get changePasswordMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String get changePasswordSubmit => '비밀번호 변경';

  @override
  String get changePasswordFailed => '비밀번호를 변경할 수 없습니다';

  @override
  String get libraryTitle => '라이브러리';

  @override
  String get libraryTabGenerations => '생성';

  @override
  String get libraryTabCredits => '크레딧';

  @override
  String get libraryTabPayments => '결제';

  @override
  String get libraryReload => '새로고침';

  @override
  String get librarySignInPrompt => '로그인하여 라이브러리 보기';

  @override
  String get libraryRetry => '재시도';

  @override
  String get libraryLoadFailed => '라이브러리를 불러올 수 없습니다.';

  @override
  String get libraryEmptyGenerations => '아직 생성한 이미지가 없습니다.';

  @override
  String get libraryEmptyCredits => '크레딧 내역이 없습니다.';

  @override
  String get libraryEmptyPayments => '결제 내역이 없습니다.';

  @override
  String get libraryDeleteDialogTitle => '생성 삭제?';

  @override
  String get libraryDeleteDialogBody => '이 생성을 삭제할까요? 되돌릴 수 없습니다.';

  @override
  String get libraryDeleteCancel => '취소';

  @override
  String get libraryDeleteConfirm => '삭제';

  @override
  String get libraryDeleteSuccess => '생성 삭제 완료';

  @override
  String get libraryDeleteFailed => '삭제 실패';

  @override
  String get libraryStatusCompleted => '완료';

  @override
  String get libraryStatusFailed => '실패';

  @override
  String get libraryStatusProcessing => '처리 중';

  @override
  String get libraryStatusPending => '대기 중';

  @override
  String get paymentResultSuccess => '결제 성공';

  @override
  String get paymentResultCancel => '결제 취소';

  @override
  String get paymentResultError => '결제 실패';

  @override
  String get paymentResultSuccessMsg => '결제가 처리되었고 크레딧이 계정에 추가되었습니다.';

  @override
  String get paymentResultCancelMsg => '결제를 취소하셨습니다. 청구되지 않았습니다.';

  @override
  String get paymentResultErrorMsg =>
      '결제 처리 중 오류가 발생했습니다. 다시 시도하거나 지원팀에 문의하세요.';

  @override
  String get paymentResultLoadFailed => '결제 정보를 불러올 수 없습니다';

  @override
  String get paymentDetailPackage => '패키지';

  @override
  String get paymentDetailCredits => '크레딧';

  @override
  String get paymentDetailAmount => '금액';

  @override
  String get paymentDetailTransaction => '거래';

  @override
  String get paymentBackHome => '홈으로';

  @override
  String get paymentTryAgain => '재시도';

  @override
  String get termsEyebrow => '법적 고지';

  @override
  String get termsHeadline => '이용약관';

  @override
  String get termsSubhead => '최종 업데이트: 2026/09/10 · REEL 서비스 전체에 적용됩니다';

  @override
  String get termsBackShort => '뒤로';

  @override
  String get termsBackLong => '홈으로';

  @override
  String get termsFooterText => 'REEL — 어둠 속에서 만들어졌습니다. 한 프레임씩.';

  @override
  String get termsAccept => '동의합니다';

  @override
  String get termsDecline => '뒤로';

  @override
  String get adminDashboardTitle => '관리자 대시보드';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => '개요';

  @override
  String get adminSidebarGenerations => '생성';

  @override
  String get adminSidebarUsers => '사용자';

  @override
  String get adminSidebarPayments => '결제';

  @override
  String get adminSidebarSettings => '설정';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => '관리자';

  @override
  String get adminMenuTooltip => '메뉴 열기';

  @override
  String get adminRtlTooltip => 'LTR / RTL 전환';

  @override
  String get adminRefreshTooltip => '새로고침';

  @override
  String get adminSearchUsersHint => '사용자 검색…';

  @override
  String get adminExportTooltip => '리포트 내보내기';

  @override
  String get adminExportLabel => '내보내기';

  @override
  String get adminExportComingSoon => '리포트 내보내기 기능이 곧 제공될 예정입니다.';

  @override
  String get adminNotificationsTooltip => '알림';

  @override
  String get adminRangeLabel => '범위';

  @override
  String get adminRangeToday => '오늘';

  @override
  String get adminRange7Days => '7일';

  @override
  String get adminRange30Days => '30일';

  @override
  String get adminRangeTodayLong => '오늘';

  @override
  String get adminRange7DaysLong => '최근 7일';

  @override
  String get adminRange30DaysLong => '최근 30일';

  @override
  String get adminAutoUpdateNote => '매일 00:00 자동 업데이트';

  @override
  String adminKpiTakes(Object range) {
    return '테이크 $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return '활성 사용자 — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return '수익 — $range';
  }

  @override
  String get adminKpiQueue => '렌더 큐';

  @override
  String get adminDailyOutputTitle => '7일 생산량';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return '이번 주는 $ratio16x9가 58%, 1:1 (24%), 9:16 (18%) 순입니다.';
  }

  @override
  String get adminStockMixTitle => '스타일 비율';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => '최근 렌더';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => '사용자';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => '목록 열기';

  @override
  String get adminFleetTitle => '큐 & GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter => '3/5 작동 중 · 1 점검 · 1 대기';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return '처리 중 — $prompt';
  }

  @override
  String get adminFleetJobIdle => '대기 — 다음 작업 대기';

  @override
  String get adminFleetJobMaintenance => '정기 점검';

  @override
  String get adminGenerationCompleted => '완료';

  @override
  String get adminGenerationProcessing => '렌더링 중';

  @override
  String get adminGenerationFailed => '실패';

  @override
  String get adminUserStatusActive => '활성';

  @override
  String get adminUserStatusInactive => '비활성';

  @override
  String get adminUserStatusBanned => '차단됨';

  @override
  String get adminUserRoleAdmin => '관리자';

  @override
  String get adminUserRoleUser => '사용자';

  @override
  String get adminSettingsTitle => '설정';

  @override
  String get adminSettingsStudioName => '스튜디오 표시 이름';

  @override
  String get adminSettingsSupportEmail => '지원 이메일';

  @override
  String get adminSettingsImageCost => '이미지당 크레딧';

  @override
  String get adminSettingsVideoCost => '비디오당 크레딧';

  @override
  String get adminSettingsAlerts => '알림';

  @override
  String get adminSettingsAlertPayment => '결제 실패 시 알림';

  @override
  String get adminSettingsAlertGeneration => '생성 실패 시 알림';

  @override
  String get adminSettingsNewsletter => '뉴스레터 발송';

  @override
  String get adminSettingsMaintenance => '점검 모드';

  @override
  String get adminSettingsRegistration => '신규 가입 허용';

  @override
  String get adminSettingsSave => '변경 저장';

  @override
  String get adminSettingsLoadFailed => '설정을 불러올 수 없습니다.';

  @override
  String get adminSettingsSaved => '설정이 저장되었습니다.';

  @override
  String get adminSettingsSaveFailed => '설정을 저장할 수 없습니다.';

  @override
  String get adminPackagesTitle => '결제 패키지';

  @override
  String get adminPackagesEmpty => '패키지가 없습니다.';

  @override
  String get adminPackagesLoadFailed => '패키지를 불러올 수 없습니다.';

  @override
  String get adminPackagesNew => '새 패키지';

  @override
  String get adminPackagesFeatured => '추천';

  @override
  String get adminPackagesInactive => '비활성';

  @override
  String get adminPackagesActive => '활성';

  @override
  String get adminPaymentsTitle => '결제';

  @override
  String get adminPaymentsEmpty => '결제 내역이 없습니다.';

  @override
  String get adminPaymentsLoadFailed => '결제를 불러올 수 없습니다.';

  @override
  String get adminPaymentsFilterAll => '전체';

  @override
  String get adminCreditsTitle => '크레딧 내역';

  @override
  String get adminCreditsEmpty => '내역이 없습니다.';

  @override
  String get adminCreditsLoadFailed => '크레딧 내역을 불러올 수 없습니다.';

  @override
  String get adminUsersTitle => '사용자';

  @override
  String get adminUsersEmpty => '사용자가 없습니다.';

  @override
  String get adminUsersLoadFailed => '사용자를 불러올 수 없습니다.';

  @override
  String get adminUsersSearch => '이메일 또는 이름으로 검색';

  @override
  String get adminUsersRefresh => '새로고침';

  @override
  String get adminUsersReset => '초기화';

  @override
  String get commonRetry => '재시도';

  @override
  String get commonCancel => '취소';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonSave => '저장';

  @override
  String get commonClose => '닫기';

  @override
  String get termsTocLabel => '목차';

  @override
  String get termsNoteBox =>
      '이는 예시 약관 콘텐츠의 UI/UX 목업입니다. 공식 게시 전에 REEL은 법무 검토를 받아야 합니다.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => '지원 이메일';

  @override
  String get termsContactButton => '지원팀에 문의';

  @override
  String get termsS01Title => '약관 동의';

  @override
  String get termsS01P1 =>
      '계정을 만들거나 REEL의 모든 기능(이미지 생성, 동영상 생성, 크레딧 충전, 플랜 업그레이드)을 사용하는 경우 아래 약관에 동의하는 것으로 간주됩니다. 동의하지 않으시면 서비스 이용을 중단해 주세요.';

  @override
  String get termsS01P2 =>
      'REEL은 만 13세 이상 사용자를 대상으로 합니다. 18세 미만 사용자는 부모 또는 법정대리인의 동의가 필요합니다.';

  @override
  String get termsS02Title => '계정';

  @override
  String get termsS02P1 =>
      '각 계정은 하나의 고유한 이메일 주소에 연결됩니다. 비밀번호 기밀 유지와 계정에서 발생하는 모든 활동에 대한 책임은 사용자에게 있습니다.';

  @override
  String get termsS02B1 => '등록 정보(이름, 이메일)는 정확하고 최신 상태여야 합니다.';

  @override
  String get termsS02B2 => 'REEL은 특정 기능을 활성화하기 전에 이메일 인증을 요구할 수 있습니다.';

  @override
  String get termsS02B3 =>
      '계정은 사용 기록과 위반 여부에 따라 active, inactive 또는 banned 상태가 될 수 있습니다.';

  @override
  String get termsS03Title => '크레딧 및 AI 생성';

  @override
  String get termsS03P1 =>
      'REEL은 크레딧 시스템으로 운영됩니다. 매번 이미지 또는 동영상 생성(\"take\") 시 유형, 해상도, 길이에 따라 해당 크레딧이 지갑에서 차감됩니다.';

  @override
  String get termsS03B1 => '크레딧은 생성 요청이 처리를 시작할 때 차감됩니다.';

  @override
  String get termsS03B2 => '시스템 오류로 생성이 실패하면 크레딧이 자동으로 환불됩니다.';

  @override
  String get termsS03B3 => '약관 위반으로 요청이 실패하면(섹션 6 참조) REEL은 크레딧을 환불하지 않습니다.';

  @override
  String get termsS03B4 => '월간/연간 플랜의 미사용 크레딧은 별도 안내가 없는 한 다음 주기로 이월되지 않습니다.';

  @override
  String get termsS04Title => '결제 및 환불';

  @override
  String get termsS04P1 =>
      'REEL은 Momo, ZaloPay, VNPay, 은행 이체 및 Stripe(국제 플랜용)를 통한 결제를 받습니다. 모든 거래에는 추적을 위한 고유 ID가 부여됩니다.';

  @override
  String get termsS04B1 => '월간/연간 플랜은 다음 주기 전에 취소하지 않는 한 자동 갱신됩니다.';

  @override
  String get termsS04B2 => '환불 요청은 플랜 크레딧이 사용되지 않았다는 조건으로 결제일로부터 7일 이내에 검토됩니다.';

  @override
  String get termsS04B3 => '일회성 크레딧 충전은 지갑에 반영된 후 환불되지 않습니다.';

  @override
  String get termsS05Title => '콘텐츠 소유권';

  @override
  String get termsS05P1 => 'REEL에서 만든 콘텐츠의 사용 권한은 현재 플랜 범위 내에서 사용자에게 있습니다.';

  @override
  String get termsS05B1 =>
      'Free 플랜: 출력물에 REEL 워터마크가 포함되며 개인 비상업적 용도로만 사용 가능합니다.';

  @override
  String get termsS05B2 => 'Pro 플랜: 워터마크 없이 상업적 사용이 가능합니다.';

  @override
  String get termsS05B3 =>
      'REEL은 AI 출력의 독창성을 보장하지 않으며 상업적 사용 전 확인은 사용자의 책임입니다.';

  @override
  String get termsS06Title => '금지 행위';

  @override
  String get termsS06P1 => '다음과 같은 콘텐츠를 만들거나 유포하기 위해 REEL을 사용할 수 없습니다:';

  @override
  String get termsS06B1 => '현행법을 위반하거나 폭력, 차별, 증오를 선동하는 콘텐츠.';

  @override
  String get termsS06B2 => '음란물이거나 미성년자를 어떤 형태로든 관련짓는 콘텐츠.';

  @override
  String get termsS06B3 => '타인을 사칭하거나 사생활을 침해하거나 허가 없이 타인의肖像을 사용하는 행위.';

  @override
  String get termsS06B4 => '제3자의 저작권, 상표권 또는 기타 지적재산권을 침해하는 행위.';

  @override
  String get termsS06P2 =>
      '위반 시 사전 통보 없이 계정이 차단(banned)될 수 있으며 크레딧이나 결제 금액은 환불되지 않습니다.';

  @override
  String get termsS07Title => '책임의 제한';

  @override
  String get termsS07P1 =>
      '본 서비스는 \"있는 그대로\" 제공됩니다. REEL은 중단이나 오류가 없는 서비스를 보장하지 않으며 모든 결과가 사용자의 기대에 부합한다고 보장하지 않습니다.';

  @override
  String get termsS07P2 =>
      '법률이 허용하는 최대 범위 내에서 REEL은 본 서비스의 사용 또는 사용 불가로 인한 간접적 손해에 대해 책임을 지지 않습니다.';

  @override
  String get termsS08Title => '계정 해지';

  @override
  String get termsS08P1 =>
      '언제든지 서비스 이용을 중단하고 계정 삭제를 요청할 수 있습니다. REEL은 위반 정도를 고려하여 약관을 위반한 계정을 일시 중지(inactive)하거나 영구 차단(banned)할 수 있습니다.';

  @override
  String get termsS09Title => '약관 변경';

  @override
  String get termsS09P1 =>
      'REEL은 본 약관을 수시로 업데이트할 수 있습니다. 중요한 변경 사항은 발효 최소 7일 전에 이메일 또는 홈페이지 배너로 공지됩니다.';

  @override
  String get termsS10Title => '문의';

  @override
  String get termsS10P1 => '본 약관에 대한 문의는 REEL 팀에 연락해 주세요.';

  @override
  String get errorPasswordRequired => '비밀번호를 입력해 주세요.';

  @override
  String get errorConfirmPasswordRequired => '비밀번호를 확인해 주세요.';

  @override
  String get backToHomeLabel => '홈';

  @override
  String get backToHomeTooltip => '홈으로 돌아가기';

  @override
  String get profileBackHome => '홈으로 돌아가기';

  @override
  String get profileNavOverview => '개요';

  @override
  String get profileNavMyRoll => '내 롤';

  @override
  String get profileNavSettings => '설정';

  @override
  String get profileNavBilling => '플랜 및 결제';

  @override
  String get profileLogout => '로그아웃';

  @override
  String profileWelcomeBack(String name) {
    return '다시 오신 것을 환영합니다, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return '오늘의 롤입니다.';
  }

  @override
  String get profileStatTotalTakes => '총 테이크 수';

  @override
  String get profileStatFavoriteStock => '선호하는 필름';

  @override
  String get profileStatDaysLabel => 'REEL과 함께한 일수';

  @override
  String profileStatDaysValue(int n) {
    return '$n일';
  }

  @override
  String get profileUpgradePro => 'Pro로 업그레이드';

  @override
  String get profileRecentActivity => '최근 활동';

  @override
  String get profileViewAll => '전체 보기 →';

  @override
  String get profileMyRollSub => 'REEL에서 생성한 모든 작업물입니다.';

  @override
  String get profileFilterAll => '전체';

  @override
  String get profileFilterVideo => '영상';

  @override
  String get profileFilterPhoto => '사진';

  @override
  String get profilePhotoTag => '사진';

  @override
  String get profileMyRollEmpty => '아직 테이크가 없습니다. 스튜디오에서 첫 프레임을 생성해 보세요.';

  @override
  String get profileTimeJustNow => '방금 전';

  @override
  String profileTimeMinutesAgo(int n) {
    return '$n분 전';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return '$n시간 전';
  }

  @override
  String get profileTimeYesterday => '어제';

  @override
  String profileTimeDaysAgo(int n) {
    return '$n일 전';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return '$n주 전';
  }

  @override
  String get profileSettingsSub => '프로필 정보와 기본 환경설정을 업데이트하세요.';

  @override
  String get profileSectionProfileInfo => '프로필 정보';

  @override
  String get profileFieldDisplayName => '표시 이름';

  @override
  String get profileFieldEmail => '이메일';

  @override
  String get profileSaveChanges => '변경 사항 저장';

  @override
  String get profileSectionPassword => '비밀번호 변경';

  @override
  String get profileFieldCurrentPassword => '현재 비밀번호';

  @override
  String get profileFieldNewPassword => '새 비밀번호';

  @override
  String get profileFieldConfirmPassword => '새 비밀번호 확인';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => '8자 이상';

  @override
  String get profilePwConfirmPlaceholder => '다시 입력하세요';

  @override
  String get profileUpdatePassword => '비밀번호 업데이트';

  @override
  String get profilePwShow => '표시';

  @override
  String get profilePwHide => '숨기기';

  @override
  String get profileSectionPrefs => '기본 환경설정';

  @override
  String get profilePrefRatio => '기본 화면 비율';

  @override
  String get profilePrefRatioDesc => '제너레이터를 열 때마다 적용됩니다';

  @override
  String get profilePrefStock => '기본 필름';

  @override
  String get profilePrefStockDesc => '프레임의 기본 룩';

  @override
  String get profileDangerTitle => '위험 구역';

  @override
  String get profileDangerDesc => '계정을 삭제하면 롤 전체가 삭제됩니다. 되돌릴 수 없습니다.';

  @override
  String get profileDeleteAccount => '계정 삭제';

  @override
  String get profileDeleteNotice =>
      '계정 삭제는 REEL 팀이 처리합니다. 삭제를 원하시면 고객 지원에 문의하세요.';

  @override
  String get profileBillingSub => '플랜과 결제 수단을 관리하세요.';

  @override
  String get profileCurrentPlan => '현재 플랜';

  @override
  String get profilePlanPerMonth => '/ 월';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '가입 시 10 크레딧';

  @override
  String get profilePlanFreeF2 => 'REEL 워터마크';

  @override
  String get profilePlanProF1 => '크레딧 팩 충전';

  @override
  String get profilePlanProF2 => '4K, 워터마크 없음';

  @override
  String get profileCurrentTag => '사용 중';

  @override
  String get profileUpgradeShort => '업그레이드';

  @override
  String get profilePaymentHistory => '결제 내역';

  @override
  String get profileEmptyPayments => '아직 거래 내역이 없습니다. Pro로 업그레이드하여 시작하세요.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => '프로필 정보가 업데이트되었습니다!';

  @override
  String get profilePasswordUpdated => '비밀번호가 업데이트되었습니다!';

  @override
  String get profileProChip => 'PRO 플랜';

  @override
  String get profileFreeChip => '무료 플랜';

  @override
  String get adminSidebarModeration => '모더레이션';

  @override
  String get adminSidebarRevenue => '수익';

  @override
  String get adminSidebarSystem => '시스템';

  @override
  String get adminRoleChip => '관리자';

  @override
  String usageCreditsLabel(int balance) {
    return '사용 가능한 크레딧 $balance';
  }

  @override
  String get homeStatCreditsLeft => '남은 크레딧';

  @override
  String get profileStatCredits => '크레딧';

  @override
  String profileCreditsAvailable(int balance) {
    return '사용 가능한 크레딧 $balance';
  }

  @override
  String get profileTopUp => '충전';

  @override
  String get profilePlanPayAsYouGo => '/ 사용한 만큼 결제';

  @override
  String profileUsageSpentToday(int spent) {
    return '오늘 $spent 크레딧 사용';
  }

  @override
  String get profileTopUpHint => '크레딧을 충전해 계속 생성하세요.';

  @override
  String get avatarUpdated => '아바타가 업데이트되었습니다';

  @override
  String get avatarUpdateFailed => '아바타를 업로드하지 못했습니다. 다시 시도해 주세요.';

  @override
  String get avatarChangeHint => '프로필 사진 변경';

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

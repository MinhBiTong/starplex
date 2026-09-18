// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'REEL — AI Film & Photo Studio';

  @override
  String get languageLabel => 'Ngôn ngữ';

  @override
  String get languagePickerTooltip => 'Chọn ngôn ngữ giao diện';

  @override
  String get signIn => 'ĐĂNG NHẬP';

  @override
  String get signUp => 'ĐĂNG KÝ';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get forgot => 'QUÊN MẬT KHẨU';

  @override
  String get resetPassword => 'ĐẶT LẠI MẬT KHẨU';

  @override
  String get newPassword => 'MẬT KHẨU MỚI';

  @override
  String get credentialsBadge => 'THÔNG TIN ĐĂNG NHẬP';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · TRUY CẬP $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'ĐĂNG NHẬP';

  @override
  String get productionAccessRollSignUp => 'ĐĂNG KÝ';

  @override
  String get productionAccessRollReset => 'ĐẶT LẠI MẬT KHẨU';

  @override
  String get productionAccessRollNewPassword => 'MẬT KHẨU MỚI';

  @override
  String get authHeadlineSignIn => 'Mỗi cảnh quay';

  @override
  String get authHeadlineSignInItalic => 'đều cần dàn cast.';

  @override
  String get authSubheadSignIn =>
      'Đăng nhập để tiếp tục sáng tạo, lưu tác phẩm và quản lý thư viện của bạn.';

  @override
  String get authHeadlineSignUp => 'Tham gia';

  @override
  String get authHeadlineSignUpItalic => 'sản xuất.';

  @override
  String get authSubheadSignUp =>
      'Tạo tài khoản để lưu tác phẩm, theo dõi credits và quay lại bất cứ khi nào cảm hứng ghé qua.';

  @override
  String get authHeadlineForgot => 'Mất';

  @override
  String get authHeadlineForgotItalic => 'âm bản?';

  @override
  String get authSubheadForgot =>
      'Nhập email của bạn để nhận liên kết đặt lại mật khẩu.';

  @override
  String get authHeadlineReset => 'Dựng lại';

  @override
  String get authHeadlineResetItalic => 'một cut mới.';

  @override
  String get authSubheadReset =>
      'Tạo mật khẩu mới để quay lại không gian sáng tạo của bạn.';

  @override
  String get inputEmail => 'EMAIL';

  @override
  String get inputEmailHint => 'ban@example.com';

  @override
  String get inputPassword => 'MẬT KHẨU';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'Tối thiểu 8 ký tự';

  @override
  String get inputFullName => 'TÊN HIỂN THỊ';

  @override
  String get inputFullNameHint => 'Đạo diễn của tác phẩm này';

  @override
  String get inputConfirmPassword => 'XÁC NHẬN MẬT KHẨU';

  @override
  String get inputConfirmPasswordHint => 'Nhập lại mật khẩu';

  @override
  String get inputResetCode => 'M ĐẶT LẠI';

  @override
  String get inputResetCodeHint => 'Dán mã được gửi qua email';

  @override
  String get inputNewPassword => 'MẬT KHẨU MỚI';

  @override
  String get inputNewPasswordHint => 'Tối thiểu 8 ký tự';

  @override
  String get inputNewPasswordConfirmHint => 'Nhập lại mật khẩu mới';

  @override
  String get inputAvatarUrl => 'URL AVATAR (TÙY CHỌN)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Họ và tên';

  @override
  String get inputFullNameEditHint => 'Nhập họ và tên của bạn';

  @override
  String get toggleShowPassword => 'Hiện mật khẩu';

  @override
  String get toggleHidePassword => 'Ẩn mật khẩu';

  @override
  String get rememberMe => 'Ghi nhớ đăng nhập';

  @override
  String get forgotPasswordLink => 'Quên mật khẩu?';

  @override
  String get signInButton => 'ĐĂNG NHẬP ►';

  @override
  String get signUpButton => 'TẠO TÀI KHOẢN ►';

  @override
  String get forgotButton => 'GỬI LIÊN KẾT ►';

  @override
  String get resetPasswordButton => 'ĐỔI MẬT KHẨU ►';

  @override
  String get orDivider => 'HOẶC';

  @override
  String get noAccountPrompt => 'Chưa có tài khoản? ';

  @override
  String get noAccountLink => 'Đăng ký ngay';

  @override
  String get hasAccountPrompt => 'Đã có tài khoản? ';

  @override
  String get hasAccountLink => 'Đăng nhập';

  @override
  String get forgotRememberedPrompt => 'Nhớ ra mật khẩu rồi? ';

  @override
  String get forgotRememberedLink => 'Quay lại đăng nhập';

  @override
  String get resetRememberedPrompt => 'Đã nhớ mật khẩu? ';

  @override
  String get resetRememberedLink => 'Quay lại đăng nhập';

  @override
  String get agreeTermsPrefix => 'Tôi đồng ý với ';

  @override
  String get agreeTermsLink => 'Điều khoản sản xuất';

  @override
  String get agreeTermsSemantic => 'Tôi đồng ý với Điều khoản sản xuất';

  @override
  String get forgotDescription =>
      'Nhập email bạn dùng để đăng ký. Mã đặt lại có hiệu lực trong 30 phút.';

  @override
  String get statsFooter => 'CẢNH TIẾP THEO CỦA BẠN BẮT ĐẦU TẠI ĐÂY';

  @override
  String get errorEmailPasswordRequired => 'Vui lòng nhập email và mật khẩu.';

  @override
  String get errorAllFieldsRequired => 'Vui lòng nhập đầy đủ thông tin.';

  @override
  String get errorPasswordTooShort => 'Mật khẩu phải có ít nhất 8 ký tự.';

  @override
  String get errorPasswordMismatch => 'Mật khẩu xác nhận không trùng khớp.';

  @override
  String get errorAcceptTerms => 'Vui lòng đồng ý với điều khoản sản xuất.';

  @override
  String get errorEmailRequired => 'Vui lòng nhập email.';

  @override
  String get errorResetCodeRequired =>
      'Mã đặt lại là bắt buộc và mật khẩu phải có ít nhất 8 ký tự.';

  @override
  String get errorGeneric => 'Không thể kết nối đến máy chủ.';

  @override
  String get errorInvalidEmail => 'Vui lòng nhập địa chỉ email hợp lệ.';

  @override
  String get errorInvalidAvatarUrl =>
      'URL avatar phải bắt đầu bằng http:// hoặc https://.';

  @override
  String get errorSignInFailed => 'Sai email hoặc mật khẩu.';

  @override
  String get errorSignUpFailed => 'Đăng ký thất bại.';

  @override
  String get errorForgotFailed => 'Không thể tạo liên kết đặt lại mật khẩu.';

  @override
  String get errorResetFailed => 'Không thể đổi mật khẩu.';

  @override
  String get errorFullNameRequired => 'Vui lòng nhập họ và tên.';

  @override
  String get successSignUp => 'Đăng ký thành công! Vui lòng đăng nhập.';

  @override
  String get successResetPassword => 'Đã đổi mật khẩu thành công.';

  @override
  String get successForgotEmail => 'Nếu email tồn tại, liên kết đã được gửi.';

  @override
  String get successProfileSaved => 'Cập nhật profile thành công!';

  @override
  String get successPasswordChanged =>
      'Đổi mật khẩu thành công! Vui lòng đăng nhập lại.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'Không thể tải thông tin profile: $message';
  }

  @override
  String get explore => 'Khám phá';

  @override
  String get gallery => 'Thư viện';

  @override
  String get faq => 'Hỏi đáp';

  @override
  String get pricing => 'Bảng giá';

  @override
  String get loginPrompt => 'Vui lòng đăng nhập trước khi tạo ảnh.';

  @override
  String get emptyPrompt => 'Hãy nhập prompt trước khi bấm Action.';

  @override
  String get imageOnlySupported =>
      'REEL hiện chỉ hỗ trợ text-to-image. Hãy chọn Photo.';

  @override
  String get imageGenerationFailed =>
      'Không thể tạo ảnh. Hãy kiểm tra backend và model.';

  @override
  String get noImageReturned => 'Model không trả về ảnh.';

  @override
  String get videoDurationLabel => 'THỜI LƯỢNG';

  @override
  String get videoQualityLabel => 'CHẤT LƯỢNG';

  @override
  String get videoQueuedMessage =>
      'Video đang được dựng — mất vài phút. Kết quả sẽ hiện tại đây.';

  @override
  String get videoGenerationFailed =>
      'Tạo video thất bại. Credit của bạn đã được hoàn lại.';

  @override
  String get videoTimeoutMessage =>
      'Video mất nhiều thời gian hơn dự kiến. Kiểm tra Thư viện trong hồ sơ ít phút nữa.';

  @override
  String get videoReadyLabel => 'Video của bạn đã sẵn sàng';

  @override
  String get usageLabelSignedOut => 'Đăng nhập để bắt đầu';

  @override
  String get rtlToggleTooltip => 'Đổi hướng bố cục LTR / RTL';

  @override
  String get footerTagline =>
      'REEL — phát triển trong bóng tối, từng khung hình một. Biến một dòng chữ thành một thước phim.';

  @override
  String get productColumn => 'SẢN PHẨM';

  @override
  String get supportColumn => 'HỖ TRỢ';

  @override
  String get signInLink => 'Đăng nhập';

  @override
  String get signUpLink => 'Đăng ký';

  @override
  String get footerCaption1 =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Nhập một cảnh.';

  @override
  String get getTheTake => 'Lấy thước quay.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Biến một dòng chữ thành một cảnh quay — có khung hình, ánh sáng và chuyển động, dựng xong trong vài giây. Video hay ảnh tĩnh, cùng một roll.';

  @override
  String get homeStatLastTake => 'TAKE VỪA TẠO';

  @override
  String get homeStatAspectRatios => 'TỈ LỆ KHUNG HÌNH';

  @override
  String get homeStatFilmStocks => 'STOCK ĐIỆN ẢNH';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'Mô tả cảnh của bạn…';

  @override
  String get homeQuickChips =>
      'Vũ hội dưới đèn chùm | Kỵ sĩ giữa bão cát | Xưởng con rối';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'Đang tạo…';

  @override
  String get homeGenerate => 'Tạo';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Tạo hoàn tất · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => 'Không tải được ảnh kết quả.';

  @override
  String get homeGenerationOpenOriginal => 'Mở ảnh gốc';

  @override
  String get homeGenerationRegenerate => 'Tạo lại';

  @override
  String get homeGenerationOpenFailed => 'Không mở được ảnh gốc.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'Một dòng chữ. Một cảnh hoàn chỉnh.';

  @override
  String get showcaseSubtitle =>
      'Xem REEL biến mô tả thành khung hình thật, từng bước một.';

  @override
  String get showcasePrompt1 =>
      '\"phi hành gia lướt ván trên sa mạc đỏ Mars, giờ vàng, toàn cảnh rộng\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"vũ hội hoá trang dưới ánh đèn chùm, chuyển động máy quay chậm\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"kỵ sĩ cưỡi ngựa giữa bão cát lúc hoàng hôn, máy quay bám theo\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Bốn công cụ, một cảnh quay';

  @override
  String get featuresSubtitle =>
      'Mọi thứ bạn cần để đi từ một dòng chữ đến một khung hình hoàn chỉnh.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Ánh sáng, chuyển động máy quay và ngữ pháp điện ảnh học từ hàng triệu khung hình thật.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 cho màn ảnh rộng, 1:1 cho feed, 9:16 cho story — không cần dựng lại từ đầu.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — chọn chất liệu trước khi bấm Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'Cùng một prompt, một studio sáng tạo. Tạo ảnh ngay; video sẽ được mở khi sẵn sàng.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Câu hỏi thường gặp';

  @override
  String get faqSubtitle => 'Còn thắc mắc gì khác, cứ nhắn cho đội REEL.';

  @override
  String get faqQ1 => 'REEL hoạt động như thế nào?';

  @override
  String get faqA1 =>
      'Bạn gõ một câu mô tả, chọn tỉ lệ khung hình và stock hình ảnh. REEL tạo ảnh dựa trên mô tả đó. Tính năng video đang được phát triển.';

  @override
  String get faqQ2 => 'REEL khác gì các công cụ AI video khác?';

  @override
  String get faqA2 =>
      'REEL tập trung vào ngôn ngữ điện ảnh — ánh sáng, bố cục và chất liệu stock — trong cùng một studio sáng tạo.';

  @override
  String get faqQ3 => 'Tôi được dùng bao nhiêu take miễn phí?';

  @override
  String get faqA3 =>
      'Hạn mức hiện tại và số credit còn lại được hiển thị ngay trong studio sau khi đăng nhập. Xem gói thanh toán để biết quyền lợi đang áp dụng.';

  @override
  String get faqQ4 => 'Định dạng và độ phân giải nào được hỗ trợ?';

  @override
  String get faqA4 =>
      'Ảnh hỗ trợ ba tỉ lệ 16:9, 1:1 và 9:16. Kích thước đầu ra phụ thuộc cấu hình tạo ảnh hiện tại.';

  @override
  String get faqQ5 => 'Tôi có thể dùng kết quả cho mục đích thương mại không?';

  @override
  String get faqA5 =>
      'Hãy xem Điều khoản sản xuất và quyền lợi của gói bạn chọn trước khi sử dụng kết quả cho mục đích thương mại.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Chọn nhịp quay của bạn';

  @override
  String get plansSubtitle =>
      'Khởi đầu miễn phí, nâng cấp bất cứ khi nào bạn cần tạo nhiều hơn.';

  @override
  String get ctaReady => 'Ready for your';

  @override
  String get ctaReadyItalic => 'first take?';

  @override
  String get ctaBody =>
      'Miễn phí, không cần thẻ tín dụng — dựng cảnh đầu tiên trong chưa đầy một phút.';

  @override
  String get ctaFreeButton => 'Tạo tài khoản miễn phí';

  @override
  String get ctaGalleryButton => 'Xem thư viện';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Khung hình mới nhất';

  @override
  String get contactSheetSubtitle =>
      'Một vài cảnh quay do cộng đồng REEL vừa dựng xong.';

  @override
  String get contactSheetDialogTitle => 'Bản xem trước phong cách hình ảnh.';

  @override
  String get contactSheetDialogBody => 'Tạo take của riêng bạn trong studio.';

  @override
  String get contactSheetClose => 'Đóng';

  @override
  String get pricingTitle => 'BẢNG GIÁ';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Chọn nhịp quay của bạn';

  @override
  String get pricingSubheading =>
      'Khởi đầu miễn phí, nâng cấp bất cứ khi nào bạn cần tạo nhiều hơn.';

  @override
  String get pricingEmpty => 'Chưa có package đang bán.';

  @override
  String get pricingBuyButton => 'Mở Studio';

  @override
  String get pricingFreeCta => 'Dùng miễn phí';

  @override
  String get pricingSignInFirst => 'Vui lòng đăng nhập trước khi mua package.';

  @override
  String get pricingLoadFailed => 'Không tải được danh sách package.';

  @override
  String get pricingStripeOpenFailed => 'Không thể mở trang thanh toán Stripe.';

  @override
  String get pricingStripeOpened =>
      'Đã mở Stripe Checkout. Credit sẽ được cộng tự động sau khi thanh toán thành công.';

  @override
  String get pricingCreditsSuffix => ' CREDITS';

  @override
  String get pricingCreditsPerMonth => 'credits mỗi tháng';

  @override
  String get pricingPeriodMonthly => '/tháng';

  @override
  String get pricingPeriodYearly => '/năm';

  @override
  String get pricingFreePerk =>
      'Miễn phí 50 credits mỗi tháng — thoải mái thử mọi công cụ trong studio.';

  @override
  String get profileTitle => 'MY PROFILE';

  @override
  String profileLoadFailed(Object message) {
    return 'Không thể tải thông tin profile: $message';
  }

  @override
  String get profileNotLoaded => 'Không thể tải thông tin profile';

  @override
  String get profileEditButton => 'SỬA PROFILE';

  @override
  String get profileChangePasswordButton => 'ĐỔI MẬT KHẨU';

  @override
  String get profileUsageSection => 'SỬ DỤNG & CREDITS';

  @override
  String get profileCreditBalance => 'Số dư credit';

  @override
  String get profileDailyUsage => 'Sử dụng hôm nay';

  @override
  String get profileAccountSection => 'THÔNG TIN TÀI KHOẢN';

  @override
  String get profileUserId => 'User ID';

  @override
  String get profileStatus => 'Trạng thái';

  @override
  String get profileStatusActive => 'Đang hoạt động';

  @override
  String get profileStatusInactive => 'Không hoạt động';

  @override
  String get profileMemberSince => 'Tham gia từ';

  @override
  String get profileUnknownName => 'Chưa rõ';

  @override
  String get profileUnknownEmail => 'Chưa có email';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'SỬA PROFILE';

  @override
  String get editProfileSubhead => 'Cập nhật thông tin profile của bạn';

  @override
  String get editProfileSave => 'LƯU THAY ĐỔI';

  @override
  String editProfileLoadFailed(Object message) {
    return 'Không thể tải profile: $message';
  }

  @override
  String get editProfileSaveFailed => 'Không thể cập nhật profile';

  @override
  String get changePasswordTitle => 'ĐỔI MẬT KHẨU';

  @override
  String get changePasswordSubhead =>
      'Nhập mật khẩu hiện tại và chọn mật khẩu mới';

  @override
  String get changePasswordCurrent => 'Mật khẩu hiện tại';

  @override
  String get changePasswordNew => 'Mật khẩu mới';

  @override
  String get changePasswordConfirm => 'Xác nhận mật khẩu mới';

  @override
  String get changePasswordCurrentRequired => 'Vui lòng nhập mật khẩu hiện tại';

  @override
  String get changePasswordNewRequired => 'Vui lòng nhập mật khẩu mới';

  @override
  String get changePasswordTooShort => 'Mật khẩu phải có ít nhất 8 ký tự';

  @override
  String get changePasswordConfirmRequired => 'Vui lòng xác nhận mật khẩu mới';

  @override
  String get changePasswordMismatch => 'Mật khẩu không trùng khớp';

  @override
  String get changePasswordSubmit => 'ĐỔI MẬT KHẨU';

  @override
  String get changePasswordFailed => 'Không thể đổi mật khẩu';

  @override
  String get libraryTitle => 'Thư viện';

  @override
  String get libraryTabGenerations => 'ẢNH Đ TẠO';

  @override
  String get libraryTabCredits => 'CREDIT';

  @override
  String get libraryTabPayments => 'PAYMENTS';

  @override
  String get libraryReload => 'Tải lại';

  @override
  String get librarySignInPrompt => 'ĐĂNG NHẬP ĐỂ XEM THƯ VIỆN';

  @override
  String get libraryRetry => 'THỬ LẠI';

  @override
  String get libraryLoadFailed => 'Không tải được thư viện của bạn.';

  @override
  String get libraryEmptyGenerations => 'Bạn chưa tạo ảnh nào.';

  @override
  String get libraryEmptyCredits => 'Chưa có giao dịch credit.';

  @override
  String get libraryEmptyPayments => 'Chưa có thanh toán.';

  @override
  String get libraryDeleteDialogTitle => 'Xóa ảnh đã tạo?';

  @override
  String get libraryDeleteDialogBody =>
      'Bạn có chắc muốn xóa ảnh này? Hành động này không thể hoàn tác.';

  @override
  String get libraryDeleteCancel => 'HỦY';

  @override
  String get libraryDeleteConfirm => 'XÓA';

  @override
  String get libraryDeleteSuccess => 'Đã xóa ảnh thành công';

  @override
  String get libraryDeleteFailed => 'Không thể xóa ảnh';

  @override
  String get libraryStatusCompleted => 'Hoàn tất';

  @override
  String get libraryStatusFailed => 'Thất bại';

  @override
  String get libraryStatusProcessing => 'Đang xử lý';

  @override
  String get libraryStatusPending => 'Đang chờ';

  @override
  String get paymentResultSuccess => 'THANH TOÁN THÀNH CÔNG';

  @override
  String get paymentResultCancel => 'Đ HỦY THANH TOÁN';

  @override
  String get paymentResultError => 'THANH TOÁN THẤT BẠI';

  @override
  String get paymentResultSuccessMsg =>
      'Thanh toán đã được xử lý. Credit đã được cộng vào tài khoản của bạn.';

  @override
  String get paymentResultCancelMsg =>
      'Bạn đã hủy thanh toán. Không có khoản phí nào được thực hiện.';

  @override
  String get paymentResultErrorMsg =>
      'Có lỗi xảy ra khi xử lý thanh toán. Vui lòng thử lại hoặc liên hệ hỗ trợ.';

  @override
  String get paymentResultLoadFailed => 'Không thể tải thông tin thanh toán';

  @override
  String get paymentDetailPackage => 'Gói';

  @override
  String get paymentDetailCredits => 'Credits';

  @override
  String get paymentDetailAmount => 'Số tiền';

  @override
  String get paymentDetailTransaction => 'Giao dịch';

  @override
  String get paymentBackHome => 'VỀ TRANG CHỦ';

  @override
  String get paymentTryAgain => 'THỬ LẠI';

  @override
  String get termsEyebrow => 'PHÁP LÝ';

  @override
  String get termsHeadline => 'Điều khoản sử dụng';

  @override
  String get termsSubhead =>
      'Cập nhật lần cuối: 10/09/2026 · Áp dụng cho toàn bộ dịch vụ REEL';

  @override
  String get termsBackShort => 'QUAY LẠI';

  @override
  String get termsBackLong => 'VỀ TRANG CHỦ';

  @override
  String get termsFooterText =>
      'REEL — SẢN XUẤT TRONG BÓNG TỐI. TỪNG FRAME MỘT.';

  @override
  String get termsAccept => 'TÔI ĐỒNG Ý';

  @override
  String get termsDecline => 'QUAY LẠI';

  @override
  String get adminDashboardTitle => 'Admin Dashboard';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Tổng quan';

  @override
  String get adminSidebarGenerations => 'Generations';

  @override
  String get adminSidebarUsers => 'Người dùng';

  @override
  String get adminSidebarPayments => 'Payments';

  @override
  String get adminSidebarSettings => 'Cài đặt';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Quản trị viên';

  @override
  String get adminMenuTooltip => 'Mở menu';

  @override
  String get adminRtlTooltip => 'Đổi hướng bố cục LTR / RTL';

  @override
  String get adminRefreshTooltip => 'Làm mới';

  @override
  String get adminSearchUsersHint => 'Tìm người dùng…';

  @override
  String get adminExportTooltip => 'Xuất báo cáo';

  @override
  String get adminExportLabel => 'XUẤT';

  @override
  String get adminExportComingSoon => 'Tính năng xuất báo cáo sắp ra mắt.';

  @override
  String get adminNotificationsTooltip => 'Thông báo';

  @override
  String get adminRangeLabel => 'Phạm vi';

  @override
  String get adminRangeToday => 'Hôm nay';

  @override
  String get adminRange7Days => '7 ngày';

  @override
  String get adminRange30Days => '30 ngày';

  @override
  String get adminRangeTodayLong => 'hôm nay';

  @override
  String get adminRange7DaysLong => '7 ngày qua';

  @override
  String get adminRange30DaysLong => '30 ngày qua';

  @override
  String get adminAutoUpdateNote => 'Tự động cập nhật lúc 00:00 hằng ngày';

  @override
  String adminKpiTakes(Object range) {
    return 'Tác phẩm — $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Người dùng hoạt động — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Doanh thu — $range';
  }

  @override
  String get adminKpiQueue => 'Hàng đợi render';

  @override
  String get adminDailyOutputTitle => 'Sản lượng 7 ngày qua';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return 'Tỉ lệ $ratio16x9 chiếm 58% tổng lượt dựng tuần này — theo sau là 1:1 (24%) và 9:16 (18%).';
  }

  @override
  String get adminStockMixTitle => 'Tỉ lệ theo phong cách';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Lượt dựng gần đây';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Người dùng';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Mở danh sách';

  @override
  String get adminFleetTitle => 'Hàng đợi & GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter =>
      '3/5 worker đang xử lý · 1 đang bảo trì · 1 rảnh';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'Đang xử lý — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Rảnh — chờ job kế tiếp';

  @override
  String get adminFleetJobMaintenance => 'Bảo trì định kỳ';

  @override
  String get adminGenerationCompleted => 'Hoàn tất';

  @override
  String get adminGenerationProcessing => 'Đang dựng';

  @override
  String get adminGenerationFailed => 'Thất bại';

  @override
  String get adminUserStatusActive => 'Đang hoạt động';

  @override
  String get adminUserStatusInactive => 'Không hoạt động';

  @override
  String get adminUserStatusBanned => 'Bị cấm';

  @override
  String get adminUserRoleAdmin => 'Quản trị';

  @override
  String get adminUserRoleUser => 'Người dùng';

  @override
  String get adminSettingsTitle => 'Cài đặt';

  @override
  String get adminSettingsStudioName => 'Tên hiển thị studio';

  @override
  String get adminSettingsSupportEmail => 'Email hỗ trợ';

  @override
  String get adminSettingsImageCost => 'Credit mỗi ảnh';

  @override
  String get adminSettingsVideoCost => 'Credit mỗi video';

  @override
  String get adminSettingsAlerts => 'Cảnh báo';

  @override
  String get adminSettingsAlertPayment => 'Thông báo khi thanh toán lỗi';

  @override
  String get adminSettingsAlertGeneration => 'Thông báo khi tạo ảnh lỗi';

  @override
  String get adminSettingsNewsletter => 'Gửi newsletter';

  @override
  String get adminSettingsMaintenance => 'Chế độ bảo trì';

  @override
  String get adminSettingsRegistration => 'Cho phép đăng ký mới';

  @override
  String get adminSettingsSave => 'LƯU THAY ĐỔI';

  @override
  String get adminSettingsLoadFailed => 'Không tải được cài đặt.';

  @override
  String get adminSettingsSaved => 'Đã lưu cài đặt.';

  @override
  String get adminSettingsSaveFailed => 'Không thể lưu cài đặt.';

  @override
  String get adminPackagesTitle => 'Payment packages';

  @override
  String get adminPackagesEmpty => 'Chưa có payment package nào.';

  @override
  String get adminPackagesLoadFailed => 'Không tải được payment packages.';

  @override
  String get adminPackagesNew => 'Package mới';

  @override
  String get adminPackagesFeatured => 'Nổi bật';

  @override
  String get adminPackagesInactive => 'Không hoạt động';

  @override
  String get adminPackagesActive => 'Đang hoạt động';

  @override
  String get adminPaymentsTitle => 'Payments';

  @override
  String get adminPaymentsEmpty => 'Chưa có thanh toán.';

  @override
  String get adminPaymentsLoadFailed => 'Không tải được payments.';

  @override
  String get adminPaymentsFilterAll => 'Tất cả';

  @override
  String get adminCreditsTitle => 'Giao dịch credit';

  @override
  String get adminCreditsEmpty => 'Chưa có giao dịch credit.';

  @override
  String get adminCreditsLoadFailed => 'Không tải được giao dịch credit.';

  @override
  String get adminUsersTitle => 'Người dùng';

  @override
  String get adminUsersEmpty => 'Không tìm thấy người dùng.';

  @override
  String get adminUsersLoadFailed => 'Không tải được người dùng.';

  @override
  String get adminUsersSearch => 'Tìm theo email hoặc tên';

  @override
  String get adminUsersRefresh => 'Làm mới';

  @override
  String get adminUsersReset => 'Đặt lại';

  @override
  String get commonRetry => 'Thử lại';

  @override
  String get commonCancel => 'Hủy';

  @override
  String get commonDelete => 'Xóa';

  @override
  String get commonSave => 'Lưu';

  @override
  String get commonClose => 'Đóng';

  @override
  String get termsTocLabel => 'Mục lục';

  @override
  String get termsNoteBox =>
      'Đây là bản dựng giao diện (UI/UX) minh hoạ nội dung điều khoản mẫu. Trước khi công bố chính thức, REEL nên nhọ luật sư rà soát để đảm bảo phù hợp quy định pháp luật hiện hành.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'Email hỗ trợ';

  @override
  String get termsContactButton => 'Liên hệ hỗ trợ';

  @override
  String get termsS01Title => 'Chấp nhận điều khoản';

  @override
  String get termsS01P1 =>
      'Bằng việc tạo tài khoản hoặc sử dụng bất kỳ tính năng nào của REEL (tạo ảnh, tạo video, nạp credit, nâng cấp gói), bạn đồng ý tuân thủ các điều khoản dưới đây. Nếu bạn không đồng ý, vui lòng ngừng sử dụng dịch vụ.';

  @override
  String get termsS01P2 =>
      'REEL dành cho người dùng từ 13 tuổi trở lên. Người dùng dưới 18 tuổi cần có sự đồng ý của phụ huynh hoặc người giám hộ hợp pháp.';

  @override
  String get termsS02Title => 'Tài khoản';

  @override
  String get termsS02P1 =>
      'Mỗi tài khoản gắn với một địa chỉ email duy nhất. Bạn chịu trách nhiệm giữ bí mật mật khẩu và mọi hoạt động diễn ra dưới tài khoản của mình.';

  @override
  String get termsS02B1 =>
      'Thông tin đăng ký (họ tên, email) phải chính xác và được cập nhật khi thay đổi.';

  @override
  String get termsS02B2 =>
      'REEL có thể yêu cầu xác minh email trước khi kích hoạt một số tính năng.';

  @override
  String get termsS02B3 =>
      'Tài khoản có thể ở trạng thái active, inactive hoặc banned tuỳ theo lịch sử sử dụng và vi phạm (nếu có).';

  @override
  String get termsS03Title => 'Credit & dịch vụ tạo nội dung AI';

  @override
  String get termsS03P1 =>
      'REEL vận hành theo cơ chế credit. Mỗi lượt tạo ảnh hoặc video sẽ trừ một số credit tương ứng vào ví của bạn, tuỳ theo loại nội dung, độ phân giải và thời lượng.';

  @override
  String get termsS03B1 =>
      'Credit được trừ khi yêu cầu tạo nội dung bắt đầu xử lý.';

  @override
  String get termsS03B2 =>
      'Nếu quá trình tạo nội dung thất bại do lỗi hệ thống, credit tương ứng sẽ được hoàn lại tự động.';

  @override
  String get termsS03B3 =>
      'REEL không hoàn credit nếu yêu cầu thất bại do nội dung vi phạm điều khoản (xem Mục 6).';

  @override
  String get termsS03B4 =>
      'Credit chưa dùng hết trong gói theo tháng/năm sẽ không được cộng dồn sang chu kỳ tiếp theo, trừ khi có thông báo khác.';

  @override
  String get termsS04Title => 'Thanh toán & hoàn tiền';

  @override
  String get termsS04P1 =>
      'REEL chấp nhận thanh toán qua Momo, ZaloPay, VNPay, chuyển khoản ngân hàng và Stripe (đối với các gói cước quốc tế). Mọi giao dịch được ghi nhận cùng mã giao dịch riêng để tra soát khi cần.';

  @override
  String get termsS04B1 =>
      'Gói theo tháng/năm được gia hạn tự động trừ khi bạn huỷ trước chu kỳ tiếp theo.';

  @override
  String get termsS04B2 =>
      'Yêu cầu hoàn tiền được xem xét trong vòng 7 ngày kể từ ngày thanh toán, với điều kiện credit của gói đó chưa được sử dụng.';

  @override
  String get termsS04B3 =>
      'Giao dịch nạp credit một lần (one_time) không được hoàn lại sau khi credit đã cộng vào ví.';

  @override
  String get termsS05Title => 'Quyền sở hữu nội dung';

  @override
  String get termsS05P1 =>
      'Bạn giữ quyền sử dụng đối với nội dung do bạn tạo ra trên REEL, trong phạm vi gói dịch vụ đang sử dụng.';

  @override
  String get termsS05B1 =>
      'Gói Free: nội dung có gắn watermark REEL, chỉ dùng cho mục đích cá nhân, phi thương mại.';

  @override
  String get termsS05B2 =>
      'Gói Pro: nội dung không watermark, được phép sử dụng cho mục đích thương mại.';

  @override
  String get termsS05B3 =>
      'REEL không xác nhận hay đảm bảo nội dung do AI tạo ra không trùng lặp với tác phẩm của bên thứ ba; người dùng tự chịu trách nhiệm kiểm tra trước khi sử dụng cho mục đích thương mại.';

  @override
  String get termsS06Title => 'Hành vi bị cấm';

  @override
  String get termsS06P1 =>
      'Bạn không được dùng REEL để tạo hoặc phát tán nội dung:';

  @override
  String get termsS06B1 =>
      'Vi phạm pháp luật hiện hành, kích động bạo lực, phân biệt đối xử hoặc thù ghét.';

  @override
  String get termsS06B2 =>
      'Khiêu dâm, liên quan đến trẻ em dưới bất kỳ hình thức nào.';

  @override
  String get termsS06B3 =>
      'Mạo danh người khác, xâm phạm quyền riêng tư hoặc hình ảnh cá nhân mà không có sự cho phép.';

  @override
  String get termsS06B4 =>
      'Vi phạm bản quyền, nhãn hiệu hoặc quyền sở hữu trí tuệ của bên thứ ba.';

  @override
  String get termsS06P2 =>
      'Vi phạm các điều trên có thể dẫn đến khoá tài khoản (banned) mà không cần báo trước, và không hoàn lại credit hay phí đã thanh toán.';

  @override
  String get termsS07Title => 'Giới hạn trách nhiệm';

  @override
  String get termsS07P1 =>
      'Dịch vụ được cung cấp \"nguyên trạng\". REEL không đảm bảo dịch vụ hoạt động liên tục không gián đoạn, không lỗi, hoặc kết quả tạo ra luôn đáp ứng kỳ vọng của người dùng.';

  @override
  String get termsS07P2 =>
      'Trong phạm vi pháp luật cho phép, REEL không chịu trách nhiệm cho các thiệt hại gián tiếp phát sinh từ việc sử dụng hoặc không thể sử dụng dịch vụ.';

  @override
  String get termsS08Title => 'Chấm dứt tài khoản';

  @override
  String get termsS08P1 =>
      'Bạn có thể ngừng sử dụng và yêu cầu xoá tài khoản bất kỳ lúc nào. REEL có quyền tạm ngưng (inactive) hoặc khoá vĩnh viễn (banned) tài khoản vi phạm điều khoản, sau khi đã cân nhắc mức độ vi phạm.';

  @override
  String get termsS09Title => 'Thay đổi điều khoản';

  @override
  String get termsS09P1 =>
      'REEL có thể cập nhật điều khoản này theo thời gian. Thay đổi quan trọng sẽ được thông báo qua email hoặc banner trên trang chủ trước khi có hiệu lực ít nhất 7 ngày.';

  @override
  String get termsS10Title => 'Liên hệ';

  @override
  String get termsS10P1 =>
      'Nếu có thắc mắc về điều khoản sử dụng, vui lòng liên hệ đội ngũ REEL.';

  @override
  String get errorPasswordRequired => 'Vui lòng nhập mật khẩu.';

  @override
  String get errorConfirmPasswordRequired => 'Vui lòng xác nhận mật khẩu.';

  @override
  String get backToHomeLabel => 'TRANG CHỦ';

  @override
  String get backToHomeTooltip => 'Trở về trang chủ';

  @override
  String get profileBackHome => 'Về trang chủ';

  @override
  String get profileNavOverview => 'Tổng quan';

  @override
  String get profileNavMyRoll => 'Tác phẩm của tôi';

  @override
  String get profileNavSettings => 'Cài đặt';

  @override
  String get profileNavBilling => 'Gói & Thanh toán';

  @override
  String get profileLogout => 'Đăng xuất';

  @override
  String profileWelcomeBack(String name) {
    return 'Chào mừng trở lại, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'Bạn đã đồng hành cùng REEL $days ngày.';
  }

  @override
  String get profileStatTotalTakes => 'Tổng tác phẩm';

  @override
  String get profileStatFavoriteStock => 'Công cụ thương dùng';

  @override
  String get profileStatDaysLabel => 'Đã đồng hành';

  @override
  String profileStatDaysValue(int n) {
    return '$n ngày';
  }

  @override
  String get profileUpgradePro => 'Nâng cấp Pro';

  @override
  String get profileRecentActivity => 'Tạo gần đây';

  @override
  String get profileViewAll => 'Xem tất cả →';

  @override
  String get profileMyRollSub => 'Toàn bộ tác phẩm bạn đã tạo trên REEL.';

  @override
  String get profileFilterAll => 'Tất cả';

  @override
  String get profileFilterVideo => 'Video';

  @override
  String get profileFilterPhoto => 'Ảnh';

  @override
  String get profilePhotoTag => 'Ảnh';

  @override
  String get profileMyRollEmpty =>
      'Chưa có tác phẩm nào — hãy tạo tác phẩm đầu tiên trong Studio.';

  @override
  String get profileTimeJustNow => 'Vừa xong';

  @override
  String profileTimeMinutesAgo(int n) {
    return '$n phút trước';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return '$n giờ trước';
  }

  @override
  String get profileTimeYesterday => 'Hôm qua';

  @override
  String profileTimeDaysAgo(int n) {
    return '$n ngày trước';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return '$n tuần trước';
  }

  @override
  String get profileSettingsSub =>
      'Cập nhật thông tin hồ sơ và tuỳ chọn mặc định.';

  @override
  String get profileSectionProfileInfo => 'Thông tin hồ sơ';

  @override
  String get profileFieldDisplayName => 'Tên hiển thị';

  @override
  String get profileFieldEmail => 'Email';

  @override
  String get profileSaveChanges => 'Lưu thay đổi';

  @override
  String get profileSectionPassword => 'Đổi mật khẩu';

  @override
  String get profileFieldCurrentPassword => 'Mật khẩu hiện tại';

  @override
  String get profileFieldNewPassword => 'Mật khẩu mới';

  @override
  String get profileFieldConfirmPassword => 'Xác nhận mật khẩu mới';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'Tối thiểu 8 ký tự';

  @override
  String get profilePwConfirmPlaceholder => 'Nhập lại';

  @override
  String get profileUpdatePassword => 'Cập nhật mật khẩu';

  @override
  String get profilePwShow => 'Hiện';

  @override
  String get profilePwHide => 'Ẩn';

  @override
  String get profileSectionPrefs => 'Tuỳ chọn mặc định';

  @override
  String get profilePrefRatio => 'Tỉ lệ khung hình mặc định';

  @override
  String get profilePrefRatioDesc => 'Áp dụng mỗi khi bạn mở generator';

  @override
  String get profilePrefStock => 'Phong cách mặc định';

  @override
  String get profilePrefStockDesc => 'Phong cách hình ảnh khởi điểm';

  @override
  String get profileDangerTitle => 'Khu vực nguy hiểm';

  @override
  String get profileDangerDesc =>
      'Xoá tài khoản sẽ xoá toàn bộ tác phẩm và không thể khôi phục.';

  @override
  String get profileDeleteAccount => 'Xoá tài khoản';

  @override
  String get profileDeleteNotice =>
      'Việc xoá tài khoản được đội ngũ REEL xử lý — hãy liên hệ hỗ trợ để yêu cầu.';

  @override
  String get profileBillingSub =>
      'Quản lý gói sử dụng và phương thức thanh toán.';

  @override
  String get profileCurrentPlan => 'Gói hiện tại';

  @override
  String get profilePlanPerMonth => '/ tháng';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '199.000đ';

  @override
  String get profilePlanFreeF1 => '50 credits/tháng';

  @override
  String get profilePlanFreeF2 => 'Có watermark REEL';

  @override
  String get profilePlanProF1 => '2.000 credits/tháng';

  @override
  String get profilePlanProF2 => '4K, không watermark';

  @override
  String get profileCurrentTag => 'Đang dùng';

  @override
  String get profileUpgradeShort => 'Nâng cấp';

  @override
  String get profilePaymentHistory => 'Lịch sử thanh toán';

  @override
  String get profileEmptyPayments =>
      'Chưa có giao dịch nào — nâng cấp Pro để bắt đầu.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'Đã lưu thông tin hồ sơ!';

  @override
  String get profilePasswordUpdated => 'Đã cập nhật mật khẩu!';

  @override
  String get profileProChip => 'GÓI PRO';

  @override
  String get profileFreeChip => 'GÓI FREE';

  @override
  String get adminSidebarModeration => 'Kiểm duyệt';

  @override
  String get adminSidebarRevenue => 'Doanh thu';

  @override
  String get adminSidebarSystem => 'Hệ thống';

  @override
  String get adminRoleChip => 'Quản trị viên';

  @override
  String usageCreditsLabel(int balance) {
    return 'Còn $balance credits';
  }

  @override
  String get homeStatCreditsLeft => 'CREDIT CÒN LẠI';

  @override
  String get profileStatCredits => 'Credits';

  @override
  String profileCreditsAvailable(int balance) {
    return 'Còn $balance credits';
  }

  @override
  String get profileTopUp => 'Nạp credits';

  @override
  String get profilePlanPayAsYouGo => '/ tháng';

  @override
  String profileUsageSpentToday(int spent) {
    return 'Đã dùng $spent credits hôm nay';
  }

  @override
  String get profileTopUpHint => 'Nạp thêm credits để tiếp tục tạo ảnh.';

  @override
  String get avatarUpdated => 'Đã cập nhật ảnh đại diện';

  @override
  String get avatarUpdateFailed =>
      'Không thể tải lên ảnh đại diện. Vui lòng thử lại.';

  @override
  String get avatarChangeHint => 'Đổi ảnh đại diện';

  @override
  String get navCreate => 'Tạo mới';

  @override
  String get navProfile => 'Hồ sơ';

  @override
  String get homeHeadline => 'Một ô prompt.';

  @override
  String get homeHeadlineAccent => 'Mọi kiểu tác phẩm.';

  @override
  String get homeSubheadRedesign =>
      '20 công cụ AI trong một trang chủ: công cụ hay dùng được ghim lên đầu, còn lại tìm nhanh khi cần. Truyện dài nhiều trang vẫn vào Manga Studio — kịch bản → tách trang → tạo lô.';

  @override
  String get toolsBarLabel => 'Ghim của bạn';

  @override
  String get toolsAllButton => 'Xem tất cả 20 công cụ';

  @override
  String get toolsSearchHint => 'Tìm công cụ — ví dụ: manga, voice, 3D, code…';

  @override
  String get toolsCatalogTitle => 'Tất cả công cụ AI';

  @override
  String get toolsCatalogSubtitle =>
      '20 công cụ · chọn một công cụ để mở panel tạo tương ứng.';

  @override
  String get toolsNoMatch =>
      'Không có công cụ nào khớp — thử từ khoá khác (voice, 3D, nhạc…).';

  @override
  String toolComingSoon(String name) {
    return '$name sắp ra mắt — hiện chỉ Ảnh & Video khả dụng.';
  }

  @override
  String get toolGroupImages => 'Hình ảnh & Thiết kế';

  @override
  String get toolGroupFilm => 'Phim & Truyện';

  @override
  String get toolGroupAudio => 'Âm thanh & Âm nhạc';

  @override
  String get toolGroupDocs => 'Nội dung dài & Tài liệu';

  @override
  String get toolGroupTech => 'Kỹ thuật & Tự động hoá';

  @override
  String get panelRatioLabel => 'Tỷ lệ';

  @override
  String get panelStyleLabel => 'Phong cách';

  @override
  String get generateImage => 'Tạo ảnh';

  @override
  String get generateVideo => 'Tạo video';

  @override
  String get panelGenerateGeneric => 'Tạo';

  @override
  String get saveToLibraryHint => 'Kết quả lưu tự động vào Thư viện.';

  @override
  String get imagePromptHint =>
      'Mô tả khung hình bạn muốn tạo… ví dụ: \'Đô thị mưa ban đêm, ánh neon phản trên mặt đường, ống kính 35mm\'';

  @override
  String get videoPromptHint =>
      'Mô tả cảnh quay… ví dụ: \'Flycam lướt qua rừng tre buổi sớm, sương mù lơ lửng, ánh sáng vàng nhạt\'';

  @override
  String get genericPromptHint => 'Mô tả điều bạn muốn tạo…';

  @override
  String get comingSoonNote =>
      'Công cụ này đang ở bản thiết kế — chưa nối server để tạo thật.';

  @override
  String get modeImageSub => 'Một prompt, một khung hình nghệ thuật.';

  @override
  String get modeVideoSub => 'Cảnh quay ngắn từ mô tả của bạn.';

  @override
  String get modeSpeechSub => 'Đọc kịch bản thành audio tự nhiên.';

  @override
  String get modeMangaSub =>
      'Truyện nhiều trang: kịch bản → trang → hộp thoại.';

  @override
  String get badgeNew => 'Mới';

  @override
  String get librarySearchHint => 'Tìm theo prompt…';

  @override
  String get libraryFilterImage => 'Ảnh';

  @override
  String get libraryFilterVideo => 'Video';

  @override
  String get libraryFilterPinned => 'Đã ghim';

  @override
  String get librarySelect => 'Chọn';

  @override
  String librarySelectedCount(int count) {
    return 'Đã chọn $count';
  }

  @override
  String get libraryBulkDownload => 'Tải xuống';

  @override
  String get libraryBulkDownloadSoon => 'Tải xuống hàng loạt sắp ra mắt.';

  @override
  String libraryBulkDeleteSuccess(int count) {
    return 'Đã xóa $count tác phẩm';
  }

  @override
  String get libraryPinAdded => 'Đã ghim vào thư viện';

  @override
  String get libraryPinRemoved => 'Đã bỏ ghim';

  @override
  String get libraryNoMatch =>
      'Không có tác phẩm nào khớp bộ lọc hoặc từ khoá.';

  @override
  String get authCardSignInTitle => 'Chào mừng trở lại';

  @override
  String get authCardSignInSub => 'Đăng nhập để tiếp tục sáng tạo với REEL.';

  @override
  String get authCardSignUpTitle => 'Tạo tài khoản';

  @override
  String get authCardSignUpSub => 'Miễn phí mãi — nâng cấp khi bạn cần.';

  @override
  String get authCardResetTitle => 'Nhập mã & mật khẩu mới';

  @override
  String get authCardResetSub => 'Mã có hiệu lực 10 phút.';

  @override
  String get authShowcaseAccent => 'Hai mươi kiểu tác phẩm.';

  @override
  String get authShowcaseSub =>
      'Ảnh, video, giọng nói, manga nhiều trang, nhạc, 3D, code… — tất cả từ chữ bạn viết. Đăng nhập để tiếp tục vén màn.';

  @override
  String get authShowcaseMore => '+12 công cụ khác';

  @override
  String get authGiftTitle => '50 credits chào mừng';

  @override
  String get authGiftSub =>
      '≈ 12 bức ảnh, hoặc 8 trang manga, hoặc 50 lần hiệu ứng âm thanh. Không cần thẻ tín dụng.';

  @override
  String get authStatToolsLabel => 'Công cụ AI';

  @override
  String get authStatMangaValue => '1 cuốn';

  @override
  String get authStatMangaLabel => 'Manga = 1 dự án';

  @override
  String get authStatRatingValue => '4.9★';

  @override
  String get authStatRatingLabel => 'Creator yêu thích';

  @override
  String get authStatFreeValue => '0đ';

  @override
  String get authStatFreeLabel => 'Bắt đầu';

  @override
  String get authStatSignupValue => '30s';

  @override
  String get authStatSignupLabel => 'Để đăng ký';

  @override
  String get authMeterEmpty => 'Độ mạnh mật khẩu';

  @override
  String get authMeterWeak => 'YẾU — THÊM CHỮ HOA / SỐ';

  @override
  String get authMeterOk => 'KHÁ TỐT';

  @override
  String get authMeterStrong => 'RẤT MẠNH ✓';

  @override
  String get adminSidebarQueue => 'Hàng đợi tạo';

  @override
  String get adminSidebarTools => 'Công cụ AI';

  @override
  String get librarySortNewest => 'Mới nhất';

  @override
  String get librarySortOldest => 'Cũ nhất';

  @override
  String get librarySortName => 'Tên A–Z';

  @override
  String get librarySortCost => 'Credits ↓';

  @override
  String get libraryCreate => 'Tạo mới';

  @override
  String get libraryProjects => '📚 DỰ ÁN ĐANG LÀM';

  @override
  String get libraryProjectMangaSub =>
      '8/12 trang · đang tạo Chương 2 · 3 nhân vật khoá';

  @override
  String get libraryProjectContinueManga => 'Tiếp tục trong Manga Studio';

  @override
  String get libraryProjectBookSub =>
      '3/6 chương · bản thảo 21.400 từ · xuất PDF-EPUB khi xong';

  @override
  String get libraryProjectContinueBook => 'Tiếp tục viết';

  @override
  String get libraryCollections => 'Bộ sưu tập';

  @override
  String get libraryCollectionsMock =>
      'Bản mockup — bộ sưu tập sẽ đồng bộ backend';

  @override
  String get libraryNewCollection => 'Bộ sưu tập mới';

  @override
  String get libraryOther => 'Khác';

  @override
  String get libraryTrash => 'Thùng rác';

  @override
  String get libraryTrashMock => 'Thùng rác giữ file 30 ngày';
}

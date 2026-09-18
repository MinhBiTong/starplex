// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'REEL — AI 影视与摄影工作室';

  @override
  String get languageLabel => '语言';

  @override
  String get languagePickerTooltip => '选择界面语言';

  @override
  String get signIn => '登录';

  @override
  String get signUp => '注册';

  @override
  String get getStarted => '开始';

  @override
  String get forgot => '忘记密码';

  @override
  String get resetPassword => '重置密码';

  @override
  String get newPassword => '新密码';

  @override
  String get credentialsBadge => '凭据';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · 访问 $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => '登录';

  @override
  String get productionAccessRollSignUp => '注册';

  @override
  String get productionAccessRollReset => '重置密码';

  @override
  String get productionAccessRollNewPassword => '新密码';

  @override
  String get authHeadlineSignIn => '每个场景';

  @override
  String get authHeadlineSignInItalic => '都需要阵容。';

  @override
  String get authSubheadSignIn => '登录以继续创作、保存作品并管理你的胶卷。';

  @override
  String get authHeadlineSignUp => '加入';

  @override
  String get authHeadlineSignUpItalic => '制片组。';

  @override
  String get authSubheadSignUp => '创建账号以保存胶卷、跟踪每日镜头数，随时回来继续拍摄。';

  @override
  String get authHeadlineForgot => '弄丢了';

  @override
  String get authHeadlineForgotItalic => '底片？';

  @override
  String get authSubheadForgot => '输入你的邮箱，我们将发送密码重置链接。';

  @override
  String get authHeadlineReset => '重新';

  @override
  String get authHeadlineResetItalic => '剪辑。';

  @override
  String get authSubheadReset => '设置新密码，回到你的创意空间。';

  @override
  String get inputEmail => '邮箱';

  @override
  String get inputEmailHint => 'you@example.com';

  @override
  String get inputPassword => '密码';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => '至少 8 个字符';

  @override
  String get inputFullName => '显示名称';

  @override
  String get inputFullNameHint => '这条胶卷的导演';

  @override
  String get inputConfirmPassword => '确认密码';

  @override
  String get inputConfirmPasswordHint => '再次输入密码';

  @override
  String get inputResetCode => '重置码';

  @override
  String get inputResetCodeHint => '粘贴邮件中的代码';

  @override
  String get inputNewPassword => '新密码';

  @override
  String get inputNewPasswordHint => '至少 8 个字符';

  @override
  String get inputNewPasswordConfirmHint => '再次输入新密码';

  @override
  String get inputAvatarUrl => '头像 URL（可选）';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => '全名';

  @override
  String get inputFullNameEditHint => '输入你的全名';

  @override
  String get toggleShowPassword => '显示密码';

  @override
  String get toggleHidePassword => '隐藏密码';

  @override
  String get rememberMe => '记住我';

  @override
  String get forgotPasswordLink => '忘记密码？';

  @override
  String get signInButton => '进入 ROLL ►';

  @override
  String get signUpButton => '开始 ROLL ►';

  @override
  String get forgotButton => '发送链接 ►';

  @override
  String get resetPasswordButton => '修改密码 ►';

  @override
  String get orDivider => '或';

  @override
  String get noAccountPrompt => '还没有账号？';

  @override
  String get noAccountLink => '立即注册';

  @override
  String get hasAccountPrompt => '已有账号？';

  @override
  String get hasAccountLink => '登录';

  @override
  String get forgotRememberedPrompt => '想起来了？';

  @override
  String get forgotRememberedLink => '返回登录';

  @override
  String get resetRememberedPrompt => '想起来了？';

  @override
  String get resetRememberedLink => '返回登录';

  @override
  String get agreeTermsPrefix => '我同意 ';

  @override
  String get agreeTermsLink => '制作条款';

  @override
  String get agreeTermsSemantic => '我同意制作条款';

  @override
  String get forgotDescription => '输入你注册时使用的邮箱。重置码 30 分钟内有效。';

  @override
  String get statsFooter => '你的下一个场景从这里开始';

  @override
  String get errorEmailPasswordRequired => '请输入邮箱和密码。';

  @override
  String get errorAllFieldsRequired => '请填写所有字段。';

  @override
  String get errorPasswordTooShort => '密码至少 8 个字符。';

  @override
  String get errorPasswordMismatch => '两次输入的密码不一致。';

  @override
  String get errorAcceptTerms => '请同意制作条款。';

  @override
  String get errorEmailRequired => '请输入邮箱。';

  @override
  String get errorResetCodeRequired => '重置码必填且密码至少 8 个字符。';

  @override
  String get errorGeneric => '无法连接到服务器。';

  @override
  String get errorInvalidEmail => '请输入有效的电子邮件地址。';

  @override
  String get errorInvalidAvatarUrl => '头像 URL 必须以 http:// 或 https:// 开头。';

  @override
  String get errorSignInFailed => '邮箱或密码错误。';

  @override
  String get errorSignUpFailed => '注册失败。';

  @override
  String get errorForgotFailed => '无法生成重置链接。';

  @override
  String get errorResetFailed => '无法重置密码。';

  @override
  String get errorFullNameRequired => '请输入你的姓名。';

  @override
  String get successSignUp => '注册成功！请登录。';

  @override
  String get successResetPassword => '密码修改成功。';

  @override
  String get successForgotEmail => '如果邮箱存在，链接已发送。';

  @override
  String get successProfileSaved => '个人资料已更新！';

  @override
  String get successPasswordChanged => '密码已修改！请重新登录。';

  @override
  String successProfileLoadFailed(Object message) {
    return '无法加载个人资料：$message';
  }

  @override
  String get explore => '探索';

  @override
  String get gallery => '画廊';

  @override
  String get faq => '常见问题';

  @override
  String get pricing => '价格';

  @override
  String get loginPrompt => '请先登录再生成图片。';

  @override
  String get emptyPrompt => '请在按下 Action 之前输入提示词。';

  @override
  String get imageOnlySupported => 'REEL 目前仅支持 text-to-image。请选择 Photo。';

  @override
  String get imageGenerationFailed => '无法生成图片，请检查后端和模型。';

  @override
  String get noImageReturned => '模型未返回图片。';

  @override
  String get videoDurationLabel => '时长';

  @override
  String get videoQualityLabel => '画质';

  @override
  String get videoQueuedMessage => '视频正在渲染中——需要几分钟时间。完成后将显示在这里。';

  @override
  String get videoGenerationFailed => '视频生成失败。您的积分已退还。';

  @override
  String get videoTimeoutMessage => '视频所需时间超出预期。请稍后在个人资料的“我的胶卷”中查看。';

  @override
  String get videoReadyLabel => '您的视频已完成';

  @override
  String get usageLabelSignedOut => '登录开始使用';

  @override
  String get rtlToggleTooltip => '切换 LTR / RTL 布局方向';

  @override
  String get footerTagline => 'REEL — 在黑暗中开发，一帧一帧地打造。把一行文字变成一个镜头。';

  @override
  String get productColumn => '产品';

  @override
  String get supportColumn => '支持';

  @override
  String get signInLink => '登录';

  @override
  String get signUpLink => '注册';

  @override
  String get footerCaption1 => 'REEL — 在黑暗中开发。一帧一帧。';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => '输入场景。';

  @override
  String get getTheTake => '获取镜头。';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead => '把一行文字变成一个镜å¤´——几秒内完成取景、布光与运动。视频或静图，同一条胶卷。';

  @override
  String get homeStatLastTake => '上一镜头';

  @override
  String get homeStatAspectRatios => '画幅比例';

  @override
  String get homeStatFilmStocks => '电影质感';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => '描述你的场æ™¯…';

  @override
  String get homeQuickChips => '水晶灯下的化装舞会 | 沙暴中的骑士 | 木偶工坊';

  @override
  String get homeStock => '胶片';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => '正在生æˆ…';

  @override
  String get homeGenerate => '生成';

  @override
  String homeGenerationSuccess(Object ratio) {
    return '镜头完成 · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => '无法加载结果图片。';

  @override
  String get homeGenerationOpenOriginal => '打开原图';

  @override
  String get homeGenerationRegenerate => '重新生成';

  @override
  String get homeGenerationOpenFailed => '无法打开原图。';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => '一行文字，一个完整的场景。';

  @override
  String get showcaseSubtitle => '看 REEL 如何一步步把描述变成真实的画面。';

  @override
  String get showcasePrompt1 => '\"宇航员在火星红色沙丘上冲浪，黄金时刻，广角镜头\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 => '\"水晶吊灯下的化装舞会，缓慢的镜头运动\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 => '\"黄昏沙暴中骑马奔驰的骑士，跟踪镜头\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => '四个工具，一个镜头';

  @override
  String get featuresSubtitle => '从一行文字到一个完整画面所需的一切。';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body => '从数百万真实画面中学习的光线、运镜与电影语法。';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body => '16:9 宽屏、1:1 信息流、9:16 故äº‹——无需重新剪辑。';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic、Documentary、Studio、Animated——按 Generate 前先选质感。';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body => '同一个提示词、同一个工作室。立刻出图；视频准备好再出。';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => '常见问题';

  @override
  String get faqSubtitle => '还有问题？给 REEL 团队留言即可。';

  @override
  String get faqQ1 => 'REEL 如何工作？';

  @override
  String get faqA1 => '输入一段描述，选择画幅比例和胶片质感。REEL 据此生成图像。视频功能开发中。';

  @override
  String get faqQ2 => 'REEL 与其他 AI 视频工具有何不同？';

  @override
  String get faqA2 => 'REEL 专注于电影语è¨€——光线、构图、胶片质æ„Ÿ——在一个工作室中。';

  @override
  String get faqQ3 => '免费有多少镜头？';

  @override
  String get faqA3 => '登录后工作室会显示当前配额和剩余积分。查看套餐了解权益。';

  @override
  String get faqQ4 => '支持哪些格式与分辨率？';

  @override
  String get faqA4 => '图片支持 16:9、1:1、9:16。输出尺寸取决于当前配置。';

  @override
  String get faqQ5 => '可以将结果用于商业用途吗？';

  @override
  String get faqA5 => '商用前请查阅制作条款与所选套餐的权益。';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => '选择你的拍摄节奏';

  @override
  String get plansSubtitle => '免费起步，当胶卷需要跑得更久时再升级。';

  @override
  String get ctaReady => '准备好你的';

  @override
  String get ctaReadyItalic => '第一个镜头？';

  @override
  String get ctaBody => '免费、无需信用å¡——一分钟内完成第一帧。';

  @override
  String get ctaFreeButton => '创建免费账号';

  @override
  String get ctaGalleryButton => '查看画廊';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => '最新画面';

  @override
  String get contactSheetSubtitle => 'REEL 社区刚刚剪辑完的几个场景。';

  @override
  String get contactSheetDialogTitle => '视觉风格预览。';

  @override
  String get contactSheetDialogBody => '在工作室里生成你自己的镜头。';

  @override
  String get contactSheetClose => '关闭';

  @override
  String get pricingTitle => '价格';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => '选择你的拍摄节奏';

  @override
  String get pricingSubheading => '免费起步，当胶卷需要跑得更久时再升级。';

  @override
  String get pricingEmpty => '暂无在售套餐。';

  @override
  String get pricingBuyButton => '购买套餐';

  @override
  String get pricingFreeCta => '免费使用';

  @override
  String get pricingSignInFirst => '购买前请先登录。';

  @override
  String get pricingLoadFailed => '无法加载套餐列表。';

  @override
  String get pricingStripeOpenFailed => '无法打开 Stripe 页面。';

  @override
  String get pricingStripeOpened => '已打开 Stripe Checkout。支付成功后积分会自动到账。';

  @override
  String get pricingCreditsSuffix => ' 积分';

  @override
  String get pricingCreditsPerMonth => '每月积分';

  @override
  String get pricingPeriodMonthly => '/月';

  @override
  String get pricingPeriodYearly => '/年';

  @override
  String get pricingFreePerk => '注册即送 25 积分——放心试用工作室。';

  @override
  String get profileTitle => '我的资料';

  @override
  String profileLoadFailed(Object message) {
    return '无法加载资料：$message';
  }

  @override
  String get profileNotLoaded => '无法加载资料信息';

  @override
  String get profileEditButton => '编辑资料';

  @override
  String get profileChangePasswordButton => '修改密码';

  @override
  String get profileUsageSection => '用量与积分';

  @override
  String get profileCreditBalance => '积分余额';

  @override
  String get profileDailyUsage => '今日用量';

  @override
  String get profileAccountSection => '账号信息';

  @override
  String get profileUserId => '用户 ID';

  @override
  String get profileStatus => '状态';

  @override
  String get profileStatusActive => '活跃';

  @override
  String get profileStatusInactive => '未活跃';

  @override
  String get profileMemberSince => '注册于';

  @override
  String get profileUnknownName => '未知';

  @override
  String get profileUnknownEmail => '无邮箱';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => '编辑资料';

  @override
  String get editProfileSubhead => '更新你的个人资料';

  @override
  String get editProfileSave => '保存修改';

  @override
  String editProfileLoadFailed(Object message) {
    return '无法加载资料：$message';
  }

  @override
  String get editProfileSaveFailed => '无法更新资料';

  @override
  String get changePasswordTitle => '修改密码';

  @override
  String get changePasswordSubhead => '输入当前密码并设置新密码';

  @override
  String get changePasswordCurrent => '当前密码';

  @override
  String get changePasswordNew => '新密码';

  @override
  String get changePasswordConfirm => '确认新密码';

  @override
  String get changePasswordCurrentRequired => '请输入当前密码';

  @override
  String get changePasswordNewRequired => '请输入新密码';

  @override
  String get changePasswordTooShort => '密码至少 8 个字符';

  @override
  String get changePasswordConfirmRequired => '请确认新密码';

  @override
  String get changePasswordMismatch => '两次密码不一致';

  @override
  String get changePasswordSubmit => '修改密码';

  @override
  String get changePasswordFailed => '无法修改密码';

  @override
  String get libraryTitle => '画廊';

  @override
  String get libraryTabGenerations => '生成记录';

  @override
  String get libraryTabCredits => '积分';

  @override
  String get libraryTabPayments => '支付';

  @override
  String get libraryReload => '刷新';

  @override
  String get librarySignInPrompt => '登录后查看画廊';

  @override
  String get libraryRetry => '重试';

  @override
  String get libraryLoadFailed => '无法加载你的画廊。';

  @override
  String get libraryEmptyGenerations => '你还没有生成任何图像。';

  @override
  String get libraryEmptyCredits => '暂无积分流水。';

  @override
  String get libraryEmptyPayments => '暂无支付。';

  @override
  String get libraryDeleteDialogTitle => '删除生成？';

  @override
  String get libraryDeleteDialogBody => '确定删除这条生成吗？该操作不可撤销。';

  @override
  String get libraryDeleteCancel => '取消';

  @override
  String get libraryDeleteConfirm => '删除';

  @override
  String get libraryDeleteSuccess => '生成已删除';

  @override
  String get libraryDeleteFailed => '删除失败';

  @override
  String get libraryStatusCompleted => '已完成';

  @override
  String get libraryStatusFailed => '失败';

  @override
  String get libraryStatusProcessing => '处理中';

  @override
  String get libraryStatusPending => '等待中';

  @override
  String get paymentResultSuccess => '支付成功';

  @override
  String get paymentResultCancel => '支付已取消';

  @override
  String get paymentResultError => '支付失败';

  @override
  String get paymentResultSuccessMsg => '支付已处理完成，积分已加入你的账号。';

  @override
  String get paymentResultCancelMsg => '你取消了支付，没有发生扣款。';

  @override
  String get paymentResultErrorMsg => '处理支付时出错，请重试或联系支持。';

  @override
  String get paymentResultLoadFailed => '无法加载支付信息';

  @override
  String get paymentDetailPackage => '套餐';

  @override
  String get paymentDetailCredits => '积分';

  @override
  String get paymentDetailAmount => '金额';

  @override
  String get paymentDetailTransaction => '交易号';

  @override
  String get paymentBackHome => '返回首页';

  @override
  String get paymentTryAgain => '重试';

  @override
  String get termsEyebrow => '法律声明';

  @override
  String get termsHeadline => '服务条款';

  @override
  String get termsSubhead => '最后更新：2026/09/10 · 适用于整个 REEL 服务';

  @override
  String get termsBackShort => '返回';

  @override
  String get termsBackLong => '返回首页';

  @override
  String get termsFooterText => 'REEL — 在黑暗中开发。一次一帧。';

  @override
  String get termsAccept => '我同意';

  @override
  String get termsDecline => '返回';

  @override
  String get adminDashboardTitle => '管理员后台';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => '概览';

  @override
  String get adminSidebarGenerations => '生成记录';

  @override
  String get adminSidebarUsers => '用户';

  @override
  String get adminSidebarPayments => '支付';

  @override
  String get adminSidebarSettings => '设置';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => '管理员';

  @override
  String get adminFallbackRole => '管理员';

  @override
  String get adminMenuTooltip => '打开菜单';

  @override
  String get adminRtlTooltip => '切换 LTR / RTL 布局';

  @override
  String get adminRefreshTooltip => '刷新';

  @override
  String get adminSearchUsersHint => '搜索用户…';

  @override
  String get adminExportTooltip => '导出报表';

  @override
  String get adminExportLabel => '导出';

  @override
  String get adminExportComingSoon => '报表导出功能即将上线。';

  @override
  String get adminNotificationsTooltip => '通知';

  @override
  String get adminRangeLabel => '范围';

  @override
  String get adminRangeToday => '今天';

  @override
  String get adminRange7Days => '7 天';

  @override
  String get adminRange30Days => '30 天';

  @override
  String get adminRangeTodayLong => '今天';

  @override
  String get adminRange7DaysLong => '近 7 天';

  @override
  String get adminRange30DaysLong => '近 30 天';

  @override
  String get adminAutoUpdateNote => '每日 00:00 自动更新';

  @override
  String adminKpiTakes(Object range) {
    return '镜头 $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return '活跃用户 — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return '收入 — $range';
  }

  @override
  String get adminKpiQueue => '渲染队列';

  @override
  String get adminDailyOutputTitle => '近 7 天产量';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return '本周 $ratio16x9 占 58%，其次 1:1（24%）和 9:16（18%）。';
  }

  @override
  String get adminStockMixTitle => '风格占比';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => '最近渲染';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => '用户';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => '打开列表';

  @override
  String get adminFleetTitle => '队列与 GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter => '3/5 工作中 · 1 维护 · 1 空闲';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return '处理中 — $prompt';
  }

  @override
  String get adminFleetJobIdle => '空闲 — 等待下一个任务';

  @override
  String get adminFleetJobMaintenance => '计划维护';

  @override
  String get adminGenerationCompleted => '已完成';

  @override
  String get adminGenerationProcessing => '渲染中';

  @override
  String get adminGenerationFailed => '失败';

  @override
  String get adminUserStatusActive => '活跃';

  @override
  String get adminUserStatusInactive => '未活跃';

  @override
  String get adminUserStatusBanned => '已封禁';

  @override
  String get adminUserRoleAdmin => '管理员';

  @override
  String get adminUserRoleUser => '用户';

  @override
  String get adminSettingsTitle => '设置';

  @override
  String get adminSettingsStudioName => '工作室显示名';

  @override
  String get adminSettingsSupportEmail => '支持邮箱';

  @override
  String get adminSettingsImageCost => '每张图像积分';

  @override
  String get adminSettingsVideoCost => '每个视频积分';

  @override
  String get adminSettingsAlerts => '通知';

  @override
  String get adminSettingsAlertPayment => '支付失败时通知';

  @override
  String get adminSettingsAlertGeneration => '生成失败时通知';

  @override
  String get adminSettingsNewsletter => '发送订阅邮件';

  @override
  String get adminSettingsMaintenance => '维护模式';

  @override
  String get adminSettingsRegistration => '允许新注册';

  @override
  String get adminSettingsSave => '保存修改';

  @override
  String get adminSettingsLoadFailed => '无法加载设置。';

  @override
  String get adminSettingsSaved => '设置已保存。';

  @override
  String get adminSettingsSaveFailed => '无法保存设置。';

  @override
  String get adminPackagesTitle => '付费套餐';

  @override
  String get adminPackagesEmpty => '暂无套餐。';

  @override
  String get adminPackagesLoadFailed => '无法加载付费套餐。';

  @override
  String get adminPackagesNew => '新建套餐';

  @override
  String get adminPackagesFeatured => '推荐';

  @override
  String get adminPackagesInactive => '未启用';

  @override
  String get adminPackagesActive => '启用';

  @override
  String get adminPaymentsTitle => '支付';

  @override
  String get adminPaymentsEmpty => '暂无支付。';

  @override
  String get adminPaymentsLoadFailed => '无法加载支付。';

  @override
  String get adminPaymentsFilterAll => '全部';

  @override
  String get adminCreditsTitle => '积分流水';

  @override
  String get adminCreditsEmpty => '暂无积分流水。';

  @override
  String get adminCreditsLoadFailed => '无法加载积分流水。';

  @override
  String get adminUsersTitle => '用户';

  @override
  String get adminUsersEmpty => '未找到用户。';

  @override
  String get adminUsersLoadFailed => '无法加载用户。';

  @override
  String get adminUsersSearch => '按邮箱或姓名搜索';

  @override
  String get adminUsersRefresh => '刷新';

  @override
  String get adminUsersReset => '重置';

  @override
  String get commonRetry => '重试';

  @override
  String get commonCancel => '取消';

  @override
  String get commonDelete => '删除';

  @override
  String get commonSave => '保存';

  @override
  String get commonClose => '关闭';

  @override
  String get termsTocLabel => '目录';

  @override
  String get termsNoteBox =>
      '这是示例条款内容的 UI/UX 模型。在正式发布前,REEL 应请法律顾问审阅文本以确保符合现行法律。';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => '支持邮箱';

  @override
  String get termsContactButton => '联系支持';

  @override
  String get termsS01Title => '条款接受';

  @override
  String get termsS01P1 =>
      '创建账户或使用 REEL 的任何功能(图生成、视频生成、充值 credit、套餐升级),即表示您同意以下条款。如不同意,请停止使用本服务。';

  @override
  String get termsS01P2 => 'REEL 面向 13 岁及以上用户。18 岁以下用户需获得父母或法定监护人的同意。';

  @override
  String get termsS02Title => '账户';

  @override
  String get termsS02P1 => '每个账户对应一个唯一的电子邮件地址。您有责任妥善保管密码,并对账户下发生的所有活动负责。';

  @override
  String get termsS02B1 => '注册信息(姓名、邮箱)必须准确并保持最新。';

  @override
  String get termsS02B2 => 'REEL 可能需要在激活某些功能前进行邮箱验证。';

  @override
  String get termsS02B3 => '账户可能处于 active、inactive 或 banned 状态,取决于使用记录和违规情况。';

  @override
  String get termsS03Title => 'Credit 与 AI 生成';

  @override
  String get termsS03P1 =>
      'REEL 通过 credit 机制运行。每一次图片或视频生成(称为一次 \"take\")都会根据类型、分辨率与时长从您的钱包中扣除相应的 credit。';

  @override
  String get termsS03B1 => 'Credit 在生成请求开始处理时扣除。';

  @override
  String get termsS03B2 => '若生成因系统错误失败,相应的 credit 将自动退还。';

  @override
  String get termsS03B3 => '若请求因违反条款而失败(见第 6 节),REEL 不退还 credit。';

  @override
  String get termsS03B4 => '月度/年度套餐未使用的 credit 不会结转到下一周期,除非另有说明。';

  @override
  String get termsS04Title => '付款与退款';

  @override
  String get termsS04P1 =>
      'REEL 接受通过 Momo、ZaloPay、VNPay、银行转账和 Stripe(用于国际套餐)进行付款。每笔交易均会记录独立的 ID 以便追溯。';

  @override
  String get termsS04B1 => '月度/年度套餐会自动续费,除非您在下一个周期前取消。';

  @override
  String get termsS04B2 => '退款申请将在付款后 7 天内审核,前提是该套餐的 credit 未被使用。';

  @override
  String get termsS04B3 => '一次性 credit 充值在 credit 到账后不可退款。';

  @override
  String get termsS05Title => '内容所有权';

  @override
  String get termsS05P1 => '您在 REEL 上创建的内容的使用权归您所有,以您当前的套餐为限。';

  @override
  String get termsS05B1 => 'Free 套餐:输出带有 REEL 水印,仅供个人非商业用途。';

  @override
  String get termsS05B2 => 'Pro 套餐:输出无水印,可用于商业用途。';

  @override
  String get termsS05B3 => 'REEL 不保证 AI 输出内容具有原创性;商业使用前的核实责任由您承担。';

  @override
  String get termsS06Title => '禁止行为';

  @override
  String get termsS06P1 => '您不得使用 REEL 创建或分发以下内容:';

  @override
  String get termsS06B1 => '违反现行法律、煽动暴力、歧视或仇恨言论。';

  @override
  String get termsS06B2 => '色情或以任何形式涉及未成年人。';

  @override
  String get termsS06B3 => '冒充他人、侵犯隐私或未经许可使用他人肖像。';

  @override
  String get termsS06B4 => '侵犯第三方版权、商标或其他知识产权。';

  @override
  String get termsS06P2 => '违规可能导致账户被封禁且不另行通知,已支付的 credit 或费用不予退还。';

  @override
  String get termsS07Title => '责任限制';

  @override
  String get termsS07P1 => '本服务按 \"现状\" 提供。REEL 不保证服务不会中断或无错误,也不保证结果始终满足您的期望。';

  @override
  String get termsS07P2 => '在法律允许的最大范围内,REEL 不对因使用或无法使用本服务而产生的间接损害承担责任。';

  @override
  String get termsS08Title => '账户终止';

  @override
  String get termsS08P1 =>
      '您可随时停止使用本服务并请求删除账户。REEL 可根据违规严重程度,暂停(inactive)或永久封禁(banned)违规账户。';

  @override
  String get termsS09Title => '条款变更';

  @override
  String get termsS09P1 => 'REEL 可能随时更新这些条款。重要变更将通过电子邮件或首页横幅提前至少 7 天通知。';

  @override
  String get termsS10Title => '联系';

  @override
  String get termsS10P1 => '如对这些条款有任何疑问,请联系 REEL 团队。';

  @override
  String get errorPasswordRequired => '请输入密码。';

  @override
  String get errorConfirmPasswordRequired => '请确认密码。';

  @override
  String get backToHomeLabel => '首页';

  @override
  String get backToHomeTooltip => '返回首页';

  @override
  String get profileBackHome => '返回首页';

  @override
  String get profileNavOverview => '总览';

  @override
  String get profileNavMyRoll => '我的胶卷';

  @override
  String get profileNavSettings => '设置';

  @override
  String get profileNavBilling => '套餐与账单';

  @override
  String get profileLogout => '退出登录';

  @override
  String profileWelcomeBack(String name) {
    return '欢迎回来，$name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return '这是您今天的胶卷。';
  }

  @override
  String get profileStatTotalTakes => '总拍摄次数';

  @override
  String get profileStatFavoriteStock => '常用胶片';

  @override
  String get profileStatDaysLabel => '使用 REEL 天数';

  @override
  String profileStatDaysValue(int n) {
    return '$n 天';
  }

  @override
  String get profileUpgradePro => '升级到 Pro';

  @override
  String get profileRecentActivity => '最近活动';

  @override
  String get profileViewAll => '查看全部 →';

  @override
  String get profileMyRollSub => '您在 REEL 上生成的所有内容。';

  @override
  String get profileFilterAll => '全部';

  @override
  String get profileFilterVideo => '视频';

  @override
  String get profileFilterPhoto => '照片';

  @override
  String get profilePhotoTag => '照片';

  @override
  String get profileMyRollEmpty => '还没有拍摄记录——去工作室生成您的第一帧吧。';

  @override
  String get profileTimeJustNow => '刚刚';

  @override
  String profileTimeMinutesAgo(int n) {
    return '$n 分钟前';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return '$n 小时前';
  }

  @override
  String get profileTimeYesterday => '昨天';

  @override
  String profileTimeDaysAgo(int n) {
    return '$n 天前';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return '$n 周前';
  }

  @override
  String get profileSettingsSub => '更新您的个人资料信息和默认偏好设置。';

  @override
  String get profileSectionProfileInfo => '个人资料信息';

  @override
  String get profileFieldDisplayName => '显示名称';

  @override
  String get profileFieldEmail => '邮箱';

  @override
  String get profileSaveChanges => '保存更改';

  @override
  String get profileSectionPassword => '修改密码';

  @override
  String get profileFieldCurrentPassword => '当前密码';

  @override
  String get profileFieldNewPassword => '新密码';

  @override
  String get profileFieldConfirmPassword => '确认新密码';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => '至少 8 个字符';

  @override
  String get profilePwConfirmPlaceholder => '再次输入';

  @override
  String get profileUpdatePassword => '更新密码';

  @override
  String get profilePwShow => '显示';

  @override
  String get profilePwHide => '隐藏';

  @override
  String get profileSectionPrefs => '默认偏好';

  @override
  String get profilePrefRatio => '默认宽高比';

  @override
  String get profilePrefRatioDesc => '每次打开生成器时都会应用';

  @override
  String get profilePrefStock => '默认胶片';

  @override
  String get profilePrefStockDesc => '画面的初始风格';

  @override
  String get profileDangerTitle => '危险区域';

  @override
  String get profileDangerDesc => '删除账户将移除您的整个胶卷，且无法撤销。';

  @override
  String get profileDeleteAccount => '删除账户';

  @override
  String get profileDeleteNotice => '账户删除由 REEL 团队处理——请联系客服申请。';

  @override
  String get profileBillingSub => '管理您的套餐和支付方式。';

  @override
  String get profileCurrentPlan => '当前套餐';

  @override
  String get profilePlanPerMonth => '/ 月';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '注册送 10 积分';

  @override
  String get profilePlanFreeF2 => 'REEL 水印';

  @override
  String get profilePlanProF1 => '按需充值积分包';

  @override
  String get profilePlanProF2 => '4K，无水印';

  @override
  String get profileCurrentTag => '使用中';

  @override
  String get profileUpgradeShort => '升级';

  @override
  String get profilePaymentHistory => '付款记录';

  @override
  String get profileEmptyPayments => '还没有交易记录——升级到 Pro 即可开始。';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => '个人资料信息已更新！';

  @override
  String get profilePasswordUpdated => '密码已更新！';

  @override
  String get profileProChip => 'PRO 套餐';

  @override
  String get profileFreeChip => '免费套餐';

  @override
  String get adminSidebarModeration => '内容审核';

  @override
  String get adminSidebarRevenue => '收入';

  @override
  String get adminSidebarSystem => '系统';

  @override
  String get adminRoleChip => '管理员';

  @override
  String usageCreditsLabel(int balance) {
    return '可用积分 $balance';
  }

  @override
  String get homeStatCreditsLeft => '剩余积分';

  @override
  String get profileStatCredits => '积分';

  @override
  String profileCreditsAvailable(int balance) {
    return '可用积分 $balance';
  }

  @override
  String get profileTopUp => '充值';

  @override
  String get profilePlanPayAsYouGo => '/ 按张付费';

  @override
  String profileUsageSpentToday(int spent) {
    return '今日已用 $spent 积分';
  }

  @override
  String get profileTopUpHint => '充值积分以继续生成。';

  @override
  String get avatarUpdated => '头像已更新';

  @override
  String get avatarUpdateFailed => '头像上传失败，请重试。';

  @override
  String get avatarChangeHint => '更换头像';

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

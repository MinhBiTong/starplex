// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'REEL — AI 映画・写真スタジオ';

  @override
  String get languageLabel => '言語';

  @override
  String get languagePickerTooltip => 'インターフェース言語を選択';

  @override
  String get signIn => 'ログイン';

  @override
  String get signUp => '新規登録';

  @override
  String get getStarted => '始める';

  @override
  String get forgot => '忘れた';

  @override
  String get resetPassword => 'パスワード再設定';

  @override
  String get newPassword => '新しいパスワード';

  @override
  String get credentialsBadge => '認証情報';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · アクセス $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'ログイン';

  @override
  String get productionAccessRollSignUp => '新規登録';

  @override
  String get productionAccessRollReset => 'パスワード再設定';

  @override
  String get productionAccessRollNewPassword => '新しいパスワード';

  @override
  String get authHeadlineSignIn => 'すべてのシーンには';

  @override
  String get authHeadlineSignInItalic => 'キャストが必要。';

  @override
  String get authSubheadSignIn => 'ログインして制作を続け、作品を保存し、ロールを管理しましょう。';

  @override
  String get authHeadlineSignUp => 'プロダクションに';

  @override
  String get authHeadlineSignUpItalic => '参加しよう。';

  @override
  String get authSubheadSignUp =>
      'アカウントを作成してロールを保存し、毎日のテイク数を追跡。インスピレーションが来たらいつでも戻れます。';

  @override
  String get authHeadlineForgot => 'ネガを';

  @override
  String get authHeadlineForgotItalic => 'なくした？';

  @override
  String get authSubheadForgot => 'メールアドレスを入力してください。リセットリンクをお送りします。';

  @override
  String get authHeadlineReset => '新しい';

  @override
  String get authHeadlineResetItalic => 'カットを。';

  @override
  String get authSubheadReset => '新しいパスワードを作成して、創作空間へ戻りましょう。';

  @override
  String get inputEmail => 'メール';

  @override
  String get inputEmailHint => 'you@example.com';

  @override
  String get inputPassword => 'パスワード';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => '8文字以上';

  @override
  String get inputFullName => '表示名';

  @override
  String get inputFullNameHint => 'このロールの監督';

  @override
  String get inputConfirmPassword => 'パスワード確認';

  @override
  String get inputConfirmPasswordHint => 'パスワードを再入力';

  @override
  String get inputResetCode => 'リセットコード';

  @override
  String get inputResetCodeHint => 'メールからコードを貼り付け';

  @override
  String get inputNewPassword => '新しいパスワード';

  @override
  String get inputNewPasswordHint => '8文字以上';

  @override
  String get inputNewPasswordConfirmHint => '新しいパスワードを再入力';

  @override
  String get inputAvatarUrl => 'アバターURL（任意）';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => '氏名';

  @override
  String get inputFullNameEditHint => '氏名を入力';

  @override
  String get toggleShowPassword => 'パスワードを表示';

  @override
  String get toggleHidePassword => 'パスワードを隠す';

  @override
  String get rememberMe => 'ログイン状態を保持';

  @override
  String get forgotPasswordLink => 'パスワードをお忘れですか？';

  @override
  String get signInButton => 'ロールに入る ►';

  @override
  String get signUpButton => 'ロールを始める ►';

  @override
  String get forgotButton => 'リンクを送信 ►';

  @override
  String get resetPasswordButton => 'パスワード変更 ►';

  @override
  String get orDivider => 'または';

  @override
  String get noAccountPrompt => 'アカウントがありませんか？ ';

  @override
  String get noAccountLink => '今すぐ登録';

  @override
  String get hasAccountPrompt => 'すでにアカウントをお持ちですか？ ';

  @override
  String get hasAccountLink => 'ログイン';

  @override
  String get forgotRememberedPrompt => 'パスワードを思い出しましたか？ ';

  @override
  String get forgotRememberedLink => 'ログインに戻る';

  @override
  String get resetRememberedPrompt => 'パスワードを思い出しましたか？ ';

  @override
  String get resetRememberedLink => 'ログインに戻る';

  @override
  String get agreeTermsPrefix => '私は ';

  @override
  String get agreeTermsLink => '制作規約';

  @override
  String get agreeTermsSemantic => '制作規約に同意します';

  @override
  String get forgotDescription => '登録時のメールアドレスを入力。コードは30分間有効です。';

  @override
  String get statsFooter => 'あなたの次のシーンがここから始まる';

  @override
  String get errorEmailPasswordRequired => 'メールとパスワードを入力してください。';

  @override
  String get errorAllFieldsRequired => 'すべての項目を入力してください。';

  @override
  String get errorPasswordTooShort => 'パスワードは8文字以上必要です。';

  @override
  String get errorPasswordMismatch => 'パスワードが一致しません。';

  @override
  String get errorAcceptTerms => '制作規約に同意してください。';

  @override
  String get errorEmailRequired => 'メールアドレスを入力してください。';

  @override
  String get errorResetCodeRequired => 'コードと8文字以上のパスワードが必要です。';

  @override
  String get errorGeneric => 'サーバーに接続できません。';

  @override
  String get errorInvalidEmail => '有効なメールアドレスを入力してください。';

  @override
  String get errorInvalidAvatarUrl =>
      'アバターの URL は http:// または https:// で始まる必要があります。';

  @override
  String get errorSignInFailed => 'メールまたはパスワードが違います。';

  @override
  String get errorSignUpFailed => '登録に失敗しました。';

  @override
  String get errorForgotFailed => 'リセットリンクを作成できませんでした。';

  @override
  String get errorResetFailed => 'パスワードを再設定できませんでした。';

  @override
  String get errorFullNameRequired => '氏名を入力してください。';

  @override
  String get successSignUp => '登録完了！ログインしてください。';

  @override
  String get successResetPassword => 'パスワードを変更しました。';

  @override
  String get successForgotEmail => 'メールが存在する場合、リンクを送信しました。';

  @override
  String get successProfileSaved => 'プロフィールを更新しました！';

  @override
  String get successPasswordChanged => 'パスワードを変更しました！再ログインしてください。';

  @override
  String successProfileLoadFailed(Object message) {
    return 'プロフィールを読み込めませんでした：$message';
  }

  @override
  String get explore => '探索';

  @override
  String get gallery => 'ギャラリー';

  @override
  String get faq => 'よくある質問';

  @override
  String get pricing => '料金';

  @override
  String get loginPrompt => '画像生成の前にログインしてください。';

  @override
  String get emptyPrompt => 'Actionを押す前にプロンプトを入力してください。';

  @override
  String get imageOnlySupported =>
      'REELは現在text-to-imageのみ対応しています。Photoを選択してください。';

  @override
  String get imageGenerationFailed => '画像を生成できませんでした。バックエンドとモデルを確認してください。';

  @override
  String get noImageReturned => 'モデルから画像が返されませんでした。';

  @override
  String get videoDurationLabel => '長さ';

  @override
  String get videoQualityLabel => '画質';

  @override
  String get videoQueuedMessage => '動画をレンダリングしています。数分かかります。完成するとここに表示されます。';

  @override
  String get videoGenerationFailed => '動画の生成に失敗しました。クレジットは返金されました。';

  @override
  String get videoTimeoutMessage =>
      '動画に予想より時間がかかっています。少し後にプロフィールの「マイロール」を確認してください。';

  @override
  String get videoReadyLabel => '動画が完成しました';

  @override
  String get usageLabelSignedOut => 'ログインして開始';

  @override
  String get rtlToggleTooltip => 'LTR / RTL レイアウト切替';

  @override
  String get footerTagline => 'REEL — 暗闇で開発、1フレームずつ。テキストを1行、シーンに変える。';

  @override
  String get productColumn => '製品';

  @override
  String get supportColumn => 'サポート';

  @override
  String get signInLink => 'ログイン';

  @override
  String get signUpLink => '登録';

  @override
  String get footerCaption1 => 'REEL — 暗闇で開発。1フレームずつ。';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'シーンを入力。';

  @override
  String get getTheTake => 'テイクを取得。';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead => 'テキスト1行を、数秒で構図・光・動きのあるショットに。映像でも写真でも、1つのロールで。';

  @override
  String get homeStatLastTake => '最後のテイク';

  @override
  String get homeStatAspectRatios => 'アスペクト比';

  @override
  String get homeStatFilmStocks => 'フィルム';

  @override
  String homeMetaProduction(Object format) {
    return 'PRODUCTION  REEL   ·   SCENE  01 — $format   ·   ROLL  A';
  }

  @override
  String get homeSceneFieldHint => 'シーンを説æ˜Ž…';

  @override
  String get homeQuickChips => 'シャンデリア下の仮面舞踏会 | 砂嵐の中の騎士 | マリオネット工房';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'テイクを生成ä¸­…';

  @override
  String get homeGenerate => '生成';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'テイク完了 · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => '結果画像を読み込めませんでした。';

  @override
  String get homeGenerationOpenOriginal => '原画を開く';

  @override
  String get homeGenerationRegenerate => '再生成';

  @override
  String get homeGenerationOpenFailed => '原画を開けませんでした。';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => '1行のテキスト。1つの完成したシーン。';

  @override
  String get showcaseSubtitle => 'REELが説明を本物のフレームに変える手順をご覧ください。';

  @override
  String get showcasePrompt1 => '\"火星の赤い砂丘でサーフィンする宇宙飛行士、ゴールデンアワー、ワイドショット\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 => '\"シャンデリア下の仮面舞踏会、ゆっくりしたカメラムーブ\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 => '\"夕暮れの砂嵐の中を馬で駆ける騎士、トラッキングショット\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => '4つのツール、1つのショット';

  @override
  String get featuresSubtitle => 'テキスト1行から完成したフレームまで、必要なすべて。';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body => '数百万の実写から学んだ光、カメラワーク、映画文法。';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body => '16:9 ワイド、1:1 フィード、9:16 ストーリー。最初から作り直す必要なし。';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic、Documentary、Studio、Animated — Generate前に質感を選択。';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body => '同じプロンプト、同じスタジオ。今すぐ画像、準備できたら映像。';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'よくある質問';

  @override
  String get faqSubtitle => '他にご質問があれば、REELチームへどうぞ。';

  @override
  String get faqQ1 => 'REELはどのように動作しますか？';

  @override
  String get faqA1 => '説明を入力し、比率とフィルムを選択。REELが画像を生成します。映像は開発中です。';

  @override
  String get faqQ2 => 'REELは他のAI動画ツールと何が違う？';

  @override
  String get faqA2 => 'REELは光、構図、フィルム感という映画言語に焦点を当てた1つのスタジオです。';

  @override
  String get faqQ3 => '無料テイクはいくつもらえますか？';

  @override
  String get faqA3 => 'ログイン後のスタジオに現在のクォータと残クレジットが表示されます。';

  @override
  String get faqQ4 => '対応フォーマットと解像度は？';

  @override
  String get faqA4 => '画像は16:9、1:1、9:16対応。出力サイズは設定に依存します。';

  @override
  String get faqQ5 => '商用利用できますか？';

  @override
  String get faqA5 => '商用利用前に制作規約とプランの特典を確認してください。';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => '撮影リズムを選ぼう';

  @override
  String get plansSubtitle => '無料で始め、ロールが長くなる時にアップグレード。';

  @override
  String get ctaReady => 'あなたの';

  @override
  String get ctaReadyItalic => '最初のテイクへ。';

  @override
  String get ctaBody => '無料、クレカ不要 — 1分以内に最初のフレーム。';

  @override
  String get ctaFreeButton => '無料アカウントを作成';

  @override
  String get ctaGalleryButton => 'ギャラリーを見る';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => '最新のフレーム';

  @override
  String get contactSheetSubtitle => 'REELコミュニティが仕上げたシーンをいくつか。';

  @override
  String get contactSheetDialogTitle => 'ビジュアルスタイルのプレビュー。';

  @override
  String get contactSheetDialogBody => 'スタジオで自分のテイクを生成。';

  @override
  String get contactSheetClose => '閉じる';

  @override
  String get pricingTitle => '料金';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => '撮影リズムを選ぼう';

  @override
  String get pricingSubheading => '無料で始めて、ロールを長く回したくなったらアップグレード。';

  @override
  String get pricingEmpty => '現在、有効なパッケージはありません。';

  @override
  String get pricingBuyButton => 'パッケージを購入';

  @override
  String get pricingFreeCta => '無料で使う';

  @override
  String get pricingSignInFirst => '購入前にログインしてください。';

  @override
  String get pricingLoadFailed => 'パッケージを読み込めませんでした。';

  @override
  String get pricingStripeOpenFailed => 'Stripeページを開けませんでした。';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkoutを開きました。支払い完了後、クレジットが自動加算されます。';

  @override
  String get pricingCreditsSuffix => ' クレジット';

  @override
  String get pricingCreditsPerMonth => '毎月のクレジット';

  @override
  String get pricingPeriodMonthly => '/月';

  @override
  String get pricingPeriodYearly => '/年';

  @override
  String get pricingFreePerk => '登録時に25クレジットをプレゼント。気軽にスタジオを試しましょう。';

  @override
  String get profileTitle => 'マイプロフィール';

  @override
  String profileLoadFailed(Object message) {
    return 'プロフィールを読み込めませんでした：$message';
  }

  @override
  String get profileNotLoaded => 'プロフィール情報を読み込めません';

  @override
  String get profileEditButton => 'プロフィール編集';

  @override
  String get profileChangePasswordButton => 'パスワード変更';

  @override
  String get profileUsageSection => '使用状況とクレジット';

  @override
  String get profileCreditBalance => 'クレジット残高';

  @override
  String get profileDailyUsage => '本日の使用';

  @override
  String get profileAccountSection => 'アカウント情報';

  @override
  String get profileUserId => 'ユーザーID';

  @override
  String get profileStatus => 'ステータス';

  @override
  String get profileStatusActive => '有効';

  @override
  String get profileStatusInactive => '無効';

  @override
  String get profileMemberSince => '登録日';

  @override
  String get profileUnknownName => '不明';

  @override
  String get profileUnknownEmail => 'メールなし';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'プロフィール編集';

  @override
  String get editProfileSubhead => 'プロフィール情報を更新';

  @override
  String get editProfileSave => '変更を保存';

  @override
  String editProfileLoadFailed(Object message) {
    return 'プロフィールを読み込めませんでした：$message';
  }

  @override
  String get editProfileSaveFailed => 'プロフィールを更新できませんでした';

  @override
  String get changePasswordTitle => 'パスワード変更';

  @override
  String get changePasswordSubhead => '現在のパスワードを入力し、新しいパスワードを設定';

  @override
  String get changePasswordCurrent => '現在のパスワード';

  @override
  String get changePasswordNew => '新しいパスワード';

  @override
  String get changePasswordConfirm => '新しいパスワードを確認';

  @override
  String get changePasswordCurrentRequired => '現在のパスワードを入力';

  @override
  String get changePasswordNewRequired => '新しいパスワードを入力';

  @override
  String get changePasswordTooShort => 'パスワードは8文字以上';

  @override
  String get changePasswordConfirmRequired => '新しいパスワードを確認';

  @override
  String get changePasswordMismatch => 'パスワードが一致しません';

  @override
  String get changePasswordSubmit => 'パスワード変更';

  @override
  String get changePasswordFailed => 'パスワードを変更できませんでした';

  @override
  String get libraryTitle => 'ライブラリ';

  @override
  String get libraryTabGenerations => '生成';

  @override
  String get libraryTabCredits => 'クレジット';

  @override
  String get libraryTabPayments => '支払い';

  @override
  String get libraryReload => '再読み込み';

  @override
  String get librarySignInPrompt => 'ログインしてライブラリを表示';

  @override
  String get libraryRetry => '再試行';

  @override
  String get libraryLoadFailed => 'ライブラリを読み込めませんでした。';

  @override
  String get libraryEmptyGenerations => 'まだ画像を生成していません。';

  @override
  String get libraryEmptyCredits => 'クレジット履歴なし。';

  @override
  String get libraryEmptyPayments => '支払いなし。';

  @override
  String get libraryDeleteDialogTitle => '生成を削除しますか？';

  @override
  String get libraryDeleteDialogBody => 'この生成を削除しますか？元に戻せません。';

  @override
  String get libraryDeleteCancel => 'キャンセル';

  @override
  String get libraryDeleteConfirm => '削除';

  @override
  String get libraryDeleteSuccess => '生成を削除しました';

  @override
  String get libraryDeleteFailed => '削除できませんでした';

  @override
  String get libraryStatusCompleted => '完了';

  @override
  String get libraryStatusFailed => '失敗';

  @override
  String get libraryStatusProcessing => '処理中';

  @override
  String get libraryStatusPending => '待機中';

  @override
  String get paymentResultSuccess => '支払い完了';

  @override
  String get paymentResultCancel => '支払いキャンセル';

  @override
  String get paymentResultError => '支払い失敗';

  @override
  String get paymentResultSuccessMsg => '支払いが処理され、クレジットがアカウントに加算されました。';

  @override
  String get paymentResultCancelMsg => '支払いをキャンセルしました。請求はありません。';

  @override
  String get paymentResultErrorMsg => '支払い処理中にエラーが発生。再試行するかサポートまでご連絡ください。';

  @override
  String get paymentResultLoadFailed => '支払い情報を読み込めませんでした';

  @override
  String get paymentDetailPackage => 'パッケージ';

  @override
  String get paymentDetailCredits => 'クレジット';

  @override
  String get paymentDetailAmount => '金額';

  @override
  String get paymentDetailTransaction => '取引';

  @override
  String get paymentBackHome => 'ホームへ戻る';

  @override
  String get paymentTryAgain => '再試行';

  @override
  String get termsEyebrow => '法的事項';

  @override
  String get termsHeadline => '利用規約';

  @override
  String get termsSubhead => '最終更新:2026/09/10 · REEL サービス全体に適用されます';

  @override
  String get termsBackShort => '戻る';

  @override
  String get termsBackLong => 'ホームへ';

  @override
  String get termsFooterText => 'REEL — 暗闇で開発。一フレームずつ。';

  @override
  String get termsAccept => '同意します';

  @override
  String get termsDecline => '戻る';

  @override
  String get adminDashboardTitle => '管理ダッシュボード';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => '概要';

  @override
  String get adminSidebarGenerations => '生成';

  @override
  String get adminSidebarUsers => 'ユーザー';

  @override
  String get adminSidebarPayments => '支払い';

  @override
  String get adminSidebarSettings => '設定';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => '管理者';

  @override
  String get adminMenuTooltip => 'メニューを開く';

  @override
  String get adminRtlTooltip => 'LTR / RTL 切替';

  @override
  String get adminRefreshTooltip => '更新';

  @override
  String get adminSearchUsersHint => 'ユーザーを検索…';

  @override
  String get adminExportTooltip => 'レポートをエクスポート';

  @override
  String get adminExportLabel => 'エクスポート';

  @override
  String get adminExportComingSoon => 'レポートのエクスポートは近日公開予定です。';

  @override
  String get adminNotificationsTooltip => '通知';

  @override
  String get adminRangeLabel => '期間';

  @override
  String get adminRangeToday => '今日';

  @override
  String get adminRange7Days => '7日間';

  @override
  String get adminRange30Days => '30日間';

  @override
  String get adminRangeTodayLong => '今日';

  @override
  String get adminRange7DaysLong => '過去7日間';

  @override
  String get adminRange30DaysLong => '過去30日間';

  @override
  String get adminAutoUpdateNote => '毎日 00:00 に自動更新';

  @override
  String adminKpiTakes(Object range) {
    return 'テイク $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'アクティブユーザー — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return '売上 — $range';
  }

  @override
  String get adminKpiQueue => 'レンダーキュー';

  @override
  String get adminDailyOutputTitle => '7日間の出力';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return '今週は$ratio16x9が58%、続いて1:1（24%）、9:16（18%）。';
  }

  @override
  String get adminStockMixTitle => 'スタイル比率';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => '最近のレンダー';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'ユーザー';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => '一覧を開く';

  @override
  String get adminFleetTitle => 'キューとGPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter => '3/5 稼働中 · 1 メンテナンス · 1 アイドル';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return '処理中 — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'アイドル — 次のジョブ待ち';

  @override
  String get adminFleetJobMaintenance => '定期メンテナンス';

  @override
  String get adminGenerationCompleted => '完了';

  @override
  String get adminGenerationProcessing => 'レンダリング中';

  @override
  String get adminGenerationFailed => '失敗';

  @override
  String get adminUserStatusActive => '有効';

  @override
  String get adminUserStatusInactive => '無効';

  @override
  String get adminUserStatusBanned => '禁止';

  @override
  String get adminUserRoleAdmin => '管理者';

  @override
  String get adminUserRoleUser => 'ユーザー';

  @override
  String get adminSettingsTitle => '設定';

  @override
  String get adminSettingsStudioName => 'スタジオ表示名';

  @override
  String get adminSettingsSupportEmail => 'サポートメール';

  @override
  String get adminSettingsImageCost => '画像ごとのクレジット';

  @override
  String get adminSettingsVideoCost => '動画ごとのクレジット';

  @override
  String get adminSettingsAlerts => '通知';

  @override
  String get adminSettingsAlertPayment => '支払い失敗時に通知';

  @override
  String get adminSettingsAlertGeneration => '生成失敗時に通知';

  @override
  String get adminSettingsNewsletter => 'ニュースレターを送信';

  @override
  String get adminSettingsMaintenance => 'メンテナンスモード';

  @override
  String get adminSettingsRegistration => '新規登録を許可';

  @override
  String get adminSettingsSave => '変更を保存';

  @override
  String get adminSettingsLoadFailed => '設定を読み込めませんでした。';

  @override
  String get adminSettingsSaved => '設定を保存しました。';

  @override
  String get adminSettingsSaveFailed => '設定を保存できませんでした。';

  @override
  String get adminPackagesTitle => '支払いパッケージ';

  @override
  String get adminPackagesEmpty => 'パッケージなし。';

  @override
  String get adminPackagesLoadFailed => 'パッケージを読み込めませんでした。';

  @override
  String get adminPackagesNew => '新規パッケージ';

  @override
  String get adminPackagesFeatured => 'おすすめ';

  @override
  String get adminPackagesInactive => '無効';

  @override
  String get adminPackagesActive => '有効';

  @override
  String get adminPaymentsTitle => '支払い';

  @override
  String get adminPaymentsEmpty => '支払いなし。';

  @override
  String get adminPaymentsLoadFailed => '支払いを読み込めませんでした。';

  @override
  String get adminPaymentsFilterAll => 'すべて';

  @override
  String get adminCreditsTitle => 'クレジット履歴';

  @override
  String get adminCreditsEmpty => '履歴なし。';

  @override
  String get adminCreditsLoadFailed => 'クレジット履歴を読み込めませんでした。';

  @override
  String get adminUsersTitle => 'ユーザー';

  @override
  String get adminUsersEmpty => 'ユーザーが見つかりません。';

  @override
  String get adminUsersLoadFailed => 'ユーザーを読み込めませんでした。';

  @override
  String get adminUsersSearch => 'メールまたは名前で検索';

  @override
  String get adminUsersRefresh => '更新';

  @override
  String get adminUsersReset => 'リセット';

  @override
  String get commonRetry => '再試行';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonDelete => '削除';

  @override
  String get commonSave => '保存';

  @override
  String get commonClose => '閉じる';

  @override
  String get termsTocLabel => '目次';

  @override
  String get termsNoteBox =>
      'これは利用規約サンプルの UI/UX モックアップです。正式公開前に、REEL は法務レビューを受けることを推奨します。';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'サポートメール';

  @override
  String get termsContactButton => 'サポートに連絡';

  @override
  String get termsS01Title => '規約の承諾';

  @override
  String get termsS01P1 =>
      'アカウントを作成するか、REEL のいずれかの機能(画像生成、動画生成、クレジットチャージ、プランアップグレード)を利用することで、以下の規約に同意したものとみなされます。同意されない場合は、本サービスのご利用をお控えください。';

  @override
  String get termsS01P2 =>
      'REEL は 13 歳以上の方を対象としています。18 歳未満の方は保護者または法定後見人の同意が必要です。';

  @override
  String get termsS02Title => 'アカウント';

  @override
  String get termsS02P1 =>
      '各アカウントは一意のメールアドレスに紐づけられます。パスワードの管理とアカウント上でのすべての活動については、ご自身の責任となります。';

  @override
  String get termsS02B1 => '登録情報(氏名・メール)は正確かつ最新の状態に保ってください。';

  @override
  String get termsS02B2 => 'REEL は特定の機能を有効化する前にメール認証を要求する場合があります。';

  @override
  String get termsS02B3 =>
      'アカウントは利用履歴と違反状況に応じて active、inactive、banned のいずれかになります。';

  @override
  String get termsS03Title => 'クレジット & AI 生成';

  @override
  String get termsS03P1 =>
      'REEL はクレジット制で運営されています。画像・動画生成のたびに(これを \"take\" と呼びます)、種類・解像度・時間に応じてクレジットがウォレットから差し引かれます。';

  @override
  String get termsS03B1 => 'クレジットは生成リクエストの処理開始時に差し引かれます。';

  @override
  String get termsS03B2 => 'システムエラーで生成が失敗した場合、クレジットは自動的に返金されます。';

  @override
  String get termsS03B3 => '規約違反によりリクエストが失敗した場合(第 6 節参照)、REEL はクレジットを返金しません。';

  @override
  String get termsS03B4 => '月間/年間プランの未使用クレジットは、特記事項がない限り次サイクルに繰越されません。';

  @override
  String get termsS04Title => '支払い & 返金';

  @override
  String get termsS04P1 =>
      'REEL は Momo、ZaloPay、VNPay、銀行振込、Stripe(国際プラン向け)での支払いを受け付けています。各取引には追跡用の固有 ID が付与されます。';

  @override
  String get termsS04B1 => '月間/年間プランは、次サイクルまでにキャンセルしない限り自動更新されます。';

  @override
  String get termsS04B2 =>
      '返金リクエストは、プランのクレジットが使用されていないことを条件に、支払日から 7 日以内に審査されます。';

  @override
  String get termsS04B3 => '一回きりのクレジットチャージは、ウォレットへの反映後は返金対象外です。';

  @override
  String get termsS05Title => 'コンテンツ権利';

  @override
  String get termsS05P1 => 'REEL で作成したコンテンツの利用権は、現プランの範囲内においてあなたに保持されます。';

  @override
  String get termsS05B1 => 'Free プラン:出力には REEL の透かしが入り、個人利用・非商用に限ります。';

  @override
  String get termsS05B2 => 'Pro プラン:出力に透かしはなく、商用利用が可能です。';

  @override
  String get termsS05B3 => 'REEL は AI 出力の独創性を保証しません。商用利用前の確認はご自身の責任で行ってください。';

  @override
  String get termsS06Title => '禁止行為';

  @override
  String get termsS06P1 => 'REEL を以下のコンテンツの作成・配布に使用しないでください:';

  @override
  String get termsS06B1 => '現行法に違反する、暴力・差別・憎悪扇動にあたるコンテンツ。';

  @override
  String get termsS06B2 => 'ポルノ、またはいかなる形でも未成年者に関わるコンテンツ。';

  @override
  String get termsS06B3 => '他人のなりすまし、プライバシーの侵害、無断での肖像利用。';

  @override
  String get termsS06B4 => '第三者の著作権・商標・その他知的財産権の侵害。';

  @override
  String get termsS06P2 => '違反した場合、事前通知なくアカウントが凍結(banned)され、クレジット・料金の返金はありません。';

  @override
  String get termsS07Title => '責任の制限';

  @override
  String get termsS07P1 =>
      '本サービスは「現状有姿」で提供されます。REEL は中断しないこと、エラーがないこと、結果が常に期待を満たすことを保証しません。';

  @override
  String get termsS07P2 =>
      '法が許容する最大限の範囲で、REEL は本サービスの利用または利用不能に起因する間接的損害について責任を負いません。';

  @override
  String get termsS08Title => 'アカウントの解約';

  @override
  String get termsS08P1 =>
      'いつでもサービス利用を停止し、アカウント削除をリクエストできます。REEL は違反の重大性を考慮の上、規約違反アカウントを停止(inactive)または永久ロック(banned)する場合があります。';

  @override
  String get termsS09Title => '規約の変更';

  @override
  String get termsS09P1 =>
      'REEL は本規約を随時更新する場合があります。重要な変更は発効の少なくとも 7 日前までにメールまたはホームページのバナーで通知します。';

  @override
  String get termsS10Title => 'お問い合わせ';

  @override
  String get termsS10P1 => '本規約に関するご質問は、REEL チームまでお問い合わせください。';

  @override
  String get errorPasswordRequired => 'パスワードを入力してください。';

  @override
  String get errorConfirmPasswordRequired => 'パスワードを確認してください。';

  @override
  String get backToHomeLabel => 'ホーム';

  @override
  String get backToHomeTooltip => 'ホームへ戻る';

  @override
  String get profileBackHome => 'ホームに戻る';

  @override
  String get profileNavOverview => '概要';

  @override
  String get profileNavMyRoll => 'マイロール';

  @override
  String get profileNavSettings => '設定';

  @override
  String get profileNavBilling => 'プランと請求';

  @override
  String get profileLogout => 'ログアウト';

  @override
  String profileWelcomeBack(String name) {
    return 'おかえりなさい、$name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return '今日のロールです。';
  }

  @override
  String get profileStatTotalTakes => '合計テイク数';

  @override
  String get profileStatFavoriteStock => 'お気に入りのフィルム';

  @override
  String get profileStatDaysLabel => 'REEL利用日数';

  @override
  String profileStatDaysValue(int n) {
    return '$n日';
  }

  @override
  String get profileUpgradePro => 'Proにアップグレード';

  @override
  String get profileRecentActivity => '最近のアクティビティ';

  @override
  String get profileViewAll => 'すべて表示 →';

  @override
  String get profileMyRollSub => 'REELで生成したすべての作品。';

  @override
  String get profileFilterAll => 'すべて';

  @override
  String get profileFilterVideo => '動画';

  @override
  String get profileFilterPhoto => '写真';

  @override
  String get profilePhotoTag => '写真';

  @override
  String get profileMyRollEmpty => 'まだテイクはありません。スタジオで最初の1枚を生成しましょう。';

  @override
  String get profileTimeJustNow => 'たった今';

  @override
  String profileTimeMinutesAgo(int n) {
    return '$n分前';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return '$n時間前';
  }

  @override
  String get profileTimeYesterday => '昨日';

  @override
  String profileTimeDaysAgo(int n) {
    return '$n日前';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return '$n週間前';
  }

  @override
  String get profileSettingsSub => 'プロフィール情報とデフォルト設定を更新します。';

  @override
  String get profileSectionProfileInfo => 'プロフィール情報';

  @override
  String get profileFieldDisplayName => '表示名';

  @override
  String get profileFieldEmail => 'メールアドレス';

  @override
  String get profileSaveChanges => '変更を保存';

  @override
  String get profileSectionPassword => 'パスワードを変更';

  @override
  String get profileFieldCurrentPassword => '現在のパスワード';

  @override
  String get profileFieldNewPassword => '新しいパスワード';

  @override
  String get profileFieldConfirmPassword => '新しいパスワード（確認）';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => '8文字以上';

  @override
  String get profilePwConfirmPlaceholder => 'もう一度入力';

  @override
  String get profileUpdatePassword => 'パスワードを更新';

  @override
  String get profilePwShow => '表示';

  @override
  String get profilePwHide => '非表示';

  @override
  String get profileSectionPrefs => 'デフォルト設定';

  @override
  String get profilePrefRatio => 'デフォルトのアスペクト比';

  @override
  String get profilePrefRatioDesc => 'ジェネレーターを開くたびに適用されます';

  @override
  String get profilePrefStock => 'デフォルトのフィルム';

  @override
  String get profilePrefStockDesc => 'フレームの初期ルック';

  @override
  String get profileDangerTitle => '危険な操作';

  @override
  String get profileDangerDesc => 'アカウントを削除するとロール全体が削除されます。この操作は元に戻せません。';

  @override
  String get profileDeleteAccount => 'アカウントを削除';

  @override
  String get profileDeleteNotice => 'アカウントの削除はREELチームが対応します。サポートにお問い合わせください。';

  @override
  String get profileBillingSub => 'プランと支払い方法を管理します。';

  @override
  String get profileCurrentPlan => '現在のプラン';

  @override
  String get profilePlanPerMonth => '/ 月';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '登録時に10クレジット';

  @override
  String get profilePlanFreeF2 => 'REELの透かし';

  @override
  String get profilePlanProF1 => 'クレジットパックをチャージ';

  @override
  String get profilePlanProF2 => '4K・透かしなし';

  @override
  String get profileCurrentTag => '使用中';

  @override
  String get profileUpgradeShort => 'アップグレード';

  @override
  String get profilePaymentHistory => '支払い履歴';

  @override
  String get profileEmptyPayments => 'まだ取引はありません。Proにアップグレードして始めましょう。';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'プロフィール情報を更新しました！';

  @override
  String get profilePasswordUpdated => 'パスワードを更新しました！';

  @override
  String get profileProChip => 'PROプラン';

  @override
  String get profileFreeChip => '無料プラン';

  @override
  String get adminSidebarModeration => 'モデレーション';

  @override
  String get adminSidebarRevenue => '売上';

  @override
  String get adminSidebarSystem => 'システム';

  @override
  String get adminRoleChip => '管理者';

  @override
  String usageCreditsLabel(int balance) {
    return '利用可能クレジット $balance';
  }

  @override
  String get homeStatCreditsLeft => '残りクレジット';

  @override
  String get profileStatCredits => 'クレジット';

  @override
  String profileCreditsAvailable(int balance) {
    return '利用可能クレジット $balance';
  }

  @override
  String get profileTopUp => 'チャージ';

  @override
  String get profilePlanPayAsYouGo => '/ 1枚ごとに支払い';

  @override
  String profileUsageSpentToday(int spent) {
    return '本日$spentクレジット使用';
  }

  @override
  String get profileTopUpHint => 'チャージして生成を続けましょう。';

  @override
  String get avatarUpdated => 'アバターを更新しました';

  @override
  String get avatarUpdateFailed => 'アバターをアップロードできませんでした。もう一度お試しください。';

  @override
  String get avatarChangeHint => 'プロフィール画像を変更';

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

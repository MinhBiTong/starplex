// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'REEL — Estúdio de Cinema e Foto com IA';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get languagePickerTooltip => 'Escolher idioma da interface';

  @override
  String get signIn => 'ENTRAR';

  @override
  String get signUp => 'REGISTAR';

  @override
  String get getStarted => 'Começar';

  @override
  String get forgot => 'ESQUECI';

  @override
  String get resetPassword => 'REDEFINIR SENHA';

  @override
  String get newPassword => 'NOVA SENHA';

  @override
  String get credentialsBadge => 'CREDENCIAIS';

  @override
  String productionAccessRoll(Object mode) {
    return 'PRODUCTION REEL · ACESSO $mode · ROLL A';
  }

  @override
  String get productionAccessRollSignIn => 'ENTRAR';

  @override
  String get productionAccessRollSignUp => 'REGISTAR';

  @override
  String get productionAccessRollReset => 'REDEFINIR SENHA';

  @override
  String get productionAccessRollNewPassword => 'NOVA SENHA';

  @override
  String get authHeadlineSignIn => 'Cada cena';

  @override
  String get authHeadlineSignInItalic => 'precisa de elenco.';

  @override
  String get authSubheadSignIn =>
      'Entre para continuar a criar, guardar obras e gerir o seu roll.';

  @override
  String get authHeadlineSignUp => 'Junte-se à';

  @override
  String get authHeadlineSignUpItalic => 'produção.';

  @override
  String get authSubheadSignUp =>
      'Crie uma conta para guardar rolls, acompanhar as tomas diárias e voltar quando a inspiração chegar.';

  @override
  String get authHeadlineForgot => 'Perdeu o';

  @override
  String get authHeadlineForgotItalic => 'negativo?';

  @override
  String get authSubheadForgot =>
      'Insira o seu email e enviaremos um link para redefinir a senha.';

  @override
  String get authHeadlineReset => 'Faça um';

  @override
  String get authHeadlineResetItalic => 'novo corte.';

  @override
  String get authSubheadReset =>
      'Crie uma nova senha para voltar ao seu espaço criativo.';

  @override
  String get inputEmail => 'EMAIL';

  @override
  String get inputEmailHint => 'voce@example.com';

  @override
  String get inputPassword => 'SENHA';

  @override
  String get inputPasswordHint => '**********';

  @override
  String get inputPasswordShort => 'Mínimo 8 caracteres';

  @override
  String get inputFullName => 'NOME DE EXIBIÇÃO';

  @override
  String get inputFullNameHint => 'Diretor deste roll';

  @override
  String get inputConfirmPassword => 'CONFIRMAR SENHA';

  @override
  String get inputConfirmPasswordHint => 'Digite a senha novamente';

  @override
  String get inputResetCode => 'CÓDIGO DE REDEFINIÇÃO';

  @override
  String get inputResetCodeHint => 'Cole o código do email';

  @override
  String get inputNewPassword => 'NOVA SENHA';

  @override
  String get inputNewPasswordHint => 'Mínimo 8 caracteres';

  @override
  String get inputNewPasswordConfirmHint => 'Digite a nova senha novamente';

  @override
  String get inputAvatarUrl => 'URL DO AVATAR (OPCIONAL)';

  @override
  String get inputAvatarUrlHint => 'https://example.com/avatar.jpg';

  @override
  String get inputFullNameEdit => 'Nome completo';

  @override
  String get inputFullNameEditHint => 'Digite seu nome completo';

  @override
  String get toggleShowPassword => 'Mostrar senha';

  @override
  String get toggleHidePassword => 'Ocultar senha';

  @override
  String get rememberMe => 'Lembrar-me';

  @override
  String get forgotPasswordLink => 'Esqueceu a senha?';

  @override
  String get signInButton => 'ENTRAR NO ROLL ►';

  @override
  String get signUpButton => 'COMEÇAR ROLL ►';

  @override
  String get forgotButton => 'ENVIAR LINK ►';

  @override
  String get resetPasswordButton => 'ALTERAR SENHA ►';

  @override
  String get orDivider => 'OU';

  @override
  String get noAccountPrompt => 'Ainda não tem conta? ';

  @override
  String get noAccountLink => 'Registe-se';

  @override
  String get hasAccountPrompt => 'Já tem conta? ';

  @override
  String get hasAccountLink => 'Entrar';

  @override
  String get forgotRememberedPrompt => 'Lembrou a senha? ';

  @override
  String get forgotRememberedLink => 'Voltar ao login';

  @override
  String get resetRememberedPrompt => 'Lembrou a senha? ';

  @override
  String get resetRememberedLink => 'Voltar ao login';

  @override
  String get agreeTermsPrefix => 'Concordo com os ';

  @override
  String get agreeTermsLink => 'Termos de Produção';

  @override
  String get agreeTermsSemantic => 'Concordo com os Termos de Produção';

  @override
  String get forgotDescription =>
      'Insira o email usado no registo. O código é válido por 30 minutos.';

  @override
  String get statsFooter => 'A SUA PRÓXIMA CENA COMEÇA AQUI';

  @override
  String get errorEmailPasswordRequired => 'Insira email e senha.';

  @override
  String get errorAllFieldsRequired => 'Preencha todos os campos.';

  @override
  String get errorPasswordTooShort =>
      'A senha deve ter pelo menos 8 caracteres.';

  @override
  String get errorPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get errorAcceptTerms => 'Aceite os Termos de Produção.';

  @override
  String get errorEmailRequired => 'Insira o seu email.';

  @override
  String get errorResetCodeRequired =>
      'O código é obrigatório e a senha deve ter pelo menos 8 caracteres.';

  @override
  String get errorGeneric => 'Não foi possível conectar ao servidor.';

  @override
  String get errorInvalidEmail => 'Insere um endereço de email válido.';

  @override
  String get errorInvalidAvatarUrl =>
      'O URL do avatar tem de começar com http:// ou https://.';

  @override
  String get errorSignInFailed => 'Email ou senha incorretos.';

  @override
  String get errorSignUpFailed => 'Falha no registo.';

  @override
  String get errorForgotFailed => 'Não foi possível gerar o link.';

  @override
  String get errorResetFailed => 'Não foi possível redefinir a senha.';

  @override
  String get errorFullNameRequired => 'Insira o seu nome.';

  @override
  String get successSignUp => 'Registo concluído! Entre.';

  @override
  String get successResetPassword => 'Senha alterada com sucesso.';

  @override
  String get successForgotEmail => 'Se o email existir, o link foi enviado.';

  @override
  String get successProfileSaved => 'Perfil atualizado!';

  @override
  String get successPasswordChanged => 'Senha alterada! Entre novamente.';

  @override
  String successProfileLoadFailed(Object message) {
    return 'Não foi possível carregar o perfil: $message';
  }

  @override
  String get explore => 'Explorar';

  @override
  String get gallery => 'Galeria';

  @override
  String get faq => 'FAQ';

  @override
  String get pricing => 'Preços';

  @override
  String get loginPrompt => 'Entre antes de gerar uma imagem.';

  @override
  String get emptyPrompt => 'Insira um prompt antes de premir Action.';

  @override
  String get imageOnlySupported =>
      'REEL só suporta text-to-image de momento. Escolha Photo.';

  @override
  String get imageGenerationFailed =>
      'Não foi possível gerar a imagem. Verifique o backend e o modelo.';

  @override
  String get noImageReturned => 'O modelo não devolveu uma imagem.';

  @override
  String get videoDurationLabel => 'DURAÇÃO';

  @override
  String get videoQualityLabel => 'QUALIDADE';

  @override
  String get videoQueuedMessage =>
      'O vídeo está sendo renderizado — leva alguns minutos. O resultado aparecerá aqui.';

  @override
  String get videoGenerationFailed =>
      'Falha na geração do vídeo. Seus créditos foram reembolsados.';

  @override
  String get videoTimeoutMessage =>
      'O vídeo está demorando mais que o esperado. Confira em breve o Meu roll no seu perfil.';

  @override
  String get videoReadyLabel => 'Seu vídeo está pronto';

  @override
  String get usageLabelSignedOut => 'Entre para começar';

  @override
  String get rtlToggleTooltip => 'Alternar direção LTR / RTL';

  @override
  String get footerTagline =>
      'REEL — desenvolvido no escuro, fotograma a fotograma. Transforme uma linha de texto numa cena.';

  @override
  String get productColumn => 'PRODUTO';

  @override
  String get supportColumn => 'SUPORTE';

  @override
  String get signInLink => 'Entrar';

  @override
  String get signUpLink => 'Registar';

  @override
  String get footerCaption1 =>
      'REEL — DESENVOLVIDO NO ESCURO. UM FOTOGRAMA DE CADA VEZ.';

  @override
  String get footerCaption2 => '© 2026 REEL STUDIO';

  @override
  String get typeAScene => 'Escreva uma cena.';

  @override
  String get getTheTake => 'Obtenha a toma.';

  @override
  String get homeEyebrow => 'AI FILM & PHOTO STUDIO';

  @override
  String get homeSubhead =>
      'Transforme uma linha de texto numa cena — emoldurada, iluminada e em movimento em segundos. Vídeo ou foto, um só roll.';

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
  String get homeSceneFieldHint => 'Descreva a sua cena…';

  @override
  String get homeQuickChips =>
      'Baile de máscaras sob lustres | Cavaleiro em tempestade de areia | Oficina de marionetas';

  @override
  String get homeStock => 'STOCK';

  @override
  String get homeStockOptions => 'Cinematic | Documentary | Studio | Animated';

  @override
  String get homeFormat => 'Video | Photo';

  @override
  String get homeRatio => '16:9 | 1:1 | 9:16';

  @override
  String get homeGenerating => 'A criar toma…';

  @override
  String get homeGenerate => 'Gerar';

  @override
  String homeGenerationSuccess(Object ratio) {
    return 'Toma concluída · $ratio';
  }

  @override
  String get homeGenerationErrorLoad => 'Não foi possível carregar a imagem.';

  @override
  String get homeGenerationOpenOriginal => 'Abrir original';

  @override
  String get homeGenerationRegenerate => 'Regenerar';

  @override
  String get homeGenerationOpenFailed => 'Não foi possível abrir o original.';

  @override
  String get showcaseEyebrow => 'FROM PROMPT TO TAKE';

  @override
  String get showcaseTitle => 'Uma linha de texto. Uma cena completa.';

  @override
  String get showcaseSubtitle =>
      'Veja o REEL transformar uma descrição num fotograma real, passo a passo.';

  @override
  String get showcasePrompt1 =>
      '\"astronauta a surfar nas dunas vermelhas de Marte, hora dourada, plano amplo\"';

  @override
  String get showcaseMeta1 => 'Cinematic · 16:9';

  @override
  String get showcasePrompt2 =>
      '\"baile de máscaras sob lustres, movimento lento de câmara\"';

  @override
  String get showcaseMeta2 => 'Cinematic · 9:16';

  @override
  String get showcasePrompt3 =>
      '\"cavaleiro a cavalo em tempestade de areia ao crepúsculo, plano de seguimento\"';

  @override
  String get showcaseMeta3 => 'Documentary · 16:9';

  @override
  String get featuresEyebrow => 'ONE ROLL, EVERY FORMAT';

  @override
  String get featuresTitle => 'Quatro ferramentas, uma só cena';

  @override
  String get featuresSubtitle =>
      'Tudo o que precisa para ir de uma linha de texto a um fotograma completo.';

  @override
  String get feature1Title => 'Cinematic engine';

  @override
  String get feature1Body =>
      'Luz, movimento de câmara e gramática cinematográfica aprendida com milhões de fotogramas reais.';

  @override
  String get feature2Title => 'Any frame, any ratio';

  @override
  String get feature2Body =>
      '16:9 ecrã panorâmico, 1:1 feed, 9:16 story — sem refazer do zero.';

  @override
  String get feature3Title => 'Four film stocks';

  @override
  String get feature3Body =>
      'Cinematic, Documentary, Studio, Animated — escolha a textura antes de Generate.';

  @override
  String get feature4Title => 'Stills or motion, one flow';

  @override
  String get feature4Body =>
      'O mesmo prompt, o mesmo estúdio. Imagens agora; vídeo quando estiver pronto.';

  @override
  String get faqEyebrow => 'FAQ';

  @override
  String get faqTitle => 'Perguntas frequentes';

  @override
  String get faqSubtitle => 'Mais dúvidas? Fale com a equipa REEL.';

  @override
  String get faqQ1 => 'Como funciona o REEL?';

  @override
  String get faqA1 =>
      'Escreva uma descrição, escolha o formato e o film stock. O REEL gera uma imagem. O vídeo está em desenvolvimento.';

  @override
  String get faqQ2 => 'O que diferencia o REEL de outras ferramentas de IA?';

  @override
  String get faqA2 =>
      'O REEL foca-se na linguagem cinematográfica — luz, enquadramento e film stock — num único estúdio.';

  @override
  String get faqQ3 => 'Quantas tomas grátis tenho?';

  @override
  String get faqA3 =>
      'A sua quota e créditos aparecem no estúdio depois de entrar. Veja os preços para os benefícios.';

  @override
  String get faqQ4 => 'Que formatos e resoluções existem?';

  @override
  String get faqA4 =>
      'As imagens suportam 16:9, 1:1 e 9:16. O tamanho depende da configuração.';

  @override
  String get faqQ5 => 'Posso usar os resultados comercialmente?';

  @override
  String get faqA5 =>
      'Verifique os Termos de Produção e os benefícios do seu plano antes do uso comercial.';

  @override
  String get plansEyebrow => 'PLANS';

  @override
  String get plansTitle => 'Escolha o seu ritmo';

  @override
  String get plansSubtitle =>
      'Comece grátis, suba quando o roll precisar de mais tempo.';

  @override
  String get ctaReady => 'Pronto para a sua';

  @override
  String get ctaReadyItalic => 'primeira toma?';

  @override
  String get ctaBody =>
      'Grátis, sem cartão — primeiro fotograma em menos de um minuto.';

  @override
  String get ctaFreeButton => 'Criar conta grátis';

  @override
  String get ctaGalleryButton => 'Ver galeria';

  @override
  String get contactSheetEyebrow => 'CONTACT SHEET — ROLL A';

  @override
  String get contactSheetTitle => 'Fotogramas recentes';

  @override
  String get contactSheetSubtitle =>
      'Algumas cenas que a comunidade REEL acabou de montar.';

  @override
  String get contactSheetDialogTitle => 'Pré-visualização do estilo.';

  @override
  String get contactSheetDialogBody => 'Gere a sua própria toma no estúdio.';

  @override
  String get contactSheetClose => 'Fechar';

  @override
  String get pricingTitle => 'PREÇOS';

  @override
  String get pricingEyebrow => 'PLANS';

  @override
  String get pricingHeading => 'Escolha o seu ritmo';

  @override
  String get pricingSubheading =>
      'Comece grátis, faça upgrade quando o roll precisar de mais tempo.';

  @override
  String get pricingEmpty => 'Sem pacotes ativos.';

  @override
  String get pricingBuyButton => 'COMPRAR PACOTE';

  @override
  String get pricingFreeCta => 'Usar grátis';

  @override
  String get pricingSignInFirst => 'Entre antes de comprar.';

  @override
  String get pricingLoadFailed => 'Não foi possível carregar pacotes.';

  @override
  String get pricingStripeOpenFailed => 'Não foi possível abrir o Stripe.';

  @override
  String get pricingStripeOpened =>
      'Stripe Checkout aberto. Créditos adicionados após pagamento.';

  @override
  String get pricingCreditsSuffix => ' CRÉDITOS';

  @override
  String get pricingCreditsPerMonth => 'créditos por mês';

  @override
  String get pricingPeriodMonthly => '/mês';

  @override
  String get pricingPeriodYearly => '/ano';

  @override
  String get pricingFreePerk =>
      '25 créditos grátis ao se inscrever — experimente o estúdio sem preocupações.';

  @override
  String get profileTitle => 'MEU PERFIL';

  @override
  String profileLoadFailed(Object message) {
    return 'Não foi possível carregar o perfil: $message';
  }

  @override
  String get profileNotLoaded => 'Não foi possível carregar o perfil';

  @override
  String get profileEditButton => 'EDITAR PERFIL';

  @override
  String get profileChangePasswordButton => 'ALTERAR SENHA';

  @override
  String get profileUsageSection => 'USO E CRÉDITOS';

  @override
  String get profileCreditBalance => 'Saldo de créditos';

  @override
  String get profileDailyUsage => 'Uso diário';

  @override
  String get profileAccountSection => 'INFO DA CONTA';

  @override
  String get profileUserId => 'ID de utilizador';

  @override
  String get profileStatus => 'Estado';

  @override
  String get profileStatusActive => 'Ativo';

  @override
  String get profileStatusInactive => 'Inativo';

  @override
  String get profileMemberSince => 'Membro desde';

  @override
  String get profileUnknownName => 'Desconhecido';

  @override
  String get profileUnknownEmail => 'Sem email';

  @override
  String get profileUnknownInitial => 'U';

  @override
  String get editProfileTitle => 'EDITAR PERFIL';

  @override
  String get editProfileSubhead => 'Atualize as informações do seu perfil';

  @override
  String get editProfileSave => 'GUARDAR';

  @override
  String editProfileLoadFailed(Object message) {
    return 'Não foi possível carregar o perfil: $message';
  }

  @override
  String get editProfileSaveFailed => 'Não foi possível atualizar o perfil';

  @override
  String get changePasswordTitle => 'ALTERAR SENHA';

  @override
  String get changePasswordSubhead => 'Insira a senha atual e escolha uma nova';

  @override
  String get changePasswordCurrent => 'Senha atual';

  @override
  String get changePasswordNew => 'Nova senha';

  @override
  String get changePasswordConfirm => 'Confirme a nova senha';

  @override
  String get changePasswordCurrentRequired => 'Insira a senha atual';

  @override
  String get changePasswordNewRequired => 'Insira uma nova senha';

  @override
  String get changePasswordTooShort =>
      'A senha deve ter pelo menos 8 caracteres';

  @override
  String get changePasswordConfirmRequired => 'Confirme a nova senha';

  @override
  String get changePasswordMismatch => 'As senhas não coincidem';

  @override
  String get changePasswordSubmit => 'ALTERAR SENHA';

  @override
  String get changePasswordFailed => 'Não foi possível alterar a senha';

  @override
  String get libraryTitle => 'Biblioteca';

  @override
  String get libraryTabGenerations => 'GERAÇÕES';

  @override
  String get libraryTabCredits => 'CRÉDITOS';

  @override
  String get libraryTabPayments => 'PAGAMENTOS';

  @override
  String get libraryReload => 'Recarregar';

  @override
  String get librarySignInPrompt => 'ENTRE PARA VER A BIBLIOTECA';

  @override
  String get libraryRetry => 'TENTAR NOVAMENTE';

  @override
  String get libraryLoadFailed => 'Não foi possível carregar a biblioteca.';

  @override
  String get libraryEmptyGenerations => 'Ainda não criou imagens.';

  @override
  String get libraryEmptyCredits => 'Sem movimentos de crédito.';

  @override
  String get libraryEmptyPayments => 'Sem pagamentos.';

  @override
  String get libraryDeleteDialogTitle => 'Apagar geração?';

  @override
  String get libraryDeleteDialogBody =>
      'Tem a certeza? Esta ação não pode ser revertida.';

  @override
  String get libraryDeleteCancel => 'CANCELAR';

  @override
  String get libraryDeleteConfirm => 'APAGAR';

  @override
  String get libraryDeleteSuccess => 'Geração apagada';

  @override
  String get libraryDeleteFailed => 'Não foi possível apagar';

  @override
  String get libraryStatusCompleted => 'Concluída';

  @override
  String get libraryStatusFailed => 'Falhou';

  @override
  String get libraryStatusProcessing => 'Em processamento';

  @override
  String get libraryStatusPending => 'Em espera';

  @override
  String get paymentResultSuccess => 'PAGAMENTO BEM-SUCEDIDO';

  @override
  String get paymentResultCancel => 'PAGAMENTO CANCELADO';

  @override
  String get paymentResultError => 'PAGAMENTO FALHOU';

  @override
  String get paymentResultSuccessMsg =>
      'O pagamento foi processado. Os créditos foram adicionados à sua conta.';

  @override
  String get paymentResultCancelMsg =>
      'Cancelou o pagamento. Nenhum valor foi cobrado.';

  @override
  String get paymentResultErrorMsg =>
      'Ocorreu um erro. Tente novamente ou contacte o suporte.';

  @override
  String get paymentResultLoadFailed =>
      'Não foi possível carregar a info do pagamento';

  @override
  String get paymentDetailPackage => 'Pacote';

  @override
  String get paymentDetailCredits => 'Créditos';

  @override
  String get paymentDetailAmount => 'Valor';

  @override
  String get paymentDetailTransaction => 'Transação';

  @override
  String get paymentBackHome => 'VOLTAR AO INÍCIO';

  @override
  String get paymentTryAgain => 'TENTAR NOVAMENTE';

  @override
  String get termsEyebrow => 'LEGAL';

  @override
  String get termsHeadline => 'Termos de serviço';

  @override
  String get termsSubhead =>
      'Última atualização: 10/09/2026 · Aplica-se a todo o serviço REEL';

  @override
  String get termsBackShort => 'VOLTAR';

  @override
  String get termsBackLong => 'PARA A PÁGINA INICIAL';

  @override
  String get termsFooterText =>
      'REEL — DESENVOLVIDO NO ESCURO. UM FRAME DE CADA VEZ.';

  @override
  String get termsAccept => 'EU CONCORDO';

  @override
  String get termsDecline => 'VOLTAR';

  @override
  String get adminDashboardTitle => 'Painel Admin';

  @override
  String get adminBadge => 'ADMIN';

  @override
  String get adminWorkspaceLabel => 'WORKSPACE';

  @override
  String get adminSidebarOverview => 'Resumo';

  @override
  String get adminSidebarGenerations => 'Gerações';

  @override
  String get adminSidebarUsers => 'Utilizadores';

  @override
  String get adminSidebarPayments => 'Pagamentos';

  @override
  String get adminSidebarSettings => 'Definições';

  @override
  String get adminBreadcrumbRoot => 'REEL STUDIO ADMIN';

  @override
  String get adminDefaultName => 'Admin';

  @override
  String get adminFallbackRole => 'Administrador';

  @override
  String get adminMenuTooltip => 'Abrir menu';

  @override
  String get adminRtlTooltip => 'Alternar LTR / RTL';

  @override
  String get adminRefreshTooltip => 'Atualizar';

  @override
  String get adminSearchUsersHint => 'Pesquisar usuários…';

  @override
  String get adminExportTooltip => 'Exportar relatório';

  @override
  String get adminExportLabel => 'EXPORTAR';

  @override
  String get adminExportComingSoon =>
      'A exportação de relatórios chega em breve.';

  @override
  String get adminNotificationsTooltip => 'Notificações';

  @override
  String get adminRangeLabel => 'Intervalo';

  @override
  String get adminRangeToday => 'Hoje';

  @override
  String get adminRange7Days => '7 dias';

  @override
  String get adminRange30Days => '30 dias';

  @override
  String get adminRangeTodayLong => 'hoje';

  @override
  String get adminRange7DaysLong => 'em 7 dias';

  @override
  String get adminRange30DaysLong => 'em 30 dias';

  @override
  String get adminAutoUpdateNote => 'Atualização diária às 00:00';

  @override
  String adminKpiTakes(Object range) {
    return 'Tomas $range';
  }

  @override
  String adminKpiUsers(Object range) {
    return 'Utilizadores ativos — $range';
  }

  @override
  String adminKpiRevenue(Object range) {
    return 'Receita — $range';
  }

  @override
  String get adminKpiQueue => 'Fila de render';

  @override
  String get adminDailyOutputTitle => 'Saída em 7 dias';

  @override
  String get adminDailyOutputEyebrow => 'DAILY OUTPUT';

  @override
  String adminDailyOutputFooter(Object ratio16x9) {
    return 'O $ratio16x9 representa 58% dos renders da semana, seguido por 1:1 (24%) e 9:16 (18%).';
  }

  @override
  String get adminStockMixTitle => 'Mix por estilo';

  @override
  String get adminStockMixEyebrow => 'FILM STOCK MIX';

  @override
  String get adminRecentTitle => 'Renders recentes';

  @override
  String get adminRecentEyebrow => 'CONTACT SHEET · LIVE';

  @override
  String get adminUsersPanelTitle => 'Utilizadores';

  @override
  String get adminUsersPanelEyebrow => 'ROSTER';

  @override
  String get adminUsersOpenList => 'Abrir lista';

  @override
  String get adminFleetTitle => 'Fila e GPU';

  @override
  String get adminFleetEyebrow => 'RENDER FLEET';

  @override
  String get adminFleetFooter =>
      '3/5 workers ativos · 1 em manutenção · 1 idle';

  @override
  String adminFleetJobProcessing(Object prompt) {
    return 'A processar — $prompt';
  }

  @override
  String get adminFleetJobIdle => 'Idle — à espera do próximo trabalho';

  @override
  String get adminFleetJobMaintenance => 'Manutenção agendada';

  @override
  String get adminGenerationCompleted => 'Concluída';

  @override
  String get adminGenerationProcessing => 'A renderizar';

  @override
  String get adminGenerationFailed => 'Falhou';

  @override
  String get adminUserStatusActive => 'Ativo';

  @override
  String get adminUserStatusInactive => 'Inativo';

  @override
  String get adminUserStatusBanned => 'Banido';

  @override
  String get adminUserRoleAdmin => 'Admin';

  @override
  String get adminUserRoleUser => 'Utilizador';

  @override
  String get adminSettingsTitle => 'Definições';

  @override
  String get adminSettingsStudioName => 'Nome do estúdio';

  @override
  String get adminSettingsSupportEmail => 'Email de suporte';

  @override
  String get adminSettingsImageCost => 'Custo por imagem';

  @override
  String get adminSettingsVideoCost => 'Custo por vídeo';

  @override
  String get adminSettingsAlerts => 'Alertas';

  @override
  String get adminSettingsAlertPayment => 'Alertar pagamentos falhados';

  @override
  String get adminSettingsAlertGeneration => 'Alertar gerações falhadas';

  @override
  String get adminSettingsNewsletter => 'Enviar newsletter';

  @override
  String get adminSettingsMaintenance => 'Modo manutenção';

  @override
  String get adminSettingsRegistration => 'Permitir registos';

  @override
  String get adminSettingsSave => 'GUARDAR';

  @override
  String get adminSettingsLoadFailed => 'Não foi possível carregar definições.';

  @override
  String get adminSettingsSaved => 'Definições guardadas.';

  @override
  String get adminSettingsSaveFailed => 'Não foi possível guardar.';

  @override
  String get adminPackagesTitle => 'Pacotes de pagamento';

  @override
  String get adminPackagesEmpty => 'Sem pacotes.';

  @override
  String get adminPackagesLoadFailed => 'Não foi possível carregar pacotes.';

  @override
  String get adminPackagesNew => 'Novo pacote';

  @override
  String get adminPackagesFeatured => 'Destaque';

  @override
  String get adminPackagesInactive => 'Inativo';

  @override
  String get adminPackagesActive => 'Ativo';

  @override
  String get adminPaymentsTitle => 'Pagamentos';

  @override
  String get adminPaymentsEmpty => 'Sem pagamentos.';

  @override
  String get adminPaymentsLoadFailed => 'Não foi possível carregar pagamentos.';

  @override
  String get adminPaymentsFilterAll => 'Todos';

  @override
  String get adminCreditsTitle => 'Movimentos de crédito';

  @override
  String get adminCreditsEmpty => 'Sem movimentos.';

  @override
  String get adminCreditsLoadFailed => 'Não foi possível carregar movimentos.';

  @override
  String get adminUsersTitle => 'Utilizadores';

  @override
  String get adminUsersEmpty => 'Sem utilizadores.';

  @override
  String get adminUsersLoadFailed => 'Não foi possível carregar utilizadores.';

  @override
  String get adminUsersSearch => 'Pesquisar por email ou nome';

  @override
  String get adminUsersRefresh => 'Atualizar';

  @override
  String get adminUsersReset => 'Repor';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Apagar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get termsTocLabel => 'Sumário';

  @override
  String get termsNoteBox =>
      'Esta é uma maquete UI/UX de termos de exemplo. Antes de qualquer publicação oficial, a REEL deve submeter o texto a revisão jurídica.';

  @override
  String get termsContactEmail => 'support@reel.studio';

  @override
  String get termsContactLabel => 'Email de suporte';

  @override
  String get termsContactButton => 'Contactar suporte';

  @override
  String get termsS01Title => 'Aceitação dos termos';

  @override
  String get termsS01P1 =>
      'Ao criar uma conta ou usar qualquer funcionalidade do REEL (geração de imagem, geração de vídeo, recarga de créditos, upgrade do plano), concorda com os termos abaixo. Se discordar, pare de usar o serviço.';

  @override
  String get termsS01P2 =>
      'O REEL é destinado a utilizadores com 13 anos ou mais. Utilizadores menores de 18 anos necessitam do consentimento de um pai ou tutor legal.';

  @override
  String get termsS02Title => 'Conta';

  @override
  String get termsS02P1 =>
      'Cada conta está associada a um único endereço de email. É responsável por manter a senha em sigilo e por toda a atividade na sua conta.';

  @override
  String get termsS02B1 =>
      'Os dados de registo (nome, email) devem ser exatos e atualizados.';

  @override
  String get termsS02B2 =>
      'O REEL pode exigir verificação de email antes de ativar certas funcionalidades.';

  @override
  String get termsS02B3 =>
      'As contas podem estar ativas, inativas ou banidas consoante o histórico de uso e infrações.';

  @override
  String get termsS03Title => 'Créditos & geração com IA';

  @override
  String get termsS03P1 =>
      'O REEL funciona com um sistema de créditos. Cada geração de imagem ou vídeo (um \"take\") desconta os créditos correspondentes da sua carteira, conforme o tipo, resolução e duração.';

  @override
  String get termsS03B1 =>
      'Os créditos são descontados quando o pedido de geração começa a ser processado.';

  @override
  String get termsS03B2 =>
      'Se uma geração falhar por erro do sistema, os créditos são reembolsados automaticamente.';

  @override
  String get termsS03B3 =>
      'O REEL não reembolsa créditos quando o pedido falha por violar os termos (ver Secção 6).';

  @override
  String get termsS03B4 =>
      'Os créditos não usados de planos mensais/anuais não transitam para o ciclo seguinte, salvo indicação em contrário.';

  @override
  String get termsS04Title => 'Pagamento & reembolso';

  @override
  String get termsS04P1 =>
      'O REEL aceita pagamentos via Momo, ZaloPay, VNPay, transferência bancária e Stripe (para planos internacionais). Cada transação é registada com ID próprio para rastreabilidade.';

  @override
  String get termsS04B1 =>
      'Os planos mensais/anuais renovam-se automaticamente, salvo cancelamento antes do próximo ciclo.';

  @override
  String get termsS04B2 =>
      'Os pedidos de reembolso são analisados em até 7 dias após o pagamento, desde que os créditos do plano não tenham sido usados.';

  @override
  String get termsS04B3 =>
      'Recargas únicas de créditos não são reembolsáveis após serem creditadas na carteira.';

  @override
  String get termsS05Title => 'Propriedade do conteúdo';

  @override
  String get termsS05P1 =>
      'Mantém os direitos de uso sobre o conteúdo que cria no REEL, dentro do âmbito do plano atual.';

  @override
  String get termsS05B1 =>
      'Plano Free: o conteúdo inclui marca d\'água REEL e destina-se a uso pessoal não comercial.';

  @override
  String get termsS05B2 =>
      'Plano Pro: o conteúdo não tem marca d\'água e pode ser usado comercialmente.';

  @override
  String get termsS05B3 =>
      'O REEL não garante a originalidade do conteúdo gerado por IA; a verificação antes do uso comercial é da sua responsabilidade.';

  @override
  String get termsS06Title => 'Conduta proibida';

  @override
  String get termsS06P1 =>
      'Não pode usar o REEL para criar ou distribuir conteúdo que:';

  @override
  String get termsS06B1 =>
      'Viole a lei vigente, incite à violência, discriminação ou ódio.';

  @override
  String get termsS06B2 =>
      'Seja pornográfico ou envolva menores sob qualquer forma.';

  @override
  String get termsS06B3 =>
      'Se faça passar por outra pessoa, viole a privacidade ou use a imagem de alguém sem autorização.';

  @override
  String get termsS06B4 =>
      'Infrinja direitos de autor, marcas ou outros direitos de propriedade intelectual de terceiros.';

  @override
  String get termsS06P2 =>
      'As violações podem levar ao banimento da conta sem aviso prévio e sem reembolso de créditos ou pagamentos.';

  @override
  String get termsS07Title => 'Limitação de responsabilidade';

  @override
  String get termsS07P1 =>
      'O serviço é fornecido \"tal como está\". O REEL não garante um serviço ininterrupto ou isento de erros, nem que cada resultado corresponda às suas expectativas.';

  @override
  String get termsS07P2 =>
      'Até ao máximo permitido por lei, o REEL não se responsabiliza por danos indiretos decorrentes do uso ou impossibilidade de usar o serviço.';

  @override
  String get termsS08Title => 'Termo da conta';

  @override
  String get termsS08P1 =>
      'Pode parar de usar o serviço e solicitar a eliminação da conta a qualquer momento. O REEL pode suspender (inactive) ou bloquear permanentemente (banned) contas que violem os termos, considerando a gravidade da infração.';

  @override
  String get termsS09Title => 'Alterações aos termos';

  @override
  String get termsS09P1 =>
      'O REEL pode atualizar estes termos. Alterações importantes serão comunicadas por email ou banner na página inicial com pelo menos 7 dias de antecedência.';

  @override
  String get termsS10Title => 'Contacto';

  @override
  String get termsS10P1 =>
      'Se tiver questões sobre estes termos, contacte a equipa REEL.';

  @override
  String get errorPasswordRequired => 'Insere a tua palavra-passe.';

  @override
  String get errorConfirmPasswordRequired => 'Confirma a tua palavra-passe.';

  @override
  String get backToHomeLabel => 'INÍCIO';

  @override
  String get backToHomeTooltip => 'Voltar ao início';

  @override
  String get profileBackHome => 'Voltar ao início';

  @override
  String get profileNavOverview => 'Visão geral';

  @override
  String get profileNavMyRoll => 'Meu roll';

  @override
  String get profileNavSettings => 'Configurações';

  @override
  String get profileNavBilling => 'Planos e faturamento';

  @override
  String get profileLogout => 'Sair';

  @override
  String profileWelcomeBack(String name) {
    return 'Bem-vindo de volta, $name 👋';
  }

  @override
  String profileWelcomeSub(int days) {
    return 'Este é o seu roll de hoje.';
  }

  @override
  String get profileStatTotalTakes => 'Total de takes';

  @override
  String get profileStatFavoriteStock => 'Stock favorito';

  @override
  String get profileStatDaysLabel => 'Dias com REEL';

  @override
  String profileStatDaysValue(int n) {
    return '$n dias';
  }

  @override
  String get profileUpgradePro => 'Fazer upgrade para Pro';

  @override
  String get profileRecentActivity => 'Atividade recente';

  @override
  String get profileViewAll => 'Ver tudo →';

  @override
  String get profileMyRollSub => 'Tudo o que você gerou no REEL.';

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
      'Ainda sem takes — gere o seu primeiro quadro no estúdio.';

  @override
  String get profileTimeJustNow => 'Agora mesmo';

  @override
  String profileTimeMinutesAgo(int n) {
    return 'há $n min';
  }

  @override
  String profileTimeHoursAgo(int n) {
    return 'há $n h';
  }

  @override
  String get profileTimeYesterday => 'Ontem';

  @override
  String profileTimeDaysAgo(int n) {
    return 'há $n dias';
  }

  @override
  String profileTimeWeeksAgo(int n) {
    return 'há $n semanas';
  }

  @override
  String get profileSettingsSub =>
      'Atualize as informações do seu perfil e as preferências padrão.';

  @override
  String get profileSectionProfileInfo => 'Informações do perfil';

  @override
  String get profileFieldDisplayName => 'Nome de exibição';

  @override
  String get profileFieldEmail => 'E-mail';

  @override
  String get profileSaveChanges => 'Salvar alterações';

  @override
  String get profileSectionPassword => 'Alterar senha';

  @override
  String get profileFieldCurrentPassword => 'Senha atual';

  @override
  String get profileFieldNewPassword => 'Nova senha';

  @override
  String get profileFieldConfirmPassword => 'Confirmar nova senha';

  @override
  String get profilePwPlaceholder => '••••••••••';

  @override
  String get profilePwNewPlaceholder => 'Pelo menos 8 caracteres';

  @override
  String get profilePwConfirmPlaceholder => 'Digite novamente';

  @override
  String get profileUpdatePassword => 'Atualizar senha';

  @override
  String get profilePwShow => 'Mostrar';

  @override
  String get profilePwHide => 'Ocultar';

  @override
  String get profileSectionPrefs => 'Preferências padrão';

  @override
  String get profilePrefRatio => 'Proporção padrão';

  @override
  String get profilePrefRatioDesc => 'Aplicado sempre que você abre o gerador';

  @override
  String get profilePrefStock => 'Stock padrão';

  @override
  String get profilePrefStockDesc => 'O visual inicial dos seus quadros';

  @override
  String get profileDangerTitle => 'Zona de perigo';

  @override
  String get profileDangerDesc =>
      'Excluir sua conta remove todo o seu roll. Não pode ser desfeito.';

  @override
  String get profileDeleteAccount => 'Excluir conta';

  @override
  String get profileDeleteNotice =>
      'A exclusão da conta é feita pela equipe do REEL — contate o suporte para solicitá-la.';

  @override
  String get profileBillingSub => 'Gerencie seu plano e métodos de pagamento.';

  @override
  String get profileCurrentPlan => 'Plano atual';

  @override
  String get profilePlanPerMonth => '/ mês';

  @override
  String get profilePlanFreePrice => '0đ';

  @override
  String get profilePlanProPrice => '299K';

  @override
  String get profilePlanFreeF1 => '10 créditos iniciais';

  @override
  String get profilePlanFreeF2 => 'Marca d\'água do REEL';

  @override
  String get profilePlanProF1 => 'Recarregue pacotes de créditos';

  @override
  String get profilePlanProF2 => '4K, sem marca d\'água';

  @override
  String get profileCurrentTag => 'Em uso';

  @override
  String get profileUpgradeShort => 'Fazer upgrade';

  @override
  String get profilePaymentHistory => 'Histórico de pagamentos';

  @override
  String get profileEmptyPayments =>
      'Ainda sem transações — faça upgrade para o Pro para começar.';

  @override
  String get profileFooter =>
      'REEL — DEVELOPED IN THE DARK. ONE FRAME AT A TIME.';

  @override
  String get profileSettingsSaved => 'Informações do perfil atualizadas!';

  @override
  String get profilePasswordUpdated => 'Senha atualizada!';

  @override
  String get profileProChip => 'PLANO PRO';

  @override
  String get profileFreeChip => 'PLANO GRÁTIS';

  @override
  String get adminSidebarModeration => 'Moderação';

  @override
  String get adminSidebarRevenue => 'Receita';

  @override
  String get adminSidebarSystem => 'Sistema';

  @override
  String get adminRoleChip => 'Administrador';

  @override
  String usageCreditsLabel(int balance) {
    return '$balance créditos disponíveis';
  }

  @override
  String get homeStatCreditsLeft => 'CRÉDITOS';

  @override
  String get profileStatCredits => 'Créditos';

  @override
  String profileCreditsAvailable(int balance) {
    return '$balance créditos disponíveis';
  }

  @override
  String get profileTopUp => 'Recarregar';

  @override
  String get profilePlanPayAsYouGo => '/ pague por imagem';

  @override
  String profileUsageSpentToday(int spent) {
    return '$spent créditos usados hoje';
  }

  @override
  String get profileTopUpHint => 'Recarregue créditos para continuar criando.';

  @override
  String get avatarUpdated => 'Avatar atualizado';

  @override
  String get avatarUpdateFailed => 'Falha ao enviar o avatar. Tente novamente.';

  @override
  String get avatarChangeHint => 'Alterar foto de perfil';

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

part of '../auth_screen.dart';

/// Top bar: REEL brand → home on the left, back link on the right.
class _AuthTopNav extends StatelessWidget {
  final VoidCallback onBackHome;
  const _AuthTopNav({required this.onBackHome});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onBackHome,
            borderRadius: BorderRadius.circular(9),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [
                          AppColors.azure,
                          AppColors.indigo,
                          AppColors.coral,
                        ],
                        stops: [0, .55, 1],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Center(
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: AppColors.ink,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    'REEL',
                    style: AppFonts.spaceGrotesk(
                      color: AppColors.mist,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LanguagePicker(compact: true),
              const SizedBox(width: 10),
              InkWell(
                onTap: onBackHome,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(
                    '← ${l10n.backToHomeLabel}',
                    style: AppFonts.inter(color: AppColors.smoke, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Left showcase column of the split-screen layout (reel-login/register):
/// gradient headline + tool chips (sign in) or gift box (sign up) + stats.
class _Showcase extends StatelessWidget {
  final AuthMode mode;
  const _Showcase({required this.mode});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = AppFonts.spaceGrotesk(
      color: AppColors.mist,
      fontSize: 31,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -.4,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(56, 40, 56, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              text: l10n.homeHeadline,
              style: style,
              children: [
                const TextSpan(text: ' '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ReelGradientText(l10n.authShowcaseAccent, style: style),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Text(
              l10n.authShowcaseSub,
              style: AppFonts.inter(
                color: AppColors.smoke,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (mode == AuthMode.signUp)
            _GiftBox(l10n: l10n)
          else
            _ToolChipsCloud(l10n: l10n),
          const SizedBox(height: 34),
          _ShowcaseStats(mode: mode, l10n: l10n),
        ],
      ),
    );
  }
}

class _GiftBox extends StatelessWidget {
  final AppLocalizations l10n;
  const _GiftBox({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 430),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.coral.withValues(alpha: .35)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🎁', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.authGiftTitle,
                  style: AppFonts.inter(
                    color: AppColors.parchment,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.authGiftSub,
                  style: AppFonts.inter(
                    color: AppColors.smoke,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolChipsCloud extends StatelessWidget {
  final AppLocalizations l10n;
  const _ToolChipsCloud({required this.l10n});

  static const _vi = [
    'Ảnh',
    'Video',
    'Manga',
    'Giọng nói',
    'Nhạc',
    '3D',
    'Bản đồ',
    'Code',
  ];
  static const _en = [
    'Image',
    'Video',
    'Manga',
    'Voice',
    'Music',
    '3D',
    'Map',
    'Code',
  ];
  static const _icons = [
    Icons.image_outlined,
    Icons.movie_outlined,
    Icons.menu_book_outlined,
    Icons.mic_none_outlined,
    Icons.music_note_outlined,
    Icons.view_in_ar_outlined,
    Icons.map_outlined,
    Icons.code_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final vi = Localizations.localeOf(context).languageCode == 'vi';
    final names = vi ? _vi : _en;
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        for (var i = 0; i < names.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.glass,
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_icons[i], size: 13, color: AppColors.mist),
                const SizedBox(width: 7),
                Text(
                  names[i],
                  style: AppFonts.inter(color: AppColors.mist, fontSize: 12),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.glass,
            border: Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            l10n.authShowcaseMore,
            style: AppFonts.inter(color: AppColors.mist, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _ShowcaseStats extends StatelessWidget {
  final AuthMode mode;
  final AppLocalizations l10n;
  const _ShowcaseStats({required this.mode, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final stats = mode == AuthMode.signUp
        ? [
            ('20', l10n.authStatToolsLabel),
            (l10n.authStatFreeValue, l10n.authStatFreeLabel),
            (l10n.authStatSignupValue, l10n.authStatSignupLabel),
          ]
        : [
            ('20', l10n.authStatToolsLabel),
            (l10n.authStatMangaValue, l10n.authStatMangaLabel),
            (l10n.authStatRatingValue, l10n.authStatRatingLabel),
          ];
    return Wrap(
      spacing: 34,
      runSpacing: 16,
      children: [
        for (final (value, label) in stats)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppFonts.spaceGrotesk(
                  color: AppColors.mist,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label.toUpperCase(),
                style: AppFonts.jetBrainsMono(
                  color: AppColors.muted,
                  fontSize: 9,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Card headline + sub for the active auth mode (mockup card headers).
class _CardHeader extends StatelessWidget {
  final AuthMode mode;
  const _CardHeader({required this.mode});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (title, sub) = switch (mode) {
      AuthMode.signIn => (l10n.authCardSignInTitle, l10n.authCardSignInSub),
      AuthMode.signUp => (l10n.authCardSignUpTitle, l10n.authCardSignUpSub),
      AuthMode.forgot => (l10n.forgotButton, l10n.forgotDescription),
      AuthMode.resetPassword => (
        l10n.authCardResetTitle,
        l10n.authCardResetSub,
      ),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.spaceGrotesk(
            color: AppColors.mist,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          sub,
          style: AppFonts.inter(
            color: AppColors.smoke,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

/// Password strength meter (register card) — 3 bars + mono label,
/// mirrors the mockup's .meter / .meter-txt.
class _PasswordMeter extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordMeter({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final v = controller.text;
        var score = 0;
        if (v.length >= 8) score++;
        if (v.contains(RegExp('[A-Z]')) && v.contains(RegExp('[0-9]'))) score++;
        if (v.contains(RegExp('[^A-Za-z0-9]')) && v.length >= 12) score++;
        final label = v.isEmpty
            ? l10n.authMeterEmpty
            : score == 1
            ? l10n.authMeterWeak
            : score == 2
            ? l10n.authMeterOk
            : l10n.authMeterStrong;
        final color = switch (score) {
          1 => AppColors.coral,
          2 => const Color(0xFFFFCF7E),
          3 => const Color(0xFF7EE0A8),
          _ => AppColors.line,
        };
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                for (var i = 0; i < 3; i++)
                  Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: i < 2 ? 5 : 0),
                      decoration: BoxDecoration(
                        color: v.isNotEmpty && i < score
                            ? color
                            : const Color(0x1AFFFFFF),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              label.toUpperCase(),
              style: AppFonts.jetBrainsMono(
                color: AppColors.muted,
                fontSize: 9,
                letterSpacing: 1,
              ),
            ),
          ],
        );
      },
    );
  }
}

part of '../home_screen.dart';

class _Header extends StatelessWidget {
  final bool scrolled, rtl;
  final int? creditBalance;
  final ValueChanged<String> onNavigate;
  final VoidCallback onStart, onDirection, onAuthChange;
  const _Header({
    required this.scrolled,
    required this.rtl,
    required this.creditBalance,
    required this.onNavigate,
    required this.onStart,
    required this.onDirection,
    required this.onAuthChange,
  });
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: scrolled ? 16 : 0,
          sigmaY: scrolled ? 16 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: width < 380 ? 16 : 28,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: scrolled
                ? AppColors.ink.withValues(alpha: .72)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: scrolled ? AppColors.lineSoft : Colors.transparent,
              ),
            ),
          ),
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 0,
                    child: ReelBrand(onTap: () => onNavigate('top')),
                  ),
                  if (width > 840)
                    Flexible(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 14,
                        runSpacing: 6,
                        children: [
                          _NavLink(l10n.navCreate, onTap: () => onNavigate('top')),
                          _NavLink(l10n.libraryTitle, onTap: () => onNavigate('library')),
                          _NavLink(l10n.pricing, onTap: () => onNavigate('pricing')),
                          _NavLink(l10n.navProfile, onTap: () => onNavigate('profile')),
                        ],
                      ),
                    ),
              Flexible(
                flex: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (width >= 380) ...[
                      LanguagePicker(compact: width <= 540),
                      const SizedBox(width: 10),
                      Tooltip(
                        message: l10n.rtlToggleTooltip,
                        child: InkWell(
                          onTap: onDirection,
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.glass,
                              border: Border.all(color: AppColors.line),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.swap_horiz,
                                  size: 14,
                                  color: AppColors.smoke,
                                ),
                                if (width > 840) ...[
                                  const SizedBox(width: 6),
                                  Text(
                                    rtl ? 'RTL' : 'LTR',
                                    style: AppFonts.jetBrainsMono(
                                      fontSize: 10.5,
                                      color: AppColors.smoke,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ] else
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: LanguagePicker(compact: true),
                      ),
                    if (AuthSession.accessToken != null) ...[
                      _CreditsPill(
                        balance: creditBalance,
                        onTap: () => onNavigate('pricing'),
                      ),
                      const SizedBox(width: 10),
                      UserAvatarMenu(onAuthChange: onAuthChange),
                    ] else ...[
                      Flexible(
                        child: ReelButton(
                          label: l10n.signIn,
                          onPressed: onStart,
                          primary: false,
                          padding: EdgeInsets.symmetric(
                            horizontal: width < 380 ? 12 : 18,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (width >= 360)
                        Flexible(
                          child: ReelButton(
                            label: l10n.getStarted,
                            onPressed: onStart,
                            padding: EdgeInsets.symmetric(
                              horizontal: width < 450 ? 12 : 18,
                              vertical: 10,
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wallet balance chip pinned next to the avatar in the header.
///
/// Mirrors the glass-pill styling of the RTL toggle. An empty balance
/// switches the border/text to coral as a top-up hint; tapping opens the
/// pricing screen. The number animates when it changes (e.g. after a
/// generation deducts credits) via [AnimatedSwitcher].
class _CreditsPill extends StatelessWidget {
  final int? balance;
  final VoidCallback onTap;
  const _CreditsPill({required this.balance, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final value = balance;
    final empty = value != null && value <= 0;
    final textColor = empty ? AppColors.coral : AppColors.mist;
    return Tooltip(
      message: l10n.usageCreditsLabel(value ?? 0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.glass,
            border: Border.all(
              color: empty
                  ? AppColors.coral.withValues(alpha: .45)
                  : AppColors.line,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.bolt_rounded,
                size: 14,
                color: AppColors.brassLt,
              ),
              const SizedBox(width: 6),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, .4),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: Text(
                  value == null ? '—' : '$value',
                  key: ValueKey<int?>(value),
                  style: AppFonts.jetBrainsMono(
                    fontSize: 11,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, {required this.onTap});
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 32),
      foregroundColor: AppColors.smoke,
      textStyle: AppFonts.inter(
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
        letterSpacing: .3,
      ),
    ),
    child: Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    ),
  );
}

class _Footer extends StatelessWidget {
  final ValueChanged<String> onNavigate;
  final VoidCallback onStart;
  const _Footer({required this.onNavigate, required this.onStart});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 70),
      padding: const EdgeInsets.fromLTRB(28, 44, 28, 32),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lineSoft)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 40,
                runSpacing: 40,
                children: [
                  SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReelBrand(onTap: () => onNavigate('top')),
                        const SizedBox(height: 12),
                        Text(
                          l10n.footerTagline,
                          style: AppFonts.inter(
                            fontSize: 13,
                            color: AppColors.smoke,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 56,
                    runSpacing: 24,
                    children: [
                      _footerColumn(l10n.productColumn, {
                        l10n.navCreate: () => onNavigate('top'),
                        l10n.libraryTitle: () => onNavigate('library'),
                        l10n.pricing: () => onNavigate('pricing'),
                      }),
                      _footerColumn(l10n.supportColumn, {
                        l10n.signInLink: onStart,
                        l10n.signUpLink: onStart,
                      }),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Divider(color: AppColors.lineSoft, height: 1),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 10,
                children: [
                  for (final text in [
                    l10n.footerCaption1,
                    l10n.footerCaption2,
                  ])
                    Text(
                      text,
                      style: AppFonts.jetBrainsMono(
                        color: const Color(0xFF524D5C),
                        fontSize: 10,
                        letterSpacing: 2,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _footerColumn(String title, Map<String, VoidCallback> links) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      title,
      style: AppFonts.jetBrainsMono(
        color: AppColors.smoke,
        fontSize: 10.5,
        letterSpacing: 1.5,
      ),
    ),
    const SizedBox(height: 14),
    for (final entry in links.entries)
      _NavLink(entry.key, onTap: entry.value),
  ],
);

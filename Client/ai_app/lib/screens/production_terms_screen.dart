import 'package:flutter/material.dart';
import '../core/app_fonts.dart';

import '../core/app_colors.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';

class ProductionTermsScreen extends StatefulWidget {
  const ProductionTermsScreen({super.key});

  @override
  State<ProductionTermsScreen> createState() => _ProductionTermsScreenState();
}

class _ProductionTermsScreenState extends State<ProductionTermsScreen>
    with TickerProviderStateMixin {
  late List<GlobalKey> _sectionKeys;
  int _activeSection = 0;
  late ScrollController _scrollController;
  double _scrollProgress = 0;

  // Animation controller drives the active dot on the TOC. We tween its
  // vertical position and its length so the highlight slides smoothly
  // from one section to the next instead of snapping.
  late final AnimationController _tocAnimController;
  double _tocFromIndex = 0;
  double _tocToIndex = 0;

  @override
  void initState() {
    super.initState();
    _sectionKeys = List<GlobalKey>.generate(10, (_) => GlobalKey());
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _tocAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    )..addListener(() {
        if (mounted) setState(() {});
      });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tocAnimController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final scrollOffset = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final progress =
        maxScroll > 0 ? (scrollOffset / maxScroll).clamp(0.0, 1.0) : 0.0;

    int closest = 0;
    double closestDist = double.infinity;
    for (var i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(
        Offset.zero,
        ancestor: context.findRenderObject(),
      );
      // 140 ≈ top header + a little breathing room; we pick whichever
      // section header is closest to that line.
      final dist = (pos.dy - 140).abs();
      if (dist < closestDist) {
        closestDist = dist;
        closest = i;
      }
    }

    if (closest != _activeSection) {
      _animateToSection(_activeSection, closest);
    }
    if (progress != _scrollProgress) {
      setState(() => _scrollProgress = progress);
    }
  }

  void _animateToSection(int from, int to) {
    setState(() => _activeSection = to);
    _tocFromIndex = from.toDouble();
    _tocToIndex = to.toDouble();
    _tocAnimController.forward(from: 0);
  }

  void _jumpTo(int index) {
    _scrollController.removeListener(_onScroll);
    setState(() => _activeSection = index);
    _animateToSection(index, index);
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
        alignment: 0.06,
      );
    }
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _scrollController.addListener(_onScroll);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: Stack(
        children: [
          const Positioned.fill(child: ReelBackdrop()),
          SafeArea(
            child: Column(
              children: [
                _TermsHeader(onBack: () => Navigator.of(context).pop()),
                _ProgressBar(progress: _scrollProgress),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth > 860;
                      if (!wide) {
                        // Mobile / narrow: original single-column scroll
                        return SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              _TermsHero(l10n: l10n),
                              _TermsLayout(
                                l10n: l10n,
                                sectionKeys: _sectionKeys,
                                activeSection: _activeSection,
                                activeT: _tocAnimController.value,
                                fromIndex: _tocFromIndex,
                                toIndex: _tocToIndex,
                                onSectionTap: _jumpTo,
                              ),
                              _TermsFooter(l10n: l10n),
                            ],
                          ),
                        );
                      }
                      // Wide / desktop: TOC is laid out OUTSIDE the
                      // scrollable area, so it stays pinned in place
                      // forever once it's on screen. The body scrolls
                      // independently inside the right column.
                      const double tocWidth = 240;
                      const double tocGap = 48;
                      const double tocTopInset = 28;
                      return Stack(
                        children: [
                          // Scrollable document body — leaves room on the
                          // left for the pinned TOC.
                          Padding(
                            padding: const EdgeInsets.only(
                              left: tocWidth + tocGap + 20,
                            ),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: [
                                  _TermsHero(l10n: l10n),
                                  _TermsBody(
                                    l10n: l10n,
                                    sectionKeys: _sectionKeys,
                                    activeSection: _activeSection,
                                  ),
                                  _TermsFooter(l10n: l10n),
                                ],
                              ),
                            ),
                          ),
                          // Pinned TOC — never moves regardless of scroll.
                          Positioned(
                            left: 28,
                            top: tocTopInset,
                            width: tocWidth,
                            child: _StickyToc(
                              l10n: l10n,
                              activeSection: _activeSection,
                              activeT: _tocAnimController.value,
                              fromIndex: _tocFromIndex,
                              toIndex: _tocToIndex,
                              onSectionTap: _jumpTo,
                            ),
                          ),
                        ],
                      );
                    },
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

// =============================================================================
// PROGRESS BAR
// =============================================================================

class _ProgressBar extends StatelessWidget {
  final double progress;
  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      decoration: const BoxDecoration(color: AppColors.lineSoft),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.azure, AppColors.indigo, AppColors.coral],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HEADER
// =============================================================================

class _TermsHeader extends StatelessWidget {
  final VoidCallback onBack;
  const _TermsHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 16 : 28,
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
          ),
          child: Row(
            children: [
              ReelBrand(onTap: onBack),
              const Spacer(),
              TextButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, size: 13),
                label: Text(compact ? l10n.termsBackShort : l10n.termsBackLong),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.parchmentDim,
                  padding: EdgeInsets.zero,
                  textStyle: AppFonts.jetBrainsMono(
                    fontSize: 10,
                    letterSpacing: compact ? 1 : 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// =============================================================================
// HERO
// =============================================================================

class _TermsHero extends StatelessWidget {
  final AppLocalizations l10n;
  const _TermsHero({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 36),
      child: Column(
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.glass,
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.azure, AppColors.coral],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.termsEyebrow,
                  style: AppFonts.jetBrainsMono(
                    color: AppColors.smoke,
                    fontSize: 10.5,
                    letterSpacing: 2.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Headline
          Text(
            l10n.termsHeadline,
            style: AppFonts.spaceGrotesk(
              color: AppColors.parchment,
              fontSize: 38,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.termsSubhead,
            style: AppFonts.jetBrainsMono(
              color: AppColors.smoke,
              fontSize: 11,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// LAYOUT (mobile / narrow only — wide layout pins the TOC outside the scroll)
// =============================================================================

class _TermsLayout extends StatelessWidget {
  final AppLocalizations l10n;
  final List<GlobalKey> sectionKeys;
  final int activeSection;
  final double activeT;
  final double fromIndex;
  final double toIndex;
  final ValueChanged<int> onSectionTap;

  const _TermsLayout({
    required this.l10n,
    required this.sectionKeys,
    required this.activeSection,
    required this.activeT,
    required this.fromIndex,
    required this.toIndex,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: Column(
          children: [
            _CompactToc(
              l10n: l10n,
              activeSection: activeSection,
              onSectionTap: onSectionTap,
            ),
            const SizedBox(height: 28),
            _DocBody(
              l10n: l10n,
              sectionKeys: sectionKeys,
              activeSection: activeSection,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// BODY ONLY (wide layout — TOC is rendered separately in a Stack)
// =============================================================================

class _TermsBody extends StatelessWidget {
  final AppLocalizations l10n;
  final List<GlobalKey> sectionKeys;
  final int activeSection;

  const _TermsBody({
    required this.l10n,
    required this.sectionKeys,
    required this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NoteBox(l10n: l10n),
          const SizedBox(height: 44),
          for (var i = 0; i < 10; i++)
            Padding(
              key: sectionKeys[i],
              padding: const EdgeInsets.only(bottom: 18),
              child: _Section(
                index: i,
                l10n: l10n,
                isActive: activeSection == i,
              ),
            ),
          const SizedBox(height: 16),
          _ContactCard(l10n: l10n),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// =============================================================================
// STICKY TOC (desktop / wide)
// =============================================================================

class _StickyToc extends StatelessWidget {
  final AppLocalizations l10n;
  final int activeSection;
  final double activeT;
  final double fromIndex;
  final double toIndex;
  final ValueChanged<int> onSectionTap;

  const _StickyToc({
    required this.l10n,
    required this.activeSection,
    required this.activeT,
    required this.fromIndex,
    required this.toIndex,
    required this.onSectionTap,
  });

  List<String> get _items => [
        l10n.termsS01Title,
        l10n.termsS02Title,
        l10n.termsS03Title,
        l10n.termsS04Title,
        l10n.termsS05Title,
        l10n.termsS06Title,
        l10n.termsS07Title,
        l10n.termsS08Title,
        l10n.termsS09Title,
        l10n.termsS10Title,
      ];

  @override
  Widget build(BuildContext context) {
    // The TOC is rendered inside a Positioned in the parent Stack, so
    // it's already pinned and never scrolls away — no extra scaffolding
    // needed.
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.termsTocLabel,
                  style: AppFonts.jetBrainsMono(
                    color: AppColors.smoke,
                    fontSize: 10,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 16),
                _SlidingTocItems(
                  items: _items,
                  activeSection: activeSection,
                  activeT: activeT,
                  fromIndex: fromIndex,
                  toIndex: toIndex,
                  onSectionTap: onSectionTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Renders the TOC items with a sliding gradient rail that animates
// between sections instead of jumping.
class _SlidingTocItems extends StatelessWidget {
  final List<String> items;
  final int activeSection;
  final double activeT;
  final double fromIndex;
  final double toIndex;
  final ValueChanged<int> onSectionTap;

  const _SlidingTocItems({
    required this.items,
    required this.activeSection,
    required this.activeT,
    required this.fromIndex,
    required this.toIndex,
    required this.onSectionTap,
  });

  // Each TOC row is fixed-height so we can compute the rail's vertical
  // position deterministically. The rail slides from fromIndex to
  // toIndex based on activeT.
  static const double _rowHeight = 38;

  @override
  Widget build(BuildContext context) {
    final easedT = Curves.easeOutCubic.transform(activeT);
    final animatedIndex =
        fromIndex + (toIndex - fromIndex) * easedT;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Faint rail behind the items
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: SizedBox(
            height: items.length * _rowHeight,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    color: AppColors.line,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: animatedIndex * _rowHeight + 6,
                  child: Container(
                    width: 2,
                    height: _rowHeight - 12,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.azure,
                          AppColors.indigo,
                          AppColors.coral,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Negative top margin pulls items onto the rail
        Transform.translate(
          offset: Offset(0, -items.length * _rowHeight),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++)
                _TocRow(
                  index: i,
                  label: items[i],
                  isActive: activeSection == i,
                  height: _rowHeight,
                  onTap: () => onSectionTap(i),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TocRow extends StatelessWidget {
  final int index;
  final String label;
  final bool isActive;
  final double height;
  final VoidCallback onTap;

  const _TocRow({
    required this.index,
    required this.label,
    required this.isActive,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.centerLeft,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          style: AppFonts.inter(
            fontSize: 13.5,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? AppColors.mist : AppColors.smoke,
            letterSpacing: isActive ? 0.2 : 0.1,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOut,
                width: 18,
                child: Text(
                  (index + 1).toString().padLeft(2, '0'),
                  style: AppFonts.jetBrainsMono(
                    fontSize: 10.5,
                    color: isActive ? AppColors.azureSoft : AppColors.muted,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// COMPACT TOC (mobile / narrow) – keeps the existing horizontal pill row
// but adds the same progress indicator under it.
// =============================================================================

class _CompactToc extends StatelessWidget {
  final AppLocalizations l10n;
  final int activeSection;
  final ValueChanged<int> onSectionTap;

  const _CompactToc({
    required this.l10n,
    required this.activeSection,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      l10n.termsS01Title,
      l10n.termsS02Title,
      l10n.termsS03Title,
      l10n.termsS04Title,
      l10n.termsS05Title,
      l10n.termsS06Title,
      l10n.termsS07Title,
      l10n.termsS08Title,
      l10n.termsS09Title,
      l10n.termsS10Title,
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.termsTocLabel,
            style: AppFonts.jetBrainsMono(
              color: AppColors.smoke,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, i) {
                final isActive = activeSection == i;
                return InkWell(
                  onTap: () => onSectionTap(i),
                  borderRadius: BorderRadius.circular(999),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.azureSoft.withValues(alpha: .15)
                          : AppColors.glass,
                      border: Border.all(
                        color: isActive
                            ? AppColors.azureSoft.withValues(alpha: .6)
                            : AppColors.line,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${i + 1}',
                          style: AppFonts.jetBrainsMono(
                            fontSize: 10.5,
                            color: isActive
                                ? AppColors.azureSoft
                                : AppColors.muted,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          items[i],
                          style: AppFonts.inter(
                            fontSize: 13,
                            color: isActive
                                ? AppColors.mist
                                : AppColors.smoke,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // Compact progress bar
          Container(
            height: 2,
            decoration: const BoxDecoration(color: AppColors.lineSoft),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: (activeSection + 1) / items.length,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.azure,
                        AppColors.indigo,
                        AppColors.coral,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// DOCUMENT BODY
// =============================================================================

class _DocBody extends StatelessWidget {
  final AppLocalizations l10n;
  final List<GlobalKey> sectionKeys;
  final int activeSection;

  const _DocBody({
    required this.l10n,
    required this.sectionKeys,
    required this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Note box
          _NoteBox(l10n: l10n),
          const SizedBox(height: 44),

          // 10 sections
          for (var i = 0; i < 10; i++)
            Padding(
              key: sectionKeys[i],
              padding: const EdgeInsets.only(bottom: 18),
              child: _Section(
                index: i,
                l10n: l10n,
                isActive: activeSection == i,
              ),
            ),

          const SizedBox(height: 16),

          // Contact card
          _ContactCard(l10n: l10n),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _NoteBox extends StatelessWidget {
  final AppLocalizations l10n;
  const _NoteBox({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 17,
            color: AppColors.azureSoft,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.termsNoteBox,
              style: AppFonts.inter(
                fontSize: 13.5,
                color: AppColors.smoke,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final int index;
  final AppLocalizations l10n;
  final bool isActive;

  const _Section({
    required this.index,
    required this.l10n,
    required this.isActive,
  });

  String get _title {
    switch (index) {
      case 0: return l10n.termsS01Title;
      case 1: return l10n.termsS02Title;
      case 2: return l10n.termsS03Title;
      case 3: return l10n.termsS04Title;
      case 4: return l10n.termsS05Title;
      case 5: return l10n.termsS06Title;
      case 6: return l10n.termsS07Title;
      case 7: return l10n.termsS08Title;
      case 8: return l10n.termsS09Title;
      case 9: return l10n.termsS10Title;
      default: return '';
    }
  }

  List<_ContentBlock> get _blocks {
    switch (index) {
      case 0:
        return [
          _ContentBlock.paragraph(l10n.termsS01P1),
          _ContentBlock.paragraph(l10n.termsS01P2),
        ];
      case 1:
        return [
          _ContentBlock.paragraph(l10n.termsS02P1),
          _ContentBlock.bullet(l10n.termsS02B1),
          _ContentBlock.bullet(l10n.termsS02B2),
          _ContentBlock.bullet(l10n.termsS02B3),
        ];
      case 2:
        return [
          _ContentBlock.paragraph(l10n.termsS03P1),
          _ContentBlock.bullet(l10n.termsS03B1),
          _ContentBlock.bullet(l10n.termsS03B2),
          _ContentBlock.bullet(l10n.termsS03B3),
          _ContentBlock.bullet(l10n.termsS03B4),
        ];
      case 3:
        return [
          _ContentBlock.paragraph(l10n.termsS04P1),
          _ContentBlock.bullet(l10n.termsS04B1),
          _ContentBlock.bullet(l10n.termsS04B2),
          _ContentBlock.bullet(l10n.termsS04B3),
        ];
      case 4:
        return [
          _ContentBlock.paragraph(l10n.termsS05P1),
          _ContentBlock.bullet(l10n.termsS05B1),
          _ContentBlock.bullet(l10n.termsS05B2),
          _ContentBlock.bullet(l10n.termsS05B3),
        ];
      case 5:
        return [
          _ContentBlock.paragraph(l10n.termsS06P1),
          _ContentBlock.bullet(l10n.termsS06B1),
          _ContentBlock.bullet(l10n.termsS06B2),
          _ContentBlock.bullet(l10n.termsS06B3),
          _ContentBlock.bullet(l10n.termsS06B4),
          _ContentBlock.paragraph(l10n.termsS06P2),
        ];
      case 6:
        return [
          _ContentBlock.paragraph(l10n.termsS07P1),
          _ContentBlock.paragraph(l10n.termsS07P2),
        ];
      case 7:
        return [
          _ContentBlock.paragraph(l10n.termsS08P1),
        ];
      case 8:
        return [
          _ContentBlock.paragraph(l10n.termsS09P1),
        ];
      case 9:
        return [
          _ContentBlock.paragraph(l10n.termsS10P1),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Each section slides a touch to the right and gains a left gradient
    // rail + a soft background glow when it becomes the active section.
    // Combined with the colour shift in text, this gives a clear
    // "this content is in focus" cue that travels with the scroll.
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 0, end: isActive ? 1 : 0),
      builder: (context, t, child) {
        return Transform.translate(
          offset: Offset(14 * (1 - t), 0),
          child: Opacity(opacity: 0.55 + 0.45 * t, child: child),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.azureSoft.withValues(alpha: .05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border(
            left: BorderSide(
              color: isActive
                  ? AppColors.azureSoft.withValues(alpha: .9)
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active glow ring behind the section number when current
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  width: isActive ? 36 : 28,
                  height: isActive ? 36 : 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [
                              AppColors.azure,
                              AppColors.indigo,
                              AppColors.coral,
                            ],
                          )
                        : null,
                    color: isActive ? null : AppColors.glass,
                    border: Border.all(
                      color: isActive ? Colors.transparent : AppColors.line,
                    ),
                    boxShadow: isActive
                        ? const [
                            BoxShadow(
                              color: Color(0x663D7CFF),
                              blurRadius: 18,
                              spreadRadius: 1,
                            ),
                          ]
                        : const [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (index + 1).toString().padLeft(2, '0'),
                    style: AppFonts.jetBrainsMono(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isActive
                          ? const Color(0xFF06070F)
                          : AppColors.smoke,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 380),
                    curve: Curves.easeOut,
                    style: AppFonts.spaceGrotesk(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.mist : AppColors.parchment,
                      letterSpacing: -0.3,
                    ),
                    child: Text(_title),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            for (final block in _blocks) ...[
              if (block.type == _BlockType.paragraph)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    style: AppFonts.inter(
                      fontSize: 14.5,
                      color: isActive
                          ? AppColors.parchmentDim
                          : AppColors.smoke,
                      height: 1.75,
                    ),
                    child: Text(block.text),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7, right: 8),
                        child: Text(
                          '\u2022',
                          style: AppFonts.inter(
                            fontSize: 14.5,
                            color: isActive
                                ? AppColors.azureSoft
                                : AppColors.smoke,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          style: AppFonts.inter(
                            fontSize: 14.5,
                            color: isActive
                                ? AppColors.parchmentDim
                                : AppColors.smoke,
                            height: 1.65,
                          ),
                          child: Text(block.text),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

enum _BlockType { paragraph, bullet }

class _ContentBlock {
  final _BlockType type;
  final String text;

  const _ContentBlock._(this.type, this.text);

  factory _ContentBlock.paragraph(String text) =>
      _ContentBlock._(_BlockType.paragraph, text);

  factory _ContentBlock.bullet(String text) =>
      _ContentBlock._(_BlockType.bullet, text);
}

class _ContactCard extends StatelessWidget {
  final AppLocalizations l10n;
  const _ContactCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.termsContactLabel,
                  style: AppFonts.jetBrainsMono(
                    fontSize: 10,
                    letterSpacing: 1.5,
                    color: AppColors.smoke,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.termsContactEmail,
                  style: AppFonts.inter(
                    fontSize: 14.5,
                    color: AppColors.parchment,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _GradButton(
            label: l10n.termsContactButton,
            onPressed: () {
              // TODO: Open email or support link
            },
          ),
        ],
      ),
    );
  }
}

class _GradButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.azure, AppColors.indigo, AppColors.coral],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(11),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF06070F),
                  ),
                ),
                const SizedBox(width: 7),
                const Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: Color(0xFF06070F),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TermsFooter extends StatelessWidget {
  final AppLocalizations l10n;
  const _TermsFooter({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lineSoft)),
      ),
      child: Center(
        child: Text(
          l10n.termsFooterText,
          style: AppFonts.jetBrainsMono(
            fontSize: 10,
            letterSpacing: 2,
            color: const Color(0xFF524D5C),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// COMPACT TOC ITEMS (mobile / narrow horizontal pill row)
// =============================================================================

part of 'admin_dashboard_screen.dart';

/// Top navigation bar – mirrors `.nav` from reel-admin-dashboard.html:
/// brand + admin tag + back link on the left, RTL toggle and the user chip
/// on the right.
class _TopNav extends StatelessWidget {
  final bool mobile;
  final VoidCallback onMenuTap;
  final VoidCallback onToggleRtl;
  final bool rtl;
  const _TopNav({
    required this.mobile,
    required this.onMenuTap,
    required this.onToggleRtl,
    required this.rtl,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final name = AuthSession.fullName?.trim().isNotEmpty == true
        ? AuthSession.fullName!.trim()
        : l10n.adminDefaultName;
    final navChildren = <Widget>[
      if (mobile) ...[
        IconButton(
          onPressed: onMenuTap,
          tooltip: l10n.adminMenuTooltip,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          icon: const Icon(Icons.menu, color: AdminColors.smoke),
        ),
        const SizedBox(width: 6),
      ],
          const _BrandMark(),
          const SizedBox(width: 9),
          Text(
            'REEL',
            style: AppFonts.spaceGrotesk(
              color: AdminColors.mist,
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
              letterSpacing: .4,
            ),
          ),
          if (!mobile) ...[
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AdminColors.azure.withValues(alpha: .1),
                border: Border.all(
                  color: AdminColors.azure.withValues(alpha: .35),
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                l10n.adminBadge.toUpperCase(),
                style: AppFonts.jetBrainsMono(
                  color: AdminColors.azureSoft,
                  fontSize: 9.5,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(width: 1, height: 16, color: AdminColors.lineSoft),
            const SizedBox(width: 16),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.of(context).maybePop(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back_rounded,
                      size: 14,
                      color: AdminColors.smoke,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.profileBackHome,
                      style: AppFonts.inter(
                        color: AdminColors.smoke,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (mobile)
            const SizedBox(width: 12)
          else
            const Spacer(),
          _RtlToggle(rtl: rtl, onTap: onToggleRtl, iconOnly: mobile),
          SizedBox(width: mobile ? 6 : 10),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 12, 5),
            decoration: BoxDecoration(
              color: AdminColors.glass,
              border: Border.all(color: AdminColors.line),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CircleAvatarLetter(
                  letter: name.characters.first.toUpperCase(),
                  size: 26,
                  fontSize: 11,
                ),
                const SizedBox(width: 9),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: mobile ? 72 : 140),
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.inter(
                      color: AdminColors.mist,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
  ];

  return Container(
    padding: EdgeInsets.fromLTRB(mobile ? 16 : 28, 12, mobile ? 16 : 28, 12),
    decoration: const BoxDecoration(
      color: Color(0xB806070B),
      border: Border(bottom: BorderSide(color: AdminColors.lineSoft)),
    ),
    // On phones the nav content scrolls horizontally (right-anchored) so a
    // narrow screen never breaks the layout.
    child: mobile
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(children: navChildren),
          )
        : Row(children: navChildren),
  );
}
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        gradient: AdminColors.spectrum,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: AdminColors.bg,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

/// Circular gradient avatar with a single letter – `.avatar` from the
/// mockup (used in the nav chip and the sidebar profile card).
class _CircleAvatarLetter extends StatelessWidget {
  final String letter;
  final double size;
  final double fontSize;
  const _CircleAvatarLetter({
    required this.letter,
    required this.size,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: AdminColors.spectrum,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: AppFonts.spaceGrotesk(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Sidebar – mirrors `.sidebar` from the mockup: profile card with the
/// admin role chip, the section switcher with the moderation count badge
/// and the logout link.
class _Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onLogout;
  final int pendingCount;
  final bool fillWidth;
  const _Sidebar({
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onLogout,
    this.pendingCount = 0,
    this.fillWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final name = AuthSession.fullName?.trim().isNotEmpty == true
        ? AuthSession.fullName!.trim()
        : l10n.adminDefaultName;
    final email = AuthSession.email ?? '';

    // 7 mục khớp reel-admin.html: Tổng quan / Người dùng / Hàng đợi tạo /
    // Công cụ AI / Kiểm duyệt / Doanh thu / Hệ thống.
    final items = <_SidebarItem>[
      _SidebarItem(0, l10n.adminSidebarOverview, Icons.grid_view_outlined),
      _SidebarItem(1, l10n.adminSidebarUsers, Icons.people_outline),
      _SidebarItem(
        2,
        l10n.adminSidebarQueue,
        Icons.pending_actions_outlined,
        badge: 14,
      ),
      _SidebarItem(3, l10n.adminSidebarTools, Icons.home_repair_service_outlined),
      _SidebarItem(
        4,
        l10n.adminSidebarModeration,
        Icons.shield_outlined,
        badge: pendingCount,
      ),
      _SidebarItem(5, l10n.adminSidebarRevenue, Icons.trending_up_rounded),
      _SidebarItem(6, l10n.adminSidebarSystem, Icons.monitor_heart_outlined),
    ];

    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.padding.bottom;
    final topInset = fillWidth ? mediaQuery.padding.top : 0.0;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Profile card.
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AdminColors.glass,
            border: Border.all(color: AdminColors.line),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              _CircleAvatarLetter(
                letter: name.characters.first.toUpperCase(),
                size: 56,
                fontSize: 21,
              ),
              const SizedBox(height: 12),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.spaceGrotesk(
                  color: AdminColors.mist,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email.isEmpty ? 'admin@reel.studio' : email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.jetBrainsMono(
                  color: AdminColors.smoke,
                  fontSize: 10.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AdminColors.coral.withValues(alpha: .1),
                  border: Border.all(
                    color: AdminColors.coral.withValues(alpha: .35),
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.settings_outlined,
                      size: 10,
                      color: AdminColors.coral,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      l10n.adminRoleChip.toUpperCase(),
                      style: AppFonts.jetBrainsMono(
                        color: AdminColors.coral,
                        fontSize: 9.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Section switcher.
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AdminColors.glass,
            border: Border.all(color: AdminColors.line),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              for (final item in items)
                _NavItem(
                  index: item.index,
                  title: item.title,
                  icon: item.icon,
                  badge: item.badge,
                  selectedIndex: selectedIndex,
                  onTap: onItemSelected,
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _NavItem(
          index: -1,
          title: l10n.profileLogout,
          icon: Icons.logout_rounded,
          badge: 0,
          selectedIndex: -2,
          onTap: (_) => onLogout(),
        ),
      ],
    );

    if (fillWidth) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: topInset, bottom: bottomInset),
          child: content,
        ),
      );
    }
    return SizedBox(
      width: 230,
      child: Padding(padding: EdgeInsets.only(bottom: bottomInset), child: content),
    );
  }
}

class _SidebarItem {
  final int index;
  final String title;
  final IconData icon;
  final int badge;
  const _SidebarItem(this.index, this.title, this.icon, {this.badge = 0});
}

class _NavItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final int badge;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _NavItem({
    required this.index,
    required this.title,
    required this.icon,
    required this.badge,
    required this.selectedIndex,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final active = index == selectedIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(11),
          onTap: () => onTap(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              gradient: active
                  ? const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0x333D7CFF), Color(0x298B7BFF)],
                    )
                  : null,
              border: Border.all(
                color: active
                    ? AdminColors.azure.withValues(alpha: .35)
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: active ? Colors.white : AdminColors.smoke,
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.inter(
                      color: active ? Colors.white : AdminColors.smoke,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (badge > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x2EFF9D9D),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '$badge',
                      style: AppFonts.jetBrainsMono(
                        color: AdminColors.bad,
                        fontSize: 9.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RtlToggle extends StatelessWidget {
  final bool rtl;
  final VoidCallback onTap;
  final bool iconOnly;
  const _RtlToggle({
    required this.rtl,
    required this.onTap,
    this.iconOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: l10n.adminRtlTooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: iconOnly ? 9 : 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AdminColors.glass,
            border: Border.all(color: AdminColors.line),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.public_rounded, size: 14, color: AdminColors.smoke),
              if (!iconOnly) ...[
                const SizedBox(width: 6),
                Text(
                  rtl ? 'RTL' : 'LTR',
                  style: AppFonts.jetBrainsMono(
                    fontSize: 10.5,
                    letterSpacing: 1,
                    color: AdminColors.smoke,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Shared panel heading: big display title + smoke subtitle, optional
/// trailing action — the mockup's `.panel-head`.
class _PanelHead extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? action;
  const _PanelHead({required this.title, required this.subtitle, this.action});

  @override
  Widget build(BuildContext context) {
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.spaceGrotesk(
            color: AdminColors.mist,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: AppFonts.inter(color: AdminColors.smoke, fontSize: 13.5),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: action == null
          ? heading
          : LayoutBuilder(
              builder: (context, constraints) => constraints.maxWidth < 560
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading,
                        const SizedBox(height: 12),
                        action!,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: heading),
                        const SizedBox(width: 14),
                        action!,
                      ],
                    ),
            ),
    );
  }
}

/// Mono uppercase footer line – the mockup's global `footer`.
class _AdminFooter extends StatelessWidget {
  const _AdminFooter();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 28),
      padding: const EdgeInsets.only(top: 26),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AdminColors.lineSoft)),
      ),
      child: Text(
        l10n.profileFooter.toUpperCase(),
        textAlign: TextAlign.center,
        style: AppFonts.jetBrainsMono(
          color: const Color(0xFF524D5C),
          fontSize: 10,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

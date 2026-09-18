import 'package:flutter/material.dart';
import '../core/app_fonts.dart';

import '../core/app_colors.dart';
import '../core/auth_session.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';

class UserAvatarMenu extends StatefulWidget {
  final VoidCallback? onLanguageChange;
  final VoidCallback? onAuthChange;

  const UserAvatarMenu({super.key, this.onLanguageChange, this.onAuthChange});

  @override
  State<UserAvatarMenu> createState() => _UserAvatarMenuState();
}

class _UserAvatarMenuState extends State<UserAvatarMenu> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlayEntry() {
    final menuWidth = (MediaQuery.sizeOf(context).width - 24).clamp(0.0, 260.0);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _closeMenu,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: menuWidth,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomRight,
                followerAnchor: Alignment.topRight,
                offset: const Offset(0, 8),
                child: Material(
                  elevation: 8,
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.line),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // User info header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.lineSoft),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AuthSession.fullName ?? 'User',
                                style: AppFonts.inter(
                                  color: AppColors.parchment,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                AuthSession.email ?? '',
                                style: AppFonts.inter(
                                  color: AppColors.parchmentDim,
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Menu items
                        _MenuItem(
                          icon: Icons.person_outline,
                          label: 'My Profile',
                          onTap: () {
                            _closeMenu();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ProfileScreen(),
                              ),
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.lineSoft,
                        ),
                        _MenuItem(
                          icon: Icons.logout,
                          label: 'Log Out',
                          onTap: () async {
                            final navigator = Navigator.of(context);
                            _closeMenu();
                            await AuthSession.clear();
                            widget.onAuthChange?.call();
                            if (!mounted) return;
                            {
                              // Navigate to home and clear all routes
                              navigator.pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const ReelHomePage(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          isDestructive: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(AuthSession.fullName ?? 'User');

    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleMenu,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.brass.withValues(alpha: 0.15),
            border: Border.all(
              color: _isOpen ? AppColors.brassLt : AppColors.brass,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initials,
              style: AppFonts.inter(
                color: AppColors.brassLt,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isDestructive ? AppColors.brass : AppColors.parchmentDim,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppFonts.inter(
                  color: isDestructive
                      ? AppColors.brass
                      : AppColors.parchmentDim,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

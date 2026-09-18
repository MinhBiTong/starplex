import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../core/api_client.dart';
import '../core/messages.dart';
import '../widgets/flagship_ui.dart';

import '../core/app_fonts.dart';
import '../core/auth_session.dart';
import '../l10n/generated/app_localizations.dart';
import 'auth_screen.dart';

// Bảng màu chuẩn từ file HTML (Aurora / Dark Theme)

part 'dashboard_shell.dart';
part 'dashboard_components.dart';
part 'dashboard_table.dart';
part 'dashboard_controls.dart';
part 'dashboard_utilities.dart';
part 'views/dashboard_view.dart';
part 'views/users_view.dart';
part 'views/generations_view.dart';
part 'views/credits_view.dart';
part 'views/packages_view.dart';
part 'views/payments_view.dart';
part 'views/settings_view.dart';
part 'views/queue_tools_views.dart';

class AdminColors {
  // Semantic aliases for the flagship aurora palette. Keeping names stable
  // means existing dashboard widgets and API flows remain untouched.
  static const bg = Color(0xFF06070B);
  static const panel = Color(0xFF0A0B13);
  static const panel2 = Color(0xFF11131E);
  static const panel3 = Color(0xFF171A27);
  static const line = Color(0x1AFFFFFF);
  static const lineSoft = Color(0x0FFFFFFF);
  static const gold = Color(0xFF3D7CFF);
  static const goldBright = Color(0xFF6FA3FF);
  static const burgundy = Color(0xFF8B7BFF);
  static const indigo = burgundy;
  static const burgundyBright = Color(0xFFFF9466);
  static const coral = burgundyBright;
  static const azure = Color(0xFF3D7CFF);
  static const azureSoft = Color(0xFF6FA3FF);
  static const good = Color(0xFF7EE0A8);
  static const warn = Color(0xFFFFCF7E);
  static const bad = Color(0xFFFF9D9D);
  static const green = good;
  static const amber = warn;
  static const red = bad;
  static const cream = Color(0xFFF1F3F8);
  static const creamDim = Color(0xFF8B93A6);
  static const muted = Color(0xFF687086);
  static const mist = Color(0xFFF1F3F8);
  static const smoke = Color(0xFF8B93A6);
  static const glass = Color(0x0BFFFFFF);
  static const glassStrong = Color(0x14FFFFFF);
  static const spectrum = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [azure, indigo, coral],
  );
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollers = <int, ScrollController>{};
  bool _rtl = false;

  /// Number of generations waiting for review – shown as the sidebar badge
  /// on the moderation entry, like `.count-badge` in the mockup.
  int _pendingCount = 0;

  @override
  void initState() {
    super.initState();
    _loadPendingCount();
  }

  @override
  void dispose() {
    for (final c in _scrollers.values) {
      c.dispose();
    }
    super.dispose();
  }

  ScrollController _scrollerFor(int index) {
    return _scrollers.putIfAbsent(index, () => ScrollController());
  }

  /// Allow child widgets (e.g. the Overview tables) to switch
  /// tabs through the parent's state without relying on `findAncestorState`.
  void selectTab(int index) {
    if (!mounted) return;
    setState(() => _selectedIndex = index);
  }

  void _toggleRtl() {
    setState(() => _rtl = !_rtl);
  }

  /// Best-effort pending count for the moderation badge; a failure here
  /// only means the badge stays hidden, never blocks the dashboard.
  Future<void> _loadPendingCount() async {
    if (AuthSession.accessToken == null) return;
    try {
      final dio = ApiClient.instance.dio;
      final response = await dio.get(
        '/admin/dashboard/generations',
        queryParameters: {'limit': 200},
      );
      if (!mounted) return;
      final items = response.data as List;
      setState(() {
        _pendingCount = items
            .where(
              (item) =>
                  (item['status']?.toString() ?? '') == 'pending',
            )
            .length;
      });
    } on DioException {
      // Badge is decorative; ignore fetch failures.
    }
  }

  Future<void> _logout() async {
    final refreshToken = AuthSession.refreshToken;
    if (refreshToken != null) {
      try {
        final dio = buildDio();
        await dio.post('/auth/logout', data: {'refresh_token': refreshToken});
        dio.close();
      } on DioException {
        // Clear local credentials even if the server is unavailable.
      }
    }
    await AuthSession.clear();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth < 960;

          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: AdminColors.bg,
            drawer: mobile
                ? Drawer(
                    backgroundColor: AdminColors.panel,
                    child: SafeArea(
                      child: _Sidebar(
                        fillWidth: true,
                        selectedIndex: _selectedIndex,
                        onLogout: _logout,
                        pendingCount: _pendingCount,
                        onItemSelected: (index) {
                          selectTab(index);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  )
                : null,
            body: Stack(
              children: [
                const Positioned.fill(child: ReelBackdrop()),
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _TopNav(
                        mobile: mobile,
                        onMenuTap: mobile
                            ? () =>
                                  _scaffoldKey.currentState?.openDrawer()
                            : () {},
                        onToggleRtl: _toggleRtl,
                        rtl: _rtl,
                      ),
                      Expanded(
                        // Desktop: the sidebar + main form ONE centered
                        // 1280 canvas (`.page-wrap > .dash-layout` in the
                        // mockup) and FittedBox scales the whole canvas
                        // down on narrower windows, matching the mockup's
                        // visual density.
                        child: mobile
                            ? SingleChildScrollView(
                                controller: _scrollerFor(_selectedIndex),
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  22,
                                  16,
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _buildView(_selectedIndex),
                                    const _AdminFooter(),
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                controller: _scrollerFor(_selectedIndex),
                                padding: const EdgeInsets.fromLTRB(
                                  28,
                                  24,
                                  28,
                                  24,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width: 1280,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 230,
                                          child: _Sidebar(
                                            selectedIndex: _selectedIndex,
                                            onLogout: _logout,
                                            pendingCount: _pendingCount,
                                            onItemSelected: selectTab,
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              _buildView(_selectedIndex),
                                              const _AdminFooter(),
                                            ],
                                          ),
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
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildView(int index) {
    switch (index) {
      case 0:
        return _DashboardView(onOpenTab: selectTab);
      case 1:
        return const _UsersView();
      case 2:
        return const _QueueView();
      case 3:
        return const _ToolsView();
      case 4:
        return _GenerationsView(onCountChanged: (count) {
          if (_pendingCount != count) {
            setState(() => _pendingCount = count);
          }
        });
      case 5:
        return const _RevenueTab();
      case 6:
        return const _SystemTab();
      default:
        return const SizedBox.shrink();
    }
  }
}

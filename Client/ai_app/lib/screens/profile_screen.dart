import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../core/app_colors.dart';
import '../core/app_fonts.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../core/messages.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';
import 'home_screen.dart';
import 'pricing_screen.dart';

/// User profile hub mirroring the `reel-user-profile.html` mockup: a sticky
/// top nav, a sidebar with the identity card + section links, and a tabbed
/// main area (overview / my roll / settings / plans & billing).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int _tabOverview = 0;
  static const int _tabMyRoll = 1;
  static const int _tabSettings = 2;
  static const int _tabBilling = 3;

  int _tab = _tabOverview;
  String _rollFilter = 'all';

  Map<String, dynamic>? _userProfile;
  bool _uploadingAvatar = false;
  Map<String, dynamic>? _usage;
  List<Map<String, dynamic>> _history = const [];
  List<Map<String, dynamic>> _payments = const [];
  bool _isLoading = true;

  // Inline notice rendered at the top of the screen content when
  // settings actions / back-navigation return with a result.
  String? _successNotice;
  String? _errorNotice;
  String? _infoNotice;

  // Settings form state. The server only accepts full_name on /users/me,
  // so email stays read-only and password change goes to its own endpoint.
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _currentPwController;
  late final TextEditingController _newPwController;
  late final TextEditingController _confirmPwController;
  bool _currentPwVisible = false;
  bool _newPwVisible = false;
  bool _confirmPwVisible = false;
  bool _savingProfile = false;
  bool _savingPassword = false;
  String? _profileFormError;
  String? _passwordFormError;

  String _prefRatio = '16:9';
  String _prefStock = 'Cinematic';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _currentPwController = TextEditingController();
    _newPwController = TextEditingController();
    _confirmPwController = TextEditingController();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPwController.dispose();
    _newPwController.dispose();
    _confirmPwController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    if (AuthSession.accessToken == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      // Share the application-wide Dio so the refresh-on-401 interceptor
      // also covers this view. Building a fresh Dio here would mean
      // each screen push opens a new TCP connection.
      final dio = ApiClient.instance.dio;
      final profile = await dio.get('/users/me');
      final profileData = Map<String, dynamic>.from(profile.data as Map);
      // Supplementary data: a failure in any of these keeps the profile
      // usable — the matching section simply renders empty/default.
      final results = await Future.wait<dynamic>([
        dio.get('/generate/usage'),
        dio.get('/generate/history'),
        dio.get('/payments/me'),
      ]).catchError((_) => <dynamic>[null, null, null]);

      if (!mounted) return;
      setState(() {
        _userProfile = profileData;
        _usage = results[0] == null
            ? null
            : Map<String, dynamic>.from(results[0].data as Map);
        _history = results[1] == null
            ? const []
            : (results[1].data as List)
                  .map((item) => Map<String, dynamic>.from(item as Map))
                  .toList();
        _payments = results[2] == null
            ? const []
            : (results[2].data as List)
                  .map((item) => Map<String, dynamic>.from(item as Map))
                  .toList();
        _isLoading = false;
      });
      _nameController.text = profileData['full_name']?.toString() ?? '';
      _emailController.text = profileData['email']?.toString() ?? '';
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        final l10n = AppLocalizations.of(context);
        // Profile-load failure isn't a form submission. Surface it
        // as an inline notice at the top of the content rather than
        // a transient toast so the user can read it after the
        // back-navigation is complete.
        _errorNotice = l10n.profileLoadFailed(e.message ?? '');
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Settings actions
  // ---------------------------------------------------------------------------

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _profileFormError = null);
      return;
    }
    setState(() {
      _savingProfile = true;
      _profileFormError = null;
    });
    try {
      final response = await ApiClient.instance.dio.put(
        '/users/me',
        data: {'full_name': name},
      );
      if (!mounted) return;
      AuthSession.fullName =
          (response.data as Map?)?['full_name']?.toString() ?? name;
      final l10n = AppLocalizations.of(context);
      setState(() {
        _successNotice = l10n.profileSettingsSaved;
        _infoNotice = null;
      });
      await _loadProfile();
    } on DioException catch (e) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      setState(
        () => _profileFormError = _dioDetail(e) ?? l10n.editProfileSaveFailed,
      );
    } finally {
      if (mounted) setState(() => _savingProfile = false);
    }
  }

  Future<void> _savePassword() async {
    final l10n = AppLocalizations.of(context);
    final current = _currentPwController.text;
    final next = _newPwController.text;
    final confirm = _confirmPwController.text;
    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      setState(() => _passwordFormError = l10n.errorPasswordRequired);
      return;
    }
    if (next.length < 8) {
      setState(() => _passwordFormError = l10n.changePasswordTooShort);
      return;
    }
    if (next != confirm) {
      setState(() => _passwordFormError = l10n.changePasswordMismatch);
      return;
    }
    setState(() {
      _savingPassword = true;
      _passwordFormError = null;
    });
    try {
      await ApiClient.instance.dio.post(
        '/auth/change-password',
        data: {'current_password': current, 'new_password': next},
      );
      if (!mounted) return;
      _currentPwController.clear();
      _newPwController.clear();
      _confirmPwController.clear();
      final l10n2 = AppLocalizations.of(context);
      setState(() {
        _successNotice = l10n2.profilePasswordUpdated;
        _infoNotice = null;
      });
    } on DioException catch (e) {
      if (!mounted) return;
      final l10n3 = AppLocalizations.of(context);
      setState(
        () => _passwordFormError = _dioDetail(e) ?? l10n3.changePasswordFailed,
      );
    } finally {
      if (mounted) setState(() => _savingPassword = false);
    }
  }

  String? _dioDetail(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['detail'] is String) {
      return data['detail'] as String;
    }
    return null;
  }

  Future<void> _confirmDeleteAccount() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          l10n.profileDeleteAccount,
          style: AppFonts.spaceGrotesk(
            color: AppColors.parchment,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          l10n.profileDangerDesc,
          style: AppFonts.inter(
            color: AppColors.parchmentDim,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              l10n.libraryDeleteCancel,
              style: AppFonts.inter(color: AppColors.smoke, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.profileDeleteAccount,
              style: AppFonts.inter(
                color: const Color(0xFFFF9D9D),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    // The backend has no self-service delete endpoint yet; the terms route
    // deletions through support, so surface that instead of a dead call.
    setState(() {
      _infoNotice = AppLocalizations.of(context).profileDeleteNotice;
      _successNotice = null;
      _errorNotice = null;
    });
  }

  // ---------------------------------------------------------------------------
  // Derived data
  // ---------------------------------------------------------------------------

  String get _fullName {
    final name = _userProfile?['full_name']?.toString().trim();
    if (name != null && name.isNotEmpty) return name;
    return AuthSession.fullName ?? 'REEL';
  }

  String get _handle {
    final base = _fullName.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    return '@$base.reel';
  }

  bool get _isPro =>
      _payments.any((payment) => payment['status'] == 'completed');

  int get _creditBalance => (_usage?['credit_balance'] as num?)?.toInt() ?? 0;

  String? get _avatarUrl => _userProfile?['avatar_url']?.toString();

  /// Opens the gallery picker and uploads the chosen image to
  /// `/users/me/avatar`. The server re-encodes the file, stores it and
  /// returns the public URL; we mirror it into the in-memory profile and
  /// the persisted session so the header pill picks it up immediately.
  Future<void> _pickAndUploadAvatar() async {
    if (_uploadingAvatar) return;
    final l10n = AppLocalizations.of(context);
    final XFile? picked;
    try {
      picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );
    } on Exception {
      return; // picker unavailable — nothing to upload
    }
    if (picked == null) return; // user cancelled

    final ext = picked.name.contains('.')
        ? picked.name.split('.').last.toLowerCase()
        : 'jpeg';
    final mediaType = switch (ext) {
      'png' => MediaType('image', 'png'),
      'webp' => MediaType('image', 'webp'),
      _ => MediaType('image', 'jpeg'),
    };

    setState(() => _uploadingAvatar = true);
    try {
      final bytes = await picked.readAsBytes();
      final response = await ApiClient.instance.dio.post(
        '/users/me/avatar',
        data: FormData.fromMap({
          'file': MultipartFile.fromBytes(
            bytes,
            filename: picked.name,
            contentType: mediaType,
          ),
        }),
      );
      final url = response.data['avatar_url']?.toString() ?? '';
      if (!mounted) return;
      if (url.isNotEmpty) {
        setState(() {
          _userProfile = {...?_userProfile, 'avatar_url': url};
        });
        await AuthSession.updateAvatar(url);
        if (!mounted) return;
        showMessage(context, l10n.avatarUpdated);
      }
    } on DioException catch (error) {
      if (mounted) {
        showMessage(
          context,
          dioErrorFromContext(context, error, l10n.avatarUpdateFailed),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingAvatar = false);
    }
  }

  /// Most-generated type across the history — the "Top tool" stat card.
  /// The history API doesn't expose per-item style, so we derive the tool
  /// from `type` (image/video) instead of the old favorite-stock logic.
  String _favoriteToolLabel(AppLocalizations l10n) {
    var images = 0;
    var videos = 0;
    for (final item in _history) {
      if ((item['type']?.toString() ?? '').toLowerCase() == 'video') {
        videos++;
      } else {
        images++;
      }
    }
    return videos > images ? l10n.libraryFilterVideo : l10n.profileFilterPhoto;
  }

  int get _daysTogether {
    final createdAt = DateTime.tryParse(
      _userProfile?['created_at']?.toString() ?? '',
    );
    if (createdAt == null) return 0;
    return DateTime.now().difference(createdAt).inDays.clamp(0, 100000);
  }

  String _relativeTime(dynamic value, AppLocalizations l10n) {
    final parsed = DateTime.tryParse(value?.toString() ?? '')?.toLocal();
    if (parsed == null) return '';
    final diff = DateTime.now().difference(parsed);
    if (diff.inMinutes < 1) return l10n.profileTimeJustNow;
    if (diff.inMinutes < 60) return l10n.profileTimeMinutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.profileTimeHoursAgo(diff.inHours);
    if (diff.inDays == 1) return l10n.profileTimeYesterday;
    if (diff.inDays < 7) return l10n.profileTimeDaysAgo(diff.inDays);
    final weeks = diff.inDays ~/ 7;
    if (weeks == 1) return l10n.profileTimeDaysAgo(diff.inDays);
    return l10n.profileTimeWeeksAgo(weeks);
  }

  String _ratioLabel(dynamic ratio) {
    final r = ratio?.toString().trim() ?? '';
    if (r == '1:1' || r == '9:16' || r == '16:9') return r;
    return '16:9';
  }

  String _tagFor(Map<String, dynamic> item, AppLocalizations l10n) {
    final type = (item['type']?.toString() ?? 'image').toLowerCase();
    final head = type == 'image' ? l10n.profilePhotoTag : type.toUpperCase();
    return '$head · ${_ratioLabel(item['aspect_ratio'])}';
  }

  List<Map<String, dynamic>> get _filteredRoll {
    if (_rollFilter == 'all') return _history;
    return _history.where((item) {
      final type = (item['type']?.toString() ?? 'image').toLowerCase();
      final ratio = _ratioLabel(item['aspect_ratio']);
      return switch (_rollFilter) {
        'video' => type == 'video',
        'photo' => type == 'image',
        _ => ratio == _rollFilter,
      };
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

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
                _buildNav(l10n),
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.azure,
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 1180,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  24,
                                  28,
                                  24,
                                  40,
                                ),
                                child: _buildPage(l10n),
                              ),
                            ),
                          ),
                        ),
                ),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top nav
  // ---------------------------------------------------------------------------

  Widget _buildNav(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xB806070B),
        border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
      ),
      child: Row(
        children: [
          const _BrandMark(),
          const SizedBox(width: 18),
          Container(width: 1, height: 16, color: AppColors.lineSoft),
          const SizedBox(width: 18),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => Navigator.of(context).maybePop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back_rounded,
                    size: 15,
                    color: AppColors.smoke,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    l10n.profileBackHome,
                    style: AppFonts.inter(
                      color: AppColors.smoke,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 14, 5),
            decoration: BoxDecoration(
              color: AppColors.glass,
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Avatar(
                  size: 26,
                  fontSize: 11,
                  initials: _initials(),
                  avatarUrl: _avatarUrl,
                ),
                const SizedBox(width: 9),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 140),
                  child: Text(
                    _fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.inter(
                      color: AppColors.mist,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Page layout: sidebar + main
  // ---------------------------------------------------------------------------

  Widget _buildPage(AppLocalizations l10n) {
    if (_userProfile == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Center(
          child: Text(
            l10n.profileNotLoaded,
            style: AppFonts.spaceGrotesk(
              color: AppColors.parchmentDim,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    final sidebar = _buildSidebar(l10n);
    final main = _buildMain(l10n);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 920;
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 250, child: sidebar),
              const SizedBox(width: 26),
              Expanded(child: main),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [sidebar, const SizedBox(height: 20), main],
        );
      },
    );
  }

  Widget _buildSidebar(AppLocalizations l10n) {
    final navItems = [
      (
        _tabOverview,
        Icons.grid_view_outlined,
        l10n.profileNavOverview,
      ),
      (_tabMyRoll, Icons.movie_outlined, l10n.profileNavMyRoll),
      (_tabSettings, Icons.settings_outlined, l10n.profileNavSettings),
      (_tabBilling, Icons.credit_card_outlined, l10n.profileNavBilling),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReelGlass(
          radius: 20,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            children: [
              _AvatarPicker(
                avatarUrl: _avatarUrl,
                initials: _initials(),
                uploading: _uploadingAvatar,
                onTap: _pickAndUploadAvatar,
              ),
              const SizedBox(height: 14),
              Text(
                _fullName,
                textAlign: TextAlign.center,
                style: AppFonts.spaceGrotesk(
                  color: AppColors.mist,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _handle,
                style: AppFonts.jetBrainsMono(
                  color: AppColors.smoke,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.azure.withValues(alpha: .1),
                  border: Border.all(color: AppColors.line),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.azureSoft,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isPro ? l10n.profileProChip : l10n.profileFreeChip,
                      style: AppFonts.jetBrainsMono(
                        color: AppColors.azureSoft,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ReelGlass(
          radius: 16,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              for (final (index, icon, label) in navItems)
                _SideLink(
                  icon: icon,
                  label: label,
                  active: _tab == index,
                  onTap: () => setState(() => _tab = index),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SideLink(
          icon: Icons.logout_rounded,
          label: l10n.profileLogout,
          active: false,
          destructive: true,
          onTap: _logout,
        ),
      ],
    );
  }

  Future<void> _logout() async {
    final navigator = Navigator.of(context);
    await AuthSession.clear();
    if (!mounted) return;
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const ReelHomePage()),
      (route) => false,
    );
  }

  Widget _buildMain(AppLocalizations l10n) {
    final panel = switch (_tab) {
      _tabMyRoll => _buildMyRollPanel(l10n),
      _tabSettings => _buildSettingsPanel(l10n),
      _tabBilling => _buildBillingPanel(l10n),
      _ => _buildOverviewPanel(l10n),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_successNotice != null || _errorNotice != null || _infoNotice != null) ...[
          _InlineNotice(
            message: _successNotice ?? _infoNotice ?? _errorNotice!,
            tone: _successNotice != null
                ? _NoticeTone.success
                : _infoNotice != null
                ? _NoticeTone.info
                : _NoticeTone.error,
            onDismiss: () => setState(() {
              _successNotice = null;
              _errorNotice = null;
              _infoNotice = null;
            }),
          ),
          const SizedBox(height: 18),
        ],
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOut,
          child: KeyedSubtree(
            key: ValueKey(_tab),
            child: panel,
          ),
        ),
      ],
    );
  }

  Widget _panelHead(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.spaceGrotesk(
            color: AppColors.mist,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: AppFonts.inter(color: AppColors.smoke, fontSize: 14),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Overview panel
  // ---------------------------------------------------------------------------

  Widget _buildOverviewPanel(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHead(
          l10n.profileWelcomeBack(_fullName),
          l10n.profileWelcomeSub(_daysTogether),
        ),
        const SizedBox(height: 22),
        _buildStatGrid(l10n),
        const SizedBox(height: 22),
        _buildUsageCard(l10n),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.profileRecentActivity,
              style: AppFonts.spaceGrotesk(
                color: AppColors.mist,
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () => setState(() => _tab = _tabMyRoll),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  l10n.profileViewAll,
                  style: AppFonts.inter(
                    color: AppColors.azureSoft,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _buildFrameGrid(
          items: _history.take(4).toList(),
          includeMeta: false,
        ),
        const SizedBox(height: 16),
        // bytype chips — khớp reel-profile.html (số liệu theo mockup).
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _byTypeChip('🖼️ Ảnh', '56'),
            _byTypeChip('🎞️ Video', '12'),
            _byTypeChip('🎙️ Âm thanh', '18'),
            _byTypeChip('📖 Trang manga', '8'),
            _byTypeChip('🧊 3D & Bản đồ', '2'),
          ],
        ),
      ],
    );
  }

  Widget _byTypeChip(String label, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppFonts.inter(color: AppColors.smoke, fontSize: 11.5),
          ),
          const SizedBox(width: 5),
          Text(
            count,
            style: AppFonts.inter(
              color: AppColors.mist,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatGrid(AppLocalizations l10n) {
    final stats = [
      ('$_creditBalance', l10n.profileStatCredits),
      ('${_history.length}', l10n.profileStatTotalTakes),
      (_favoriteToolLabel(l10n), l10n.profileStatFavoriteStock),
      (l10n.profileStatDaysValue(_daysTogether), l10n.profileStatDaysLabel),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 760 ? 4 : 2;
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: constraints.maxWidth / columns / 96,
          children: [
            for (final (value, label) in stats)
              ReelGlass(
                radius: 16,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.spaceGrotesk(
                        color: AppColors.mist,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      label.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.jetBrainsMono(
                        color: AppColors.smoke,
                        fontSize: 9.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  /// Credits burned on completed generations today (local timezone).
  /// Failed generations are excluded — the server refunds those, so
  /// counting them would overstate real usage.
  int get _creditsSpentToday {
    final now = DateTime.now();
    var spent = 0;
    for (final item in _history) {
      if (item['status'] != 'completed') continue;
      final created = DateTime.tryParse(item['created_at']?.toString() ?? '');
      if (created == null) continue;
      final local = created.toLocal();
      if (local.year == now.year &&
          local.month == now.month &&
          local.day == now.day) {
        spent += (item['credit_cost'] as num?)?.toInt() ?? 0;
      }
    }
    return spent;
  }

  Widget _buildUsageCard(AppLocalizations l10n) {
    final spentToday = _creditsSpentToday;
    final pool = spentToday + _creditBalance;
    final percent = pool > 0 ? (spentToday / pool).clamp(0.0, 1.0) : 0.0;
    return ReelGlass(
      radius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.profileCreditsAvailable(_creditBalance),
                  style: AppFonts.inter(
                    color: AppColors.mist,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                l10n.profileUsageSpentToday(spentToday),
                style: AppFonts.jetBrainsMono(
                  color: AppColors.smoke,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 8,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const ColoredBox(color: AppColors.lineSoft),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percent,
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.profileTopUpHint,
                  style: AppFonts.inter(
                    color: AppColors.smoke,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              ReelButton(
                label: l10n.profileTopUp,
                onPressed: _openPricing,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openPricing() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PricingScreen()),
    );
    if (!mounted) return;
    await _loadProfile();
  }

  // ---------------------------------------------------------------------------
  // My roll panel
  // ---------------------------------------------------------------------------

  Widget _buildMyRollPanel(AppLocalizations l10n) {
    final filters = [
      ('all', l10n.profileFilterAll),
      ('video', l10n.profileFilterVideo),
      ('photo', l10n.profileFilterPhoto),
      ('16:9', '16:9'),
      ('9:16', '9:16'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHead(l10n.profileNavMyRoll, l10n.profileMyRollSub),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final (value, label) in filters)
              _FilterChip(
                label: label,
                active: _rollFilter == value,
                onTap: () => setState(() => _rollFilter = value),
              ),
          ],
        ),
        const SizedBox(height: 18),
        if (_filteredRoll.isEmpty)
          _EmptyState(message: l10n.profileMyRollEmpty)
        else
          _buildFrameGrid(items: _filteredRoll, includeMeta: true),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Settings panel
  // ---------------------------------------------------------------------------

  Widget _buildSettingsPanel(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHead(l10n.profileNavSettings, l10n.profileSettingsSub),
        const SizedBox(height: 22),
        ReelGlass(
          radius: 18,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(l10n.profileSectionProfileInfo),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoColumns = constraints.maxWidth > 640;
                  final nameField = _settingsField(
                    label: l10n.profileFieldDisplayName,
                    controller: _nameController,
                  );
                  final emailField = _settingsField(
                    label: l10n.profileFieldEmail,
                    controller: _emailController,
                    readOnly: true,
                  );
                  return twoColumns
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: nameField),
                            const SizedBox(width: 16),
                            Expanded(child: emailField),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            nameField,
                            const SizedBox(height: 16),
                            emailField,
                          ],
                        );
                },
              ),
              if (_profileFormError != null) ...[
                const SizedBox(height: 12),
                Text(
                  _profileFormError!,
                  style: AppFonts.inter(
                    color: AppColors.coral,
                    fontSize: 12.5,
                  ),
                ),
              ],
              const SizedBox(height: 18),
              ReelButton(
                label: l10n.profileSaveChanges,
                onPressed: _savingProfile ? null : _saveProfile,
                loading: _savingProfile,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ReelGlass(
          radius: 18,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(l10n.profileSectionPassword),
              const SizedBox(height: 16),
              _passwordField(
                label: l10n.profileFieldCurrentPassword,
                controller: _currentPwController,
                visible: _currentPwVisible,
                placeholder: l10n.profilePwPlaceholder,
                onToggle: () => setState(
                  () => _currentPwVisible = !_currentPwVisible,
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoColumns = constraints.maxWidth > 640;
                  final newField = _passwordField(
                    label: l10n.profileFieldNewPassword,
                    controller: _newPwController,
                    visible: _newPwVisible,
                    placeholder: l10n.profilePwNewPlaceholder,
                    onToggle: () =>
                        setState(() => _newPwVisible = !_newPwVisible),
                  );
                  final confirmField = _passwordField(
                    label: l10n.profileFieldConfirmPassword,
                    controller: _confirmPwController,
                    visible: _confirmPwVisible,
                    placeholder: l10n.profilePwConfirmPlaceholder,
                    onToggle: () => setState(
                      () => _confirmPwVisible = !_confirmPwVisible,
                    ),
                  );
                  return twoColumns
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: newField),
                            const SizedBox(width: 16),
                            Expanded(child: confirmField),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            newField,
                            const SizedBox(height: 16),
                            confirmField,
                          ],
                        );
                },
              ),
              if (_passwordFormError != null) ...[
                const SizedBox(height: 12),
                Text(
                  _passwordFormError!,
                  style: AppFonts.inter(
                    color: AppColors.coral,
                    fontSize: 12.5,
                  ),
                ),
              ],
              const SizedBox(height: 18),
              ReelButton(
                label: l10n.profileUpdatePassword,
                onPressed: _savingPassword ? null : _savePassword,
                loading: _savingPassword,
                primary: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ReelGlass(
          radius: 18,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(l10n.profileSectionPrefs),
              const SizedBox(height: 16),
              _prefRow(
                title: l10n.profilePrefRatio,
                subtitle: l10n.profilePrefRatioDesc,
                options: const ['16:9', '1:1', '9:16'],
                activeIndex: _prefRatio == '16:9'
                    ? 0
                    : _prefRatio == '1:1'
                    ? 1
                    : 2,
                onChanged: (i) =>
                    setState(() => _prefRatio = ['16:9', '1:1', '9:16'][i]),
              ),
              const SizedBox(height: 14),
              _prefRow(
                title: l10n.profilePrefStock,
                subtitle: l10n.profilePrefStockDesc,
                // 'Anime' hiển thị theo mockup; khi dùng làm style mặc định
                // cho generator nó được map sang 'Animated' mà backend nhận.
                options: const ['Cinematic', 'Anime', 'Studio'],
                activeIndex: _prefStock == 'Cinematic'
                    ? 0
                    : _prefStock == 'Anime'
                    ? 1
                    : 2,
                onChanged: (i) => setState(
                  () => _prefStock = ['Cinematic', 'Anime', 'Studio'][i],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0x0DFF5050),
            border: Border.all(color: const Color(0x40FF6464)),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.profileDangerTitle,
                style: AppFonts.spaceGrotesk(
                  color: const Color(0xFFFF9D9D),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.profileDangerDesc,
                style: AppFonts.inter(
                  color: AppColors.smoke,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              _DangerButton(label: l10n.profileDeleteAccount, onTap: _confirmDeleteAccount),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: AppFonts.spaceGrotesk(
        color: AppColors.mist,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _settingsField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.inter(
            color: AppColors.smoke,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          readOnly: readOnly,
          style: AppFonts.inter(color: AppColors.mist, fontSize: 14),
          cursorColor: AppColors.azure,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0x09FFFFFF),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 13,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.azure,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool visible,
    required String placeholder,
    required VoidCallback onToggle,
  }) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.inter(
            color: AppColors.smoke,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: !visible,
          style: AppFonts.inter(color: AppColors.mist, fontSize: 14),
          cursorColor: AppColors.azure,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0x09FFFFFF),
            isDense: true,
            contentPadding: const EdgeInsets.only(
              left: 13,
              right: 52,
              top: 13,
              bottom: 13,
            ),
            hintText: placeholder,
            hintStyle: AppFonts.inter(
              color: AppColors.muted,
              fontSize: 13.5,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.azure,
                width: 1.2,
              ),
            ),
            suffixIcon: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onToggle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  visible ? l10n.profilePwHide : l10n.profilePwShow,
                  style: AppFonts.inter(
                    color: AppColors.smoke,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 44),
          ),
        ),
      ],
    );
  }

  Widget _prefRow({
    required String title,
    required String subtitle,
    required List<String> options,
    required int activeIndex,
    required ValueChanged<int> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFonts.inter(
                  color: AppColors.mist,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppFonts.inter(color: AppColors.smoke, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        _Segmented(options: options, activeIndex: activeIndex, onChanged: onChanged),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Billing panel
  // ---------------------------------------------------------------------------

  Widget _buildBillingPanel(AppLocalizations l10n) {
    final isPro = _isPro;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHead(l10n.profileNavBilling, l10n.profileBillingSub),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.azure.withValues(alpha: .1),
                AppColors.coral.withValues(alpha: .05),
              ],
            ),
            border: Border.all(color: AppColors.azure.withValues(alpha: .35)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profileCurrentPlan.toUpperCase(),
                      style: AppFonts.jetBrainsMono(
                        color: AppColors.smoke,
                        fontSize: 11,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          isPro ? 'Pro' : 'Free',
                          style: AppFonts.spaceGrotesk(
                            color: AppColors.mist,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            isPro
                                ? l10n.profilePlanPerMonth
                                : l10n.profilePlanPayAsYouGo,
                            style: AppFonts.inter(
                              color: AppColors.smoke,
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ReelButton(
                label: l10n.profileUpgradePro,
                onPressed: _openPricing,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns = constraints.maxWidth > 640;
            final freeCard = _miniPlanCard(
              name: 'Free',
              price: l10n.profilePlanFreePrice,
              features: [l10n.profilePlanFreeF1, l10n.profilePlanFreeF2],
              current: !isPro,
            );
            final proCard = _miniPlanCard(
              name: 'Pro',
              price: l10n.profilePlanProPrice,
              features: [l10n.profilePlanProF1, l10n.profilePlanProF2],
              current: isPro,
              showUpgrade: true,
            );
            return twoColumns
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: freeCard),
                      const SizedBox(width: 14),
                      Expanded(child: proCard),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      freeCard,
                      const SizedBox(height: 14),
                      proCard,
                    ],
                  );
          },
        ),
        const SizedBox(height: 24),
        Text(
          l10n.profilePaymentHistory,
          style: AppFonts.spaceGrotesk(
            color: AppColors.mist,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        if (_payments.isEmpty)
          _EmptyState(message: l10n.profileEmptyPayments, icon: Icons.credit_card_outlined)
        else
          Column(
            children: [
              for (final payment in _payments)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.glass,
                    border: Border.all(color: AppColors.line),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _relativeTime(payment['created_at'], l10n),
                          style: AppFonts.jetBrainsMono(
                            color: AppColors.smoke,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                      Text(
                        '${payment['amount'] ?? ''} ${payment['currency'] ?? ''}'
                            .trim(),
                        style: AppFonts.spaceGrotesk(
                          color: AppColors.mist,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if ((payment['status'] ?? '') == 'completed')
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x227EE0A8),
                            border: Border.all(
                              color: const Color(0x667EE0A8),
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            Localizations.localeOf(context).languageCode == 'vi'
                                ? 'THÀNH CÔNG'
                                : 'SUCCESS',
                            style: AppFonts.jetBrainsMono(
                              color: const Color(0xFF7EE0A8),
                              fontSize: 9,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _miniPlanCard({
    required String name,
    required String price,
    required List<String> features,
    required bool current,
    bool showUpgrade = false,
  }) {
    final l10n = AppLocalizations.of(context);
    return ReelGlass(
      radius: 16,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppFonts.inter(
                  color: AppColors.mist,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (current)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.azure.withValues(alpha: .4),
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    l10n.profileCurrentTag,
                    style: AppFonts.jetBrainsMono(
                      color: AppColors.azureSoft,
                      fontSize: 9,
                      letterSpacing: 1,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: AppFonts.spaceGrotesk(
                  color: AppColors.mist,
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ' ${l10n.profilePlanPerMonth}',
                style: AppFonts.inter(color: AppColors.smoke, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final feature in features)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_rounded,
                    size: 13,
                    color: AppColors.azureSoft,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppFonts.inter(
                        color: AppColors.smoke,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (showUpgrade) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ReelButton(
                label: l10n.profileUpgradeShort,
                onPressed: _openPricing,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Frame grid (recent activity / my roll)
  // ---------------------------------------------------------------------------

  Widget _buildFrameGrid({
    required List<Map<String, dynamic>> items,
    required bool includeMeta,
  }) {
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width > 760 ? 3 : (width > 480 ? 2 : 1);
        final gap = 14.0;
        final cardWidth = (width - gap * (columns - 1)) / columns;
        final cardHeight = cardWidth * 3 / 4;
        final extent = includeMeta ? cardHeight + 26 : cardHeight;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: gap,
            mainAxisSpacing: gap,
            mainAxisExtent: extent,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final card = _FrameCard(
              item: item,
              tag: _tagFor(item, l10n),
              label: (item['prompt']?.toString() ?? '').toUpperCase(),
              variant: index % 6,
            );
            if (!includeMeta) return card;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: card),
                const SizedBox(height: 6),
                Text(
                  _relativeTime(item['created_at'], l10n),
                  style: AppFonts.jetBrainsMono(
                    color: AppColors.smoke,
                    fontSize: 10.5,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Footer
  // ---------------------------------------------------------------------------

  Widget _buildFooter() {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lineSoft)),
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

  String _initials() {
    final trimmed = _fullName.trim();
    if (trimmed.isEmpty) return 'U';
    return trimmed[0].toUpperCase();
  }
}

// =============================================================================
// Shared pieces
// =============================================================================

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        gradient: AppColors.spectrum,
        borderRadius: BorderRadius.circular(7),
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
      // The gradient mark doubles as the wordmark anchor; the REEL text
      // sits next to it in the nav row.
    );
  }
}

/// Large tappable avatar with a camera affordance. Tapping opens the
/// gallery picker; while the upload runs the whole disc turns into a
/// progress indicator.
class _AvatarPicker extends StatelessWidget {
  final String? avatarUrl;
  final String initials;
  final bool uploading;
  final VoidCallback onTap;

  const _AvatarPicker({
    required this.avatarUrl,
    required this.initials,
    required this.uploading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: l10n.avatarChangeHint,
      child: InkWell(
        onTap: uploading ? null : onTap,
        borderRadius: BorderRadius.circular(999),
        customBorder: const CircleBorder(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 64,
              height: 64,
              foregroundDecoration: uploading
                  ? BoxDecoration(
                      color: AppColors.ink.withValues(alpha: .6),
                      shape: BoxShape.circle,
                    )
                  : null,
              child: _Avatar(
                size: 64,
                fontSize: 24,
                initials: initials,
                avatarUrl: avatarUrl,
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.line),
                ),
                child: uploading
                    ? const Padding(
                        padding: EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          strokeWidth: 1.8,
                          color: AppColors.brassLt,
                        ),
                      )
                    : const Icon(
                        Icons.photo_camera_outlined,
                        size: 12,
                        color: AppColors.smoke,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final double size;
  final double fontSize;
  final String initials;
  final String? avatarUrl;

  const _Avatar({
    required this.size,
    required this.fontSize,
    required this.initials,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final image = avatarUrl;
    final hasImage = image != null && image.isNotEmpty;
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: AppColors.spectrum,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: hasImage
          ? Image.network(
              image,
              fit: BoxFit.cover,
              width: size,
              height: size,
              errorBuilder: (_, _, _) => _initialText(),
            )
          : _initialText(),
    );
  }

  Widget _initialText() {
    return Text(
      initials,
      style: AppFonts.spaceGrotesk(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _SideLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool destructive;
  final VoidCallback onTap;

  const _SideLink({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final contentColor = destructive
        ? AppColors.smoke
        : active
        ? Colors.white
        : AppColors.smoke;
    final container = Container(
      decoration: BoxDecoration(
        gradient: active
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0x333D7CFF),
                  Color(0x298B7BFF),
                ],
              )
            : null,
        border: active
            ? Border.all(color: AppColors.azure.withValues(alpha: .35))
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(11),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        hoverColor: AppColors.glassStrong,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          child: Row(
            children: [
              Icon(icon, size: 17, color: contentColor),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.inter(
                    color: contentColor,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (!destructive) return container;
    // Logout gets the mockup's hover-to-red affordance.
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: container,
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(
                  colors: [Color(0x383D7CFF), Color(0x33FF9466)],
                )
              : null,
          color: active ? null : AppColors.glass,
          border: Border.all(
            color: active ? AppColors.azure : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: AppFonts.inter(
            color: active ? Colors.white : AppColors.smoke,
            fontSize: 12.5,
          ),
        ),
      ),
    );
  }
}

class _Segmented extends StatelessWidget {
  final List<String> options;
  final int activeIndex;
  final ValueChanged<int> onChanged;

  const _Segmented({
    required this.options,
    required this.activeIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0x09FFFFFF),
        border: Border.all(color: AppColors.lineSoft),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < options.length; i++)
            GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: i == activeIndex
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.azure, AppColors.indigo],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  options[i],
                  style: AppFonts.inter(
                    color: i == activeIndex ? Colors.white : AppColors.smoke,
                    fontSize: 12,
                    fontWeight: i == activeIndex
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DangerButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _DangerButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(11),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0x1FFF5050),
          border: Border.all(color: const Color(0x66FF6464)),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(
          label,
          style: AppFonts.inter(
            color: const Color(0xFFFF9D9D),
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const _EmptyState({required this.message, this.icon = Icons.movie_outlined});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lineSoft),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.smoke.withValues(alpha: .5)),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppFonts.inter(color: AppColors.smoke, fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}

/// One generation frame: gradient (or real image) backdrop, a ratio tag in
/// the top-right corner, a hover play affordance and a mono caption along
/// the bottom — the same "frame card" language as the mockup gallery.
class _FrameCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final String tag;
  final String label;
  final int variant;

  const _FrameCard({
    required this.item,
    required this.tag,
    required this.label,
    required this.variant,
  });

  @override
  State<_FrameCard> createState() => _FrameCardState();
}

class _FrameCardState extends State<_FrameCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.item['file_url']?.toString();
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final isVideo = widget.item['type']?.toString() == 'video';

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _hover ? const Color(0x33FFFFFF) : AppColors.line,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // mp4 URLs cannot render in Image.network; video cards keep
              // the gradient frame with a persistent play badge instead.
              if (hasImage && !isVideo)
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _frameBackground(widget.variant),
                )
              else
                _frameBackground(widget.variant),
              // Top-right tag pill.
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x8C06070B),
                    border: Border.all(color: AppColors.line),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    widget.tag,
                    style: AppFonts.jetBrainsMono(
                      color: AppColors.mist,
                      fontSize: 8.5,
                    ),
                  ),
                ),
              ),
              // Hover play affordance.
              Center(
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _hover ? 1 : 0,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0x59000000),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom caption scrim.
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 9,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0x99000000), Colors.transparent],
                    ),
                  ),
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.jetBrainsMono(
                      color: AppColors.mist,
                      fontSize: 9.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The six radial-glow gradient backdrops from the mockup (fc1–fc6):
  /// a base void colour plus two coloured glows placed per variant.
  Widget _frameBackground(int variant) {
    const setups = <(Alignment, Color, Alignment, Color)>[
      (Alignment(-0.7, -0.9), AppColors.coral, Alignment(0.9, 0.9), AppColors.azure),
      (Alignment(0.7, -0.9), AppColors.azure, Alignment(-0.9, 0.9), Colors.white),
      (Alignment(-0.8, 0.9), AppColors.coral, Alignment(0.9, -0.7), AppColors.indigo),
      (Alignment(0.8, -0.7), AppColors.indigo, Alignment(-0.8, 0.9), AppColors.azure),
      (Alignment(-0.8, 0.8), AppColors.coral, Alignment(0.9, -0.9), AppColors.indigo),
      (Alignment(0.8, 0.9), AppColors.azure, Alignment(-0.8, -0.7), AppColors.coral),
    ];
    final (c1, k1, c2, k2) = setups[variant.clamp(0, setups.length - 1)];

    return Container(
      color: AppColors.surface,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: c1,
                radius: 1.2,
                colors: [k1.withValues(alpha: .5), k1.withValues(alpha: 0)],
                stops: const [0, .65],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: c2,
                radius: 1.1,
                colors: [k2.withValues(alpha: .35), k2.withValues(alpha: 0)],
                stops: const [0, .65],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Inline notice rendered at the top of the profile screen body. We
/// keep it private to this file (instead of reusing the auth-screen
/// widget) because the auth form's `_InlineNotice` is a `part of`
/// member of `auth_screen.dart` and not exportable. The visual
/// language is identical.
enum _NoticeTone { success, info, error }

class _InlineNotice extends StatelessWidget {
  final String message;
  final _NoticeTone tone;
  final VoidCallback? onDismiss;

  const _InlineNotice({
    required this.message,
    required this.tone,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = switch (tone) {
      _NoticeTone.success => (AppColors.azure, Icons.check_circle_outline),
      _NoticeTone.info => (AppColors.azure, Icons.info_outline),
      _NoticeTone.error => (AppColors.coral, Icons.error_outline),
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
      decoration: BoxDecoration(
        color: scheme.$1.withValues(alpha: .08),
        border: Border.all(color: scheme.$1.withValues(alpha: .4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(scheme.$2, size: 16, color: scheme.$1),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppFonts.inter(
                color: AppColors.parchment,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: const Icon(Icons.close, size: 14),
              color: AppColors.smoke,
              onPressed: onDismiss,
              tooltip: 'Dismiss',
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../core/app_colors.dart';
import '../core/app_fonts.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../core/messages.dart';
import 'auth_screen.dart';
import 'library_screen.dart';
import 'pricing_screen.dart';
import 'profile_screen.dart';
import '../widgets/flagship_ui.dart';
import '../widgets/language_picker.dart';
import '../widgets/user_avatar_menu.dart';
import '../l10n/generated/app_localizations.dart';

part 'home/home_chrome.dart';
part 'home/home_generator.dart';
part 'home/home_studio.dart';
part 'home/tool_catalog.dart';

class ReelHomePage extends StatefulWidget {
  const ReelHomePage({super.key});

  @override
  State<ReelHomePage> createState() => _ReelHomePageState();
}

class _ReelHomePageState extends State<ReelHomePage> {
  final _scroll = ScrollController();
  final _topKey = GlobalKey();
  bool _scrolled = false;
  bool _rtl = false;
  final _pointer = ValueNotifier<Offset>(Offset.zero);

  /// Currently selected tool key — drives the workspace panel below the
  /// pinned mode grid. `image` and `video` hit the real API; every other
  /// tool opens a design-preview panel that toasts "coming soon".
  String _activeTool = 'image';
  String _ratio = '16:9';
  String _stock = 'Cinematic';
  int _durationSeconds = 5;
  String _videoQuality = '720p';
  String? _generatedImageUrl;
  String? _generatedVideoUrl;
  Map<String, dynamic>? _usage;
  bool _isGenerating = false;
  Timer? _videoPollTimer;

  /// Shared prompt between the image and video panels — "one prompt box",
  /// switching tools keeps the text so users can re-run the same idea.
  final TextEditingController _sceneController = TextEditingController(
    text: 'a lone astronaut surfing across the red dunes of mars, golden hour, wide shot',
  );
  final TextEditingController _genericController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final scrolled = _scroll.offset > 12;
      if (_scrolled != scrolled) setState(() => _scrolled = scrolled);
    });
    _loadUsage();
  }

  Future<void> _loadUsage() async {
    if (AuthSession.accessToken == null) {
      if (mounted) setState(() => _usage = null);
      return;
    }
    final dio = buildDio();
    try {
      final response = await dio.get('/generate/usage');
      if (mounted) {
        setState(
          () => _usage = Map<String, dynamic>.from(response.data as Map),
        );
      }
    } on DioException {
      // Usage is supplementary; generation remains usable if this request fails.
      if (mounted) setState(() => _usage = null);
    } finally {
      dio.close();
    }
  }

  @override
  void dispose() {
    _sceneController.dispose();
    _genericController.dispose();
    _scroll.dispose();
    _pointer.dispose();
    _videoPollTimer?.cancel();
    super.dispose();
  }

  Future<void> _generateImage() async {
    if (_isGenerating) return;
    final l10n = AppLocalizations.of(context);
    if (AuthSession.accessToken == null) {
      showMessage(context, l10n.loginPrompt);
      await _openAuth();
      return;
    }
    final prompt = _sceneController.text.trim();
    if (prompt.isEmpty) {
      showMessage(context, l10n.emptyPrompt);
      return;
    }

    setState(() {
      _isGenerating = true;
      _generatedImageUrl = null;
      _generatedVideoUrl = null;
    });
    final dio = buildDio(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(minutes: 10),
    );
    try {
      final response = await dio.post(
        '/generate/image',
        data: {
          'prompt': prompt,
          'aspect_ratio': _ratio,
          // Chip hiển thị "Anime" (theo mockup) — backend chỉ nhận
          // 'Animated' trong Literal style schema.
          'style': _stock == 'Anime' ? 'Animated' : _stock,
          'type': 'image',
        },
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      if (!mounted) return;
      setState(() => _generatedImageUrl = data['image_url'] as String?);
      if (_generatedImageUrl == null) {
        showMessage(context, l10n.noImageReturned);
      }
    } on DioException catch (error) {
      if (mounted) {
        showMessage(
          context,
          dioErrorFromContext(context, error, l10n.imageGenerationFailed),
        );
      }
    } finally {
      dio.close();
      // Refresh the wallet on both outcomes: the backend has already
      // deducted on success (and refunded on failure), so the header
      // credits pill and the usage line stay in sync with the server.
      _loadUsage();
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  Future<void> _generateVideo() async {
    if (_isGenerating) return;
    final l10n = AppLocalizations.of(context);
    if (AuthSession.accessToken == null) {
      showMessage(context, l10n.loginPrompt);
      await _openAuth();
      return;
    }
    final prompt = _sceneController.text.trim();
    if (prompt.isEmpty) {
      showMessage(context, l10n.emptyPrompt);
      return;
    }

    setState(() {
      _isGenerating = true;
      _generatedImageUrl = null;
      _generatedVideoUrl = null;
    });
    final dio = buildDio(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    );
    try {
      final response = await dio.post(
        '/generate/video',
        data: {
          'prompt': prompt,
          'aspect_ratio': _ratio,
          'duration_seconds': _durationSeconds,
          'quality': _videoQuality,
          'type': 'video',
        },
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      final generationId = data['generation_id'] as int?;
      if (!mounted) return;
      if (generationId == null) {
        setState(() => _isGenerating = false);
        showMessage(context, l10n.videoGenerationFailed);
        return;
      }
      showMessage(context, l10n.videoQueuedMessage);
      _startVideoPolling(generationId);
    } on DioException catch (error) {
      if (mounted) {
        showMessage(
          context,
          dioErrorFromContext(context, error, l10n.videoGenerationFailed),
        );
        setState(() => _isGenerating = false);
      }
      _loadUsage();
    } finally {
      dio.close();
    }
  }

  /// Polls the async video job until it completes, fails or the deadline
  /// passes. Keeps [_isGenerating] true the whole time so the submit button
  /// stays disabled and the panel shows the rendering state.
  void _startVideoPolling(int generationId) {
    _videoPollTimer?.cancel();
    final deadline = DateTime.now().add(const Duration(minutes: 20));
    _videoPollTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        final dio = buildDio(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
        );
        try {
          final response = await dio.get('/generate/video/$generationId');
          final data = Map<String, dynamic>.from(response.data as Map);
          final jobStatus = data['status']?.toString();
          if (!mounted) return;
          if (jobStatus == 'completed') {
            timer.cancel();
            setState(() {
              _generatedVideoUrl = data['video_url']?.toString();
              _isGenerating = false;
            });
            _loadUsage();
          } else if (jobStatus == 'failed') {
            timer.cancel();
            setState(() => _isGenerating = false);
            showMessage(
              context,
              data['error_message']?.toString().isNotEmpty == true
                  ? '${AppLocalizations.of(context).videoGenerationFailed} (${data['error_message']})'
                  : AppLocalizations.of(context).videoGenerationFailed,
            );
            _loadUsage();
          } else if (DateTime.now().isAfter(deadline)) {
            timer.cancel();
            setState(() => _isGenerating = false);
            showMessage(context, AppLocalizations.of(context).videoTimeoutMessage);
          }
        } on DioException {
          // Transient network hiccup — keep polling until the deadline.
        } finally {
          dio.close();
        }
      },
    );
  }

  /// Design-preview tools: nothing hits the server, we just announce it.
  void _generateOnPreviewTool() {
    final entry = _toolByKey(_activeTool);
    final name = entry?.nameOf(context) ?? _activeTool;
    showMessage(context, AppLocalizations.of(context).toolComingSoon(name));
  }

  // Panel setters — panels are separate widgets in the same library, they
  // mutate workspace options through these instead of touching setState.
  void setRatio(String value) => setState(() => _ratio = value);
  void setStock(String value) => setState(() => _stock = value);
  void setDuration(int value) => setState(() => _durationSeconds = value);
  void setQuality(String value) => setState(() => _videoQuality = value);

  Future<void> _openAuth() async {
    await _push(const AuthScreen());
  }

  /// Pushes a screen and refreshes session-dependent UI (credits pill,
  /// signed-in header state) when the user comes back.
  Future<void> _push(Widget screen) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    if (mounted) {
      setState(() {});
      await _loadUsage();
    }
  }

  /// Opens the tool-catalog dialog and activates whatever tool was picked.
  Future<void> _openCatalog() async {
    final key = await showDialog<String>(
      context: context,
      barrierColor: AppColors.ink.withValues(alpha: .66),
      builder: (_) => _ToolCatalogDialog(selectedKey: _activeTool),
    );
    if (key == null || !mounted) return;
    _selectTool(key);
  }

  void _selectTool(String key) {
    setState(() => _activeTool = key);
    if (key == 'image' || key == 'video') return;
    // Preview tools still open their panel, but we announce right away
    // that live generation is image/video only.
    final entry = _toolByKey(key);
    if (entry != null) {
      showMessage(
        context,
        AppLocalizations.of(context).toolComingSoon(entry.nameOf(context)),
      );
    }
  }

  void _navigate(String section) {
    switch (section) {
      case 'library':
        _push(const LibraryScreen());
        return;
      case 'pricing':
        _push(const PricingScreen());
        return;
      case 'profile':
        if (AuthSession.accessToken == null) {
          _openAuth();
        } else {
          _push(const ProfileScreen());
        }
        return;
      case 'auth':
        _openAuth();
        return;
    }
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      0,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final narrow = width <= 640;
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: MouseRegion(
          onHover: (event) {
            if (MediaQuery.disableAnimationsOf(context)) return;
            final size = MediaQuery.sizeOf(context);
            _pointer.value = Offset(
              (event.localPosition.dx / size.width - .5) * 26,
              (event.localPosition.dy / size.height - .5) * 26,
            );
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ValueListenableBuilder<Offset>(
                  valueListenable: _pointer,
                  child: const ReelBackdrop(),
                  builder: (_, offset, child) => AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                    transform: Matrix4.translationValues(
                      offset.dx,
                      offset.dy,
                      0,
                    ),
                    child: child,
                  ),
                ),
              ),
              SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scroll,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1280),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(key: _topKey, height: 86),
                              _WorkspaceHero(narrow: narrow),
                              _ToolsBar(
                                narrow: narrow,
                                onOpenCatalog: _openCatalog,
                              ),
                              const SizedBox(height: 18),
                              _ModeGrid(
                                active: _activeTool,
                                onSelect: _selectTool,
                                narrow: narrow,
                              ),
                              const SizedBox(height: 20),
                              _buildToolPanel(),
                              _Footer(
                                onNavigate: _navigate,
                                onStart: _openAuth,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: _Header(
                        scrolled: _scrolled,
                        rtl: _rtl,
                        creditBalance:
                            (_usage?['credit_balance'] as num?)?.toInt(),
                        onNavigate: _navigate,
                        onStart: _openAuth,
                        onDirection: () => setState(() => _rtl = !_rtl),
                        onAuthChange: () {
                          setState(() {});
                          _loadUsage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolPanel() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOut,
      child: KeyedSubtree(
        key: ValueKey<String>(_activeTool),
        child: switch (_activeTool) {
          'image' => _ImagePanel(state: this),
          'video' => _VideoPanel(state: this),
          'speech' => _SpeechPanel(state: this),
          'manga' => _MangaStudioPanel(state: this),
          _ => _PreviewToolPanel(state: this),
        },
      ),
    );
  }
}

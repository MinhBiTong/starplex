part of '../home_screen.dart';

/// Compact left-aligned workspace hero — "Một ô prompt. Mọi kiểu tác phẩm."
class _WorkspaceHero extends StatelessWidget {
  final bool narrow;
  const _WorkspaceHero({required this.narrow});

  @override
  Widget build(BuildContext context) {
    final style = AppFonts.spaceGrotesk(
      color: AppColors.mist,
      fontSize: narrow ? 24 : 30,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -.4,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(narrow ? 20 : 28, 8, narrow ? 20 : 28, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: AppLocalizations.of(context).homeHeadline,
              style: style,
              children: [
                TextSpan(text: ' '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ReelGradientText(
                    AppLocalizations.of(context).homeHeadlineAccent,
                    style: style,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              AppLocalizations.of(context).homeSubheadRedesign,
              style: AppFonts.inter(
                color: AppColors.smoke,
                fontSize: 14,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "GHIM CỦA BẠN" + search box + "Xem tất cả 20 công cụ" opener.
class _ToolsBar extends StatelessWidget {
  final bool narrow;
  final VoidCallback onOpenCatalog;
  const _ToolsBar({required this.narrow, required this.onOpenCatalog});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(narrow ? 20 : 28, 22, narrow ? 20 : 28, 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          Text(
            l10n.toolsBarLabel.toUpperCase(),
            style: AppFonts.jetBrainsMono(
              color: AppColors.muted,
              fontSize: 9.5,
              letterSpacing: 1.4,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: narrow ? double.infinity : 360,
              minWidth: narrow ? double.infinity : 220,
            ),
            child: TextField(
              readOnly: true,
              onTap: onOpenCatalog,
              style: AppFonts.inter(color: AppColors.parchment, fontSize: 12.5),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: AppColors.glass,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 15,
                  color: AppColors.smoke,
                ),
                hintText: l10n.toolsSearchHint,
                hintStyle: AppFonts.inter(color: AppColors.muted, fontSize: 12.5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: const BorderSide(color: AppColors.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: const BorderSide(color: AppColors.line),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: const BorderSide(color: AppColors.azure),
                ),
              ),
            ),
          ),
          ReelButton(
            label: l10n.toolsAllButton,
            onPressed: onOpenCatalog,
            primary: false,
            icon: Icons.expand_more,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
        ],
      ),
    );
  }
}

/// The 4 pinned tool cards under the tools bar. Manga carries the coral
/// "New" badge like the mockup.
class _ModeGrid extends StatelessWidget {
  final String active;
  final ValueChanged<String> onSelect;
  final bool narrow;
  const _ModeGrid({
    required this.active,
    required this.onSelect,
    required this.narrow,
  });

  static const _pinned = <String, IconData>{
    'image': Icons.image_outlined,
    'video': Icons.movie_outlined,
    'speech': Icons.mic_none_outlined,
    'manga': Icons.menu_book_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final keys = _pinned.keys.toList();
    final columns = MediaQuery.sizeOf(context).width >= 980
        ? 4
        : MediaQuery.sizeOf(context).width >= 560
        ? 2
        : 1;
    return Padding(
      padding: EdgeInsets.fromLTRB(narrow ? 20 : 28, 0, narrow ? 20 : 28, 0),
      child: Column(
        children: [
          for (final row in _chunk(keys, columns))
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final key in row)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: _ModeCard(
                          tool: _toolByKey(key)!,
                          subtitle: _pinnedSubtitle(l10n, key),
                          icon: _pinned[key]!,
                          badge: key == 'manga' ? l10n.badgeNew : null,
                          active: active == key,
                          onTap: () => onSelect(key),
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

  static String _pinnedSubtitle(AppLocalizations l10n, String key) =>
      switch (key) {
        'image' => l10n.modeImageSub,
        'video' => l10n.modeVideoSub,
        'speech' => l10n.modeSpeechSub,
        _ => l10n.modeMangaSub,
      };

  static List<List<T>> _chunk<T>(List<T> list, int size) => [
    for (var i = 0; i < list.length; i += size)
      list.sublist(i, (i + size).clamp(0, list.length)),
  ];
}

class _ModeCard extends StatelessWidget {
  final _ToolEntry tool;
  final String subtitle;
  final IconData icon;
  final String? badge;
  final bool active;
  final VoidCallback onTap;
  const _ModeCard({
    required this.tool,
    required this.subtitle,
    required this.icon,
    required this.active,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: active
                ? AppColors.azure.withValues(alpha: .12)
                : AppColors.glass,
            border: Border.all(
              color: active
                  ? AppColors.azure.withValues(alpha: .5)
                  : AppColors.line,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.azure.withValues(alpha: .9)
                          : const Color(0x0DFFFFFF),
                      border: active
                          ? null
                          : Border.all(color: AppColors.line),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      size: 17,
                      color: active ? Colors.white : AppColors.mist,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tool.nameOf(context),
                    style: AppFonts.spaceGrotesk(
                      color: AppColors.mist,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: AppFonts.inter(
                      color: AppColors.smoke,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              if (badge != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.coral.withValues(alpha: .1),
                      border: Border.all(
                        color: AppColors.coral.withValues(alpha: .4),
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badge!.toUpperCase(),
                      style: AppFonts.jetBrainsMono(
                        color: AppColors.coral,
                        fontSize: 8.5,
                        letterSpacing: 1,
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
}

/// Shared chip row: mono label + pill options with an azure active state.
class _ChipRow extends StatelessWidget {
  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;
  const _ChipRow({
    required this.label,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: AppFonts.jetBrainsMono(
            color: AppColors.muted,
            fontSize: 10,
            letterSpacing: 2,
          ),
        ),
        for (final option in options)
          InkWell(
            onTap: () => onSelect(option),
            borderRadius: BorderRadius.circular(11),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: option == selected
                    ? const Color(0x263D7CFF)
                    : AppColors.glass,
                border: Border.all(
                  color: option == selected
                      ? AppColors.azure.withValues(alpha: .55)
                      : AppColors.line,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                option,
                style: AppFonts.inter(
                  color: option == selected
                      ? Colors.white
                      : AppColors.parchmentDim,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Prompt box shared by every panel — glass body, azure focus ring.
class _SceneField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  const _SceneField({required this.controller, this.hint});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      minLines: 2,
      style: AppFonts.inter(
        color: AppColors.parchment,
        fontSize: 14,
        height: 1.55,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0x09FFFFFF),
        hintText: hint ?? AppLocalizations.of(context).homeSceneFieldHint,
        hintStyle: AppFonts.inter(color: AppColors.muted),
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.azure),
        ),
      ),
    );
  }
}

/// "Tạo ảnh · ≈ 4 CR" + "kết quả lưu tự động" caption.
class _GenerateRow extends StatelessWidget {
  final String label;
  final String cost;
  final bool loading;
  final VoidCallback onPressed;
  const _GenerateRow({
    required this.label,
    required this.cost,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 14,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ReelButton(
          label: label,
          onPressed: loading ? null : onPressed,
          loading: loading,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        ),
        Text(
          cost,
          style: AppFonts.jetBrainsMono(
            color: AppColors.smoke,
            fontSize: 10.5,
          ),
        ),
        Text(
          l10n.saveToLibraryHint,
          style: AppFonts.inter(color: AppColors.muted, fontSize: 12),
        ),
      ],
    );
  }
}

/// Live panel — Text → Ảnh (POST /generate/image).
class _ImagePanel extends StatelessWidget {
  final _ReelHomePageState state;
  const _ImagePanel({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ReelGlass(
      blur: true,
      radius: 18,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SceneField(controller: state._sceneController, hint: l10n.imagePromptHint),
          const SizedBox(height: 14),
          _ChipRow(
            label: l10n.panelRatioLabel,
            options: const ['16:9', '1:1', '9:16'],
            selected: state._ratio,
            onSelect: state.setRatio,
          ),
          const SizedBox(height: 8),
          _ChipRow(
            label: l10n.panelStyleLabel,
            options: const ['Cinematic', 'Anime', 'Studio'],
            selected: state._stock,
            onSelect: state.setStock,
          ),
          const SizedBox(height: 16),
          _GenerateRow(
            label: l10n.generateImage,
            cost: '≈ 4 CR',
            loading: state._isGenerating,
            onPressed: state._generateImage,
          ),
          // Lưới thumb trang trí như mockup (hiện khi chưa có kết quả thật)
          if (state._generatedImageUrl == null) ...[
            const SizedBox(height: 18),
            GridView.count(
              crossAxisCount: MediaQuery.sizeOf(context).width < 720 ? 2 : 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 16 / 10,
              children: [
                for (final (gradient, tag) in _kImageThumbGradients)
                  Container(
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: AppColors.line),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.ink.withValues(alpha: .8),
                        border: Border.all(color: AppColors.line),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        tag,
                        style: AppFonts.jetBrainsMono(
                          color: AppColors.smoke,
                          fontSize: 8.5,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
          if (state._generatedImageUrl != null) ...[
            const SizedBox(height: 18),
            _GeneratedImage(
              imageUrl: state._generatedImageUrl!,
              ratio: state._ratio,
              onRegenerate: state._generateImage,
            ),
          ],
        ],
      ),
    );
  }
}

/// Live panel — Text → Video (POST /generate/video + polling).
class _VideoPanel extends StatelessWidget {
  final _ReelHomePageState state;
  const _VideoPanel({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ReelGlass(
      blur: true,
      radius: 18,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SceneField(controller: state._sceneController, hint: l10n.videoPromptHint),
          const SizedBox(height: 14),
          _ChipRow(
            label: l10n.videoDurationLabel,
            options: const ['5s', '8s', '12s'],
            selected: '${state._durationSeconds}s',
            onSelect: (value) => state.setDuration(
              int.parse(value.replaceAll(RegExp(r'[^0-9]'), '')),
            ),
          ),
          const SizedBox(height: 8),
          _ChipRow(
            label: l10n.videoQualityLabel,
            options: const ['720p', '1080p'],
            selected: state._videoQuality,
            onSelect: state.setQuality,
          ),
          const SizedBox(height: 16),
          _GenerateRow(
            label: l10n.generateVideo,
            cost: '≈ 30 CR',
            loading: state._isGenerating,
            onPressed: state._generateVideo,
          ),
          // Thumb 21:9 trang trí như mockup khi chưa có kết quả thật
          if (state._generatedVideoUrl == null && !state._isGenerating) ...[
            const SizedBox(height: 18),
            AspectRatio(
              aspectRatio: 21 / 9,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    center: Alignment(-.4, 0),
                    radius: 1.4,
                    colors: [Color(0x663D7CFF), Color(0x598B7BFF), Color(0xFF0D0F1A)],
                    stops: [0, .55, 1],
                  ),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: AppColors.line),
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.ink.withValues(alpha: .8),
                    border: Border.all(color: AppColors.line),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _t(context, '5s · FLYCAM', '5s · DRONE'),
                    style: AppFonts.jetBrainsMono(
                      color: AppColors.smoke,
                      fontSize: 8.5,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (state._generatedVideoUrl != null) ...[
            const SizedBox(height: 18),
            _GeneratedVideo(
              videoUrl: state._generatedVideoUrl!,
              ratio: state._ratio,
              onRegenerate: state._generateVideo,
            ),
          ],
        ],
      ),
    );
  }
}

/// Design-preview panel for the 18 tools without a live model behind them:
/// full mockup layout, but Generate only announces the tool is coming soon.
class _PreviewToolPanel extends StatelessWidget {
  final _ReelHomePageState state;
  const _PreviewToolPanel({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tool = _toolByKey(state._activeTool) ?? _toolByKey('image')!;
    return ReelGlass(
      blur: true,
      radius: 18,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.azure, AppColors.indigo],
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(tool.icon, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tool.nameOf(context),
                      style: AppFonts.spaceGrotesk(
                        color: AppColors.mist,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      tool.descOf(context),
                      style: AppFonts.inter(
                        color: AppColors.smoke,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SceneField(
            controller: state._genericController,
            hint: l10n.genericPromptHint,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.coral.withValues(alpha: .06),
              border: Border.all(
                color: AppColors.coral.withValues(alpha: .45),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.auto_awesome_outlined,
                  size: 15,
                  color: AppColors.coral,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    l10n.comingSoonNote,
                    style: AppFonts.inter(
                      color: AppColors.coral,
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _GenerateRow(
            label: '${l10n.panelGenerateGeneric} ${tool.nameOf(context)}',
            cost: tool.cost,
            loading: false,
            onPressed: state._generateOnPreviewTool,
          ),
        ],
      ),
    );
  }
}

/// Inline result card — generated image with open-in-browser + regenerate.
class _GeneratedImage extends StatelessWidget {
  final String imageUrl, ratio;
  final VoidCallback onRegenerate;
  const _GeneratedImage({
    required this.imageUrl,
    required this.ratio,
    required this.onRegenerate,
  });
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        const Divider(color: AppColors.lineSoft),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (_, child, progress) => progress == null
                ? child
                : const SizedBox(
                    height: 180,
                    child: Center(child: CircularProgressIndicator()),
                  ),
            errorBuilder: (_, _, _) => SizedBox(
              height: 120,
              child: Center(child: Text(l10n.homeGenerationErrorLoad)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.homeGenerationSuccess(ratio),
                style: AppFonts.jetBrainsMono(
                  fontSize: 11,
                  color: AppColors.smoke,
                ),
              ),
            ),
            IconButton(
              tooltip: l10n.homeGenerationOpenOriginal,
              icon: const Icon(Icons.open_in_new, size: 16),
              onPressed: () async {
                final opened = await launchUrl(
                  Uri.parse(imageUrl),
                  mode: LaunchMode.externalApplication,
                );
                if (!opened && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.homeGenerationOpenFailed)),
                  );
                }
              },
            ),
            IconButton(
              tooltip: l10n.homeGenerationRegenerate,
              icon: const Icon(Icons.refresh, size: 16),
              onPressed: onRegenerate,
            ),
          ],
        ),
      ],
    );
  }
}

/// Inline player for a generated clip. Keeps the chewie transport style
/// shared with the old contact-sheet preview.
class _GeneratedVideo extends StatefulWidget {
  final String videoUrl, ratio;
  final VoidCallback onRegenerate;
  const _GeneratedVideo({
    required this.videoUrl,
    required this.ratio,
    required this.onRegenerate,
  });

  @override
  State<_GeneratedVideo> createState() => _GeneratedVideoState();
}

class _GeneratedVideoState extends State<_GeneratedVideo> {
  VideoPlayerController? _controller;
  ChewieController? _chewie;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant _GeneratedVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _disposeControllers();
      _init();
    }
  }

  Future<void> _init() async {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    _controller = controller;
    try {
      await controller.initialize();
      final chewie = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
        aspectRatio: controller.value.aspectRatio == 0
            ? 16 / 9
            : controller.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.brass,
          handleColor: AppColors.brass,
          backgroundColor: AppColors.line,
          bufferedColor: AppColors.lineSoft,
        ),
        placeholder: Container(color: AppColors.surface),
        autoInitialize: true,
      );
      if (!mounted) return;
      setState(() => _chewie = chewie);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = AppLocalizations.of(context).homeGenerationErrorLoad);
    }
  }

  void _disposeControllers() {
    _chewie?.dispose();
    _chewie = null;
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        const Divider(color: AppColors.lineSoft),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: _chewie != null
              ? AspectRatio(
                  aspectRatio: _chewie!.aspectRatio ?? 16 / 9,
                  child: Chewie(controller: _chewie!),
                )
              : SizedBox(
                  height: 180,
                  child: Center(
                    child: _error != null
                        ? Text(_error!)
                        : const CircularProgressIndicator(),
                  ),
                ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.videoReadyLabel,
                style: AppFonts.jetBrainsMono(
                  fontSize: 11,
                  color: AppColors.smoke,
                ),
              ),
            ),
            IconButton(
              tooltip: l10n.homeGenerationOpenOriginal,
              icon: const Icon(Icons.open_in_new, size: 16),
              onPressed: () async {
                final opened = await launchUrl(
                  Uri.parse(widget.videoUrl),
                  mode: LaunchMode.externalApplication,
                );
                if (!opened && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.homeGenerationOpenFailed)),
                  );
                }
              },
            ),
            IconButton(
              tooltip: l10n.homeGenerationRegenerate,
              icon: const Icon(Icons.refresh, size: 16),
              onPressed: widget.onRegenerate,
            ),
          ],
        ),
      ],
    );
  }
}

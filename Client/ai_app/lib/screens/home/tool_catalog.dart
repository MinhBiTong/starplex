part of '../home_screen.dart';

/// One row in the tool-catalog dialog.
///
/// `live` tools (image, video) are wired to `/generate/*` on the AI server;
/// every other entry opens a design-preview panel that toasts "coming soon"
/// because the backend doesn't expose those models yet.
class _ToolEntry {
  final String key;
  final bool live;
  final IconData icon;
  final String nameEn, nameVi, descEn, descVi;
  /// Extra latin keywords so English queries (voice, tts, 3d…) find tools
  /// whose Vietnamese label doesn't contain them.
  final String keywords;
  final String cost;
  const _ToolEntry({
    required this.key,
    required this.icon,
    required this.nameEn,
    required this.nameVi,
    required this.descEn,
    required this.descVi,
    this.keywords = '',
    required this.cost,
    this.live = false,
  });

  bool get isPreview => !live;

  String nameOf(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'vi' ? nameVi : nameEn;

  String descOf(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'vi' ? descVi : descEn;

  bool matches(String lowerQuery) {
    if (lowerQuery.isEmpty) return true;
    return '$nameEn $nameVi $descEn $descVi $keywords'
        .toLowerCase()
        .contains(lowerQuery);
  }
}

/// Catalog in display order: group key → tools of that group.
const _kToolCatalog = <String, List<_ToolEntry>>{
  'images': [
    _ToolEntry(
      key: 'image',
      live: true,
      icon: Icons.image_outlined,
      nameEn: 'Image',
      nameVi: 'Ảnh',
      descEn: 'Poster, concept art, thumbnail',
      descVi: 'Poster, concept art, thumbnail',
      keywords: 'image picture photo anh',
      cost: '≈ 4 CR',
    ),
    _ToolEntry(
      key: 'character',
      icon: Icons.palette_outlined,
      nameEn: 'Character',
      nameVi: 'Nhân vật',
      descEn: 'Character design from multiple angles',
      descVi: 'Thiết kế nhân vật nhiều góc',
      keywords: 'character turnaround design nhan vat',
      cost: '≈ 6 CR',
    ),
    _ToolEntry(
      key: 'model3d',
      icon: Icons.view_in_ar_outlined,
      nameEn: '3D model',
      nameVi: 'Mô hình 3D',
      descEn: 'Objects, characters — GLB/OBJ',
      descVi: 'Object, character — GLB/OBJ',
      keywords: '3d model glb obj mesh',
      cost: '≈ 15 CR',
    ),
    _ToolEntry(
      key: 'scene3d',
      icon: Icons.home_work_outlined,
      nameEn: '3D scene',
      nameVi: 'Cảnh 3D',
      descEn: 'Interior, architecture',
      descVi: 'Interior, kiến trúc',
      keywords: '3d scene interior canh',
      cost: '≈ 15 CR',
    ),
    _ToolEntry(
      key: 'map',
      icon: Icons.map_outlined,
      nameEn: 'Map',
      nameVi: 'Bản đồ',
      descEn: 'Fantasy map, world map',
      descVi: 'Fantasy map, world map',
      keywords: 'map world fantasy ban do',
      cost: '≈ 4 CR',
    ),
  ],
  'film': [
    _ToolEntry(
      key: 'video',
      live: true,
      icon: Icons.movie_outlined,
      nameEn: 'Video',
      nameVi: 'Video',
      descEn: 'Cinematic, ads, animation',
      descVi: 'Cinematic, quảng cáo, animation',
      keywords: 'video clip phim animation',
      cost: '≈ 30 CR',
    ),
    _ToolEntry(
      key: 'manga',
      icon: Icons.menu_book_outlined,
      nameEn: 'Manga',
      nameVi: 'Manga',
      descEn: 'Script → pages → panels',
      descVi: 'Kịch bản → trang → khung',
      keywords: 'manga comic truyen tranh',
      cost: '≈ 6 CR/trang',
    ),
    _ToolEntry(
      key: 'comic',
      icon: Icons.brush_outlined,
      nameEn: 'Comic',
      nameVi: 'Comic',
      descEn: 'Script → panels → dialogue',
      descVi: 'Kịch bản → khung → thoại',
      keywords: 'comic strip truyen',
      cost: '≈ 6 CR/trang',
    ),
    _ToolEntry(
      key: 'avatar',
      icon: Icons.record_voice_over_outlined,
      nameEn: 'Talking avatar',
      nameVi: 'Avatar nói',
      descEn: 'Script → AI presenter',
      descVi: 'Kịch bản → AI presenter',
      keywords: 'avatar talking presenter',
      cost: '≈ 25 CR',
    ),
  ],
  'audio': [
    _ToolEntry(
      key: 'speech',
      icon: Icons.mic_none_outlined,
      nameEn: 'Voice',
      nameVi: 'Giọng nói',
      descEn: 'Narration, audiobook',
      descVi: 'Đọc kịch bản, audiobook',
      keywords: 'voice tts text to speech giong doc',
      cost: '≈ 1 CR/100từ',
    ),
    _ToolEntry(
      key: 'music',
      icon: Icons.music_note_outlined,
      nameEn: 'BGM',
      nameVi: 'Nhạc nền',
      descEn: 'Soundtrack by mood',
      descVi: 'Soundtrack theo mood',
      keywords: 'music soundtrack beat nhac nen bgm',
      cost: '≈ 10 CR',
    ),
    _ToolEntry(
      key: 'song',
      icon: Icons.library_music_outlined,
      nameEn: 'Song',
      nameVi: 'Bài hát',
      descEn: 'Vocal + instrumental',
      descVi: 'Vocal + beat',
      keywords: 'song vocal bai hat singing',
      cost: '≈ 20 CR',
    ),
    _ToolEntry(
      key: 'sfx',
      icon: Icons.volume_up_outlined,
      nameEn: 'Sound effect',
      nameVi: 'Sound Effect',
      descEn: 'Rain, guns, footsteps…',
      descVi: 'Tiếng mưa, súng, bước chân…',
      keywords: 'sound effect sfx ambience am thanh',
      cost: '≈ 1 CR',
    ),
  ],
  'docs': [
    _ToolEntry(
      key: 'book',
      icon: Icons.auto_stories_outlined,
      nameEn: 'Book',
      nameVi: 'Sách',
      descEn: 'Novel, children’s book',
      descVi: 'Novel, sách thiếu nhi',
      keywords: 'book novel sach story',
      cost: '≈ 5 CR/chương',
    ),
    _ToolEntry(
      key: 'doc',
      icon: Icons.description_outlined,
      nameEn: 'Document',
      nameVi: 'Tài liệu',
      descEn: 'Report, SRS, proposal',
      descVi: 'Báo cáo, SRS, proposal',
      keywords: 'document report srs proposal tai lieu',
      cost: '≈ 3 CR',
    ),
    _ToolEntry(
      key: 'slides',
      icon: Icons.slideshow_outlined,
      nameEn: 'Presentation',
      nameVi: 'Presentation',
      descEn: 'Slide deck / pitch',
      descVi: 'Slide deck / pitch',
      keywords: 'presentation slides pitch deck',
      cost: '≈ 10 CR',
    ),
  ],
  'tech': [
    _ToolEntry(
      key: 'code',
      icon: Icons.code_outlined,
      nameEn: 'Code',
      nameVi: 'Code',
      descEn: 'Apps, websites, APIs',
      descVi: 'App, website, API',
      keywords: 'code app api script',
      cost: '≈ 2 CR',
    ),
    _ToolEntry(
      key: 'website',
      icon: Icons.language_outlined,
      nameEn: 'Website',
      nameVi: 'Website',
      descEn: 'Landing page, dashboard',
      descVi: 'Landing page, dashboard',
      keywords: 'website landing page dashboard web',
      cost: '≈ 8 CR',
    ),
    _ToolEntry(
      key: 'game',
      icon: Icons.sports_esports_outlined,
      nameEn: 'Game',
      nameVi: 'Game',
      descEn: 'Prototype / game scene',
      descVi: 'Prototype / game scene',
      keywords: 'game prototype pixel',
      cost: '≈ 40 CR',
    ),
    _ToolEntry(
      key: 'agent',
      icon: Icons.smart_toy_outlined,
      nameEn: 'Agent',
      nameVi: 'Agent',
      descEn: 'Goal → AI workflow',
      descVi: 'Mục tiêu → AI workflow',
      keywords: 'agent workflow automation tu dong',
      cost: 'tuỳ bước',
    ),
  ],
};

_ToolEntry? _toolByKey(String key) {
  for (final tools in _kToolCatalog.values) {
    for (final tool in tools) {
      if (tool.key == key) return tool;
    }
  }
  return null;
}

String _groupTitle(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  return switch (key) {
    'images' => l10n.toolGroupImages,
    'film' => l10n.toolGroupFilm,
    'audio' => l10n.toolGroupAudio,
    'docs' => l10n.toolGroupDocs,
    _ => l10n.toolGroupTech,
  };
}

/// Modal catalog of all 20 tools with live search. Pops with the picked
/// tool key (or null when dismissed). Mirrors the mockup dialog: dark
/// sheet, mono section labels, glass tool tiles with an azure active state.
class _ToolCatalogDialog extends StatefulWidget {
  final String selectedKey;
  const _ToolCatalogDialog({required this.selectedKey});

  @override
  State<_ToolCatalogDialog> createState() => _ToolCatalogDialogState();
}

class _ToolCatalogDialogState extends State<_ToolCatalogDialog> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final q = _query.trim().toLowerCase();
    final visibleGroups = <MapEntry<String, List<_ToolEntry>>>[
      for (final group in _kToolCatalog.entries)
        MapEntry(
          group.key,
          group.value.where((tool) => tool.matches(q)).toList(),
        ),
    ].where((group) => group.value.isNotEmpty).toList();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 920),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 14, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.toolsCatalogTitle,
                          style: AppFonts.spaceGrotesk(
                            color: AppColors.mist,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.toolsCatalogSubtitle,
                          style: AppFonts.inter(
                            color: AppColors.smoke,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _SheetCloseButton(onClose: () => Navigator.of(context).pop()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: TextField(
                controller: _search,
                autofocus: true,
                onChanged: (value) => setState(() => _query = value),
                style: AppFonts.inter(color: AppColors.parchment, fontSize: 13),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: AppColors.glass,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 16,
                    color: AppColors.smoke,
                  ),
                  hintText: l10n.toolsSearchHint,
                  hintStyle: AppFonts.inter(color: AppColors.muted),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
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
            Flexible(
              child: visibleGroups.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.toolsNoMatch,
                        textAlign: TextAlign.center,
                        style: AppFonts.inter(
                          color: AppColors.smoke,
                          fontSize: 12.5,
                        ),
                      ),
                    )
                  : ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      children: [
                        for (final group in visibleGroups) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 14, bottom: 8),
                            child: Text(
                              _groupTitle(context, group.key).toUpperCase(),
                              style: AppFonts.jetBrainsMono(
                                color: AppColors.smoke,
                                fontSize: 9.5,
                                letterSpacing: 1.4,
                              ),
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: width >= 860
                                ? 4
                                : width >= 620
                                ? 3
                                : 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 2.9,
                            children: [
                              for (final tool in group.value)
                                _CatalogTile(
                                  tool: tool,
                                  selected: tool.key == widget.selectedKey,
                                  onTap: () =>
                                      Navigator.of(context).pop(tool.key),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetCloseButton extends StatelessWidget {
  final VoidCallback onClose;
  const _SheetCloseButton({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      onPressed: onClose,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.glass,
        side: const BorderSide(color: AppColors.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: const Icon(Icons.close, size: 16, color: AppColors.smoke),
    );
  }
}

class _CatalogTile extends StatelessWidget {
  final _ToolEntry tool;
  final bool selected;
  final VoidCallback onTap;
  const _CatalogTile({
    required this.tool,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.azure.withValues(alpha: .14)
              : AppColors.glass,
          border: Border.all(
            color: selected ? AppColors.azure.withValues(alpha: .55) : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0x0FFFFFFF),
                border: Border.all(color: AppColors.line),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(tool.icon, size: 15, color: AppColors.mist),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          tool.nameOf(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.inter(
                            color: AppColors.parchment,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (tool.live) ...[
                        const SizedBox(width: 5),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF7EE0A8),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tool.descOf(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.inter(
                      color: AppColors.muted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

part of '../home_screen.dart';

/// Helper bilingual inline cho nội dung tĩnh theo mockup (vi/en).
String _t(BuildContext context, String vi, String en) =>
    Localizations.localeOf(context).languageCode == 'vi' ? vi : en;

/// Panel Giọng nói theo mockup: voice grid + chip tốc độ/định dạng +
/// waveform trang trí. Generate chỉ toast (chưa có TTS backend).
class _SpeechPanel extends StatefulWidget {
  final _ReelHomePageState state;
  const _SpeechPanel({required this.state});

  @override
  State<_SpeechPanel> createState() => _SpeechPanelState();
}

class _SpeechPanelState extends State<_SpeechPanel> {
  int _voice = 0;
  int _speed = 1;
  int _format = 0;

  static const _voices = <(String, String, String, String)>[
    ('Minh — Nam trẻ', 'Minh — Young male', 'Ẩn chứa năng lượng, đọc quảng cáo', 'Energetic, reads ads'),
    ('Hà — Nữ ấm', 'Hà — Warm female', 'Chậm rãi, đọc truyện đêm', 'Slow, bedtime stories'),
    ('Ông Tùng', 'Mr. Tùng', 'Trầm, đọc tài liệu / phim tài liệu', 'Deep, docs & documentary'),
    ('Mai — Nữ sáng', 'Mai — Bright female', 'Nhanh, đọc tin tức / podcast', 'Fast, news & podcast'),
  ];

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 720;
    return ReelGlass(
      blur: true,
      radius: 18,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SceneField(
            controller: widget.state._genericController,
            hint: _t(
              context,
              'Dán kịch bản cần đọc… REEL sẽ tách câu, thêm ngắt nghỉ và tạo audio tự nhiên.',
              'Paste the script to read… REEL splits sentences, adds pauses and generates natural audio.',
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _t(context, 'GIỌNG ĐỌC', 'VOICE'),
            style: AppFonts.jetBrainsMono(color: AppColors.muted, fontSize: 10, letterSpacing: 2),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: narrow ? 2 : 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.2,
            children: [
              for (var i = 0; i < _voices.length; i++)
                InkWell(
                  onTap: () => setState(() => _voice = i),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: _voice == i
                          ? AppColors.azure.withValues(alpha: .14)
                          : AppColors.glass,
                      border: Border.all(
                        color: _voice == i
                            ? AppColors.azure.withValues(alpha: .55)
                            : AppColors.line,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const [
                              LinearGradient(colors: [AppColors.azure, AppColors.indigo]),
                              LinearGradient(colors: [AppColors.coral, Color(0xFFFF6D6D)]),
                              LinearGradient(colors: [AppColors.indigo, Color(0xFF5A4FD8)]),
                              LinearGradient(colors: [Color(0xFF41D6A8), AppColors.azure]),
                            ][i],
                          ),
                          child: const Icon(Icons.graphic_eq, size: 13, color: Colors.white),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _t(context, _voices[i].$1, _voices[i].$2),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.inter(
                                  color: AppColors.parchment,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _t(context, _voices[i].$3, _voices[i].$4),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.inter(color: AppColors.smoke, fontSize: 9.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          _ChipRow(
            label: _t(context, 'TỐC ĐỘ', 'SPEED'),
            options: const ['0.8×', '1.0×', '1.2×'],
            selected: const ['0.8×', '1.0×', '1.2×'][_speed],
            onSelect: (v) =>
                setState(() => _speed = const ['0.8×', '1.0×', '1.2×'].indexOf(v)),
          ),
          const SizedBox(height: 8),
          _ChipRow(
            label: _t(context, 'ĐỊNH DẠNG', 'FORMAT'),
            options: const ['MP3', 'WAV'],
            selected: const ['MP3', 'WAV'][_format],
            onSelect: (v) => setState(() => _format = const ['MP3', 'WAV'].indexOf(v)),
          ),
          const SizedBox(height: 16),
          _GenerateRow(
            label: _t(context, 'Tạo giọng nói', 'Generate voice'),
            cost: '≈ 1 CR/100từ',
            loading: false,
            onPressed: widget.state._generateOnPreviewTool,
          ),
          const SizedBox(height: 16),
          const _Waveform(),
        ],
      ),
    );
  }
}

/// Waveform trang trí — dải cột cao thấp theo sin, giống khung .wave mockup.
class _Waveform extends StatelessWidget {
  const _Waveform();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(13),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = (constraints.maxWidth / 6).floor();
          return Row(
            children: [
              for (var i = 0; i < count; i++)
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: (30 + math.sin(i * .55).abs() * 55) / 84,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [AppColors.azure, AppColors.indigo],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Manga Studio theo mockup: thanh dự án + 3 cột (trang / editor / cố truyện)
/// + batch bar. Toàn bộ là bản xem trước — tạo chỉ toast.
class _MangaStudioPanel extends StatefulWidget {
  final _ReelHomePageState state;
  const _MangaStudioPanel({required this.state});

  @override
  State<_MangaStudioPanel> createState() => _MangaStudioPanelState();
}

class _MangaStudioPanelState extends State<_MangaStudioPanel> {
  int _page = 3; // Trang 4 đang chọn như mockup
  int _layout = 0;
  final Set<int> _chars = {0, 1};
  int _style = 0;
  bool _seedLock = true;

  // (số trang, tiêu đề, phụ đề, trạng thái: 1 done, 2 đang chạy, 0 todo)
  static const _pages = <(int, String, String, int)>[
    (1, 'Trang 1 · Mở màn', 'Vực núi trong mưa bão', 1),
    (2, 'Trang 2 · Rin xuất hiện', 'Cận cảnh, mái tóc đỏ', 1),
    (3, 'Trang 3 · Đối đầu', 'Góc nhìn thấp, tia chớp', 2),
    (4, 'Trang 4 · Chưa có prompt', 'Chọn để viết prompt', 0),
    (5, 'Trang 5 · Chưa có prompt', 'Chọn để viết prompt', 0),
  ];
  static const _pagesCh2 = <(int, String, String, int)>[
    (6, 'Trang 6 · Lò rèn', 'Ánh lửa xanh chiếu mặt', 1),
    (7, 'Trang 7 · Chưa có prompt', 'Chọn để viết prompt', 0),
  ];
  static const _charsList = <(String, String, String, String, String)>[
    (
      'R',
      'Rin — Kiếm sĩ đỏ',
      'Rin — Crimson swordsman',
      'mái tóc đỏ dài, áo choàng đen vá víu, sẹo trái lông mày',
      'long red hair, tattered black cloak, scar over left brow',
    ),
    (
      'K',
      'Kaito — Thợ rèn',
      'Kaito — Blacksmith',
      'thân hình vạm vỡ, tát nước để lộ huy hiệu rồng trên vai',
      'burly frame, water reveal shows the dragon crest on his shoulder',
    ),
    (
      'A',
      'Adaptus — Ong Linh',
      'Adaptus — Spirit bee',
      'kích thước con bò cạp, đôi cánh thủy tinh',
      'scorpion-sized, glass wings',
    ),
  ];
  static const _kMangaStyles = <(String, String)>[
    ('Shonen Đen-Trắng', 'Black & White Shonen'),
    ('Manga Màu', 'Color Manga'),
    ('Seinen Chầy', 'Gritty Seinen'),
    ('Chibi Q&A', 'Chibi Q&A'),
  ];

  void _mockTap() => widget.state._generateOnPreviewTool();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---- thanh dự án ----
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              color: Color(0x07FFFFFF),
              border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.coral, AppColors.indigo],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('📖', style: TextStyle(fontSize: 13))),
                ),
                Text(
                  'Lóe Sáng Ở Wano',
                  style: AppFonts.spaceGrotesk(
                    color: AppColors.mist,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _t(context, 'Bản thảo · 12 trang · 2 chương', 'Draft · 12 pages · 2 chapters'),
                  style: AppFonts.jetBrainsMono(color: AppColors.smoke, fontSize: 10),
                ),
                const SizedBox(width: 4),
                ReelButton(
                  label: _t(context, 'Xuất PDF / CBZ', 'Export PDF / CBZ'),
                  onPressed: _mockTap,
                  primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                ),
                ReelButton(
                  label: _t(context, 'Lưu dự án', 'Save project'),
                  onPressed: _mockTap,
                  primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                ),
              ],
            ),
          ),
          // ---- thân 3 cột ----
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 860) {
                return Column(
                  children: [_pageList(context), _editor(context), _bible(context)],
                );
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 250, child: _pageList(context)),
                    const VerticalDivider(width: 1, color: AppColors.lineSoft),
                    Expanded(child: _editor(context)),
                    const VerticalDivider(width: 1, color: AppColors.lineSoft),
                    SizedBox(width: 262, child: _bible(context)),
                  ],
                ),
              );
            },
          ),
          // ---- batch bar ----
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0x07FFFFFF),
              border: Border(top: BorderSide(color: AppColors.lineSoft)),
            ),
            child: Wrap(
              spacing: 14,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ReelButton(
                  label: _t(
                    context,
                    '⚡ Tạo tất cả trang còn thiếu (5 trang · ≈ 30 CR)',
                    '⚡ Generate missing pages (5 · ≈ 30 CR)',
                  ),
                  onPressed: _mockTap,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                SizedBox(
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: 2 / 12,
                      minHeight: 7,
                      backgroundColor: const Color(0x14FFFFFF),
                      valueColor: const AlwaysStoppedAnimation(AppColors.azure),
                    ),
                  ),
                ),
                Text(
                  _t(context, 'ĐÃ TẠO 2/12 TRANG', '2/12 PAGES DONE'),
                  style: AppFonts.jetBrainsMono(color: AppColors.smoke, fontSize: 10.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.coral.withValues(alpha: .45)),
              color: AppColors.coral.withValues(alpha: .05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _t(context, '✦ Tách kịch bản tự động', '✦ Auto-split script'),
                  style: AppFonts.inter(
                    color: AppColors.coral,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _t(
                    context,
                    'Dán kịch bản dài (một cuốn), AI chia thành các trang kèm prompt từng trang.',
                    'Paste a long script; AI splits it into pages with per-page prompts.',
                  ),
                  style: AppFonts.inter(color: AppColors.smoke, fontSize: 10.5, height: 1.45),
                ),
                const SizedBox(height: 8),
                ReelButton(
                  label: _t(context, 'Dán kịch bản → Tách trang', 'Paste script → Split pages'),
                  onPressed: _mockTap,
                  primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _chapLabel('CHƯƠNG 1 — TRẬN ADAPTUS'),
          for (final (no, title, sub, st) in _pages)
            _pageTile(context, no, title, sub, st),
          _chapLabel('CHƯƠNG 2 — LÒ RÈN TRĂNG'),
          for (final (no, title, sub, st) in _pagesCh2)
            _pageTile(context, no, title, sub, st),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _mockTap,
            child: Text(
              _t(context, '＋ Thêm trang · ＋ Thêm chương', '＋ Add page · ＋ Add chapter'),
              style: AppFonts.inter(color: AppColors.smoke, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chapLabel(String text) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 5, left: 4),
    child: Text(
      text,
      style: AppFonts.jetBrainsMono(
        color: AppColors.muted,
        fontSize: 9.5,
        letterSpacing: 1.4,
      ),
    ),
  );

  Widget _pageTile(BuildContext context, int no, String title, String sub, int st) {
    final selected = _page == no - 1;
    return InkWell(
      onTap: () => setState(() => _page = no - 1),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.azure.withValues(alpha: .13) : Colors.transparent,
          border: Border.all(
            color: selected ? AppColors.azure.withValues(alpha: .4) : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 26,
              decoration: BoxDecoration(
                color: st == 0 ? const Color(0xFF14161F) : null,
                gradient: st == 0
                    ? null
                    : RadialGradient(
                        center: const Alignment(-.3, -.3),
                        radius: 1.2,
                        colors: [
                          [
                            AppColors.azure.withValues(alpha: .7),
                            AppColors.indigo.withValues(alpha: .65),
                            AppColors.coral.withValues(alpha: .6),
                            const Color(0xFF7EE0A8).withValues(alpha: .5),
                          ][no % 4],
                          const Color(0xFF14161F),
                        ],
                      ),
                border: Border.all(color: AppColors.line),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.inter(color: AppColors.mist, fontSize: 12.5),
                  ),
                  Text(
                    sub,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.inter(color: AppColors.muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            if (st == 1)
              const Icon(Icons.check_circle, size: 15, color: Color(0xFF7EE0A8))
            else if (st == 2)
              const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 1.6,
                  color: Color(0xFFFFCF7E),
                ),
              )
            else
              const Icon(Icons.radio_button_unchecked, size: 14, color: Color(0x40FFFFFF)),
          ],
        ),
      ),
    );
  }

  Widget _editor(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _t(
                    context,
                    'Trang ${_page + 1} — Chương ${_page < 5 ? 1 : 2}',
                    'Page ${_page + 1} — Chapter ${_page < 5 ? 1 : 2}',
                  ),
                  style: AppFonts.spaceGrotesk(
                    color: AppColors.mist,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              for (var i = 0; i < 3; i++)
                InkWell(
                  onTap: () => setState(() => _layout = i),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: 30,
                    height: 24,
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: _layout == i
                          ? AppColors.azure.withValues(alpha: .14)
                          : AppColors.glass,
                      border: Border.all(
                        color: _layout == i
                            ? AppColors.azure.withValues(alpha: .6)
                            : AppColors.line,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: _layoutGlyph(i),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 1.4,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F2EA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: _mangaPanel(
                      context,
                      art: const LinearGradient(
                        colors: [Color(0xCC3D7CFF), Color(0x998B7BFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      bubble: _t(
                        context,
                        'Sấm ở Wano không nghe như sấm…',
                        'Wano thunder doesn\u2019t sound like thunder…',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _mangaPanel(
                            context,
                            art: const LinearGradient(
                              colors: [Color(0xCCFF9466), Color(0xB3FF6D6D)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            fx: 'GÕO!!!',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _mangaPanel(
                            context,
                            art: const LinearGradient(
                              colors: [Color(0xB3FF6D6D), Color(0x998B7BFF)],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            fx: 'RẦM!',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _mangaPanel(
                      context,
                      art: const LinearGradient(
                        colors: [Color(0xA63D7CFF), Color(0xFF2A2D45)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      bubble: _t(
                        context,
                        '…nó nghe như tiếng gõ cửa, Rin ạ.',
                        '…it sounds like a knock at the door, Rin.',
                      ),
                      alignRight: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                _t(context, 'PROMPT TRANG ${_page + 1}', 'PAGE ${_page + 1} PROMPT'),
                style: AppFonts.jetBrainsMono(
                  color: AppColors.smoke,
                  fontSize: 9.5,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 8),
              for (final name in ['+ Rin', '+ Kaito'])
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.azure.withValues(alpha: .1),
                    border: Border.all(color: AppColors.azure.withValues(alpha: .35)),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    name,
                    style: AppFonts.inter(color: AppColors.azureSoft, fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 7),
          _SceneField(controller: widget.state._genericController),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ReelButton(
                label: _t(context, 'Tạo trang này', 'Generate page'),
                onPressed: _mockTap,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              ReelButton(
                label: _t(context, 'Tạo lại khung 2', 'Regenerate panel 2'),
                onPressed: _mockTap,
                primary: false,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              // ConstrainedBox thay Flexible vì con trực tiếp của Wrap
              // không được nhận ParentData của Flex (làm vỡ build panel).
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 270),
                child: Text(
                  _t(
                    context,
                    'Nhân vật dùng Character Sheet bên phải để giữ nét giống các trang trước.',
                    'Characters use the Character Sheet to stay consistent across pages.',
                  ),
                  style: AppFonts.inter(color: AppColors.muted, fontSize: 10.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _layoutGlyph(int i) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (i == 0) ...[
        Container(
          height: 9,
          decoration: BoxDecoration(
            color: const Color(0x59FFFFFF),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Row(
          children: [
            Expanded(child: Container(height: 4, decoration: _box())),
            Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.only(left: 2),
                decoration: _box(),
              ),
            ),
          ],
        ),
      ] else if (i == 1) ...[
        Container(height: 5, decoration: _box()),
        Container(height: 5, decoration: _box()),
        Container(height: 5, decoration: _box()),
      ] else
        Expanded(child: Container(decoration: _box())),
    ],
  );

  BoxDecoration _box() =>
      BoxDecoration(color: const Color(0x59FFFFFF), borderRadius: BorderRadius.circular(2));

  Widget _mangaPanel(
    BuildContext context, {
    required Gradient art,
    String? bubble,
    String? fx,
    bool alignRight = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: art,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF14161F), width: 2),
      ),
      child: Stack(
        children: [
          if (bubble != null)
            Positioned(
              top: alignRight ? null : 8,
              bottom: alignRight ? 8 : null,
              left: alignRight ? null : 10,
              right: alignRight ? 10 : null,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 190),
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF14161F), width: 1.5),
                ),
                child: Text(
                  bubble,
                  style: AppFonts.inter(
                    color: const Color(0xFF14161F),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          if (fx != null)
            Positioned(
              right: 6,
              bottom: 4,
              child: Text(
                fx,
                style: AppFonts.jetBrainsMono(
                  color: const Color(0xFF14161F),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bible(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _bibleTitle(_t(context, 'NHÂN VẬT (CHARACTER SHEET)', 'CHARACTERS (CHARACTER SHEET)')),
          const SizedBox(height: 9),
          for (var i = 0; i < _charsList.length; i++)
            InkWell(
              onTap: () =>
                  setState(() => _chars.contains(i) ? _chars.remove(i) : _chars.add(i)),
              borderRadius: BorderRadius.circular(11),
              child: Container(
                margin: const EdgeInsets.only(bottom: 7),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.glass,
                  border: Border.all(
                    color: _chars.contains(i)
                        ? AppColors.coral.withValues(alpha: .5)
                        : AppColors.line,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppColors.coral, Color(0xFFFF6D6D)],
                        ),
                      ),
                      child: Text(
                        _charsList[i].$1,
                        style: AppFonts.spaceGrotesk(
                          color: const Color(0xFF14161F),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _t(context, _charsList[i].$2, _charsList[i].$3),
                            style: AppFonts.inter(
                              color: AppColors.parchment,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _t(context, _charsList[i].$4, _charsList[i].$5),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.inter(
                              color: AppColors.smoke,
                              fontSize: 10,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _t(context, '🔒', '🔒'),
                      style: const TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
          _bibleTitle(_t(context, 'PHONG CÁCH TOÀN TRUYỆN', 'SERIES STYLE')),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final (i, label) in _kMangaStyles.indexed)
                InkWell(
                  onTap: () => setState(() => _style = i),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: _style == i
                          ? AppColors.azure.withValues(alpha: .18)
                          : AppColors.glass,
                      border: Border.all(
                        color: _style == i
                            ? AppColors.azure.withValues(alpha: .55)
                            : AppColors.line,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      _t(context, label.$1, label.$2),
                      style: AppFonts.inter(
                        color: _style == i ? Colors.white : AppColors.smoke,
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _bibleTitle(_t(context, 'ĐỒNG BỘ CHI TIẾT', 'DETAIL SYNC')),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.glass,
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _t(context, 'Khoá Seed toàn truyện', 'Lock series seed'),
                    style: AppFonts.jetBrainsMono(color: AppColors.smoke, fontSize: 10.5),
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _seedLock = !_seedLock),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 30,
                    height: 17,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: _seedLock ? AppColors.azure : const Color(0x1FFFFFFF),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 150),
                      alignment: _seedLock
                          ? AlignmentDirectional.centerEnd
                          : AlignmentDirectional.centerStart,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
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
  }

  Widget _bibleTitle(String text) => Text(
    text,
    style: AppFonts.jetBrainsMono(
      color: AppColors.smoke,
      fontSize: 9.5,
      letterSpacing: 1.4,
    ),
  );
}

/// 4 thumb trang trí dưới composer Ảnh — gradient khớp mockup.
const _kImageThumbGradients = <(LinearGradient, String)>[
  (
    LinearGradient(
      colors: [Color(0x8C3D7CFF), Color(0x738B7BFF), Color(0xFF0D0F1A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0, .6, 1],
    ),
    '16:9',
  ),
  (
    LinearGradient(
      colors: [Color(0x808B7BFF), Color(0x663D7CFF), Color(0xFF0D0F1A)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0, .6, 1],
    ),
    '1:1',
  ),
  (
    LinearGradient(
      colors: [Color(0x73FF9466), Color(0x4DFF5050), Color(0xFF0D0F1A)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0, .6, 1],
    ),
    '9:16',
  ),
  (
    LinearGradient(
      colors: [Color(0x663D7CFF), Color(0xFF0D0F1A)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, 1],
    ),
    '16:9',
  ),
];

part of '../admin_dashboard_screen.dart';

// Text tokens cục bộ — admin palette không khai báo màu chữ.
const _mistText = Color(0xFFF1F3F8);
const _smokeText = Color(0xFF8B93A6);
const _mutedText = Color(0xFF687086);

/// View "Hàng đợi tạo" — mock tĩnh theo reel-admin.html: 5 job mẫu với
/// trạng thái đang chạy / hàng đợi / lỗi.
class _QueueView extends StatelessWidget {
  const _QueueView();

  static const _jobs = <(String, String, String, String, String, int)>[
    ('#J-9241', '📖 Manga trang 9', '@quangtrinh', 'Chương 2 — Lò Rèn Trăng…', '6', 2),
    ('#J-9240', '🎞️ Video 8s', '@linhart', 'Flycam thác nước sunset…', '45', 2),
    ('#J-9239', '🖼️ Ảnh 4K', '@toonlab', 'Poster phim kinh dị…', '4', 1),
    ('#J-9238', '🎙️ Giọng nói', '@linhart', 'Chương 3 — narration…', '8', 0),
    ('#J-9237', '📚 Sách chương 4', '@quangtrinh', 'Đêm Trước Cột Mốc…', '5', 1),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.adminSidebarQueue,
            style: AppFonts.spaceGrotesk(
              color: _mistText,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '14 job đang chạy · GPU pool: 4×A100 · trung bình 22s/job',
            style: AppFonts.inter(color: _smokeText, fontSize: 13),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
            decoration: BoxDecoration(
              color: AdminColors.glass,
              border: Border.all(color: AdminColors.line),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(150),
                2: FixedColumnWidth(110),
                3: FixedColumnWidth(230),
                4: FixedColumnWidth(70),
                5: FixedColumnWidth(140),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AdminColors.lineSoft)),
                  ),
                  children: [
                    for (final h in ['ID', 'Công cụ', 'Người dùng', 'Prompt', 'Credits', 'Trạng thái'])
                      _queueCell(
                        h,
                        style: AppFonts.jetBrainsMono(
                          color: _mutedText,
                          fontSize: 9,
                          letterSpacing: 1.2,
                        ),
                      ),
                  ],
                ),
                for (final (id, tool, user, prompt, credits, st) in _jobs)
                  TableRow(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AdminColors.lineSoft)),
                    ),
                    children: [
                      _queueCell(id, mono: true),
                      _queueCell(tool),
                      _queueCell(user, mono: true),
                      _queueCell(prompt, dim: true),
                      _queueCell(credits, mono: true),
                      _queueCell(
                        '',
                        child: _queueStatus(context, st),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _queueCell(
    String text, {
    bool mono = false,
    bool dim = false,
    TextStyle? style,
    Widget? child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: child ??
          Text(
            text,
            style: style ??
                AppFonts.inter(
                  color: dim ? _mutedText : _mistText,
                  fontSize: mono ? 10.5 : 12.5,
                ),
          ),
    );
  }

  Widget _queueStatus(BuildContext context, int st) {
    final (label, color, border, bg) = switch (st) {
      2 => ('⟳ ĐANG CHẠY', const Color(0xFFFFCF7E), const Color(0x66FFCF7E), const Color(0x14FFCF7E)),
      1 => ('HÀNG ĐỢI', const Color(0xFF7EE0A8), const Color(0x667EE0A8), const Color(0x147EE0A8)),
      _ => ('LỖI · HOÀN CR', const Color(0xFFFF9D9D), const Color(0x66FF9D9D), const Color(0x14FF9D9D)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppFonts.jetBrainsMono(
          color: color,
          fontSize: 8.5,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

/// View "Công cụ AI" — 12 toggle bật/tắt công cụ cho toàn hệ thống,
/// mock theo reel-admin.html (tắt chỉ đổi trạng thái local + snackbar).
class _ToolsView extends StatefulWidget {
  const _ToolsView();

  @override
  State<_ToolsView> createState() => _ToolsViewState();
}

class _ToolsViewState extends State<_ToolsView> {
  // (icon, tên, mô tả model + giá, usage, mặc định bật)
  static const _tools = <(String, String, String, String, bool)>[
    ('🖼️', 'Ảnh', 'SDXL · 4 CR', '3.2k/ngày', true),
    ('🎞️', 'Video', 'LTX · 30 CR', '410/ngày', true),
    ('📖', 'Manga', 'Studio · 6 CR/trang', '1.1k trang/ngày', true),
    ('🎙️', 'Giọng nói', 'TTS · 1 CR/100 từ', '890/ngày', true),
    ('🎵', 'Nhạc nền', 'MusicGen · 10 CR', '240/ngày', true),
    ('🎤', 'Bài hát', 'SongGen · 20 CR', '85/ngày', true),
    ('🔊', 'Sound Effect', 'AudioGen · 1 CR', '1.4k/ngày', true),
    ('🧊', 'Mô hình 3D', 'TripoSR · 15 CR', '66/ngày', true),
    ('🏠', 'Cảnh 3D', 'Scene · 15 CR', '31/ngày', true),
    ('🗺️', 'Bản đồ', '4 CR', '48/ngày', true),
    ('🎮', 'Game', 'Beta · 40 CR', '12/ngày', false),
    ('🧑‍💻', 'Agent', 'Beta · tuỳ bước', '7/ngày', false),
  ];

  late final Set<int> _off = {
    for (final (i, t) in _tools.indexed)
      if (!t.$5) i,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.adminSidebarTools,
            style: AppFonts.spaceGrotesk(
              color: _mistText,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Bật/tắt từng công cụ cho toàn hệ thống — tắt sẽ ẩn ngay cả với user đã ghim.',
            style: AppFonts.inter(color: _smokeText, fontSize: 13),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) => GridView.count(
              crossAxisCount: constraints.maxWidth < 720 ? 1 : 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: constraints.maxWidth < 720 ? 5.2 : 4.6,
              children: [
                for (final (i, (icon, name, model, usage, _)) in _tools.indexed)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AdminColors.glass,
                      border: Border.all(color: AdminColors.line),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0x0FFFFFFF),
                            border: Border.all(color: AdminColors.line),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(icon, style: const TextStyle(fontSize: 14)),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: AppFonts.inter(
                                  color: _mistText,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                model,
                                style: AppFonts.inter(
                                  color: _mutedText,
                                  fontSize: 10.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          usage,
                          style: AppFonts.jetBrainsMono(
                            color: _mutedText,
                            fontSize: 9.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _AdminToggle(
                          value: !_off.contains(i),
                          onChanged: (value) {
                            setState(
                              () => value ? _off.remove(i) : _off.add(i),
                            );
                            showMessage(
                              context,
                              value
                                  ? '✓ Đã bật $name'
                                  : '⛔ Đã tắt $name — user không thấy công cụ này',
                            );
                          },
                        ),
                      ],
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

/// Toggle pill dùng cho view Công cụ AI (không phụ thuộc widget khác).
class _AdminToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _AdminToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 34,
        height: 19,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF7EE0A8) : const Color(0x1FFFFFFF),
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: value
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          child: Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

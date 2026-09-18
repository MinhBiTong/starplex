part of '../admin_dashboard_screen.dart';

/// Moderation queue tab – mirrors `panel-moderation` from the mockup:
/// a filter chip row and `.mod-item` cards with a gradient thumbnail, the
/// prompt as title, a status reason chip and a detail action.
class _GenerationsView extends StatefulWidget {
  final ValueChanged<int> onCountChanged;
  const _GenerationsView({required this.onCountChanged});

  @override
  State<_GenerationsView> createState() => _GenerationsViewState();
}

class _GenerationsViewState extends State<_GenerationsView> {
  late final Dio _dio;
  List<Map<String, dynamic>> _items = const [];
  bool _loading = true;
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _dio = ApiClient.instance.dio;
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final response = await _dio.get(
        '/admin/dashboard/generations',
        queryParameters: {'limit': 200},
      );
      if (!mounted) return;
      setState(() {
        _items = (response.data as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
        _loading = false;
      });
      widget.onCountChanged(_countByStatus('pending'));
    } on DioException {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  int _countByStatus(String status) => _items
      .where((item) => (item['status']?.toString() ?? '') == status)
      .length;

  List<Map<String, dynamic>> get _filtered {
    if (_filter == 'all') return _items;
    return _items
        .where((item) => (item['status']?.toString() ?? '') == _filter)
        .toList();
  }

  String _statusLabel(String status) => switch (status) {
        'completed' => 'Hoàn thành',
        'pending' => 'Đang chờ',
        'failed' => 'Lỗi dựng',
        _ => status,
      };

  String _two(int number) => number.toString().padLeft(2, '0');

  String _timeLabel(dynamic value) {
    final parsed = DateTime.tryParse(value?.toString() ?? '');
    if (parsed == null) return '';
    final local = parsed.toLocal();
    return '${_two(local.day)}/${_two(local.month)}/${local.year} ${_two(local.hour)}:${_two(local.minute)}';
  }

  Future<void> _openDetail(Map<String, dynamic> item) async {
    final user = (item['full_name']?.toString() ?? '').trim();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _AdminDialog(
        eyebrow: 'MODERATION',
        title: item['prompt']?.toString() ?? 'Chi tiết lượt dựng',
        maxWidth: 520,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _detailRow(
              'Người gửi',
              user.isEmpty
                  ? item['email']?.toString() ?? '—'
                  : '$user · ${item['email']}',
            ),
            _detailRow(
              'Trạng thái',
              _statusLabel(item['status']?.toString() ?? ''),
            ),
            _detailRow(
              'Loại',
              (item['type']?.toString() ?? 'image').toUpperCase(),
            ),
            _detailRow('Tỉ lệ', item['aspect_ratio']?.toString() ?? '—'),
            _detailRow('Credit', item['credit_cost']?.toString() ?? '0'),
            if ((item['error_message']?.toString() ?? '').isNotEmpty)
              _detailRow('Lỗi', item['error_message'].toString()),
            _detailRow('Thời gian', _timeLabel(item['created_at'])),
          ],
        ),
        actions: [
          _AdminGhostButton(
            label: 'Đóng',
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label.toUpperCase(),
              style: AppFonts.jetBrainsMono(
                color: AdminColors.smoke,
                fontSize: 9.5,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppFonts.inter(color: AdminColors.mist, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending = _countByStatus('pending');
    final completed = _countByStatus('completed');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PanelHead(
          title: 'Kiểm duyệt nội dung',
          subtitle: '$pending mục đang chờ xử lý · $completed đã hoàn thành.',
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final (value, label) in const [
              ('all', 'Tất cả'),
              ('pending', 'Đang chờ'),
              ('completed', 'Hoàn thành'),
              ('failed', 'Lỗi dựng'),
            ])
              _ModFilterChip(
                label: label,
                active: _filter == value,
                onTap: () => setState(() => _filter = value),
              ),
          ],
        ),
        const SizedBox(height: 18),
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(60),
            child: Center(
              child: CircularProgressIndicator(color: AdminColors.azure),
            ),
          )
        else if (_filtered.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              border: Border.all(color: AdminColors.lineSoft),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                'Không có lượt dựng nào trong mục này.',
                style: AppFonts.inter(
                  color: AdminColors.smoke,
                  fontSize: 13.5,
                ),
              ),
            ),
          )
        else
          Column(
            children: [
              for (var i = 0; i < _filtered.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ModItem(
                    item: _filtered[i],
                    variant: i % 5,
                    statusLabel: _statusLabel(
                      _filtered[i]['status']?.toString() ?? '',
                    ),
                    timeLabel: _timeLabel(_filtered[i]['created_at']),
                    onView: () => _openDetail(_filtered[i]),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _ModFilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _ModFilterChip({
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
          color: active ? null : AdminColors.glass,
          border: Border.all(
            color: active ? AdminColors.azure : AdminColors.line,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: AppFonts.inter(
            color: active ? Colors.white : AdminColors.smoke,
            fontSize: 12.5,
          ),
        ),
      ),
    );
  }
}

/// One moderation card – `.mod-item` with `.mod-thumb` / `.mod-reason`.
class _ModItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final int variant;
  final String statusLabel;
  final String timeLabel;
  final VoidCallback onView;

  const _ModItem({
    required this.item,
    required this.variant,
    required this.statusLabel,
    required this.timeLabel,
    required this.onView,
  });

  Color get _statusColor => switch (item['status']?.toString() ?? '') {
        'completed' => AdminColors.good,
        'pending' => AdminColors.warn,
        _ => AdminColors.bad,
      };

  @override
  Widget build(BuildContext context) {
    final prompt = item['prompt']?.toString() ?? '';
    final email = item['email']?.toString() ?? '';
    final type = (item['type']?.toString() ?? 'image').toUpperCase();
    final ratio = item['aspect_ratio']?.toString() ?? '';
    final imageUrl = item['file_url']?.toString();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AdminColors.glass,
        border: Border.all(color: AdminColors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 84,
              height: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ModThumb(variant: variant),
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prompt,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.inter(
                    color: AdminColors.mist,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: .12),
                        border: Border.all(
                          color: _statusColor.withValues(alpha: .3),
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        statusLabel,
                        style: AppFonts.jetBrainsMono(
                          color: _statusColor,
                          fontSize: 10,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                    Text(
                      '$type · $ratio · $timeLabel',
                      style: AppFonts.inter(
                        color: AdminColors.smoke,
                        fontSize: 11.5,
                      ),
                    ),
                    Text(
                      email,
                      style: AppFonts.jetBrainsMono(
                        color: AdminColors.smoke,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          _GhostButton(label: 'Xem', onTap: onView),
        ],
      ),
    );
  }
}

/// Gradient thumbnail placeholder (`.fc`-style radial glows) shown when a
/// generation has no image file yet.
class _ModThumb extends StatelessWidget {
  final int variant;
  const _ModThumb({required this.variant});

  @override
  Widget build(BuildContext context) {
    const setups = <(Alignment, Color, Alignment, Color)>[
      (Alignment(-0.7, -0.9), AdminColors.coral, Alignment(0.9, 0.9), AdminColors.azure),
      (Alignment(0.7, -0.9), AdminColors.azure, Alignment(-0.9, 0.9), Colors.white),
      (Alignment(-0.8, 0.9), AdminColors.coral, Alignment(0.9, -0.7), AdminColors.indigo),
      (Alignment(0.8, 0.9), AdminColors.azure, Alignment(-0.8, -0.7), AdminColors.coral),
      (Alignment(-0.8, 0.8), AdminColors.coral, Alignment(0.9, -0.9), AdminColors.indigo),
    ];
    final (c1, k1, c2, k2) = setups[variant.clamp(0, setups.length - 1)];
    return Container(
      color: AdminColors.panel,
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

part of '../admin_dashboard_screen.dart';

/// Overview tab mirroring `panel-overview` from reel-admin-dashboard.html:
/// KPI grid, a 7-day takes line chart, an account-status donut, a system
/// status strip and the newest registrations table.
class _DashboardView extends StatefulWidget {
  final ValueChanged<int> onOpenTab;
  const _DashboardView({required this.onOpenTab});

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  late final Dio _dio;
  Map<String, dynamic> _summary = const {};
  List<Map<String, dynamic>> _generations = const [];
  List<_AdminUser> _users = const [];
  bool _loading = true;
  DateTime _updatedAt = DateTime.now();

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
    setState(() {
      _loading = true;
      _summary = const {};
    });
    try {
      final responses = await Future.wait([
        _dio.get('/admin/dashboard/summary'),
        _dio.get(
          '/admin/dashboard/generations',
          queryParameters: {'limit': 200},
        ),
        _dio.get('/users', queryParameters: {'page': 1, 'page_size': 100}),
      ]);
      if (!mounted) return;
      final payload = responses[0].data;
      final usersPayload = Map<String, dynamic>.from(responses[2].data as Map);
      setState(() {
        _summary = payload is Map ? Map<String, dynamic>.from(payload) : {};
        _generations = (responses[1].data as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
        _users = (usersPayload['items'] as List? ?? const [])
            .map((item) => _AdminUser.fromJson(Map<String, dynamic>.from(item)))
            .toList();
        _updatedAt = DateTime.now();
        _loading = false;
      });
    } on DioException {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  // -- Derived metrics -------------------------------------------------------

  int get _pendingCount => _generations
      .where((g) => (g['status']?.toString() ?? '') == 'pending')
      .length;
  int get _failedCount => _generations
      .where((g) => (g['status']?.toString() ?? '') == 'failed')
      .length;
  double get _errorRate => _generations.isEmpty
      ? 0
      : _failedCount * 100 / _generations.length;
  String get _avgSpeed {
    final durations = <double>[];
    for (final g in _generations) {
      final start = DateTime.tryParse(g['created_at']?.toString() ?? '');
      final end = DateTime.tryParse(g['completed_at']?.toString() ?? '');
      if (start != null && end != null && end.isAfter(start)) {
        durations.add(end.difference(start).inMilliseconds / 1000);
      }
    }
    if (durations.isEmpty) return '—';
    final avg = durations.reduce((a, b) => a + b) / durations.length;
    return '${avg.toStringAsFixed(1)}s';
  }

  /// Takes per day for the last 7 days (oldest first).
  List<int> get _weeklyTakes {
    final now = DateTime.now();
    final buckets = List.filled(7, 0);
    for (final g in _generations) {
      final created = DateTime.tryParse(g['created_at']?.toString() ?? '');
      if (created == null) continue;
      final diff = DateTime(now.year, now.month, now.day)
          .difference(DateTime(created.year, created.month, created.day))
          .inDays;
      if (diff >= 0 && diff < 7) buckets[6 - diff]++;
    }
    return buckets;
  }

  double get _activeShare {
    if (_users.isEmpty) return 1;
    final active = _users.where((u) => u.status == 'active').length;
    return active / _users.length;
  }

  String _money(num value) {
    if (value >= 1_000_000_000) {
      return '${(value / 1_000_000_000).toStringAsFixed(1)}tỷ';
    }
    if (value >= 1_000_000) {
      return '${(value / 1_000_000).toStringAsFixed(1)}tr';
    }
    return value.toString();
  }

  String _two(int number) => number.toString().padLeft(2, '0');
  String _dateLabel(DateTime date) =>
      '${_two(date.day)}/${_two(date.month)}/${date.year}';

  @override
  Widget build(BuildContext context) {
    final updated =
        'Cập nhật lúc ${_two(_updatedAt.hour)}:${_two(_updatedAt.minute)} · ${_dateLabel(_updatedAt)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PanelHead(
          title: 'Tổng quan hệ thống',
          subtitle: updated,
          action: _GhostButton(
            label: 'Xuất báo cáo',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Tính năng xuất báo cáo sắp ra mắt.'),
                backgroundColor: AdminColors.panel,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(60),
            child: Center(
              child: CircularProgressIndicator(color: AdminColors.azure),
            ),
          )
        else ...[
          _ResponsiveCards(
            children: [
              _AdminKpiCard(
                label: 'Tổng người dùng',
                value: ((_summary['users'] as num?) ?? 0).toInt(),
              ),
              _AdminKpiCard(
                label: 'Tổng lượt dựng',
                value: ((_summary['generations'] as num?) ?? 0).toInt(),
              ),
              _AdminKpiCard(
                label: 'Tổng doanh thu',
                display: '${_money((_summary['revenue'] as num?) ?? 0)}đ',
              ),
              _AdminKpiCard(
                label: 'Giao dịch thành công',
                value: ((_summary['completed_payments'] as num?) ?? 0).toInt(),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _ChartRow(
            left: _ChartCard(
              title: 'Lượt dựng 7 ngày qua',
              child: SizedBox(
                width: double.infinity,
                height: 190,
                child: CustomPaint(
                  painter: _TakesLineChart(values: _weeklyTakes),
                ),
              ),
            ),
            right: _ChartCard(
              title: 'Trạng thái tài khoản',
              child: _AccountDonut(activeShare: _activeShare, total: _users.length),
            ),
          ),
          const SizedBox(height: 22),
          _StatusStrip(
            cards: [
              _StatusCardData(
                good: true,
                label: 'Hàng đợi',
                value: '$_pendingCount đang xử lý',
              ),
              _StatusCardData(
                good: true,
                label: 'Tốc độ dựng TB',
                value: _avgSpeed,
              ),
              _StatusCardData(
                good: _errorRate < 5,
                label: 'Tỉ lệ lỗi',
                value: '${_errorRate.toStringAsFixed(1)}%',
              ),
              _StatusCardData(
                good: true,
                label: 'Credit lưu hành',
                value: ((_summary['credit_balance'] as num?) ?? 0)
                    .toInt()
                    .toString(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Người dùng mới đăng ký',
            style: AppFonts.spaceGrotesk(
              color: AdminColors.mist,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _AdminTable(
            headers: const ['Người dùng', 'Ngày đăng ký', 'Gói'],
            flexes: const [4.2, 2.2, 1.6],
            rows: _users
                .take(5)
                .map(
                  (user) => [
                    _UserCellRow(name: user.fullName ?? user.email, email: user.email),
                    Text(
                      _dateLabel(DateTime.tryParse(user.createdAt) ?? DateTime.now()),
                      style: AppFonts.jetBrainsMono(
                        fontSize: 11.5,
                        color: AdminColors.smoke,
                      ),
                    ),
                    _PlanChip(label: user.role == 'admin' ? 'Pro' : 'Free'),
                  ],
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}

/// KPI card – `.kpi-card` from the mockup: mono label + display number.
class _AdminKpiCard extends StatelessWidget {
  final String label;
  final int? value;
  final String? display;
  const _AdminKpiCard({required this.label, this.value, this.display});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AdminColors.glass,
        border: Border.all(color: AdminColors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.jetBrainsMono(
              color: AdminColors.smoke,
              fontSize: 9.5,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            display ?? value.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.spaceGrotesk(
              color: AdminColors.mist,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Two-column chart band (1.6fr / 1fr on desktop, stacked on mobile).
class _ChartRow extends StatelessWidget {
  final Widget left;
  final Widget right;
  const _ChartRow({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 16, child: left),
              const SizedBox(width: 16),
              Expanded(flex: 10, child: right),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [left, const SizedBox(height: 16), right],
        );
      },
    );
  }
}

/// Glass chart container – `.chart-card`.
class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: AdminColors.glass,
        border: Border.all(color: AdminColors.line),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.spaceGrotesk(
              color: AdminColors.mist,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

/// Area + line chart of the last 7 days of takes, matching the mockup SVG:
/// azure stroke, fading fill, point dots, coral dot on today.
class _TakesLineChart extends CustomPainter {
  final List<int> values;
  _TakesLineChart({required this.values});

  static const _dayLabels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  @override
  void paint(Canvas canvas, Size size) {
    final left = 10.0,
        right = size.width - 10,
        top = 12.0,
        bottom = size.height - 30;
    final maxValue = values.fold<int>(0, (a, b) => a > b ? a : b);
    final span = maxValue == 0 ? 1.0 : maxValue.toDouble();

    Offset pointAt(int i) {
      final x = left + (right - left) * i / (values.length - 1).clamp(1, 6);
      final y = bottom - (bottom - top) * (values[i] / span);
      return Offset(x, y);
    }

    final path = Path()..moveTo(pointAt(0).dx, pointAt(0).dy);
    for (var i = 1; i < values.length; i++) {
      path.lineTo(pointAt(i).dx, pointAt(i).dy);
    }
    // Fading area under the line.
    final fill = Path.from(path)
      ..lineTo(right, bottom)
      ..lineTo(left, bottom)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AdminColors.azure.withValues(alpha: .35),
            AdminColors.azure.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromLTWH(0, top, size.width, bottom - top)),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = AdminColors.azure
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    for (var i = 0; i < values.length; i++) {
      final isToday = i == values.length - 1;
      canvas.drawCircle(
        pointAt(i),
        isToday ? 4 : 3.5,
        Paint()..color = isToday ? AdminColors.coral : AdminColors.azure,
      );
    }

    final labelStyle = AppFonts.jetBrainsMono(
      fontSize: 9.5,
      color: AdminColors.smoke,
    );
    final now = DateTime.now();
    for (var i = 0; i < values.length; i++) {
      final date = now.subtract(Duration(days: values.length - 1 - i));
      final label = _dayLabels[date.weekday - 1];
      final tp = TextPainter(
        text: TextSpan(text: label, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(pointAt(i).dx - tp.width / 2, bottom + 10));
    }
  }

  @override
  bool shouldRepaint(_TakesLineChart old) => old.values != values;
}

/// Donut split of active vs other accounts, centre shows the active share.
class _AccountDonut extends StatelessWidget {
  final double activeShare;
  final int total;
  const _AccountDonut({required this.activeShare, required this.total});

  @override
  Widget build(BuildContext context) {
    final percent = (activeShare * 100).round();
    return Column(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: _DonutPainter(activeShare: activeShare.clamp(0, 1)),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$percent%',
                      style: AppFonts.spaceGrotesk(
                        color: AdminColors.mist,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$total TK',
                      style: AppFonts.jetBrainsMono(
                        color: AdminColors.smoke,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: [
            _LegendItem(
              color: AdminColors.azure,
              label: 'Hoạt động — $percent%',
            ),
            _LegendItem(
              color: AdminColors.coral,
              label: 'Khác — ${100 - percent}%',
            ),
          ],
        ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double activeShare;
  const _DonutPainter({required this.activeShare});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 11;
    const stroke = 22.0;
    // Background ring (coral) = non-active share.
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = AdminColors.coral.withValues(alpha: .85),
    );
    // Foreground arc (azure) = active share, starting at 12 o'clock.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      3.14159 * 2 * activeShare,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = AdminColors.azure,
    );
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.activeShare != activeShare;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppFonts.inter(color: AdminColors.smoke, fontSize: 12),
        ),
      ],
    );
  }
}

/// Status metric card – `.status-card` with glowing dot.
class _StatusCardData {
  final bool good;
  final String label;
  final String value;
  const _StatusCardData({
    required this.good,
    required this.label,
    required this.value,
  });
}

class _StatusStrip extends StatelessWidget {
  final List<_StatusCardData> cards;
  const _StatusStrip({required this.cards});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 900 ? 4 : 2;
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: constraints.maxWidth / columns / 86,
          children: [
            for (final card in cards)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AdminColors.glass,
                  border: Border.all(color: AdminColors.line),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: card.good ? AdminColors.good : AdminColors.warn,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: card.good
                                    ? AdminColors.good.withValues(alpha: .6)
                                    : AdminColors.warn.withValues(alpha: .6),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            card.label.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.jetBrainsMono(
                              color: AdminColors.smoke,
                              fontSize: 9.5,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      card.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.spaceGrotesk(
                        color: AdminColors.mist,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
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
}

/// Revenue tab composite: KPI band + 6-month bar chart above the existing
/// payments and credit-transaction views.
class _RevenueTab extends StatefulWidget {
  const _RevenueTab();

  @override
  State<_RevenueTab> createState() => _RevenueTabState();
}

class _RevenueTabState extends State<_RevenueTab> {
  late final Dio _dio;
  List<Map<String, dynamic>> _payments = const [];
  bool _loading = true;

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
    try {
      final response = await _dio.get('/admin/payments');
      if (!mounted) return;
      setState(() {
        _payments = (response.data as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
        _loading = false;
      });
    } on DioException {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  num get _totalRevenue => _payments
      .where((p) => (p['status']?.toString() ?? '') == 'completed')
      .fold<num>(0, (sum, p) => sum + ((p['amount'] as num?) ?? 0));
  int get _completedCount => _payments
      .where((p) => (p['status']?.toString() ?? '') == 'completed')
      .length;
  double get _successRate =>
      _payments.isEmpty ? 0 : _completedCount * 100 / _payments.length;

  /// Completed revenue per month for the last 6 months (oldest first).
  List<num> get _monthlyRevenue {
    final now = DateTime.now();
    final buckets = List<num>.filled(6, 0);
    for (final p in _payments) {
      if ((p['status']?.toString() ?? '') != 'completed') continue;
      final created = DateTime.tryParse(p['created_at']?.toString() ?? '');
      if (created == null) continue;
      final diff =
          (now.year - created.year) * 12 + (now.month - created.month);
      if (diff >= 0 && diff < 6) buckets[5 - diff] += (p['amount'] as num?) ?? 0;
    }
    return buckets;
  }

  String _money(num value) {
    if (value >= 1_000_000) {
      return '${(value / 1_000_000).toStringAsFixed(1)}tr';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthLabels = List.generate(
      6,
      (i) => 'T${DateTime(now.year, now.month - 5 + i).month}',
    );
    final maxRevenue = _monthlyRevenue.fold<num>(0, (a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PanelHead(
          title: 'Doanh thu',
          subtitle: 'Tổng quan giao dịch và dòng tiền gần đây.',
        ),
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(60),
            child: Center(
              child: CircularProgressIndicator(color: AdminColors.azure),
            ),
          )
        else ...[
          _ResponsiveCards(
            children: [
              _AdminKpiCard(
                label: 'Tổng doanh thu',
                display: '${_money(_totalRevenue)}đ',
              ),
              _AdminKpiCard(
                label: 'Giao dịch thành công',
                value: _completedCount,
              ),
              _AdminKpiCard(
                label: 'Tỉ lệ thành công',
                display: '${_successRate.toStringAsFixed(1)}%',
              ),
            ],
          ),
          const SizedBox(height: 22),
          _ChartCard(
            title: 'Doanh thu 6 tháng qua',
            child: SizedBox(
              height: 170,
              child: _RevenueBarChart(
                values: _monthlyRevenue,
                labels: monthLabels,
                max: maxRevenue == 0 ? 1 : maxRevenue,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
        const _PaymentsView(),
        const SizedBox(height: 8),
        const _CreditsView(),
      ],
    );
  }
}

/// Vertical bar chart – `.bar-chart` with the coral→azure gradient fill.
class _RevenueBarChart extends StatelessWidget {
  final List<num> values;
  final List<String> labels;
  final num max;
  const _RevenueBarChart({
    required this.values,
    required this.labels,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < values.length; i++)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 34,
                  height:
                      ((values[i] / max) * 120).clamp(6, 120).toDouble(),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AdminColors.coral, AdminColors.azure],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                      bottom: Radius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  labels[i],
                  style: AppFonts.jetBrainsMono(
                    color: AdminColors.smoke,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// System tab composite: health banner, status strip, 20-day uptime strip,
/// then the existing package management and settings views.
class _SystemTab extends StatefulWidget {
  const _SystemTab();

  @override
  State<_SystemTab> createState() => _SystemTabState();
}

class _SystemTabState extends State<_SystemTab> {
  late final Dio _dio;
  List<Map<String, dynamic>> _generations = const [];
  bool _loading = true;

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
    try {
      final response = await _dio.get(
        '/admin/dashboard/generations',
        queryParameters: {'limit': 200},
      );
      if (!mounted) return;
      setState(() {
        _generations = (response.data as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
        _loading = false;
      });
    } on DioException {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  int _failuresOnDay(int daysAgo) {
    final now = DateTime.now();
    return _generations.where((g) {
      if ((g['status']?.toString() ?? '') != 'failed') return false;
      final created = DateTime.tryParse(g['created_at']?.toString() ?? '');
      if (created == null) return false;
      return now.difference(created).inDays == daysAgo;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final failed = _generations
        .where((g) => (g['status']?.toString() ?? '') == 'failed')
        .length;
    final errorRate =
        _generations.isEmpty ? 0.0 : failed * 100 / _generations.length;
    final pending = _generations
        .where((g) => (g['status']?.toString() ?? '') == 'pending')
        .length;
    final allGood = errorRate < 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PanelHead(
          title: 'Hệ thống',
          subtitle: 'Tình trạng hạ tầng và hàng đợi dựng cảnh.',
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: (allGood ? AdminColors.good : AdminColors.warn)
                .withValues(alpha: .08),
            border: Border.all(
              color: (allGood ? AdminColors.good : AdminColors.warn)
                  .withValues(alpha: .3),
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                allGood ? Icons.check_circle_outline : Icons.warning_amber_rounded,
                size: 18,
                color: allGood ? AdminColors.good : AdminColors.warn,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  allGood
                      ? 'Tất cả hệ thống đang hoạt động bình thường.'
                      : 'Phát hiện một số lỗi dựng cảnh — vui lòng kiểm tra hàng đợi.',
                  style: AppFonts.inter(
                    color: allGood ? AdminColors.good : AdminColors.warn,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(60),
            child: Center(
              child: CircularProgressIndicator(color: AdminColors.azure),
            ),
          )
        else ...[
          _StatusStrip(
            cards: [
              _StatusCardData(
                good: true,
                label: 'Hàng đợi dựng cảnh',
                value: '$pending đang xử lý',
              ),
              _StatusCardData(
                good: _errorRateOf() < 5,
                label: 'Tỉ lệ lỗi',
                value: '${_errorRateOf().toStringAsFixed(1)}%',
              ),
            ],
          ),
          const SizedBox(height: 22),
          _ChartCard(
            title: 'Ổn định 20 ngày qua',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (var day = 19; day >= 0; day--)
                      Expanded(
                        child: Tooltip(
                          message:
                              _failuresOnDay(day) == 0 ? 'Bình thường' : '${_failuresOnDay(day)} lỗi',
                          child: Container(
                            height: 26,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration: BoxDecoration(
                              color: _failuresOnDay(day) == 0
                                  ? AdminColors.good
                                  : AdminColors.warn,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Mỗi ô là một ngày. Ô vàng đánh dấu ngày có lượt dựng lỗi.',
                  style: AppFonts.inter(
                    color: AdminColors.smoke,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
        const _PackagesView(),
        const SizedBox(height: 8),
        const _SettingsView(),
      ],
    );
  }

  double _errorRateOf() {
    if (_generations.isEmpty) return 0;
    final failed = _generations
        .where((g) => (g['status']?.toString() ?? '') == 'failed')
        .length;
    return failed * 100 / _generations.length;
  }
}

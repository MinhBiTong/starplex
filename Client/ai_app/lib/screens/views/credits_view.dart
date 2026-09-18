part of '../admin_dashboard_screen.dart';

class _CreditsView extends StatefulWidget {
  const _CreditsView();
  @override
  State<_CreditsView> createState() => _CreditsViewState();
}

class _CreditsViewState extends State<_CreditsView> {
  late final Dio _dio;
  List<Map<String, dynamic>> _items = const [];
  bool _loading = true;
  String? _error;
  @override
  void initState() {
    super.initState();
    _dio = buildDio();
    _load();
  }

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }

    Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await _dio.get(
        '/admin/dashboard/credits'
      );
      if (!mounted) return;
      setState(() {
        _items = (response.data as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        _loading = false;
      });
    } on DioException catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = error.response?.data is Map
            ? error.response!.data['detail']?.toString() ??
                'Không tải được giao dịch credit.'
            : 'Không tải được giao dịch credit.';
      });
    }
  }

  Future<void> _adjust(Map<String, dynamic> item) async {
    final amountController = TextEditingController();
    final reasonController = TextEditingController(
      text: 'Điều chỉnh bởi admin',
    );
    final submitted = await showDialog<bool>(
      context: context,
      builder: (context) => _AdminDialog(
        eyebrow: 'ADJUST CREDIT',
        title: 'Điều chỉnh credit',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              decoration: BoxDecoration(
                color: AdminColors.glass,
                border: Border.all(color: AdminColors.line),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AdminColors.gold, AdminColors.coral],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item['email']?.toString() ?? '',
                      style: AppFonts.inter(
                        fontSize: 13,
                        color: AdminColors.cream,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _AdminField(
              label: 'Số lượng (+/-)',
              hint: 'Số nguyên · có dấu',
              child: _AdminTextField(
                controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
              ),
            ),
            _AdminField(
              label: 'Lý do',
              hint: 'Mô tả thay đổi',
              child: _AdminTextField(
                controller: reasonController,
              ),
            ),
          ],
        ),
        actions: [
          _AdminGhostButton(
            label: 'Hủy',
            onPressed: () => Navigator.pop(context, false),
          ),
          _AdminPrimaryButton(
            label: 'Lưu',
            icon: Icons.check_rounded,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    final amount = int.tryParse(amountController.text.trim());
    if (submitted != true || amount == null || amount == 0 || !mounted) {
      amountController.dispose();
      reasonController.dispose();
      return;
    }
    try {
      await _dio.post(
        '/credits/admin/${item['user_id']}/adjust',
        data: {'amount': amount, 'description': reasonController.text.trim()}
      );
      if (mounted) {
        _message('Đã điều chỉnh credit.');
        await _load();
      }
    } on DioException catch (error) {
      if (mounted) {
        final detail = error.response?.data is Map
            ? error.response!.data['detail']?.toString()
            : null;
        _message(detail ?? 'Không thể điều chỉnh credit.', true);
      }
    } finally {
      amountController.dispose();
      reasonController.dispose();
    }
  }

  void _message(String value, [bool error = false]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        backgroundColor: error ? AdminColors.red : AdminColors.green,
      ),
    );
  }

  String _dateLabel(dynamic value) {
    final str = value?.toString() ?? '';
    final iso = str.split('T').first;
    final parts = iso.split('-');
    if (parts.length == 3) {
      return '${parts[2]}/${parts[1]}/${parts[0]}';
    }
    return iso;
  }

  Widget _typePill(String value) {
    switch (value) {
      case 'purchase':
      case 'bonus':
        return _StatusPill.info(value.toUpperCase());
      case 'refund':
        return _StatusPill.processing(value.toUpperCase());
      default:
        return _StatusPill.failed(value.toUpperCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(color: AdminColors.gold),
        ),
      );
    }
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          _error!,
          style: AppFonts.inter(color: AdminColors.creamDim, fontSize: 13),
        ),
      );
    }
    return _PanelBlock(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FilterBar(
            children: [_GhostButton(label: 'Tải lại', onTap: _load)],
          ),
          _items.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    l10n.adminCreditsEmpty,
                    style: const TextStyle(color: AdminColors.muted),
                  ),
                )
              : _AdminTable(
                  headers: const [
                    'Mã',
                    'Người dùng',
                    'Loại',
                    'Số lượng',
                    'Số dư sau',
                    'Lý do',
                    'Thời gian',
                    '',
                  ],
                  flexes: const [0.6, 2.8, 1.2, 1.0, 1.0, 2.0, 1.1, 1.0],
                  rows: _items.map((c) {
                    final amount = (c['amount'] as num?) ?? 0;
                    return [
                      Text(
                        '#${c['id']}',
                        style: AppFonts.jetBrainsMono(
                          fontSize: 11,
                          color: AdminColors.muted,
                        ),
                      ),
                      _UserCellRow(
                        name: (c['full_name']?.toString() ?? '').trim(),
                        email: c['email']?.toString() ?? '',
                      ),
                      _typePill(c['type']?.toString() ?? ''),
                      Text(
                        amount.toString(),
                        style: AppFonts.jetBrainsMono(
                          fontSize: 11,
                          color: amount >= 0
                              ? AdminColors.green
                              : AdminColors.coral,
                        ),
                      ),
                      Text(
                        (c['balance_after']?.toString() ?? '0'),
                        style: AppFonts.jetBrainsMono(
                          fontSize: 11,
                          color: AdminColors.mist,
                        ),
                      ),
                      Text(
                        c['description']?.toString() ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.inter(
                          color: AdminColors.creamDim,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _dateLabel(c['created_at']),
                        style: AppFonts.jetBrainsMono(
                          fontSize: 11,
                          color: AdminColors.muted,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _ActionBtn(
                          label: 'Điều chỉnh',
                          onTap: () => _adjust(c),
                        ),
                      ),
                    ];
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

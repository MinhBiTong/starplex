part of '../admin_dashboard_screen.dart';

class _PaymentsView extends StatefulWidget {
  const _PaymentsView();
  @override
  State<_PaymentsView> createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<_PaymentsView> {
  late final Dio _dio;
  List<Map<String, dynamic>> _payments = const [];
  bool _loading = true;
  String? _statusFilter;
  String? _methodFilter;

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
    try {
      final response = await _dio.get(
        '/admin/payments',
        queryParameters: {
          if (_statusFilter != null) 'status': _statusFilter,
          if (_methodFilter != null) 'payment_method': _methodFilter,
        }
      );
      if (mounted) {
        setState(() {
          _payments = (response.data as List)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
          _loading = false;
        });
      }
    } on DioException catch (error) {
      if (mounted) {
        setState(() => _loading = false);
        _message(
          error.response?.data is Map
              ? error.response!.data['detail']?.toString() ??
                    'Không tải được payments.'
              : 'Không tải được payments.',
          true,
        );
      }
    }
  }

  void _message(String value, [bool error = false]) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value),
          backgroundColor: error ? AdminColors.red : AdminColors.green,
        ),
      );

  Future<void> _showPaymentDetail(Map<String, dynamic> payment) async {
    await showDialog(
      context: context,
      builder: (context) => _PaymentDetailDialog(
        payment: payment,
        onRefund: () async {
          Navigator.of(context).pop();
          await _refundPayment(payment);
        },
      ),
    );
  }

  Future<void> _refundPayment(Map<String, dynamic> payment) async {
    // Confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _AdminDialog(
        eyebrow: 'CONFIRM',
        title: 'Xác nhận hoàn tiền',
        maxWidth: 460,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bạn có chắc muốn hoàn tiền cho giao dịch này?',
              style: AppFonts.spaceGrotesk(
                color: AdminColors.cream,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: AdminColors.glass,
                border: Border.all(color: AdminColors.line),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _refundRow(
                    'Trừ credit người dùng',
                    'âˆ’${payment['credit_amount']} credits',
                  ),
                  const SizedBox(height: 8),
                  _refundRow(
                    'Đánh dấu giao dịch',
                    'Đã hủy',
                  ),
                  const SizedBox(height: 8),
                  _refundRow(
                    'Tạo giao dịch hoàn tiền',
                    'Refund transaction',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 14,
                  color: AdminColors.amber,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Hành động này không thể hoàn tác.',
                    style: AppFonts.inter(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AdminColors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          _AdminGhostButton(
            label: 'Hủy',
            onPressed: () => Navigator.of(context).pop(false),
          ),
          _AdminPrimaryButton(
            label: 'Hoàn tiền',
            icon: Icons.replay_rounded,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await _dio.post(
        '/admin/payments/${payment['id']}/refund'
      );
      _message('Refund processed successfully');
      await _load();
    } on DioException catch (error) {
      if (mounted) {
        final message = error.response?.data is Map
            ? error.response!.data['detail']?.toString() ??
                  'Failed to process refund'
            : 'Failed to process refund';
        _message(message, true);
      }
    }
  }

  Future<void> _changeStatus(
    Map<String, dynamic> payment,
    String status,
  ) async {
    try {
      await _dio.patch(
        '/admin/payments/${payment['id']}/status',
        data: {'status': status}
      );
      _message('Đã cập nhật giao dịch.');
      await _load();
    } on DioException catch (error) {
      if (mounted) {
        _message(
          error.response?.data is Map
              ? error.response!.data['detail']?.toString() ??
                    'Không cập nhật được.'
              : 'Không cập nhật được.',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: AdminColors.gold),
      );
    }
    return _PanelBlock(
      child: Column(
        children: [
          _FilterBar(
            children: [
              _FilterSelect(
                label: 'Tất cả trạng thái',
                value: _statusFilter ?? 'all',
                items: [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text(l10n.adminPaymentsFilterAll),
                  ),
                  DropdownMenuItem(value: 'pending', child: Text('Đang xử lý')),
                  DropdownMenuItem(
                    value: 'completed',
                    child: Text('Thành công'),
                  ),
                  DropdownMenuItem(value: 'failed', child: Text('Thất bại')),
                  DropdownMenuItem(value: 'cancelled', child: Text('Đã hủy')),
                ],
                onChanged: (value) {
                  setState(() => _statusFilter = value == 'all' ? null : value);
                  _load();
                },
              ),
              _FilterSelect(
                label: 'Tất cả phương thức',
                value: _methodFilter ?? 'all',
                items: const [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text('Tất cả phương thức'),
                  ),
                  DropdownMenuItem(value: 'momo', child: Text('MoMo')),
                  DropdownMenuItem(value: 'zalopay', child: Text('ZaloPay')),
                  DropdownMenuItem(value: 'vnpay', child: Text('VNPay')),
                  DropdownMenuItem(
                    value: 'bank_transfer',
                    child: Text('Bank transfer'),
                  ),
                  DropdownMenuItem(value: 'stripe', child: Text('Stripe')),
                ],
                onChanged: (value) {
                  setState(() => _methodFilter = value == 'all' ? null : value);
                  _load();
                },
              ),
              _GhostButton(label: 'Tải lại', onTap: _load),
            ],
          ),
          _payments.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(l10n.adminPaymentsEmpty),
                )
              : _AdminTable(
                  headers: const [
                    'Mã GD',
                    'Gói',
                    'Số tiền',
                    'Phương thức',
                    'Trạng thái',
                    'Ngày',
                    '',
                  ],
                  rows: _payments
                      .map(
                        (p) => [
                          Text(
                            p['transaction_code']?.toString() ?? '#${p['id']}',
                          ),
                          Text(p['package_name']?.toString() ?? ''),
                          Text('${p['amount']} ${p['currency']}'),
                          Text(p['payment_method']?.toString() ?? ''),
                          _status(p['status']?.toString() ?? ''),
                          Text(
                            _dateLabel(p['created_at']),
                            style: AppFonts.jetBrainsMono(
                              fontSize: 11,
                              color: AdminColors.muted,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _ActionBtn(
                                label: 'Chi tiết',
                                onTap: () => _showPaymentDetail(p),
                              ),
                              if (p['status'] == 'pending') ...[
                                _ActionBtn(
                                  label: 'Duyệt',
                                  onTap: () => _changeStatus(p, 'completed'),
                                ),
                                _ActionBtn(
                                  label: 'Hủy',
                                  isDanger: true,
                                  onTap: () => _changeStatus(p, 'cancelled'),
                                ),
                              ],
                              if (p['status'] == 'completed')
                                _ActionBtn(
                                  label: 'Hoàn tiền',
                                  isDanger: true,
                                  onTap: () => _refundPayment(p),
                                ),
                            ],
                          ),
                        ],
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _refundRow(String label, String value) {
    return Row(
      children: [
        Text(
          '•',
          style: AppFonts.jetBrainsMono(
            fontSize: 13,
            color: AdminColors.goldBright,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: AppFonts.inter(
              fontSize: 13,
              color: AdminColors.creamDim,
            ),
          ),
        ),
        Text(
          value,
          style: AppFonts.jetBrainsMono(
            fontSize: 12,
            color: AdminColors.cream,
          ),
        ),
      ],
    );
  }

  Widget _status(String value) {
    if (value == 'completed') return _StatusPill.done('Thành công');
    if (value == 'failed') return _StatusPill.failed('Thất bại');
    if (value == 'cancelled') return _StatusPill.suspended('Đã hủy');
    return _StatusPill.processing('Đang xử lý');
  }

  String _dateLabel(dynamic value) {
    final str = value?.toString() ?? '';
    final iso = str.split('T').first;
    final parts = iso.split('-');
    if (parts.length == 3) return '${parts[2]}/${parts[1]}/${parts[0]}';
    return iso;
  }
}

class _PaymentDetailDialog extends StatelessWidget {
  final Map<String, dynamic> payment;
  final VoidCallback onRefund;

  const _PaymentDetailDialog({required this.payment, required this.onRefund});

  String _dateLabel(dynamic value) {
    final str = value?.toString() ?? '';
    final iso = str.split('T').first;
    final parts = iso.split('-');
    if (parts.length == 3) return '${parts[2]}/${parts[1]}/${parts[0]}';
    return iso;
  }

  @override
  Widget build(BuildContext context) {
    final status = payment['status']?.toString() ?? '';
    final isCompleted = status == 'completed';

    return _AdminDialog(
      eyebrow: 'PAYMENT DETAILS',
      title: payment['transaction_code']?.toString() ?? '#${payment['id']}',
      maxWidth: 600,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hero amount card
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            decoration: BoxDecoration(
              color: AdminColors.glass,
              border: Border.all(color: AdminColors.line),
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AdminColors.glassStrong,
                  AdminColors.glass,
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: AdminColors.spectrum,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    size: 18,
                    color: Color(0xFF06070F),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        payment['package_name']?.toString() ?? 'N/A',
                        style: AppFonts.spaceGrotesk(
                          color: AdminColors.cream,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${payment['amount']} ${payment['currency']}  ·  '
                        '+${payment['credit_amount'] ?? 0} credits',
                        style: AppFonts.jetBrainsMono(
                          color: AdminColors.creamDim,
                          fontSize: 11,
                          letterSpacing: .8,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0x2255D6BE)
                        : const Color(0x22FFB86B),
                    border: Border.all(
                      color: isCompleted
                          ? AdminColors.green
                          : AdminColors.amber,
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: AppFonts.jetBrainsMono(
                      color: isCompleted
                          ? AdminColors.green
                          : AdminColors.amber,
                      fontSize: 10,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Mã giao dịch',
            value:
                payment['transaction_code']?.toString() ??
                '#${payment['id']}',
            mono: true,
          ),
          _DetailRow(
            label: 'Phương thức',
            value: payment['payment_method']?.toString().toUpperCase() ?? 'N/A',
            mono: true,
          ),
          _DetailRow(
            label: 'User ID',
            value: '#${payment['user_id']}',
            mono: true,
          ),
          _DetailRow(
            label: 'Ngày tạo',
            value: _dateLabel(payment['created_at']).isEmpty
                ? 'N/A'
                : _dateLabel(payment['created_at']),
            mono: true,
          ),
          if (payment['paid_at'] != null)
            _DetailRow(
              label: 'Ngày thanh toán',
              value: _dateLabel(payment['paid_at']).isEmpty
                  ? 'N/A'
                  : _dateLabel(payment['paid_at']),
              mono: true,
            ),
          if (payment['provider_transaction_id'] != null)
            _DetailRow(
              label: 'Provider transaction',
              value:
                  payment['provider_transaction_id']?.toString() ?? 'N/A',
              mono: true,
            ),
        ],
      ),
      actions: [
        if (isCompleted)
          _DangerButton(
            label: 'Process refund',
            icon: Icons.replay_rounded,
            onPressed: onRefund,
          ),
        _AdminGhostButton(
          label: 'Đóng',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool mono;

  const _DetailRow({
    required this.label,
    required this.value,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label.toUpperCase(),
              style: AppFonts.jetBrainsMono(
                color: AdminColors.muted,
                fontSize: 9.5,
                letterSpacing: 1.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: (mono
                      ? AppFonts.jetBrainsMono(
                          color: AdminColors.cream,
                          fontSize: 12.5,
                        )
                      : AppFonts.inter(
                          color: AdminColors.cream,
                          fontSize: 13,
                        )),
            ),
          ),
        ],
      ),
    );
  }
}

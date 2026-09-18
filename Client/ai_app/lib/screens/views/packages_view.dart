part of '../admin_dashboard_screen.dart';

class _AdminPackage {
  final int id;
  final String name;
  final double price;
  final String currency;
  final int creditAmount;
  final String? description;
  final bool isActive;
  final String billingPeriod;
  final bool isFeatured;
  final List<String> benefits;

  const _AdminPackage({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.creditAmount,
    required this.description,
    required this.isActive,
    required this.billingPeriod,
    required this.isFeatured,
    required this.benefits,
  });

  factory _AdminPackage.fromJson(Map<String, dynamic> json) => _AdminPackage(
    id: json['id'] as int,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    currency: json['currency'] as String,
    creditAmount: json['credit_amount'] as int,
    description: json['description'] as String?,
    isActive: json['is_active'] == true,
    billingPeriod: json['billing_period'] as String,
    isFeatured: json['is_featured'] == true,
    benefits: (json['benefits'] as List? ?? const [])
        .map((item) => item.toString())
        .toList(),
  );
}

class _PackagesView extends StatefulWidget {
  const _PackagesView();
  @override
  State<_PackagesView> createState() => _PackagesViewState();
}

class _PackagesViewState extends State<_PackagesView> {
  late final Dio _dio;
  List<_AdminPackage> _packages = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _dio = buildDio(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
    );
    _loadPackages();
  }

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }

  String _dioMessage(DioException error) {
    final l10n = AppLocalizations.of(context);
    return dioErrorMessage(error, l10n.errorGeneric);
  }

  void _showMessage(String message, {bool error = false}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: error ? AdminColors.red : AdminColors.green,
        ),
      );

  Future<void> _loadPackages() async {
    setState(() => _loading = true);
    try {
      final response = await _dio.get('/admin/payment-packages');
      final items = (response.data as List)
          .map(
            (item) => _AdminPackage.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
      if (!mounted) return;
      setState(() {
        _packages = items;
        _loading = false;
      });
    } on DioException catch (error) {
      if (!mounted) return;
      setState(() => _loading = false);
      _showMessage(_dioMessage(error), error: true);
    }
  }

  Future<void> _openForm([_AdminPackage? package]) async {
    final payload = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _PackageFormDialog(package: package),
    );
    if (payload == null || !mounted) return;
    try {
      if (package == null) {
        await _dio.post('/admin/payment-packages', data: payload);
      } else {
        await _dio.put(
          '/admin/payment-packages/${package.id}',
          data: payload,
        );
      }
      if (!mounted) return;
      _showMessage(
        package == null ? 'Đã tạo package.' : 'Đã cập nhật package.',
      );
      await _loadPackages();
    } on DioException catch (error) {
      if (mounted) _showMessage(_dioMessage(error), error: true);
    }
  }

  Future<void> _toggle(_AdminPackage package, bool value) async {
    try {
      await _dio.patch(
        '/admin/payment-packages/${package.id}/status',
        queryParameters: {'is_active': value},
      );
      await _loadPackages();
    } on DioException catch (error) {
      if (mounted) _showMessage(_dioMessage(error), error: true);
    }
  }

  Future<void> _delete(_AdminPackage package) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _AdminDialog(
        eyebrow: 'DELETE',
        title: 'Xóa package',
        maxWidth: 440,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bạn có chắc muốn xóa package này?',
              style: AppFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AdminColors.cream,
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
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AdminColors.spectrum,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      package.name.isNotEmpty
                          ? package.name[0].toUpperCase()
                          : '?',
                      style: AppFonts.spaceGrotesk(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF06070F),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.name,
                          style: AppFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AdminColors.cream,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ID #${package.id}',
                          style: AppFonts.jetBrainsMono(
                            fontSize: 11,
                            color: AdminColors.muted,
                          ),
                        ),
                      ],
                    ),
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
            onPressed: () => Navigator.pop(context, false),
          ),
          _DangerButton(
            label: 'Xóa package',
            icon: Icons.delete_outline_rounded,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _dio.delete('/admin/payment-packages/${package.id}');
      if (mounted) _showMessage('Đã xóa package.');
      await _loadPackages();
    } on DioException catch (error) {
      if (mounted) _showMessage(_dioMessage(error), error: true);
    }
  }

  String _periodLabel(String value, AppLocalizations l10n) => value == 'monthly'
      ? l10n.pricingPeriodMonthly
      : value == 'yearly'
      ? l10n.pricingPeriodYearly
      : '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelBlock(
      title: l10n.adminPackagesTitle,
      eyebrow: 'Gói bán',
      action: _PrimaryButton(label: '+ ${l10n.adminPackagesNew}', onTap: () => _openForm()),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: _loading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator(color: AdminColors.gold),
                ),
              )
            : _packages.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(l10n.adminPackagesEmpty),
                ),
              )
            : _ResponsiveCards(
                children: _packages
                    .map(
                      (package) => _AdminPackageCard(
                        package: package,
                        priceUnit: _periodLabel(package.billingPeriod, l10n),
                        onEdit: () => _openForm(package),
                        onToggle: (value) => _toggle(package, value),
                        onDelete: () => _delete(package),
                        l10n: l10n,
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}

class _AdminPackageCard extends StatelessWidget {
  final _AdminPackage package;
  final String priceUnit;
  final VoidCallback onEdit;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;
  final AppLocalizations l10n;
  const _AdminPackageCard({
    required this.package,
    required this.priceUnit,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      border: Border.all(
        color: package.isFeatured ? AdminColors.gold : AdminColors.line,
      ),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AdminColors.panel2, AdminColors.panel],
      ),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        if (package.isFeatured)
          Positioned(
            top: -25,
            right: -25,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: AdminColors.burgundy,
              child: Text(
                l10n.adminPackagesFeatured.toUpperCase(),
                style: AppFonts.jetBrainsMono(
                  fontSize: 9,
                  color: AdminColors.cream,
                ),
              ),
            ),
          ),
        Column(
          children: [
            Text(
              package.name,
              style: AppFonts.spaceGrotesk(
                fontSize: 22,
                color: AdminColors.cream,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${package.currency == 'USD' ? '\$' : package.currency} ${package.price.toStringAsFixed(0)}',
                    style: AppFonts.spaceGrotesk(
                      fontSize: 28,
                      color: AdminColors.goldBright,
                    ),
                  ),
                  TextSpan(
                    text: priceUnit,
                    style: AppFonts.jetBrainsMono(
                      fontSize: 11,
                      color: AdminColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${package.creditAmount} CREDITS',
              style: AppFonts.jetBrainsMono(
                fontSize: 11,
                letterSpacing: 1,
                color: AdminColors.creamDim,
              ),
            ),
            const SizedBox(height: 12),
            if (package.benefits.isNotEmpty)
              Text(
                package.benefits.join(' • '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AdminColors.muted, fontSize: 11),
              ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  package.isActive ? l10n.adminPackagesActive : l10n.adminPackagesInactive,
                  style: AppFonts.jetBrainsMono(
                    fontSize: 10.5,
                    color: AdminColors.muted,
                  ),
                ),
                const SizedBox(width: 8),
                _Switch(initialValue: package.isActive, onChanged: onToggle),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _GhostButton(
                    label: 'Chỉnh sửa',
                    isFullWidth: true,
                    onTap: onEdit,
                  ),
                ),
                const SizedBox(width: 8),
                _ActionBtn(label: l10n.commonDelete, isDanger: true, onTap: onDelete),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class _PackageFormDialog extends StatefulWidget {
  final _AdminPackage? package;
  const _PackageFormDialog({this.package});
  @override
  State<_PackageFormDialog> createState() => _PackageFormDialogState();
}

class _PackageFormDialogState extends State<_PackageFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name,
      _price,
      _currency,
      _credits,
      _description,
      _benefits;
  late String _period;
  late bool _active, _featured;

  @override
  void initState() {
    super.initState();
    final p = widget.package;
    _name = TextEditingController(text: p?.name ?? '');
    _price = TextEditingController(text: p?.price.toStringAsFixed(2) ?? '');
    _currency = TextEditingController(text: p?.currency ?? 'USD');
    _credits = TextEditingController(text: p?.creditAmount.toString() ?? '');
    _description = TextEditingController(text: p?.description ?? '');
    _benefits = TextEditingController(text: p?.benefits.join('\n') ?? '');
    _period = p?.billingPeriod ?? 'one_time';
    _active = p?.isActive ?? true;
    _featured = p?.isFeatured ?? false;
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _currency.dispose();
    _credits.dispose();
    _description.dispose();
    _benefits.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, {
      'name': _name.text.trim(),
      'price': double.parse(_price.text.trim()),
      'currency': _currency.text.trim().toUpperCase(),
      'credit_amount': int.parse(_credits.text.trim()),
      'description': _description.text.trim().isEmpty
          ? null
          : _description.text.trim(),
      'is_active': _active,
      'billing_period': _period,
      'is_featured': _featured,
      'benefits': _benefits.text
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.package != null;
    return _AdminDialog(
      eyebrow: editing ? 'EDIT PACKAGE' : 'NEW PACKAGE',
      title: editing ? 'Chỉnh sửa package' : 'Tạo package mới',
      maxWidth: 560,
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _AdminField(
              label: 'Tên package',
              hint: 'Bắt buộc',
              child: _AdminTextField(
                controller: _name,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Nhập tên package' : null,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _AdminField(
                    label: 'Giá',
                    hint: 'Số thập phân',
                    child: _AdminTextField(
                      controller: _price,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (v) => double.tryParse(v ?? '') == null
                          ? 'Giá không hợp lệ'
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _AdminField(
                    label: 'Currency',
                    hint: 'VD: USD',
                    child: _AdminTextField(
                      controller: _currency,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Nhập currency'
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            _AdminField(
              label: 'Credit',
              hint: 'Số lượng credit · > 0',
              child: _AdminTextField(
                controller: _credits,
                keyboardType: TextInputType.number,
                validator: (v) {
                  final value = int.tryParse(v ?? '');
                  return value == null || value <= 0
                      ? 'Credit phải lớn hơn 0'
                      : null;
                },
              ),
            ),
            _AdminField(
              label: 'Chu kỳ thanh toán',
              child: _AdminDropdown<String>(
                value: _period,
                items: const [
                  DropdownMenuItem(
                    value: 'monthly',
                    child: Text('Theo tháng'),
                  ),
                  DropdownMenuItem(
                    value: 'yearly',
                    child: Text('Theo năm'),
                  ),
                  DropdownMenuItem(
                    value: 'one_time',
                    child: Text('Một lần'),
                  ),
                ],
                onChanged: (v) => setState(() => _period = v!),
              ),
            ),
            _AdminField(
              label: 'Mô tả',
              hint: 'Tùy chọn',
              child: _AdminTextField(
                controller: _description,
              ),
            ),
            _AdminField(
              label: 'Quyền lợi',
              hint: 'Mỗi dòng một mục',
              child: _AdminTextField(
                controller: _benefits,
                maxLength: 500,
              ),
            ),
            _GlassToggleRow(
              label: 'Đang bán',
              value: _active,
              onChanged: (v) => setState(() => _active = v),
            ),
            const SizedBox(height: 10),
            _GlassToggleRow(
              label: 'Đánh dấu phổ biến',
              value: _featured,
              onChanged: (v) => setState(() => _featured = v),
            ),
          ],
        ),
      ),
      actions: [
        _AdminGhostButton(
          label: 'Hủy',
          onPressed: () => Navigator.pop(context),
        ),
        _AdminPrimaryButton(
          label: editing ? 'Cập nhật' : 'Tạo mới',
          icon: editing ? Icons.save_rounded : Icons.add_rounded,
          onPressed: _submit,
        ),
      ],
    );
  }
}

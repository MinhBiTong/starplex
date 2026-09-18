part of '../admin_dashboard_screen.dart';

class _SettingsView extends StatefulWidget {
  const _SettingsView();
  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  late final Dio _dio;
  final _studioName = TextEditingController();
  final _supportEmail = TextEditingController();
  final _imageCost = TextEditingController();
  final _videoCost = TextEditingController();
  bool _paymentFailed = true;
  bool _generationFailed = true;
  bool _newsletter = false;
  bool _maintenance = false;
  bool _registration = true;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _dio = buildDio(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
    );
    _load();
  }

  @override
  void dispose() {
    _dio.close();
    _studioName.dispose();
    _supportEmail.dispose();
    _imageCost.dispose();
    _videoCost.dispose();
    super.dispose();
  }

    String _value(Map<String, dynamic> values, String key, String fallback) =>
      values[key]?['value']?.toString() ?? fallback;
  bool _boolValue(Map<String, dynamic> values, String key, bool fallback) =>
      (_value(values, key, fallback ? 'true' : 'false')).toLowerCase() ==
      'true';

  Future<void> _load() async {
    try {
      final response = await _dio.get(
        '/admin/settings'
      );
      final values = <String, dynamic>{
        for (final item in (response.data as List)) item['key'] as String: item,
      };
      _studioName.text = _value(
        values,
        'studio_name',
        'REEL — AI Film & Photo Studio',
      );
      _supportEmail.text = _value(
        values,
        'support_email',
        'support@reel.studio',
      );
      _imageCost.text = _value(values, 'image_credit_cost', '3');
      _videoCost.text = _value(values, 'video_credit_cost', '12');
      _paymentFailed = _boolValue(values, 'email_payment_failed', true);
      _generationFailed = _boolValue(values, 'notify_generation_failed', true);
      _newsletter = _boolValue(values, 'newsletter_enabled', false);
      _maintenance = _boolValue(values, 'maintenance_mode', false);
      _registration = _boolValue(values, 'registration_enabled', true);
    } on DioException catch (error) {
      if (mounted) _message(_messageFrom(error), true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _messageFrom(DioException error) {
    final data = error.response?.data;
    return data is Map && data['detail'] is String
        ? data['detail'] as String
        : 'Không thể tải settings.';
  }

  void _message(String message, [bool error = false]) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: error ? AdminColors.red : AdminColors.green,
        ),
      );

  Future<void> _save() async {
    setState(() => _saving = true);
    final items = [
      ['studio_name', _studioName.text.trim(), 'string'],
      ['support_email', _supportEmail.text.trim(), 'string'],
      ['image_credit_cost', _imageCost.text.trim(), 'int'],
      ['video_credit_cost', _videoCost.text.trim(), 'int'],
      ['email_payment_failed', '$_paymentFailed', 'bool'],
      ['notify_generation_failed', '$_generationFailed', 'bool'],
      ['newsletter_enabled', '$_newsletter', 'bool'],
      ['maintenance_mode', '$_maintenance', 'bool'],
      ['registration_enabled', '$_registration', 'bool'],
    ];
    try {
      await _dio.put(
        '/admin/settings',
        data: {
          'items': items
              .map(
                (item) => {
                  'key': item[0],
                  'value': item[1],
                  'value_type': item[2],
                },
              )
              .toList(),
        }
      );
      if (mounted) _message('Đã lưu thay đổi.');
    } on DioException catch (error) {
      if (mounted) _message(_messageFrom(error), true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: AdminColors.creamDim),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AdminColors.line),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AdminColors.gold),
    ),
  );

  Widget _field(
    String label,
    TextEditingController controller, {
    bool number = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      keyboardType: number ? TextInputType.number : null,
      style: const TextStyle(color: AdminColors.cream),
      decoration: _decoration(label),
    ),
  );

  Widget _toggle(
    String title,
    String description,
    bool value,
    ValueChanged<bool> onChanged,
  ) => Material(
    color: Colors.transparent,
    child: SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: AdminColors.cream)),
      subtitle: Text(
        description,
        style: const TextStyle(color: AdminColors.muted),
      ),
      value: value,
      activeThumbColor: AdminColors.gold,
      onChanged: onChanged,
    ),
  );

  Widget _group(String title, List<Widget> children) => Padding(
    padding: const EdgeInsets.only(bottom: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.jetBrainsMono(
            fontSize: 10.5,
            letterSpacing: 2,
            color: AdminColors.gold,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: AdminColors.gold),
      );
    }
    return _PanelBlock(
      title: l10n.adminSettingsTitle,
      eyebrow: 'Cấu hình',
      action: _PrimaryButton(
        label: _saving ? 'Đang lưu...' : l10n.adminSettingsSave,
        onTap: _saving ? () {} : _save,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final left = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _group('Thông tin studio', [
                  _field(l10n.adminSettingsStudioName, _studioName),
                  _field(l10n.adminSettingsSupportEmail, _supportEmail),
                ]),
                _group('API & mô hình', [
                  _field(l10n.adminSettingsImageCost, _imageCost, number: true),
                  _field(l10n.adminSettingsVideoCost, _videoCost, number: true),
                ]),
              ],
            );
            final right = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _group('Thông báo hệ thống', [
                  _toggle(
                    l10n.adminSettingsAlertPayment,
                    'Gửi cảnh báo tới admin',
                    _paymentFailed,
                    (v) => setState(() => _paymentFailed = v),
                  ),
                  _toggle(
                    l10n.adminSettingsAlertGeneration,
                    'Theo dõi lỗi từ model',
                    _generationFailed,
                    (v) => setState(() => _generationFailed = v),
                  ),
                  _toggle(
                    l10n.adminSettingsNewsletter,
                    'Tổng hợp gửi mỗi tuần',
                    _newsletter,
                    (v) => setState(() => _newsletter = v),
                  ),
                ]),
                _group('Bảo trì', [
                  _toggle(
                    l10n.adminSettingsMaintenance,
                    'Tạm khóa truy cập người dùng thường',
                    _maintenance,
                    (v) => setState(() => _maintenance = v),
                  ),
                  _toggle(
                    l10n.adminSettingsRegistration,
                    'Tắt để tạm dừng nhận tài khoản mới',
                    _registration,
                    (v) => setState(() => _registration = v),
                  ),
                ]),
              ],
            );
            if (constraints.maxWidth < 720) {
              return Column(children: [left, right]);
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: 32),
                Expanded(child: right),
              ],
            );
          },
        ),
      ),
    );
  }
}

part of '../admin_dashboard_screen.dart';

class _AdminUser {
  final int id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final String role;
  final String status;
  final String createdAt;

  const _AdminUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.role,
    required this.status,
    required this.createdAt,
  });

  factory _AdminUser.fromJson(Map<String, dynamic> json) => _AdminUser(
    id: json['id'] as int,
    email: json['email'] as String,
    fullName: json['full_name'] as String?,
    avatarUrl: json['avatar_url'] as String?,
    role: json['role'] as String,
    status: json['status'] as String,
    createdAt: json['created_at'] as String,
  );
}

/// Body widget shared between the standalone Users tab and the Overview's
/// inline preview panel. Stays presentation-only – never owns its own Dio
/// session.
class _UsersRosterBody extends StatelessWidget {
  final List<_AdminUser> users;
  final bool loading;
  const _UsersRosterBody({required this.users, required this.loading});

  String _statusLabel(String status, AppLocalizations l10n) {
    switch (status) {
      case 'inactive':
        return l10n.adminUserStatusInactive;
      case 'banned':
        return l10n.adminUserStatusBanned;
      default:
        return l10n.adminUserStatusActive;
    }
  }

  String _dateLabel(String value) {
    final date = DateTime.tryParse(value)?.toLocal();
    if (date == null) return value;
    String two(int number) => number.toString().padLeft(2, '0');
    return '${two(date.day)}/${two(date.month)}/${date.year}';
  }

  String _planFor(_AdminUser user) =>
      user.role == 'admin' ? 'Pro' : 'Free';

  int _usageUsed(_AdminUser user) {
    final hash = user.email.codeUnits.fold<int>(0, (acc, c) => acc + c);
    if (user.role == 'admin') return 400 + (hash % 1000);
    return hash % 9;
  }

  int _usageLimit(_AdminUser user) =>
      user.role == 'admin' ? 0 : 8;

  Widget _statusPill(String status, AppLocalizations l10n) {
    if (status == 'active') return _StatusPill.active(_statusLabel(status, l10n));
    if (status == 'banned') return _StatusPill.suspended(l10n.adminUserStatusBanned);
    return _StatusPill.processing(_statusLabel(status, l10n));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: CircularProgressIndicator(color: AdminColors.gold),
        ),
      );
    }
    if (users.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Text(
          'Chưa có người dùng phù hợp.',
          style: TextStyle(color: AdminColors.muted),
        ),
      );
    }
    return _AdminTable(
      headers: const [
        'Người dùng',
        'Gói',
        'Takes đã dùng',
        'Trạng thái',
        'Tham gia',
      ],
      flexes: const [3.0, 1.0, 1.6, 1.6, 1.2],
      rows: users.map((user) {
        final plan = _planFor(user);
        return [
          _UserCellRow(
            name: (user.fullName ?? 'Chưa đặt tên').trim(),
            email: user.email,
          ),
          _PlanChip(label: plan, pro: plan == 'Pro'),
          _UsageBar(
            used: _usageUsed(user),
            limit: _usageLimit(user),
            unlimited: plan == 'Pro',
          ),
          _statusPill(user.status, l10n),
          Text(
            _dateLabel(user.createdAt),
            style: AppFonts.jetBrainsMono(
              fontSize: 11,
              color: AdminColors.muted,
            ),
          ),
        ];
      }).toList(),
    );
  }
}

class _UsersView extends StatefulWidget {
  const _UsersView();

  @override
  State<_UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<_UsersView> {
  final Dio _dio = buildDio(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
  );
  final TextEditingController _searchController = TextEditingController();

  List<_AdminUser> _users = const [];
  int _total = 0;
  int _page = 1;
  int _totalPages = 0;
  bool _loading = true;
  String? _roleFilter;
  String? _statusFilter;

    @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dio.close();
    super.dispose();
  }

  Future<void> _loadUsers({int page = 1}) async {
    setState(() {
      _loading = true;
      _page = page;
    });
    try {
      final response = await _dio.get(
        '/users',
        queryParameters: {
          'page': page,
          'page_size': 8,
          if (_searchController.text.trim().isNotEmpty)
            'search': _searchController.text.trim(),
          if (_roleFilter != null) 'role': _roleFilter,
          if (_statusFilter != null) 'status': _statusFilter,
        },
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      if (!mounted) return;
      setState(() {
        _users = (data['items'] as List)
            .map((item) => _AdminUser.fromJson(Map<String, dynamic>.from(item)))
            .toList();
        _total = data['total'] as int;
        _page = data['page'] as int;
        _totalPages = data['total_pages'] as int;
        _loading = false;
      });
    } on DioException catch (error) {
      if (!mounted) return;
      setState(() => _loading = false);
      _showMessage(_dioMessage(error), error: true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      _showMessage('Không đá»c được danh sách người dùng.', error: true);
    }
  }

  String _dioMessage(DioException error) {
    final data = error.response?.data;
    if (data is Map && data['detail'] is String) {
      return data['detail'] as String;
    }
    return 'Không kết nối được tới máy chủ. Hãy kiểm tra API đang chạy.';
  }

  void _showMessage(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? AdminColors.red : AdminColors.green,
      ),
    );
  }

  Future<void> _openForm([_AdminUser? user]) async {
    final payload = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _UserFormDialog(user: user),
    );
    if (payload == null || !mounted) return;

    try {
      if (user == null) {
        await _dio.post('/users', data: payload);
      } else {
        await _dio.put(
          '/users/${user.id}',
          data: payload
        );
      }
      if (!mounted) return;
      _showMessage(
        user == null ? 'Đã tạo người dùng.' : 'Đã cập nhật người dùng.',
      );
      await _loadUsers(page: user == null ? 1 : _page);
    } on DioException catch (error) {
      if (mounted) _showMessage(_dioMessage(error), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _PanelBlock(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FilterBar(
            children: [
              _FilterInput(
                hint: 'Tìm theo tên hoặc email…',
                controller: _searchController,
                onChanged: (_) => _loadUsers(),
              ),
              _FilterSelect(
                label: 'Tất cả vai trò',
                value: _roleFilter ?? 'all',
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('Tất cả vai trò')),
                  DropdownMenuItem(value: 'user', child: Text('Người dùng')),
                  DropdownMenuItem(value: 'admin', child: Text('Quản trị')),
                ],
                onChanged: (value) {
                  setState(() => _roleFilter = value == 'all' ? null : value);
                  _loadUsers();
                },
              ),
              _FilterSelect(
                label: 'Tất cả trạng thái',
                value: _statusFilter ?? 'all',
                items: const [
                  DropdownMenuItem(
                    value: 'all',
                    child: Text('Tất cả trạng thái'),
                  ),
                  DropdownMenuItem(value: 'active', child: Text('Hoạt động')),
                  DropdownMenuItem(
                    value: 'inactive',
                    child: Text('Không hoạt động'),
                  ),
                  DropdownMenuItem(value: 'banned', child: Text('Bị khoá')),
                ],
                onChanged: (value) {
                  setState(() => _statusFilter = value == 'all' ? null : value);
                  _loadUsers();
                },
              ),
              const Spacer(),
              _PrimaryButton(
                label: '+ Thêm người dùng',
                onTap: () => _openForm(),
              ),
            ],
          ),
          _UsersRosterBody(users: _users, loading: _loading),
          _UsersFoot(
            page: _page,
            totalPages: _totalPages,
            total: _total,
            count: _users.length,
            onPage: (value) => _loadUsers(page: value),
          ),
        ],
      ),
    );
  }
}

class _UsersFoot extends StatelessWidget {
  final int page;
  final int totalPages;
  final int total;
  final int count;
  final ValueChanged<int> onPage;

  const _UsersFoot({
    required this.page,
    required this.totalPages,
    required this.total,
    required this.count,
    required this.onPage,
  });

  @override
  Widget build(BuildContext context) {
    final first = total == 0 ? 0 : ((page - 1) * 8) + 1;
    final last = ((page - 1) * 8) + count;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AdminColors.lineSoft)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final summary = Text(
            'Hiển thị $first–$last trên $total người dùng',
            style: AppFonts.jetBrainsMono(
              fontSize: 11,
              color: AdminColors.muted,
            ),
          );
          final pagination = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PagerBtn(
                label: 'â€¹',
                onTap: page > 1 ? () => onPage(page - 1) : null,
              ),
              _PagerBtn(label: '$page', active: true),
              _PagerBtn(
                label: 'â€º',
                onTap: page < totalPages ? () => onPage(page + 1) : null,
              ),
            ],
          );
          return constraints.maxWidth < 440
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [summary, const SizedBox(height: 10), pagination],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: summary),
                    pagination,
                  ],
                );
        },
      ),
    );
  }
}

class _UserFormDialog extends StatefulWidget {
  final _AdminUser? user;

  const _UserFormDialog({this.user});

  @override
  State<_UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<_UserFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _avatar;
  late String _role;
  late String _status;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    _name = TextEditingController(text: user?.fullName ?? '');
    _email = TextEditingController(text: user?.email ?? '');
    _password = TextEditingController();
    _avatar = TextEditingController(text: user?.avatarUrl ?? '');
    _role = user?.role ?? 'user';
    _status = user?.status ?? 'active';
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _avatar.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final result = <String, dynamic>{
      'email': _email.text.trim(),
      'full_name': _name.text.trim().isEmpty ? null : _name.text.trim(),
      'avatar_url': _avatar.text.trim().isEmpty ? null : _avatar.text.trim(),
      'role': _role,
      'status': _status,
    };
    if (widget.user == null || _password.text.trim().isNotEmpty) {
      result['password'] = _password.text;
    }
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.user != null;
    return _AdminDialog(
      eyebrow: editing ? 'EDIT USER' : 'NEW USER',
      title: editing ? 'Sửa người dùng' : 'Thêm người dùng',
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _AdminField(
              label: 'Họ tên',
              hint: 'Tên hiển thị',
              child: _AdminTextField(
                controller: _name,
                maxLength: 255,
              ),
            ),
            _AdminField(
              label: 'Email',
              hint: 'Bắt buộc · đăng nhập',
              child: _AdminTextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || !value.contains('@')
                    ? 'Email không hợp lệ'
                    : null,
              ),
            ),
            _AdminField(
              label: editing ? 'Mật khẩu mới' : 'Mật khẩu',
              hint: editing
                  ? 'Äể trống nếu giữ nguyên'
                  : 'Bắt buộc · tối thiểu 8 ký tự',
              child: _AdminTextField(
                controller: _password,
                obscure: true,
                validator: (value) {
                  if (editing && (value == null || value.isEmpty)) return null;
                  return value != null && value.length >= 8
                      ? null
                      : 'Mật khẩu tối thiểu 8 ký tự';
                },
              ),
            ),
            _AdminField(
              label: 'Avatar URL',
              hint: 'Tùy chọn',
              child: _AdminTextField(
                controller: _avatar,
              ),
            ),
            _AdminField(
              label: 'Vai trò',
              child: _AdminDropdown<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('Người dùng')),
                  DropdownMenuItem(value: 'admin', child: Text('Quản trị')),
                ],
                onChanged: (value) => setState(() => _role = value!),
              ),
            ),
            _AdminField(
              label: 'Trạng thái',
              child: _AdminDropdown<String>(
                value: _status,
                items: const [
                  DropdownMenuItem(value: 'active', child: Text('Hoạt động')),
                  DropdownMenuItem(
                    value: 'inactive',
                    child: Text('Không hoạt động'),
                  ),
                  DropdownMenuItem(value: 'banned', child: Text('Bị khoá')),
                ],
                onChanged: (value) => setState(() => _status = value!),
              ),
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
          icon: editing ? Icons.save_rounded : Icons.person_add_alt_1_rounded,
          onPressed: _submit,
        ),
      ],
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../core/app_fonts.dart';
import '../core/library_pins.dart';

import '../core/app_colors.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../core/messages.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';
import 'auth_screen.dart';
import 'shared_dialogs.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late final Dio _dio;
  late final TabController _tabs;
  bool _loading = true;
  String? _error;
  List<Map<String, dynamic>> _generations = const [];
  List<Map<String, dynamic>> _credits = const [];
  List<Map<String, dynamic>> _payments = const [];

  @override
  void initState() {
    super.initState();
    _dio = buildDio();
    _tabs = TabController(length: 3, vsync: this);
    LibraryPins.instance.ensureLoaded();
    _load();
  }

  @override
  void dispose() {
    _tabs.dispose();
    _dio.close();
    super.dispose();
  }

  Future<void> _load() async {
    if (AuthSession.accessToken == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final responses = await Future.wait([
        _dio.get('/generate/history'),
        _dio.get('/credits/transactions'),
        _dio.get('/payments/me'),
      ]);
      if (!mounted) return;
      setState(() {
        _generations = _asList(responses[0].data);
        _credits = _asList(responses[1].data);
        _payments = _asList(responses[2].data);
        _loading = false;
      });
    } on DioException catch (error) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      setState(() {
        _loading = false;
        _error = dioErrorMessage(error, l10n.libraryLoadFailed);
      });
    }
  }

  Future<void> _openLogin() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const AuthScreen()));
    if (!mounted) return;
    setState(() {});
    _load();
  }

  List<Map<String, dynamic>> _asList(dynamic value) => (value as List)
      .map((item) => Map<String, dynamic>.from(item as Map))
      .toList();

  String _date(dynamic value) {
    final parsed = DateTime.tryParse(value?.toString() ?? '')?.toLocal();
    if (parsed == null) return value?.toString() ?? '';
    return '${parsed.day.toString().padLeft(2, '0')}/${parsed.month.toString().padLeft(2, '0')}/${parsed.year}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (AuthSession.accessToken == null) {
      return Scaffold(
        backgroundColor: AppColors.ink,
        appBar: AppBar(
          backgroundColor: AppColors.ink,
          title: Text(l10n.libraryTitle),
        ),
        body: _SignInLibrary(onTap: _openLogin),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        title: Text(
          l10n.libraryTitle,
          style: AppFonts.spaceGrotesk(color: AppColors.parchment),
        ),
        actions: [
          IconButton(
            tooltip: l10n.libraryReload,
            onPressed: _loading ? null : _load,
            icon: const Icon(Icons.refresh, color: AppColors.brass),
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          labelColor: AppColors.brassLt,
          unselectedLabelColor: AppColors.parchmentDim,
          indicatorColor: AppColors.brass,
          tabs: [
            Tab(text: l10n.libraryTabGenerations),
            Tab(text: l10n.libraryTabCredits),
            Tab(text: l10n.libraryTabPayments),
          ],
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.brass),
            )
          : _error != null
          ? _ErrorLibrary(message: _error!, onRetry: _load)
          : TabBarView(
              controller: _tabs,
              children: [
                _GalleryTab(items: _generations, date: _date),
                _CreditTab(items: _credits, date: _date),
                _PaymentTab(items: _payments, date: _date),
              ],
            ),
    );
  }
}

class _SignInLibrary extends StatelessWidget {
  final VoidCallback onTap;
  const _SignInLibrary({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: ReelButton(
        label: l10n.librarySignInPrompt,
        onPressed: onTap,
        primary: true,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      ),
    );
  }
}

class _ErrorLibrary extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorLibrary({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: AppFonts.inter(color: AppColors.parchmentDim, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ReelButton(
            label: l10n.libraryRetry,
            onPressed: onRetry,
            primary: false,
            icon: Icons.refresh,
          ),
        ],
      ),
    );
  }
}

/// Gallery workspace: search + type/pin filters + pin flags + multi-select
/// with a bulk bar (download / batch delete). Pins live in [LibraryPins].
enum _GalleryFilter { all, image, video, pinned }

class _GalleryTab extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String Function(dynamic) date;
  const _GalleryTab({required this.items, required this.date});

  @override
  State<_GalleryTab> createState() => _GalleryTabState();
}

class _GalleryTabState extends State<_GalleryTab> {
  final _search = TextEditingController();
  final Set<int> _busyIds = {};
  _GalleryFilter _filter = _GalleryFilter.all;
  int _sort = 0; // 0 mới nhất · 1 cũ nhất · 2 tên A–Z · 3 credits ↓
  String _query = '';
  bool _selectMode = false;
  final Set<int> _selected = {};

  @override
  void initState() {
    super.initState();
    LibraryPins.instance.ensureLoaded();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    final q = _query.trim().toLowerCase();
    final list = [
      for (final item in widget.items)
        if (_matches(item, q)) item,
    ];
    int timeValue(Map<String, dynamic> item) =>
        DateTime.tryParse(item['created_at']?.toString() ?? '')
                ?.millisecondsSinceEpoch ??
            0;
    switch (_sort) {
      case 1:
        list.sort((a, b) => timeValue(a).compareTo(timeValue(b)));
      case 2:
        list.sort(
          (a, b) => (a['prompt']?.toString() ?? '').compareTo(
            b['prompt']?.toString() ?? '',
          ),
        );
      case 3:
        list.sort(
          (a, b) => ((b['credit_cost'] as num?)?.toInt() ?? 0).compareTo(
            (a['credit_cost'] as num?)?.toInt() ?? 0,
          ),
        );
      default:
        list.sort((a, b) => timeValue(b).compareTo(timeValue(a)));
    }
    return list;
  }

  bool _matches(Map<String, dynamic> item, String q) {
    if (q.isNotEmpty &&
        !(item['prompt']?.toString() ?? '').toLowerCase().contains(q)) {
      return false;
    }
    final id = item['id'] as int;
    return switch (_filter) {
      _GalleryFilter.all => true,
      _GalleryFilter.image => item['type']?.toString() == 'image',
      _GalleryFilter.video => item['type']?.toString() == 'video',
      _GalleryFilter.pinned => LibraryPins.instance.isPinned(id),
    };
  }

  void _toggleSelected(int id) {
    setState(() {
      if (!_selected.remove(id)) _selected.add(id);
      if (_selected.isEmpty) _selectMode = false;
    });
  }

  Future<void> _togglePin(int id) async {
    await LibraryPins.instance.toggle(id);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    showMessage(
      context,
      LibraryPins.instance.isPinned(id)
          ? l10n.libraryPinAdded
          : l10n.libraryPinRemoved,
    );
  }

  Future<bool> _confirm(String title, String body) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AdminDialog(
        eyebrow: 'CONFIRM',
        title: title,
        maxWidth: 460,
        content: Text(
          body,
          style: AppFonts.inter(
            color: AppColors.parchment,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          AdminGhostButton(
            label: l10n.libraryDeleteCancel,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          AdminPrimaryButton(
            label: l10n.libraryDeleteConfirm,
            icon: Icons.delete_outline_rounded,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    return confirmed == true;
  }

  Future<void> _deleteGeneration(int generationId) async {
    final l10n = AppLocalizations.of(context);
    if (!await _confirm(
      l10n.libraryDeleteDialogTitle,
      l10n.libraryDeleteDialogBody,
    )) {
      return;
    }
    if (!mounted) return;
    setState(() => _busyIds.add(generationId));

    final dio = buildDio();
    try {
      await dio.delete('/generate/$generationId');
      await LibraryPins.instance.forget([generationId]);
      if (!mounted) return;
      showMessage(context, l10n.libraryDeleteSuccess);
      _reload();
    } on DioException catch (error) {
      if (!mounted) return;
      showMessage(context, dioErrorMessage(error, l10n.libraryDeleteFailed));
    } finally {
      dio.close();
      if (mounted) setState(() => _busyIds.remove(generationId));
    }
  }

  Future<void> _bulkDelete() async {
    final l10n = AppLocalizations.of(context);
    if (!await _confirm(
      l10n.libraryDeleteDialogTitle,
      l10n.libraryDeleteDialogBody,
    )) {
      return;
    }
    final ids = _selected.toList();
    var deleted = 0;
    final dio = buildDio();
    try {
      for (final id in ids) {
        try {
          await dio.delete('/generate/$id');
          deleted++;
        } on DioException {
          // Keep deleting the rest; report the partial success below.
        }
      }
    } finally {
      dio.close();
    }
    await LibraryPins.instance.forget(ids);
    if (!mounted) return;
    showMessage(
      context,
      deleted > 0
          ? l10n.libraryBulkDeleteSuccess(deleted)
          : l10n.libraryDeleteFailed,
    );
    if (deleted > 0) {
      setState(() {
        _selected.clear();
        _selectMode = false;
      });
      _reload();
    }
  }

  void _reload() =>
      context.findAncestorStateOfType<_LibraryScreenState>()?._load();

  void _mockTap(String message) => showMessage(context, message);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filtered = _filtered;
    final showSidebar = MediaQuery.sizeOf(context).width >= 1020;
    final showProjects =
        _filter == _GalleryFilter.all && _query.trim().isEmpty;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---- header actions: tìm kiếm + sắp xếp + tạo mới ----
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                      minWidth: 180,
                    ),
                    child: TextField(
                      controller: _search,
                      onChanged: (value) => setState(() => _query = value),
                      style: AppFonts.inter(
                        color: AppColors.parchment,
                        fontSize: 12.5,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: AppColors.glass,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 15,
                          color: AppColors.smoke,
                        ),
                        hintText: l10n.librarySearchHint,
                        hintStyle: AppFonts.inter(
                          color: AppColors.muted,
                          fontSize: 12.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 9,
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.glass,
                      border: Border.all(color: AppColors.line),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _sort,
                        dropdownColor: AppColors.surface,
                        style: AppFonts.inter(
                          color: AppColors.parchment,
                          fontSize: 12,
                        ),
                        icon: const Icon(
                          Icons.expand_more,
                          size: 16,
                          color: AppColors.smoke,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 0,
                            child: Text(l10n.librarySortNewest),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text(l10n.librarySortOldest),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(l10n.librarySortName),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text(l10n.librarySortCost),
                          ),
                        ],
                        onChanged: (value) => setState(() => _sort = value ?? 0),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ReelButton(
                    label: l10n.libraryCreate,
                    icon: Icons.add,
                    onPressed: () => Navigator.of(context)
                        .popUntil((route) => route.isFirst),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 9,
                    ),
                  ),
                ],
              ),
            ),
            // ---- chips lọc ----
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _FilterChip(
                    label: l10n.profileFilterAll,
                    active: _filter == _GalleryFilter.all,
                    onTap: () => setState(() => _filter = _GalleryFilter.all),
                  ),
                  _FilterChip(
                    label: l10n.libraryFilterImage,
                    active: _filter == _GalleryFilter.image,
                    onTap: () => setState(() => _filter = _GalleryFilter.image),
                  ),
                  _FilterChip(
                    label: l10n.libraryFilterVideo,
                    active: _filter == _GalleryFilter.video,
                    onTap: () => setState(() => _filter = _GalleryFilter.video),
                  ),
                  _FilterChip(
                    label: '📌 ${l10n.libraryFilterPinned}',
                    active: _filter == _GalleryFilter.pinned,
                    onTap: () =>
                        setState(() => _filter = _GalleryFilter.pinned),
                  ),
                  const SizedBox(width: 2),
                  _FilterChip(
                    label: _selectMode ? l10n.commonCancel : l10n.librarySelect,
                    active: _selectMode,
                    onTap: () => setState(() {
                      _selectMode = !_selectMode;
                      if (!_selectMode) _selected.clear();
                    }),
                  ),
                ],
              ),
            ),
            // ---- sidebar + main ----
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showSidebar)
                    SizedBox(
                      width: 216,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 4, 4, 96),
                        child: _SideRail(
                          filter: _filter,
                          total: widget.items.length,
                          pinned: widget.items
                              .where(
                                (i) => LibraryPins.instance.isPinned(
                                  i['id'] as int,
                                ),
                              )
                              .length,
                          onAll: () =>
                              setState(() => _filter = _GalleryFilter.all),
                          onPinned: () =>
                              setState(() => _filter = _GalleryFilter.pinned),
                          onMock: _mockTap,
                        ),
                      ),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (showProjects && widget.items.isNotEmpty) ...[
                            Text(
                              l10n.libraryProjects,
                              style: AppFonts.jetBrainsMono(
                                color: AppColors.smoke,
                                fontSize: 9.5,
                                letterSpacing: 1.4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _ProjectCard(
                              emoji: '📚',
                              title: 'Lóe Sáng Ở Wano',
                              tag: 'MANGA',
                              tagHot: true,
                              progress: .66,
                              subtitle: l10n.libraryProjectMangaSub,
                              updated: l10n.profileTimeHoursAgo(2),
                              continueLabel: l10n.libraryProjectContinueManga,
                              onTap: () => _mockTap(
                                l10n.libraryProjectContinueManga,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _ProjectCard(
                              emoji: '📕',
                              title: 'Đêm Trước Cột Mốc',
                              tag: 'SÁCH',
                              progress: .5,
                              subtitle: l10n.libraryProjectBookSub,
                              updated: l10n.profileTimeYesterday,
                              continueLabel: l10n.libraryProjectContinueBook,
                              onTap: () =>
                                  _mockTap(l10n.libraryProjectContinueBook),
                            ),
                            const SizedBox(height: 22),
                          ],
                          Text(
                            '${l10n.libraryTabGenerations.toUpperCase()} · ${filtered.length}',
                            style: AppFonts.jetBrainsMono(
                              color: AppColors.smoke,
                              fontSize: 9.5,
                              letterSpacing: 1.4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (widget.items.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 60),
                              child: Text(
                                l10n.libraryEmptyGenerations,
                                textAlign: TextAlign.center,
                                style: AppFonts.inter(
                                  color: AppColors.parchmentDim,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          else if (filtered.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 60),
                              child: Text(
                                l10n.libraryNoMatch,
                                textAlign: TextAlign.center,
                                style: AppFonts.inter(
                                  color: AppColors.parchmentDim,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          else
                            ListenableBuilder(
                              listenable: LibraryPins.instance,
                              builder: (context, _) => GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 360,
                                      mainAxisExtent: 360,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                    ),
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final item = filtered[index];
                                  final generationId = item['id'] as int;
                                  return _GalleryCard(
                                    item: item,
                                    date: widget.date(item['created_at']),
                                    isPinned: LibraryPins.instance.isPinned(
                                      generationId,
                                    ),
                                    isBusy: _busyIds.contains(generationId),
                                    selectMode: _selectMode,
                                    isSelected: _selected.contains(
                                      generationId,
                                    ),
                                    onPin: () => _togglePin(generationId),
                                    onDelete: () =>
                                        _deleteGeneration(generationId),
                                    onToggleSelect: () =>
                                        _toggleSelected(generationId),
                                    onLongPress: () => setState(() {
                                      _selectMode = true;
                                      _selected.add(generationId);
                                    }),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _BulkBar(
          visible: _selectMode && _selected.isNotEmpty,
          count: _selected.length,
          onDownload: () =>
              showMessage(context, l10n.libraryBulkDownloadSoon),
          onDelete: _bulkDelete,
          onCancel: () => setState(() {
            _selectMode = false;
            _selected.clear();
          }),
        ),
      ],
    );
  }
}

/// Sidebar trái theo mockup: tất cả / đã ghim / bộ sưu tập / thùng rác.
class _SideRail extends StatelessWidget {
  final _GalleryFilter filter;
  final int total, pinned;
  final VoidCallback onAll, onPinned;
  final ValueChanged<String> onMock;
  const _SideRail({
    required this.filter,
    required this.total,
    required this.pinned,
    required this.onAll,
    required this.onPinned,
    required this.onMock,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sideItem(
          '🗂️',
          l10n.libraryTabGenerations,
          total,
          active: filter == _GalleryFilter.all,
          onTap: onAll,
        ),
        _sideItem(
          '📌',
          l10n.libraryFilterPinned,
          pinned,
          active: filter == _GalleryFilter.pinned,
          onTap: onPinned,
        ),
        _sideSep(l10n.libraryCollections),
        _sideItem(
          '🎬',
          'Trailer Wano',
          4,
          onTap: () => onMock(l10n.libraryCollectionsMock),
        ),
        _sideItem(
          '🗡️',
          'Concept Wano',
          6,
          onTap: () => onMock(l10n.libraryCollectionsMock),
        ),
        _sideItem(
          '＋',
          l10n.libraryNewCollection,
          null,
          onTap: () => onMock(l10n.libraryCollectionsMock),
        ),
        _sideSep(l10n.libraryOther),
        _sideItem(
          '🗑️',
          l10n.libraryTrash,
          2,
          onTap: () => onMock(l10n.libraryTrashMock),
        ),
      ],
    );
  }

  Widget _sideSep(String label) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 6, left: 10),
    child: Text(
      label.toUpperCase(),
      style: AppFonts.jetBrainsMono(
        color: AppColors.muted,
        fontSize: 9,
        letterSpacing: 1.6,
      ),
    ),
  );

  Widget _sideItem(
    String icon,
    String label,
    int? count, {
    bool active = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: active
              ? AppColors.azure.withValues(alpha: .14)
              : Colors.transparent,
          border: Border.all(
            color: active
                ? AppColors.azure.withValues(alpha: .4)
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.inter(
                  color: active ? Colors.white : AppColors.smoke,
                  fontSize: 13,
                ),
              ),
            ),
            if (count != null)
              Text(
                '$count',
                style: AppFonts.jetBrainsMono(
                  color: AppColors.muted,
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Thẻ "Dự án đang làm" theo mockup: thumb + tag + progress + link tiếp tục.
class _ProjectCard extends StatelessWidget {
  final String emoji, title, tag, subtitle, updated, continueLabel;
  final bool tagHot;
  final double progress;
  final VoidCallback onTap;
  const _ProjectCard({
    required this.emoji,
    required this.title,
    required this.tag,
    required this.subtitle,
    required this.updated,
    required this.continueLabel,
    required this.progress,
    required this.onTap,
    this.tagHot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1D2E),
                  border: Border.all(color: AppColors.line),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppFonts.spaceGrotesk(
                    color: AppColors.parchment,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tagHot
                      ? AppColors.coral.withValues(alpha: .1)
                      : AppColors.azure.withValues(alpha: .1),
                  border: Border.all(
                    color: tagHot
                        ? AppColors.coral.withValues(alpha: .4)
                        : AppColors.azure.withValues(alpha: .4),
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tag,
                  style: AppFonts.jetBrainsMono(
                    color: tagHot ? AppColors.coral : AppColors.azureSoft,
                    fontSize: 8,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppFonts.inter(color: AppColors.smoke, fontSize: 12),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0x14FFFFFF),
              valueColor: AlwaysStoppedAnimation(
                tagHot ? AppColors.coral : AppColors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                updated,
                style: AppFonts.inter(color: AppColors.muted, fontSize: 11),
              ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    '$continueLabel →',
                    style: AppFonts.inter(
                      color: AppColors.azureSoft,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? AppColors.azure.withValues(alpha: .18)
              : AppColors.glass,
          border: Border.all(
            color: active
                ? AppColors.azure.withValues(alpha: .55)
                : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: AppFonts.inter(
            color: active ? Colors.white : AppColors.parchmentDim,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final String date;
  final bool isPinned, isBusy, selectMode, isSelected;
  final VoidCallback onPin, onDelete, onToggleSelect, onLongPress;
  const _GalleryCard({
    required this.item,
    required this.date,
    required this.isPinned,
    required this.isBusy,
    required this.selectMode,
    required this.isSelected,
    required this.onPin,
    required this.onDelete,
    required this.onToggleSelect,
    required this.onLongPress,
  });

  String _status(String value, AppLocalizations l10n) {
    switch (value) {
      case 'completed':
        return l10n.libraryStatusCompleted;
      case 'failed':
        return l10n.libraryStatusFailed;
      case 'processing':
        return l10n.libraryStatusProcessing;
      default:
        return l10n.libraryStatusPending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final imageUrl = item['file_url']?.toString();
    final status = item['status']?.toString() ?? '';
    final type = item['type']?.toString() ?? '';
    final cost = (item['credit_cost'] as num?)?.toInt() ?? 0;
    final typeLabel = type == 'video'
        ? l10n.libraryFilterVideo
        : l10n.libraryFilterImage;

    return InkWell(
      onTap: selectMode ? onToggleSelect : null,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(14),
      child: ReelGlass(
        radius: 14,
        blur: false,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  imageUrl == null || imageUrl.isEmpty
                      ? Center(
                          child: Text(
                            _status(status, l10n),
                            style: AppFonts.inter(
                              color: AppColors.parchmentDim,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: AppColors.parchmentDim,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                  if (isBusy)
                    Container(
                      color: AppColors.ink.withValues(alpha: 0.7),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.brass,
                        ),
                      ),
                    ),
                  if (isSelected)
                    Container(
                      color: AppColors.azure.withValues(alpha: .18),
                    ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _CardOverlayButton(
                      tooltip: isPinned
                          ? l10n.libraryPinRemoved
                          : l10n.libraryPinAdded,
                      icon: isPinned
                          ? Icons.push_pin
                          : Icons.push_pin_outlined,
                      color: isPinned ? AppColors.coral : AppColors.smoke,
                      onTap: selectMode ? null : onPin,
                    ),
                  ),
                  if (selectMode)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _SelectionDot(selected: isSelected),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['prompt']?.toString() ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.inter(
                      color: AppColors.parchment,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$typeLabel • ${_status(status, l10n)} • $date • $cost CR',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.inter(
                            color: AppColors.parchmentDim,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      if (status != 'processing' && !isBusy && !selectMode)
                        IconButton(
                          tooltip: l10n.commonDelete,
                          icon: const Icon(Icons.delete_outline, size: 18),
                          color: AppColors.coral,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: onDelete,
                        ),
                    ],
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

class _CardOverlayButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _CardOverlayButton({
    required this.tooltip,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ink.withValues(alpha: .62),
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 30,
          height: 30,
          child: Icon(icon, size: 15, color: color),
        ),
      ),
    );
  }
}

class _SelectionDot extends StatelessWidget {
  final bool selected;
  const _SelectionDot({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.azure : AppColors.ink.withValues(alpha: .5),
        border: Border.all(
          color: selected ? AppColors.azure : Colors.white70,
          width: 1.5,
        ),
      ),
      child: selected
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }
}

/// Floating bulk-action bar shown while a multi-select is active.
class _BulkBar extends StatelessWidget {
  final bool visible;
  final int count;
  final VoidCallback onDownload, onDelete, onCancel;
  const _BulkBar({
    required this.visible,
    required this.count,
    required this.onDownload,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 16,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        offset: visible ? Offset.zero : const Offset(0, 1.6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 10, 10, 10),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: .95),
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.librarySelectedCount(count),
                  style: AppFonts.inter(
                    color: AppColors.parchment,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 14),
                _BulkButton(
                  label: l10n.libraryBulkDownload,
                  icon: Icons.download_outlined,
                  onTap: onDownload,
                ),
                const SizedBox(width: 6),
                _BulkButton(
                  label: l10n.commonDelete,
                  icon: Icons.delete_outline,
                  danger: true,
                  onTap: onDelete,
                ),
                const SizedBox(width: 6),
                _BulkButton(label: l10n.commonCancel, onTap: onCancel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BulkButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool danger;
  final VoidCallback onTap;
  const _BulkButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.glass,
          border: Border.all(
            color: danger
                ? Colors.redAccent.withValues(alpha: .45)
                : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 14,
                color: danger ? Colors.redAccent : AppColors.parchment,
              ),
            if (icon != null) const SizedBox(width: 6),
            Text(
              label,
              style: AppFonts.inter(
                color: danger ? Colors.redAccent : AppColors.parchment,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreditTab extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String Function(dynamic) date;
  const _CreditTab({required this.items, required this.date});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (items.isEmpty) {
      return Center(child: Text(l10n.libraryEmptyCredits));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(color: AppColors.lineSoft),
      itemBuilder: (_, index) {
        final item = items[index];
        final amount = (item['amount'] as num?)?.toInt() ?? 0;
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            item['description']?.toString() ?? item['type'].toString(),
          ),
          subtitle: Text(date(item['created_at'])),
          trailing: Text(
            '${amount >= 0 ? '+' : ''}$amount',
            style: TextStyle(
              color: amount >= 0 ? Colors.green : AppColors.brassLt,
            ),
          ),
        );
      },
    );
  }
}

class _PaymentTab extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String Function(dynamic) date;
  const _PaymentTab({required this.items, required this.date});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (items.isEmpty) return Center(child: Text(l10n.libraryEmptyPayments));
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(color: AppColors.lineSoft),
      itemBuilder: (_, index) {
        final item = items[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(item['package_name']?.toString() ?? 'Payment'),
          subtitle: Text(
            '${item['transaction_code'] ?? ''} • ${date(item['created_at'])}',
          ),
          trailing: Text(
            '${item['amount']} ${item['currency']}\n${item['status']}',
          ),
        );
      },
    );
  }
}

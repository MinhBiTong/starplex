import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../core/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_colors.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../core/messages.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';
import 'auth_screen.dart';
import 'pricing/pricing_data.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});
  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  List<PlanCardData> _packages = const [];
  bool _loading = true;
  bool _yearly = false;
  int? _creditBalance;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await fetchActivePackages(context);
    if (!mounted) return;
    setState(() {
      _packages = result.packages;
      _loading = false;
    });
    if (AuthSession.isSignedIn) {
      final dio = buildDio();
      try {
        final response = await dio.get('/generate/usage');
        if (!mounted) return;
        setState(
          () => _creditBalance =
              (response.data as Map)['credit_balance'] as int?,
        );
      } on DioException {
        // Strip stays hidden without a balance — non-critical.
      } finally {
        dio.close();
      }
    }
  }

  String _error(DioException error) {
    final l10n = AppLocalizations.of(context);
    return dioErrorMessage(error, l10n.pricingLoadFailed);
  }

  void _message(String value, [bool error = false]) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value),
          backgroundColor: error ? Colors.redAccent : Colors.green,
        ),
      );

  Future<void> _buy(PlanCardData package) async {
    final l10n = AppLocalizations.of(context);
    if (!AuthSession.isSignedIn) {
      _message(l10n.pricingSignInFirst, true);
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const AuthScreen()));
      if (!mounted || !AuthSession.isSignedIn) return;
    }
    final dio = buildDio();
    try {
      final response = await dio.post(
        '/payments/stripe/checkout-session',
        data: {'package_id': package.id},
      );
      final checkoutUrl = (response.data as Map)['checkout_url']?.toString();
      if (checkoutUrl == null || checkoutUrl.isEmpty) {
        throw DioException(
          requestOptions: response.requestOptions,
          message: 'Stripe Checkout URL was not returned.',
        );
      }
      final opened = await launchUrl(
        Uri.parse(checkoutUrl),
        mode: LaunchMode.externalApplication,
      );
      if (!opened) {
        _message(l10n.pricingStripeOpenFailed, true);
      } else if (mounted) {
        _message(l10n.pricingStripeOpened);
      }
    } on DioException catch (error) {
      if (mounted) _message(_error(error), true);
    } finally {
      dio.close();
    }
  }

  /// Giá hiển thị khi bật "Theo năm": giảm 20% × 12 tháng (display-only —
  /// Stripe checkout vẫn tính theo chu kỳ thật của gói).
  String _yearlyPrice(PlanCardData p) {
    final digits = p.priceText.replaceAll(RegExp(r'[^0-9.]'), '');
    final monthly = double.tryParse(digits) ?? 0;
    if (monthly == 0) return p.priceText;
    final yearly = monthly * 12 * .8;
    final symbol = p.priceText.startsWith(r'$') ? r'$' : '';
    final text = yearly % 1 == 0
        ? yearly.toStringAsFixed(0)
        : yearly.toStringAsFixed(2);
    return '$symbol$text';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vi = Localizations.localeOf(context).languageCode == 'vi';
    String t(String vi_, String en) => vi ? vi_ : en;
    final narrow = MediaQuery.sizeOf(context).width < 640;

    return Scaffold(
      backgroundColor: AppColors.ink,
      body: Stack(
        children: [
          const Positioned.fill(child: ReelBackdrop()),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(narrow ? 20 : 40, 12, narrow ? 20 : 40, 48),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Topbar(onBack: () => Navigator.of(context).pop(), title: l10n.pricingTitle),
                      const SizedBox(height: 20),
                      // ---------- HERO ----------
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 640),
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: t('Bắt đầu ', 'Start '),
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: ReelGradientText(
                                        t('miễn phí', 'free'),
                                        style: AppFonts.spaceGrotesk(
                                          color: AppColors.mist,
                                          fontSize: narrow ? 24 : 30,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -.4,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: t('. Mở rộng theo cách bạn tạo.', '. Scale the way you create.'),
                                    ),
                                  ],
                                  style: AppFonts.spaceGrotesk(
                                    color: AppColors.mist,
                                    fontSize: narrow ? 24 : 30,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -.4,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 9),
                              Text(
                                t(
                                  'Mọi gói đều dùng chung 20 công cụ AI — khác nhau ở số credits, mức ưu tiên và giới hạn dự án.',
                                  'Every plan shares the same 20 AI tools — they differ in credits, priority and project limits.',
                                ),
                                textAlign: TextAlign.center,
                                style: AppFonts.inter(
                                  color: AppColors.smoke,
                                  fontSize: 14,
                                  height: 1.55,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_creditBalance != null) ...[
                        const SizedBox(height: 22),
                        // ---------- STRIP ----------
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                          decoration: BoxDecoration(
                            color: AppColors.azure.withValues(alpha: .08),
                            border: Border.all(color: AppColors.azure.withValues(alpha: .35)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: t('Bạn còn ', 'You have '),
                                  style: AppFonts.inter(color: AppColors.mist, fontSize: 13),
                                  children: [
                                    TextSpan(
                                      text: '$_creditBalance credits',
                                      style: AppFonts.inter(
                                        color: AppColors.azureSoft,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: t(' (nạp lẻ, không hết hạn)', ' (top-up credits never expire)'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 22),
                      // ---------- TOGGLE ----------
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.glass,
                            border: Border.all(color: AppColors.line),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _CycleButton(
                                label: t('Theo tháng', 'Monthly'),
                                active: !_yearly,
                                onTap: () => setState(() => _yearly = false),
                              ),
                              _CycleButton(
                                label: t('Theo năm', 'Yearly'),
                                badge: '−20%',
                                active: _yearly,
                                onTap: () => setState(() => _yearly = true),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // ---------- PLANS ----------
                      if (_loading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(child: CircularProgressIndicator(color: AppColors.brass)),
                        )
                      else if (_packages.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Text(
                            l10n.pricingEmpty,
                            textAlign: TextAlign.center,
                            style: AppFonts.inter(color: AppColors.parchmentDim, fontSize: 14),
                          ),
                        )
                      else
                        _PlansGrid(
                          children: [
                            for (final tier in _packages)
                              PlanCard(
                                data: tier,
                                isFeatured: tier.isFeatured,
                                displayPrice: _yearly ? _yearlyPrice(tier) : null,
                                displayPeriod: _yearly ? t('/ năm', '/ year') : null,
                                primaryCtaLabel: tier.isFree
                                    ? l10n.pricingFreeCta
                                    : l10n.pricingBuyButton,
                                onCta: () => _buy(tier),
                              ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      // ---------- CHI PHÍ THEO CÔNG CỤ ----------
                      _SectionLabel(label: t('🧮 Một tác phẩm tốn bao nhiêu credit?', '🧮 Credit cost per creation')),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final (icon, label, cost) in _kToolCosts)
                            _CostChip(icon: icon, label: t(label.$1, label.$2), cost: cost),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text.rich(
                        TextSpan(
                          text: t(
                            'Số credit khoá tại thời điểm bấm tạo và hiển thị ước tính trước khi chạy. ',
                            'Credits are locked when you hit generate and shown as an estimate first. ',
                          ),
                          style: AppFonts.inter(color: AppColors.muted, fontSize: 12, height: 1.5),
                          children: [
                            TextSpan(
                              text: t(
                                'Tác phẩm lỗi do hệ thống được hoàn credit tự động.',
                                'Failed generations are automatically refunded.',
                              ),
                              style: AppFonts.inter(
                                color: const Color(0xFF7EE0A8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // ---------- SO SÁNH ----------
                      _SectionLabel(label: t('📊 So sánh chi tiết', '📊 Detailed comparison')),
                      const SizedBox(height: 12),
                      _CompareTable(t: t),
                      const SizedBox(height: 30),
                      // ---------- FAQ ----------
                      _SectionLabel(label: t('❓ Câu hỏi thường gặp', '❓ FAQ')),
                      const SizedBox(height: 12),
                      for (final (q, a) in _kFaq)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _FaqTile(question: t(q.$1, q.$2), answer: t(a.$1, a.$2)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _kToolCosts = <(String, (String, String), String)>[
  ('🖼️', ('Ảnh', 'Image'), '≈ 4 CR'),
  ('🧑‍🎨', ('Nhân vật', 'Character'), '≈ 6 CR'),
  ('📖', ('Manga', 'Manga'), '≈ 6 CR/trang'),
  ('🎞️', ('Video', 'Video'), '≈ 30 CR'),
  ('🎵', ('Nhạc', 'Music'), '≈ 10 CR'),
  ('🎤', ('Bài hát', 'Song'), '≈ 20 CR'),
  ('🔊', ('SFX', 'SFX'), '≈ 1 CR'),
  ('🗣️', ('Avatar', 'Avatar'), '≈ 25 CR'),
  ('🧊', ('3D', '3D'), '≈ 15 CR'),
  ('🗺️', ('Bản đồ', 'Map'), '≈ 4 CR'),
  ('📚', ('Sách', 'Book'), '≈ 5 CR/chương'),
  ('💻', ('Code', 'Code'), '≈ 2 CR'),
];

const _kFaq = <((String, String), (String, String))>[
  (
    ('Credit chưa dùng có bị mất không?', 'Do unused credits expire?'),
    (
      'Credit của gói được cộng dồn tối đa 1 tháng nếu chưa dùng hết. Credit nạp lẻ không bao giờ hết hạn và được ưu tiên dùng trước.',
      'Plan credits roll over for up to 1 month. Top-up credits never expire and are consumed first.',
    ),
  ),
  (
    ('Tác phẩm tạo lỗi có bị mất credit không?', 'Do failed generations cost credits?'),
    (
      'Không. Mọi generation lỗi vì hệ thống (timeout, model lỗi, queue fail) được hoàn credit tự động về số dư trong vài giây.',
      'No. Every system-side failure (timeout, model error, queue fail) is refunded automatically within seconds.',
    ),
  ),
  (
    ('Thanh toán bằng hình thức nào?', 'Which payment methods are supported?'),
    (
      'VNPay QR, Momo, ZaloPay và thẻ quốc tế (Visa/Mastercard qua Stripe). Hoá đơn VAT xuất cho gói theo yêu cầu.',
      'VNPay QR, Momo, ZaloPay and international cards (Visa/Mastercard via Stripe). VAT invoices on request.',
    ),
  ),
  (
    ('Huỷ gói hoặc đổi gói thế nào?', 'How do I cancel or switch plans?'),
    (
      'Huỷ bất cứ lúc nào; bạn vẫn dùng hết tháng đã trả. Nâng cấp giữa chu kỳ được trừ phần ngày còn lại của gói cũ.',
      'Cancel anytime and keep the paid month. Mid-cycle upgrades are prorated against the old plan.',
    ),
  ),
  (
    ('Manga Studio có tính phí riêng không?', 'Is Manga Studio billed separately?'),
    (
      'Không — Manga Studio nằm trong gói, chỉ tốn credit theo từng trang khi bạn bấm tạo (≈ 6 CR/trang).',
      'No — Manga Studio is included; you only pay credits per page when you generate (≈ 6 CR/page).',
    ),
  ),
];

class _CycleButton extends StatelessWidget {
  final String label;
  final String? badge;
  final bool active;
  final VoidCallback onTap;
  const _CycleButton({
    required this.label,
    required this.active,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(colors: [AppColors.azure, AppColors.indigo])
              : null,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppFonts.inter(
                color: active ? Colors.white : AppColors.smoke,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Text(
                badge!,
                style: AppFonts.jetBrainsMono(
                  color: const Color(0xFF7EE0A8),
                  fontSize: 9,
                  letterSpacing: 1,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppFonts.jetBrainsMono(
        color: AppColors.smoke,
        fontSize: 9.5,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _CostChip extends StatelessWidget {
  final String icon, label, cost;
  const _CostChip({required this.icon, required this.label, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 7, 14, 7),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Text(label, style: AppFonts.inter(color: AppColors.mist, fontSize: 12.5)),
          const SizedBox(width: 6),
          Text(
            cost,
            style: AppFonts.jetBrainsMono(
              color: AppColors.azureSoft,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareTable extends StatelessWidget {
  final String Function(String, String) t;
  const _CompareTable({required this.t});

  @override
  Widget build(BuildContext context) {
    final rows = <(String, String, String, String)>[
      (t('Credits hàng tháng', 'Monthly credits'), '50', '2.000', t('6.000 dùng chung', '6,000 shared')),
      (t('Ảnh, Nhân vật, Bản đồ', 'Image, Character, Map'), '✓', '✓', '✓'),
      (t('Text → Video', 'Text → Video'), '✕', '✓', '✓'),
      (t('Âm thanh: giọng nói, nhạc, SFX', 'Audio: voice, music, SFX'), '✓', '✓', '✓'),
      (t('Manga / Sách — dự án dài', 'Manga / Books — long-form'), t('1 dự án', '1 project'), t('Không giới hạn', 'Unlimited'), t('Không giới hạn', 'Unlimited')),
      (t('Character Sheet khoá nhân vật', 'Locked character sheets'), '✕', '✓', '✓'),
      (t('Không watermark', 'No watermark'), '✕', '✓', '✓'),
      (t('Xuất 4K / PDF / CBZ / EPUB', '4K / PDF / CBZ / EPUB export'), '✕', '✓', '✓'),
      (t('Hàng đợi', 'Queue'), t('Thường', 'Standard'), t('Ưu tiên', 'Priority'), '⚡ ${t('Cao nhất', 'Highest')}'),
      (t('Nạp credit lẻ', 'Credit top-ups'), '✓', t('✓ giá ưu đãi', '✓ discounted'), t('✓ giá ưu đãi', '✓ discounted')),
      (t('Thành viên', 'Members'), '1', '1', '5'),
      (t('API + webhook', 'API + webhook'), '✕', '✕', '✓'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(18),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FixedColumnWidth(240),
            1: FixedColumnWidth(90),
            2: FixedColumnWidth(110),
            3: FixedColumnWidth(140),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.line)),
              ),
              children: [
                _cell(t('Tính năng', 'Feature'), header: true, left: true),
                _cell('Free', header: true),
                _cell('Pro', header: true, hot: true),
                _cell('Studio', header: true),
              ],
            ),
            for (final (label, free, pro, studio) in rows)
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
                ),
                children: [
                  _cell(label, left: true, dim: true),
                  _cell(free),
                  _cell(pro, hot: true),
                  _cell(studio),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _cell(String text, {bool header = false, bool left = false, bool hot = false, bool dim = false}) {
    final isMark = text == '✓' || text == '✕';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Text(
        text,
        textAlign: left ? TextAlign.left : TextAlign.center,
        style: header
            ? AppFonts.spaceGrotesk(
                color: hot ? AppColors.azureSoft : AppColors.mist,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              )
            : AppFonts.inter(
                color: isMark
                    ? (text == '✓' ? const Color(0xFF7EE0A8) : AppColors.muted)
                    : dim
                    ? AppColors.smoke
                    : hot
                    ? AppColors.azureSoft
                    : AppColors.parchment,
                fontSize: 13,
                fontWeight: isMark || hot ? FontWeight.w700 : FontWeight.w400,
              ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question, answer;
  const _FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 18),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
          iconColor: AppColors.smoke,
          collapsedIconColor: AppColors.smoke,
          title: Text(
            question,
            style: AppFonts.inter(
              color: AppColors.parchment,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                answer,
                style: AppFonts.inter(
                  color: AppColors.smoke,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================== TOPBAR & GRID ==============================

class _Topbar extends StatelessWidget {
  final VoidCallback onBack;
  final String title;
  const _Topbar({required this.onBack, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _IconAction(icon: Icons.arrow_back, onTap: onBack),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: AppFonts.spaceGrotesk(
                color: AppColors.parchment,
                fontSize: 18,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.glass,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.line),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, size: 17, color: AppColors.parchmentDim),
        ),
      ),
    );
  }
}

class _PlansGrid extends StatelessWidget {
  final List<Widget> children;
  const _PlansGrid({required this.children});

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width < 640 ? 1 : (width < 980 ? 2 : 3);
        const gap = 16.0;
        final cardWidth = columns == 1
            ? width
            : (width - (columns - 1) * gap) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: children
              .map((child) => SizedBox(width: cardWidth, child: child))
              .toList(),
        );
      },
    );
  }
}

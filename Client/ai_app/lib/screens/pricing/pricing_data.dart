import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/api_client.dart';
import '../../core/app_fonts.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../widgets/flagship_ui.dart';

/// Lightweight DTO carrying every value the UI needs to render a plan card.
///
/// Kept dumb (no widget logic) so it can be reused by the pricing screen and
/// any preview tile on the homepage / landing page without duplicating the
/// formatting code.
class PlanCardData {
  final int id;
  final String name;
  final String priceText;
  final String periodSuffix;
  final String creditsLabel;
  final List<String> benefits;
  final bool isFeatured;
  final bool isFree;
  final String rawBillingPeriod;

  const PlanCardData({
    required this.id,
    required this.name,
    required this.priceText,
    required this.periodSuffix,
    required this.creditsLabel,
    required this.benefits,
    required this.isFeatured,
    required this.isFree,
    required this.rawBillingPeriod,
  });

  static double _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  static String _priceText(Map<String, dynamic> package) {
    final currency = (package['currency']?.toString() ?? '').toUpperCase();
    final price = _asDouble(package['price']);
    final symbol = switch (currency) {
      'USD' => r'$',
      'VND' => '',
      _ => currency.isEmpty ? '' : '$currency ',
    };
    if (price == 0) return '0';
    final number =
        price % 1 == 0 ? price.toStringAsFixed(0) : price.toStringAsFixed(2);
    return '$symbol$number';
  }

  static String _period(String? value, AppLocalizations l10n) {
    switch (value) {
      case 'monthly':
        return l10n.pricingPeriodMonthly;
      case 'yearly':
        return l10n.pricingPeriodYearly;
      default:
        return '';
    }
  }

  factory PlanCardData.fromPackage(
    Map<String, dynamic> package, {
    required AppLocalizations l10n,
  }) {
    final price = _asDouble(package['price']);
    final credits = package['credit_amount'];
    final creditsLabel = price == 0
        ? '${credits ?? 0} ${l10n.pricingCreditsSuffix}'.trim()
        : '${credits ?? 0} ${l10n.pricingCreditsPerMonth}';
    final benefits = ((package['benefits'] as List?) ?? const [])
        .map((e) => e?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toList();

    return PlanCardData(
      id: package['id'] is int
          ? package['id'] as int
          : int.tryParse('${package['id']}') ?? 0,
      name: package['name']?.toString() ?? '',
      priceText: _priceText(package),
      periodSuffix: _period(package['billing_period']?.toString(), l10n),
      creditsLabel: creditsLabel,
      benefits: benefits,
      isFeatured: package['is_featured'] == true,
      isFree: price == 0,
      rawBillingPeriod: package['billing_period']?.toString() ?? '',
    );
  }
}

/// Result of fetching active packages.
///
/// Distinguishes between "API answered with an empty list" (a real
/// no-active-packages signal) and "call failed" (network / server error) so
/// the UI can keep retrying the latter without flashing the empty-state card.
class FetchPackagesResult {
  final List<PlanCardData> packages;
  final bool failed;

  const FetchPackagesResult.success(this.packages) : failed = false;

  const FetchPackagesResult.failure(this.packages) : failed = true;

  bool get isEmpty => packages.isEmpty;
}

/// Fetches the active payment packages from the API.
///
/// Returns a [FetchPackagesResult] describing both the list and whether the
/// request succeeded. On failure the list is empty so callers can simply do
/// `result.packages` without null-checks.
Future<FetchPackagesResult> fetchActivePackages(BuildContext context) async {
  // Localized strings are baked into the card DTO, so we resolve l10n up
  // front. If `context` is somehow not under a `Localizations` widget,
  // fall back to English so a missing translation never crashes the
  // listing screen.
  final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations) ??
      lookupAppLocalizations(const Locale('en'));
  // Use generous timeouts: a cold-starting FastAPI can easily need 5+
  // seconds to answer its first request while it imports modules and
  // warms the connection pool. A tight timeout here is what caused the
  // historical "skeleton forever → click Retry" symptom.
  final dio = buildDio(
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 20),
  );
  try {
    final response = await dio.get('/payment-packages/active');
    final raw = response.data;
    // The endpoint should always answer with a JSON array. If FastAPI
    // ever returns an object (e.g. an error envelope that wasn't caught
    // upstream), we treat it as a failure instead of crashing the parser.
    if (raw is! List) {
      debugPrint(
        '[fetchActivePackages] Unexpected payload type: ${raw.runtimeType}',
      );
      return const FetchPackagesResult.failure([]);
    }
    final list = raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .map((json) {
          try {
            return PlanCardData.fromPackage(json, l10n: l10n);
          } catch (error) {
            // Skip any malformed entry rather than blowing up the whole
            // list — a single bad row shouldn't hide every other package.
            debugPrint('[fetchActivePackages] Skipping bad package: $error');
            return null;
          }
        })
        .whereType<PlanCardData>()
        .toList();
    debugPrint('[fetchActivePackages] Loaded ${list.length} package(s)');
    return FetchPackagesResult.success(list);
  } on DioException catch (error) {
    debugPrint(
      '[fetchActivePackages] DioException: '
      '${error.type} ${error.response?.statusCode} ${error.message}',
    );
    return const FetchPackagesResult.failure([]);
  } catch (error, stack) {
    // Last-resort safety net: anything thrown by the parser, the l10n
    // lookup, or the dio interceptor must NOT leave the call site in a
    // half-broken state.
    debugPrint('[fetchActivePackages] Unexpected error: $error\n$stack');
    return const FetchPackagesResult.failure([]);
  } finally {
    dio.close();
  }
}

/// ============================================================================
/// PUBLIC PLAN CARD
/// ----------------------------------------------------------------------------
/// The single source of truth for how a payment package is rendered. Both the
/// pricing screen and the homepage pricing section use this widget. Never
/// duplicate or hand-roll another plan card UI.
/// ============================================================================
class PlanCard extends StatelessWidget {
  final PlanCardData data;
  final bool isFeatured;
  final String primaryCtaLabel;
  final VoidCallback onCta;
  /// Override hiển thị khi bật "Theo năm" — checkout vẫn dùng chu kỳ thật.
  final String? displayPrice;
  final String? displayPeriod;

  const PlanCard({
    super.key,
    required this.data,
    required this.isFeatured,
    required this.primaryCtaLabel,
    required this.onCta,
    this.displayPrice,
    this.displayPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      featured: isFeatured,
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  data.name.isEmpty ? '—' : data.name,
                  style: AppFonts.spaceGrotesk(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.parchment,
                    letterSpacing: -.2,
                  ),
                ),
              ),
              if (isFeatured)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.brass.withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.brass.withValues(alpha: .35),
                    ),
                  ),
                  child: Text(
                    'PRO',
                    style: AppFonts.jetBrainsMono(
                      fontSize: 9.5,
                      letterSpacing: 1.4,
                      color: AppColors.brass,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  displayPrice ?? data.priceText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.spaceGrotesk(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.parchment,
                    letterSpacing: -.5,
                  ),
                ),
              ),
              if ((displayPeriod ?? data.periodSuffix).isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(
                  displayPeriod ?? data.periodSuffix,
                  style: AppFonts.spaceGrotesk(
                    fontSize: 14,
                    color: AppColors.parchmentDim,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            data.creditsLabel,
            style: AppFonts.jetBrainsMono(
              fontSize: 10.5,
              letterSpacing: 1.2,
              color: AppColors.brass,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          if (data.benefits.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final benefit in data.benefits)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.glassStrong,
                              border:
                                  Border.all(color: AppColors.brass, width: 1),
                            ),
                            child: Center(
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.brass,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            benefit,
                            style: AppFonts.inter(
                              color: AppColors.parchment,
                              fontSize: 13,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ReelButton(
              label: primaryCtaLabel,
              onPressed: onCta,
              primary: isFeatured,
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass card surface used by both the pricing screen and the homepage.
/// Kept internal so callers can only compose via `PlanCard`.
class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool featured;
  const _GlassCard({
    required this.child,
    required this.padding,
    required this.featured,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.glassStrong, AppColors.glass],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: featured
              ? AppColors.brass.withValues(alpha: .45)
              : AppColors.line,
        ),
        boxShadow: featured
            ? [
                BoxShadow(
                  color: AppColors.brass.withValues(alpha: .12),
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ]
            : null,
      ),
      padding: padding,
      child: child,
    );
  }
}

/// Skeleton placeholder shown while packages are loading or auto-retrying.
class PlanCardSkeleton extends StatelessWidget {
  final bool featured;
  const PlanCardSkeleton({super.key, this.featured = false});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      featured: featured,
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bar(width: 90, height: 14),
          const SizedBox(height: 18),
          _bar(width: 130, height: 30),
          const SizedBox(height: 12),
          _bar(width: 160, height: 10),
          const SizedBox(height: 22),
          for (var i = 0; i < 3; i++) ...[
            _bar(width: double.infinity, height: 12),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 14),
          _bar(width: double.infinity, height: 38),
        ],
      ),
    );
  }

  Widget _bar({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.glassStrong,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

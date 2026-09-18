import 'package:flutter/material.dart';
import '../core/app_fonts.dart';
import 'package:dio/dio.dart';

import '../core/app_colors.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';
import 'home_screen.dart';

enum PaymentResultType { success, cancel, error }

class PaymentResultScreen extends StatefulWidget {
  final PaymentResultType resultType;
  final String? sessionId;
  final String? errorMessage;

  const PaymentResultScreen({
    super.key,
    required this.resultType,
    this.sessionId,
    this.errorMessage,
  });

  @override
  State<PaymentResultScreen> createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _isLoadingPayment = false;
  Map<String, dynamic>? _paymentDetails;
  String? _errorDetail;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    if (widget.resultType == PaymentResultType.success &&
        widget.sessionId != null) {
      _loadPaymentDetails();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _animationController.value = 1;
    } else if (_animationController.status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  Future<void> _loadPaymentDetails() async {
    if (AuthSession.accessToken == null) return;

    setState(() => _isLoadingPayment = true);

    final dio = buildDio();

    try {
      // Load user's recent payments to find the one matching this session
      final response = await dio.get(
        '/payments/me',
        queryParameters: {'limit': 10},
      );

      if (mounted) {
        final payments = (response.data as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

        // Find the most recent completed payment
        final recentPayment = payments.firstWhere(
          (p) =>
              p['status'] == 'completed' &&
              p['payment_method'] == 'stripe' &&
              (p['provider_transaction_id']?.toString().contains(
                    widget.sessionId!,
                  ) ??
                  false),
          orElse: () =>
              payments.isNotEmpty && payments[0]['status'] == 'completed'
              ? payments[0]
              : {},
        );

        setState(() {
          _paymentDetails = recentPayment.isNotEmpty ? recentPayment : null;
          _isLoadingPayment = false;
        });
      }
    } on DioException {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        setState(() {
          _errorDetail = l10n.paymentResultLoadFailed;
          _isLoadingPayment = false;
        });
      }
    } finally {
      dio.close();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: Stack(
        children: [
          const Positioned.fill(child: ReelBackdrop()),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final l10n = AppLocalizations.of(context);
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(color: _getBorderColor(), width: 1),
          borderRadius: BorderRadius.circular(26),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.glassStrong, AppColors.glass],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(height: 24),
            _buildTitle(l10n),
            const SizedBox(height: 16),
            _buildMessage(l10n),
            if (widget.resultType == PaymentResultType.success) ...[
              const SizedBox(height: 24),
              _isLoadingPayment
                  ? const CircularProgressIndicator(color: AppColors.brass)
                  : _buildPaymentDetails(l10n),
            ],
            const SizedBox(height: 32),
            _buildActions(l10n),
          ],
        ),
      ),
    );
  }

  Color _getBorderColor() {
    switch (widget.resultType) {
      case PaymentResultType.success:
        return AppColors.brassLt;
      case PaymentResultType.cancel:
        return AppColors.muted;
      case PaymentResultType.error:
        return AppColors.oxblood;
    }
  }

  Widget _buildIcon() {
    IconData icon;
    Color color;

    switch (widget.resultType) {
      case PaymentResultType.success:
        icon = Icons.check_circle_outline;
        color = AppColors.brassLt;
        break;
      case PaymentResultType.cancel:
        icon = Icons.cancel_outlined;
        color = AppColors.muted;
        break;
      case PaymentResultType.error:
        icon = Icons.error_outline;
        color = AppColors.oxblood;
        break;
    }

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, size: 48, color: color),
    );
  }

  Widget _buildTitle(AppLocalizations l10n) {
    String title;

    switch (widget.resultType) {
      case PaymentResultType.success:
        title = l10n.paymentResultSuccess;
        break;
      case PaymentResultType.cancel:
        title = l10n.paymentResultCancel;
        break;
      case PaymentResultType.error:
        title = l10n.paymentResultError;
        break;
    }

    return Text(
      title,
      style: AppFonts.inter(
        color: AppColors.parchment,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage(AppLocalizations l10n) {
    String message;

    switch (widget.resultType) {
      case PaymentResultType.success:
        message = l10n.paymentResultSuccessMsg;
        break;
      case PaymentResultType.cancel:
        message = l10n.paymentResultCancelMsg;
        break;
      case PaymentResultType.error:
        message = widget.errorMessage ?? l10n.paymentResultErrorMsg;
        break;
    }

    return Text(
      message,
      style: AppFonts.inter(
        color: AppColors.parchmentDim,
        fontSize: 14,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPaymentDetails(AppLocalizations l10n) {
    if (_errorDetail != null) {
      return Text(
        _errorDetail!,
        style: AppFonts.inter(color: AppColors.oxblood, fontSize: 12),
        textAlign: TextAlign.center,
      );
    }

    if (_paymentDetails == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lineSoft),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.ink.withValues(alpha: 0.5),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            l10n.paymentDetailPackage,
            _paymentDetails!['package_name']?.toString() ?? 'N/A',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            l10n.paymentDetailCredits,
            '${_paymentDetails!['credit_amount'] ?? 0} credits',
            highlight: true,
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            l10n.paymentDetailAmount,
            '${_paymentDetails!['currency'] ?? 'USD'} ${_paymentDetails!['amount'] ?? 0}',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            l10n.paymentDetailTransaction,
            _paymentDetails!['transaction_code']?.toString() ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.inter(
            color: AppColors.parchmentDim,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppFonts.inter(
              color: highlight ? AppColors.brassLt : AppColors.parchment,
              fontSize: highlight ? 16 : 13,
              fontWeight: highlight ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(AppLocalizations l10n) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ReelButton(
            label: l10n.paymentBackHome,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const ReelHomePage()),
                (route) => false,
              );
            },
          ),
        ),
        if (widget.resultType == PaymentResultType.cancel ||
            widget.resultType == PaymentResultType.error) ...[
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Go back to pricing
            },
            child: Text(
              l10n.paymentTryAgain,
              style: AppFonts.inter(
                color: AppColors.brass,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

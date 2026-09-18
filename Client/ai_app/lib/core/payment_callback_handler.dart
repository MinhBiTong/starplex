import 'package:flutter/material.dart';

import '../screens/payment_result_screen.dart';

class PaymentCallbackHandler {
  static void handleCallback(BuildContext context, Uri uri) {
    final queryParams = uri.queryParameters;

    // Check for stripe callback parameters
    final stripeStatus = queryParams['stripe'];
    final sessionId = queryParams['session_id'];

    if (stripeStatus == null) return;

    PaymentResultType resultType;

    switch (stripeStatus.toLowerCase()) {
      case 'success':
        resultType = PaymentResultType.success;
        break;
      case 'cancel':
      case 'cancelled':
        resultType = PaymentResultType.cancel;
        break;
      case 'error':
      case 'failed':
        resultType = PaymentResultType.error;
        break;
      default:
        return; // Unknown status, ignore
    }

    // Navigate to payment result screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) =>
            PaymentResultScreen(resultType: resultType, sessionId: sessionId),
      ),
      (route) => false, // Clear navigation stack
    );
  }

  static bool isPaymentCallback(Uri uri) {
    return uri.queryParameters.containsKey('stripe');
  }
}

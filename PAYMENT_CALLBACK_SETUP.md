# Payment Callback Setup Guide

## Overview
Hệ thống đã được implement để handle Stripe Payment Success/Cancel callbacks từ Stripe Checkout về Flutter app.

## Backend Configuration

### Environment Variables (.env)
```bash
# Frontend URL for redirects
FRONTEND_URL=http://localhost:8080

# Optional: Override default redirect URLs
STRIPE_SUCCESS_URL=http://localhost:8080/?stripe=success&session_id={CHECKOUT_SESSION_ID}
STRIPE_CANCEL_URL=http://localhost:8080/?stripe=cancel
```

### Default Redirect URLs
Nếu không set STRIPE_SUCCESS_URL và STRIPE_CANCEL_URL, backend tự động generate:
- **Success**: `{FRONTEND_URL}/?stripe=success&session_id={CHECKOUT_SESSION_ID}`
- **Cancel**: `{FRONTEND_URL}/?stripe=cancel`

## Frontend Implementation

### 1. PaymentResultScreen (`lib/screens/payment_result_screen.dart`)
Screen hiển thị kết quả thanh toán với 3 states:
- **Success**: Hiển thị icon success, load payment details từ API
- **Cancel**: Hiển thị thông báo user đã cancel
- **Error**: Hiển thị error message

**Features:**
- Animated entry với scale transition
- Load payment details từ `/payments/me` endpoint
- Hiển thị: package name, credits, amount, transaction code
- Actions: "BACK TO HOME", "TRY AGAIN" (cho cancel/error)

### 2. PaymentCallbackHandler (`lib/core/payment_callback_handler.dart`)
Utility class để parse URL query parameters và navigate:

```dart
// Check if URL is payment callback
bool isCallback = PaymentCallbackHandler.isPaymentCallback(uri);

// Handle callback
PaymentCallbackHandler.handleCallback(context, uri);
```

**Supported Query Parameters:**
- `?stripe=success&session_id=xxx` → PaymentResultScreen(success)
- `?stripe=cancel` → PaymentResultScreen(cancel)
- `?stripe=error` → PaymentResultScreen(error)

### 3. Main App Deep Link Handling (`lib/main.dart`)
```dart
ReelApp extends StatefulWidget với navigatorKey
onGenerateRoute: Intercept deep links và handle payment callbacks
```

## Flow Diagram

```
User → PricingScreen 
  → Click "MUA PACKAGE"
  → Backend creates Stripe Checkout Session
  → launchUrl() opens Stripe in external browser
  
User completes payment in Stripe
  → Stripe redirects to: {FRONTEND_URL}/?stripe=success&session_id=xxx
  → Flutter app receives deep link
  → onGenerateRoute intercepts URL
  → PaymentCallbackHandler parses params
  → Navigate to PaymentResultScreen(success)
  → Load payment details from API
  → Display success with transaction info
```

## Testing Locally

### 1. Backend
```bash
cd AI_Server
# Ensure .env has:
FRONTEND_URL=http://localhost:8080

python -m uvicorn main:app --reload
```

### 2. Frontend (Flutter Web)
```bash
cd Client/ai_app
flutter run -d chrome --web-port 8080
```

### 3. Test Stripe Checkout
1. Go to Pricing page
2. Click "MUA PACKAGE"
3. Stripe Checkout opens in new tab
4. Use test card: `4242 4242 4242 4242`
5. Complete payment
6. Should redirect to: `http://localhost:8080/?stripe=success&session_id=cs_test_xxx`
7. PaymentResultScreen shows success

### 4. Test Cancel
- In Stripe Checkout, click back button
- Should redirect to: `http://localhost:8080/?stripe=cancel`
- PaymentResultScreen shows cancel

## Mobile Deep Linking (Future)

Để support mobile apps (iOS/Android), cần thêm:

### iOS (ios/Runner/Info.plist)
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>reel</string>
    </array>
  </dict>
</array>
```

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<intent-filter>
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data
    android:scheme="reel"
    android:host="payment" />
</intent-filter>
```

### Updated Backend URLs for Mobile
```bash
STRIPE_SUCCESS_URL=reel://payment?stripe=success&session_id={CHECKOUT_SESSION_ID}
STRIPE_CANCEL_URL=reel://payment?stripe=cancel
```

## Webhook Integration

**Note**: Stripe webhook vẫn là primary method để complete payments và grant credits. Callback UI chỉ để inform user về kết quả.

**Webhook Flow:**
1. User completes payment in Stripe
2. Stripe sends webhook event → `/api/v1/payments/stripe/webhook`
3. Backend marks payment as completed + grants credits
4. User redirected back to app
5. PaymentResultScreen loads completed payment from database

**Callback chỉ là UI/UX enhancement**, actual payment processing happens via webhook.

## Troubleshooting

### Issue: Callback không được trigger
**Check:**
- FRONTEND_URL trong .env đúng port
- Flutter app đang chạy trên port khớp với FRONTEND_URL
- Browser cho phép redirect từ Stripe

### Issue: PaymentResultScreen không load payment details
**Check:**
- User đã đăng nhập (AuthSession.accessToken != null)
- Webhook đã được Stripe gọi thành công (check backend logs)
- Payment status = 'completed' trong database

### Issue: Deep link không work trên mobile
**Check:**
- URL scheme đã config trong Info.plist / AndroidManifest.xml
- Backend STRIPE_SUCCESS_URL sử dụng custom scheme (reel://)
- App đã được rebuild sau khi thêm config

## Security Notes

1. **Never trust client-side payment confirmation** - Always validate via webhook
2. **session_id trong URL chỉ để reference** - Không dùng để authorize credit grant
3. **Webhook signature verification** - Backend phải verify Stripe signature
4. **Idempotency** - Payment completion logic phải idempotent (check status before grant credits)

## Files Created/Modified

### Backend
- `AI_Server/controller/v1/endpoints/payments.py` - Đã có sẵn `_checkout_return_url()` function

### Frontend
- ✅ `Client/ai_app/lib/screens/payment_result_screen.dart` - NEW
- ✅ `Client/ai_app/lib/core/payment_callback_handler.dart` - NEW  
- ✅ `Client/ai_app/lib/main.dart` - MODIFIED (added deep link handling)

## Future Enhancements

1. **Push Notifications**: Notify user khi webhook completes payment (nếu callback bị miss)
2. **Payment History Link**: Từ PaymentResultScreen → navigate to LibraryScreen payments tab
3. **Receipt Generation**: Generate PDF receipt cho completed payments
4. **Retry Failed Payments**: UI để retry failed payment với cùng package
5. **Subscription Management**: Handle recurring billing success/failure callbacks

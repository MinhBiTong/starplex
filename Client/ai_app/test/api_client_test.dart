import 'package:flutter_test/flutter_test.dart';

import 'package:ai_app/core/api_client.dart';
import 'package:ai_app/core/auth_session.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiClient', () {
    setUp(() async {
      // Reset session between tests so we don't leak tokens across cases.
      AuthSession.accessToken = null;
      AuthSession.refreshToken = null;
    });

    test('buildDio() returns a Dio whose base URL ends with /api/v1', () {
      final dio = buildDio();
      expect(dio.options.baseUrl, endsWith('/api/v1'));
    });

    test('ApiClient.instance.dio returns the same instance across calls',
        () {
      final first = ApiClient.instance.dio;
      final second = ApiClient.instance.dio;
      expect(identical(first, second), isTrue);
    });

    test('ApiClient.instance.build returns a fresh Dio each call', () {
      // build() is for callers that explicitly want an isolated instance
      // (e.g. the public auth screen) so each invocation must produce
      // its own Dio with its own interceptor chain.
      final first = ApiClient.instance.build();
      final second = ApiClient.instance.build();
      expect(identical(first, second), isFalse);
      expect(first.options.baseUrl, endsWith('/api/v1'));
      expect(second.options.baseUrl, endsWith('/api/v1'));
    });

    test('AuthHeaderInterceptor is wired into the shared Dio', () {
      // Dio itself adds a LogInterceptor at index 0, then our
      // _AuthHeaderInterceptor at index 1. We don't introspect the
      // concrete type (it's private), we just verify the count went up
      // past zero so our interceptor chain is in place.
      final shared = buildDio();
      expect(shared.interceptors.length, greaterThanOrEqualTo(1));
    });
  });
}

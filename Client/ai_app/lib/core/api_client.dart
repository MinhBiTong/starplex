import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'auth_session.dart';

/// Single source of truth for the backend base URL.
///
/// On the web (and any non-Android target) we point at the local FastAPI
/// instance on `127.0.0.1`. On Android we use the emulator-loopback alias
/// `10.0.2.2` so the dev server is reachable without manual config.
String apiBaseUrl() {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return 'http://127.0.0.1:8000/api/v1';
  }
  return 'http://10.0.2.2:8000/api/v1';
}

/// Lazily-initialised, application-wide Dio instance.
///
/// Sharing one instance instead of constructing a new `Dio` per screen
/// has two wins:
///   * every request goes through the same auth interceptor, so the
///     refresh-on-401 behaviour is consistent everywhere;
///   * HTTP keep-alive can actually keep the TCP connection warm
///     between calls instead of tearing it down on every screen push.
class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  Dio? _dio;

  /// Returns the shared Dio, building it on the first call.
  Dio get dio => _dio ??= _buildDio();

  /// Builds a fresh `Dio` with the auth + refresh interceptors wired in.
  ///
  /// Exposed for tests and for screens that explicitly want an isolated
  /// instance (e.g. the public /auth/login form, where we must not send
  /// a stale bearer header while the user is still anonymous).
  Dio build({
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) =>
      _buildDio(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      );

  Dio _buildDio({
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl(),
        connectTimeout: connectTimeout ?? const Duration(seconds: 10),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(_AuthHeaderInterceptor(dio));
    return dio;
  }

  /// Backwards-compatible free function. New code should use
  /// `ApiClient.instance.dio` so the refresh interceptor is shared.
  Dio buildDio({
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) =>
      build(connectTimeout: connectTimeout, receiveTimeout: receiveTimeout);
}

/// Top-level convenience wrapper kept for callers that historically
/// imported `buildDio` as a free function (most screens under
/// `lib/screens/**`). New code should prefer
/// `ApiClient.instance.dio` so every request shares the same Dio and
/// benefits from the refresh-on-401 interceptor.
Dio buildDio({
  Duration? connectTimeout,
  Duration? receiveTimeout,
}) =>
    ApiClient.instance.build(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

/// Adds the bearer token to every outgoing request and transparently
/// refreshes the access token on 401.
///
/// The refresh path is cooperative across concurrent requests and across
/// every Dio instance built by this file: when a 401 lands, we mark a
/// refresh as in-flight, queue every other request that arrives in the
/// meantime, then resolve them all with the new token once
/// `/auth/refresh` returns. Without the queue, three parallel requests
/// would each trigger their own refresh and the last one would win,
/// leaving the others with a token that has just been rotated out.
class _AuthHeaderInterceptor extends Interceptor {
  _AuthHeaderInterceptor(this._dio);

  final Dio _dio;

  // Refresh coordination is shared across every Dio instance. Screens
  // call buildDio() per screen, each getting its own interceptor — with
  // per-instance state, two screens hitting 401 concurrently would each
  // run a refresh, and the second one would present a refresh token the
  // first just rotated out, logging the user out.
  static bool _refreshing = false;
  static final List<_PendingRequest> _pending = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = AuthSession.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final shouldAttemptRefresh = response != null &&
        response.statusCode == 401 &&
        err.requestOptions.extra['__retried__'] != true &&
        AuthSession.refreshToken != null;

    if (!shouldAttemptRefresh) {
      handler.next(err);
      return;
    }

    // Queue this request until the in-flight refresh finishes.
    final completer = _PendingRequest(err.requestOptions);
    _pending.add(completer);

    if (_refreshing) {
      // Another request is already refreshing; once it completes, our
      // queued request will be retried in the success branch below.
      return;
    }

    _refreshing = true;
    try {
      await _refreshAccessToken();
      // Drain the queue: every queued request now retries with the
      // fresh token attached.
      final drained = List.of(_pending);
      _pending.clear();
      for (final pending in drained) {
        try {
          pending.options.extra['__retried__'] = true;
          pending.options.headers['Authorization'] =
              'Bearer ${AuthSession.accessToken}';
          final retried = await _dio.fetch(pending.options);
          pending.completer.complete(retried);
        } catch (e) {
          // Re-throw as-is: catch (e) binds to a non-nullable `Object`.
          pending.completer.completeError(e);
        }
      }
    } catch (refreshError) {
      // Refresh itself failed — surface the original 401 to the caller
      // and fail every queued request so the UI can prompt re-login.
      final drained = List.of(_pending);
      _pending.clear();
      for (final pending in drained) {
        pending.completer.completeError(refreshError);
      }
      if (refreshError is DioException) {
        handler.next(refreshError);
      } else {
        handler.next(err);
      }
    } finally {
      _refreshing = false;
    }
  }

  Future<void> _refreshAccessToken() async {
    // Use a bare Dio (no auth interceptor) so we don't recurse on the
    // refresh endpoint itself if it happens to return 401.
    final raw = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl(),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    final response = await raw.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refresh_token': AuthSession.refreshToken},
    );
    final data = response.data;
    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        message: 'Empty refresh response',
      );
    }
    final newAccess = data['access_token'] as String?;
    final newRefresh = data['refresh_token'] as String?;
    if (newAccess == null || newRefresh == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        message: 'Refresh response missing tokens',
      );
    }
    AuthSession.accessToken = newAccess;
    AuthSession.refreshToken = newRefresh;
    // The refresh response carries the user row; keep the cached
    // role/email/name in sync before the rotated pair hits storage.
    final user = data['user'];
    if (user is Map<String, dynamic>) {
      AuthSession.role = user['role'] as String?;
      AuthSession.email = user['email'] as String?;
      AuthSession.fullName = user['full_name'] as String?;
    }
    // The backend revoked the old refresh token when issuing this pair,
    // so the persisted copy must be updated now or the next app start
    // would restore a dead token and force a re-login.
    await AuthSession.persistRotatedTokens();
  }
}

class _PendingRequest {
  _PendingRequest(this.options);
  final RequestOptions options;
  final Completer<Response<dynamic>> completer = Completer<Response<dynamic>>();
}

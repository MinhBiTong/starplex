import 'package:shared_preferences/shared_preferences.dart';

class AuthSession {
  AuthSession._();

  static const _accessTokenKey = 'auth.access_token';
  static const _refreshTokenKey = 'auth.refresh_token';
  static const _roleKey = 'auth.role';
  static const _emailKey = 'auth.email';
  static const _nameKey = 'auth.full_name';
  static const _avatarKey = 'auth.avatar_url';

  static String? accessToken;
  static String? refreshToken;
  static String? role;
  static String? email;
  static String? fullName;
  static String? avatarUrl;

  static Future<void> save({
    required String access,
    required String refresh,
    required Map<String, dynamic> user,
    required bool remember,
  }) async {
    accessToken = access;
    refreshToken = refresh;
    role = user['role'] as String?;
    email = user['email'] as String?;
    fullName = user['full_name'] as String?;
    avatarUrl = user['avatar_url'] as String?;

    final prefs = await SharedPreferences.getInstance();
    if (remember) {
      await prefs.setString(_accessTokenKey, access);
      await prefs.setString(_refreshTokenKey, refresh);
      await prefs.setString(_roleKey, role ?? '');
      await prefs.setString(_emailKey, email ?? '');
      await prefs.setString(_nameKey, fullName ?? '');
      await prefs.setString(_avatarKey, avatarUrl ?? '');
    } else {
      await clearPersistent();
    }
  }

  static Future<bool> restore() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(_accessTokenKey);
    refreshToken = prefs.getString(_refreshTokenKey);
    role = prefs.getString(_roleKey);
    email = prefs.getString(_emailKey);
    fullName = prefs.getString(_nameKey);
    avatarUrl = prefs.getString(_avatarKey);
    return accessToken != null && refreshToken != null;
  }

  static Future<void> clearPersistent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_roleKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_avatarKey);
  }

  /// Persists the current in-memory token pair after a refresh rotation.
  ///
  /// The backend revokes the old refresh token the moment it issues a new
  /// one, so whatever is on disk goes stale on every rotation. Only writes
  /// when a refresh token was already persisted (i.e. the user chose
  /// "remember me"); memory-only sessions stay memory-only.
  static Future<void> persistRotatedTokens() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_refreshTokenKey) == null) return;
    await prefs.setString(_accessTokenKey, accessToken ?? '');
    await prefs.setString(_refreshTokenKey, refreshToken ?? '');
    await prefs.setString(_roleKey, role ?? '');
    await prefs.setString(_emailKey, email ?? '');
    await prefs.setString(_nameKey, fullName ?? '');
    await prefs.setString(_avatarKey, avatarUrl ?? '');
  }

  /// Caches a freshly uploaded avatar URL. Only persists when a
  /// persistent session exists (same rule as [persistRotatedTokens]).
  static Future<void> updateAvatar(String url) async {
    avatarUrl = url;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_refreshTokenKey) == null) return;
    await prefs.setString(_avatarKey, url);
  }

  static Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
    role = null;
    email = null;
    fullName = null;
    avatarUrl = null;
    await clearPersistent();
  }

  /// Whether the user currently holds a valid access token in memory.
  ///
  /// We deliberately don't validate the token here — a quick UI gate
  /// just needs to know whether a token is present. Real validation
  /// (and refresh on 401) happens inside the dio interceptor.
  static bool get isSignedIn => accessToken != null && accessToken!.isNotEmpty;
}

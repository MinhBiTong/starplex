/// Lightweight, dependency-free validators that mirror the server-side
/// Pydantic rules. We run them client-side so the user gets immediate
/// feedback without paying a network round-trip; the server still
/// validates the same rules as the source of truth.
library;

/// Pragmatic email check. Mirrors Pydantic's `EmailStr` closely enough
/// for UX purposes — it covers 99% of real addresses without the
/// overhead of a third-party package.
///
/// Accepted: `local@domain.tld`, plus `+`, `.`, `_`, `-` in the local
/// part, and any number of sub-domains. Both `TLD` and final segment
/// must be at least 2 characters.
final RegExp _emailRegex = RegExp(
  r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
);

/// Returns true when [value] looks like a syntactically valid email.
bool isValidEmail(String? value) {
  if (value == null) return false;
  final trimmed = value.trim();
  if (trimmed.isEmpty || trimmed.length > 254) return false;
  return _emailRegex.hasMatch(trimmed);
}

/// Returns true when [value] is a well-formed absolute http(s) URL.
/// Empty strings and null are accepted as "no URL" — callers decide
/// whether empty means valid or required.
bool isValidAvatarUrl(String? value) {
  if (value == null) return true;
  final trimmed = value.trim();
  if (trimmed.isEmpty) return true;
  final uri = Uri.tryParse(trimmed);
  if (uri == null || !uri.isAbsolute) return false;
  return uri.scheme == 'http' || uri.scheme == 'https';
}

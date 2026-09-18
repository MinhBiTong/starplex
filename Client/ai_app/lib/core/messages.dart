import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

/// Shows a localized snackbar message.
void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Converts a [DioException] into a user-friendly message. If the response
/// carries a known shape (`detail`, `error.message`, or `message`) we surface
/// it verbatim — otherwise we fall back to [fallback].
String dioErrorMessage(
  DioException error,
  String fallback, {
  String? generic,
}) {
  final data = error.response?.data;
  if (data is Map) {
    if (data['detail'] is String) return data['detail'] as String;
    final err = data['error'];
    if (err is Map && err['message'] is String) {
      return err['message'] as String;
    }
    if (data['message'] is String) return data['message'] as String;
  }
  if (error.response == null) {
    return generic ?? fallback;
  }
  return fallback;
}

/// Convenience wrapper that pulls the localized fallback from
/// `AppLocalizations.of(context)`. Use when the caller already has a
/// `BuildContext` available.
String dioErrorFromContext(BuildContext context, DioException error, String fallback) {
  final l10n = AppLocalizations.of(context);
  return dioErrorMessage(error, fallback, generic: l10n.errorGeneric);
}

import 'package:flutter/material.dart';
import '../core/app_fonts.dart';
import 'package:dio/dio.dart';

import '../core/app_colors.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../core/messages.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Field-level submission state. Success / error feedback from the
  // most recent submit attempt is rendered inline directly beneath
  // the field that owns it (or the form footer when no field is
  // implicated).
  String? _currentPasswordError;
  String? _formSuccessNotice;

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;
    if (AuthSession.accessToken == null) return;

    setState(() {
      _isLoading = true;
      _currentPasswordError = null;
      _formSuccessNotice = null;
    });

    try {
      // Reuse the application-wide Dio so the refresh-on-401 interceptor
      // also covers this screen — if the access token has just expired,
      // we transparently rotate it instead of forcing the user to log
      // back in just to change their password.
      await ApiClient.instance.dio.post(
        '/auth/change-password',
        data: {
          'current_password': _currentPasswordController.text,
          'new_password': _newPasswordController.text,
        },
      );

      if (mounted) {
        final l10n = AppLocalizations.of(context);
        // Inline confirmation at the foot of the form so the user can
        // confirm the change before the auth-cleared redirect kicks in.
        setState(() {
          _formSuccessNotice = l10n.successPasswordChanged;
        });
        // Brief delay so the user can register the inline notice before
        // we yank them out to the login screen. Without this the
        // redirect races the visual update.
        await Future.delayed(const Duration(milliseconds: 900));
        if (!mounted) return;
        // Clear auth and navigate to login
        await AuthSession.clear();
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    } on DioException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        // Wrong current password is by far the dominant failure
        // mode — flag it on that field so the user knows where to
        // act. Server-side validation problems with the new
        // password fall back to the form footer.
        final detail = dioErrorMessage(e, l10n.changePasswordFailed);
        setState(() {
          _currentPasswordError = detail;
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: Stack(
        children: [
          const Positioned.fill(child: ReelBackdrop()),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(l10n),
                Expanded(child: _buildForm(l10n)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.parchment),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              l10n.changePasswordTitle,
              style: AppFonts.spaceGrotesk(
                color: AppColors.parchment,
                fontSize: 18,
                letterSpacing: .5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ReelGlass(
            radius: 26,
            blur: true,
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.changePasswordSubhead,
                    style: AppFonts.inter(
                      color: AppColors.parchmentDim,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    label: l10n.changePasswordCurrent,
                    obscure: _obscureCurrentPassword,
                    externalError: _currentPasswordError,
                    onChanged: () {
                      if (_currentPasswordError != null) {
                        setState(() => _currentPasswordError = null);
                      }
                    },
                    onToggleVisibility: () {
                      setState(
                        () =>
                            _obscureCurrentPassword = !_obscureCurrentPassword,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.changePasswordCurrentRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    label: l10n.changePasswordNew,
                    obscure: _obscureNewPassword,
                    onToggleVisibility: () {
                      setState(
                        () => _obscureNewPassword = !_obscureNewPassword,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.changePasswordNewRequired;
                      }
                      if (value.length < 8) {
                        return l10n.changePasswordTooShort;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: l10n.changePasswordConfirm,
                    obscure: _obscureConfirmPassword,
                    onToggleVisibility: () {
                      setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.changePasswordConfirmRequired;
                      }
                      if (value != _newPasswordController.text) {
                        return l10n.changePasswordMismatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  if (_formSuccessNotice != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _InlineFormNotice(
                        message: _formSuccessNotice!,
                        tone: _NoticeTone.success,
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: ReelButton(
                      label: l10n.changePasswordSubmit,
                      onPressed: _isLoading ? null : _changePassword,
                      loading: _isLoading,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
    String? externalError,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.inter(
            color: AppColors.brass,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          onChanged: (_) => onChanged?.call(),
          style: AppFonts.inter(color: AppColors.parchment, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.glass,
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.parchmentDim,
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: externalError != null
                    ? AppColors.coral
                    : AppColors.line,
                width: externalError != null ? 1.5 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.brass, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.coral),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.coral, width: 2),
            ),
          ),
        ),
        if (externalError != null && externalError.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 14,
                  color: AppColors.coral,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    externalError,
                    style: AppFonts.inter(
                      color: AppColors.coral,
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Shared helpers for inline form-level notices in this screen.
enum _NoticeTone { success, info, error }

class _InlineFormNotice extends StatelessWidget {
  final String message;
  final _NoticeTone tone;
  const _InlineFormNotice({
    required this.message,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = switch (tone) {
      _NoticeTone.success => (AppColors.brass, Icons.check_circle_outline),
      _NoticeTone.info => (AppColors.azure, Icons.info_outline),
      _NoticeTone.error => (AppColors.coral, Icons.error_outline),
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.$1.withValues(alpha: .08),
        border: Border.all(color: scheme.$1.withValues(alpha: .4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(scheme.$2, size: 16, color: scheme.$1),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppFonts.inter(
                color: AppColors.parchment,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

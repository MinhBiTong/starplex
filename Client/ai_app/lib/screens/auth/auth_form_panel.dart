part of '../auth_screen.dart';

class _AuthFormPanel extends StatelessWidget {
  final AuthMode mode;
  final bool isLoading;
  final ValueChanged<AuthMode> onModeChanged;
  final TextEditingController nameController;
  // Per-mode controllers. Each form owns its own TextEditingController
  // so typing into the forgot-password email field cannot leak into
  // the sign-in / sign-up email fields (and vice-versa). The panel
  // picks the right controller for the active mode at build time.
  final TextEditingController signInEmailController;
  final TextEditingController signUpEmailController;
  final TextEditingController forgotEmailController;
  final TextEditingController signInPasswordController;
  final TextEditingController signUpPasswordController;
  final TextEditingController signUpConfirmController;
  final TextEditingController resetPasswordController;
  final TextEditingController resetConfirmController;
  final TextEditingController resetTokenController;
  final bool rememberMe;
  final bool termsAccepted;

  // Field-level submission state, surfaced inline beneath the relevant
  // field. See [_AuthScreenState] for the source of truth.
  final String? emailSubmitError;
  final String? passwordSubmitError;
  final String? resetCodeSubmitError;
  final String? termsSubmitError;
  final String? forgotSubmitNotice;
  final String? signupSuccessNotice;

  final ValueChanged<bool> onRememberChanged;
  final ValueChanged<bool> onTermsChanged;
  final VoidCallback onTermsTap;
  final VoidCallback onSignInSubmit;
  final VoidCallback onSignUpSubmit;
  final VoidCallback onForgotSubmit;
  final VoidCallback onResetSubmit;
  final VoidCallback onDismissForgotNotice;
  final VoidCallback onDismissSignupNotice;

  final GlobalKey<FormState> formKey;

  const _AuthFormPanel({
    required this.mode,
    required this.isLoading,
    required this.onModeChanged,
    required this.nameController,
    required this.signInEmailController,
    required this.signUpEmailController,
    required this.forgotEmailController,
    required this.signInPasswordController,
    required this.signUpPasswordController,
    required this.signUpConfirmController,
    required this.resetPasswordController,
    required this.resetConfirmController,
    required this.resetTokenController,
    required this.rememberMe,
    required this.termsAccepted,
    required this.emailSubmitError,
    required this.passwordSubmitError,
    required this.resetCodeSubmitError,
    required this.termsSubmitError,
    required this.forgotSubmitNotice,
    required this.signupSuccessNotice,
    required this.onRememberChanged,
    required this.onTermsChanged,
    required this.onTermsTap,
    required this.onSignInSubmit,
    required this.onSignUpSubmit,
    required this.onForgotSubmit,
    required this.onResetSubmit,
    required this.onDismissForgotNotice,
    required this.onDismissSignupNotice,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(mode: mode),
          const SizedBox(height: 22),
          _buildForm(context, l10n),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, AppLocalizations l10n) {
    switch (mode) {
      case AuthMode.signIn:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Success notice from the previous submit (signup created
            // an account, reset-password updated the password). Stays
            // on the email field so the user reads it before typing.
            if (signupSuccessNotice != null)
              _InlineNotice(
                message: signupSuccessNotice!,
                tone: _NoticeTone.success,
                onDismiss: onDismissSignupNotice,
              ),
            if (forgotSubmitNotice != null)
              _InlineNotice(
                message: forgotSubmitNotice!,
                tone: _NoticeTone.info,
                onDismiss: onDismissForgotNotice,
              ),
            _InputField(
              label: l10n.inputEmail,
              hint: l10n.inputEmailHint,
              controller: signInEmailController,
              externalError: emailSubmitError,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.errorEmailRequired;
                }
                if (!isValidEmail(value.trim())) {
                  return l10n.errorInvalidEmail;
                }
                return null;
              },
            ),
            _InputField(
              label: l10n.inputPassword,
              hint: l10n.inputPasswordHint,
              isPassword: true,
              controller: signInPasswordController,
              externalError: passwordSubmitError,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.errorPasswordRequired;
                }
                return null;
              },
            ),
            _CustomCheckbox(
              value: rememberMe,
              onChanged: onRememberChanged,
              semanticLabel: l10n.rememberMe,
              label: Text(
                l10n.rememberMe,
                style: AppFonts.inter(
                  color: AppColors.parchmentDim,
                  fontSize: 14,
                ),
              ),
              trailing: InkWell(
                onTap: () => onModeChanged(AuthMode.forgot),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text(
                    l10n.forgotPasswordLink,
                    style: AppFonts.jetBrainsMono(
                      color: AppColors.brass,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
            _PrimaryButton(
              label: l10n.signInButton,
              onTap: isLoading ? null : onSignInSubmit,
              isLoading: isLoading,
            ),
            const _OrDivider(),
            _BottomLink(
              text1: l10n.noAccountPrompt,
              text2: l10n.noAccountLink,
              onTap: () => onModeChanged(AuthMode.signUp),
            ),
            const SizedBox(height: 32),
          ],
        );
      case AuthMode.signUp:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InputField(
              label: l10n.inputFullName,
              hint: l10n.inputFullNameHint,
              controller: nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.errorFullNameRequired;
                }
                return null;
              },
            ),
            _InputField(
              label: l10n.inputEmail,
              hint: l10n.inputEmailHint,
              controller: signUpEmailController,
              externalError: emailSubmitError,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.errorEmailRequired;
                }
                if (!isValidEmail(value.trim())) {
                  return l10n.errorInvalidEmail;
                }
                return null;
              },
            ),
            _InputField(
              label: l10n.inputPassword,
              hint: l10n.inputPasswordShort,
              isPassword: true,
              controller: signUpPasswordController,
              externalError: passwordSubmitError,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.errorPasswordRequired;
                }
                if (value.length < 8) {
                  return l10n.errorPasswordTooShort;
                }
                return null;
              },
            ),
            _PasswordMeter(controller: signUpPasswordController),
            _InputField(
              label: l10n.inputConfirmPassword,
              hint: l10n.inputConfirmPasswordHint,
              isPassword: true,
              controller: signUpConfirmController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.errorConfirmPasswordRequired;
                }
                if (value != signUpPasswordController.text) {
                  return l10n.errorPasswordMismatch;
                }
                return null;
              },
            ),
            _CustomCheckbox(
              value: termsAccepted,
              onChanged: onTermsChanged,
              semanticLabel: l10n.agreeTermsSemantic,
              label: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    l10n.agreeTermsPrefix,
                    style: AppFonts.inter(
                      color: AppColors.parchmentDim,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTermsTap,
                    child: Text(
                      l10n.agreeTermsLink,
                      style: AppFonts.inter(
                        color: AppColors.brass,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Terms acceptance is the only piece of form-level
            // validation we can't tie to a textual field, so we
            // render its error inline directly beneath the
            // checkbox rather than as a snackbar.
            if (termsSubmitError != null)
              _InlineNotice(
                message: termsSubmitError!,
                tone: _NoticeTone.error,
              ),
            _PrimaryButton(
              label: l10n.signUpButton,
              onTap: isLoading ? null : onSignUpSubmit,
              isLoading: isLoading,
            ),
            const SizedBox(height: 32),
            _BottomLink(
              text1: l10n.hasAccountPrompt,
              text2: l10n.hasAccountLink,
              onTap: () => onModeChanged(AuthMode.signIn),
            ),
            const SizedBox(height: 32),
          ],
        );
      case AuthMode.forgot:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InputField(
              label: l10n.inputEmail,
              hint: l10n.inputEmailHint,
              controller: forgotEmailController,
              externalError: emailSubmitError,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.errorEmailRequired;
                }
                if (!isValidEmail(value.trim())) {
                  return l10n.errorInvalidEmail;
                }
                return null;
              },
            ),
            _PrimaryButton(
              label: l10n.forgotButton,
              onTap: isLoading ? null : onForgotSubmit,
              isLoading: isLoading,
            ),
            const SizedBox(height: 32),
            _BottomLink(
              text1: l10n.forgotRememberedPrompt,
              text2: l10n.forgotRememberedLink,
              onTap: () => onModeChanged(AuthMode.signIn),
            ),
            const SizedBox(height: 32),
          ],
        );
      case AuthMode.resetPassword:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InputField(
              label: l10n.inputResetCode,
              hint: l10n.inputResetCodeHint,
              controller: resetTokenController,
              externalError: resetCodeSubmitError,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.errorResetCodeRequired;
                }
                return null;
              },
            ),
            _InputField(
              label: l10n.inputNewPassword,
              hint: l10n.inputNewPasswordHint,
              isPassword: true,
              controller: resetPasswordController,
              externalError: passwordSubmitError,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.errorPasswordRequired;
                }
                if (value.length < 8) {
                  return l10n.errorPasswordTooShort;
                }
                return null;
              },
            ),
            _InputField(
              label: l10n.inputConfirmPassword,
              hint: l10n.inputNewPasswordConfirmHint,
              isPassword: true,
              controller: resetConfirmController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.errorConfirmPasswordRequired;
                }
                if (value != resetPasswordController.text) {
                  return l10n.errorPasswordMismatch;
                }
                return null;
              },
            ),
            _PrimaryButton(
              label: l10n.resetPasswordButton,
              onTap: isLoading ? null : onResetSubmit,
              isLoading: isLoading,
            ),
            const SizedBox(height: 32),
            _BottomLink(
              text1: l10n.resetRememberedPrompt,
              text2: l10n.resetRememberedLink,
              onTap: () => onModeChanged(AuthMode.signIn),
            ),
            const SizedBox(height: 32),
          ],
        );
    }
  }
}

/// Inline notice rendered *inside* the auth form card. Used for:
///   * successful state transitions (signup completed, password
///     updated) so the user reads them on the next step;
///   * server-side errors that don't naturally attach to a text
///     field, like "you must accept the production terms";
///   * neutral info notices like "we just emailed you a reset link".
///
/// Replaces the previous form-level `SnackBar` (transient toast) so
/// every outcome is anchored to the field that caused it.
enum _NoticeTone { success, info, error }

class _InlineNotice extends StatelessWidget {
  final String message;
  final _NoticeTone tone;
  final VoidCallback? onDismiss;

  const _InlineNotice({
    required this.message,
    required this.tone,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = switch (tone) {
      _NoticeTone.success => (AppColors.brass, Icons.check_circle_outline),
      _NoticeTone.info => (AppColors.azure, Icons.info_outline),
      _NoticeTone.error => (AppColors.coral, Icons.error_outline),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
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
            if (onDismiss != null)
              IconButton(
                icon: const Icon(Icons.close, size: 14),
                color: AppColors.smoke,
                onPressed: onDismiss,
                tooltip: 'Dismiss',
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
      ),
    );
  }
}

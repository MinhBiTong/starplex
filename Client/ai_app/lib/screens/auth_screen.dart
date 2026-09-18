import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_fonts.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../core/messages.dart';
import '../core/validators.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';
import '../widgets/language_picker.dart';
import 'admin_dashboard_screen.dart';
import 'home_screen.dart';
import 'production_terms_screen.dart';

part 'auth/auth_branding.dart';
part 'auth/auth_form_panel.dart';
part 'auth/auth_fields.dart';
part 'auth/auth_actions.dart';
/// Single Dio for the auth screen. We deliberately do NOT use
/// [ApiClient.instance.dio] here: the auth screen is public/anonymous and
/// sending a stale bearer header (or, worse, triggering the refresh
/// interceptor) before the user has signed in is a footgun. The auth
/// endpoints run on a plain client with the auth-header interceptor
/// only.
final Dio _dio = buildDio();

enum AuthMode { signIn, signUp, forgot, resetPassword }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _mode = AuthMode.signIn;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _termsAccepted = false;
  final _formKey = GlobalKey<FormState>();

  // Field-level submission errors. The validators already own the
  // syntactic checks; these slots hold the *outcome* of the last
  // submit attempt so we can render it inline next to the field that
  // caused the failure (or, for forgot-password, as a neutral
  // "check your inbox" notice below the email field).
  String? _emailSubmitError;
  String? _passwordSubmitError;
  String? _resetCodeSubmitError;
  String? _termsSubmitError;
  String? _forgotSubmitNotice;
  String? _signupSuccessNotice;

  final _nameController = TextEditingController();
  // One TextEditingController per mode + per field. Sharing a single
  // controller across sign-in / sign-up / forgot caused the email
  // value to bleed across forms: typing in one mode was visible in
  // the others. We keep separate buffers and clear them when the
  // user switches modes so cross-mode leakage stays impossible.
  final _signInEmailController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _forgotEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmController = TextEditingController();
  final _resetPasswordController = TextEditingController();
  final _resetConfirmController = TextEditingController();
  final _resetTokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Auto-clear submit-side errors as soon as the user edits the
    // corresponding field — otherwise a stale "Email already
    // registered" message would still show after they've corrected
    // the typo that caused it.
    _signInEmailController.addListener(_clearSignInEmailSubmitError);
    _signUpEmailController.addListener(_clearSignUpEmailSubmitError);
    _forgotEmailController.addListener(_clearForgotEmailSubmitError);
    _signInPasswordController.addListener(_clearSignInPasswordSubmitError);
    _signUpPasswordController.addListener(_clearSignUpPasswordSubmitError);
    _resetPasswordController.addListener(_clearResetPasswordSubmitError);
    _resetTokenController.addListener(_clearResetCodeSubmitError);
  }

  void _clearSignInEmailSubmitError() {
    if (_emailSubmitError == null && _forgotSubmitNotice == null) return;
    setState(() {
      _emailSubmitError = null;
      _forgotSubmitNotice = null;
    });
  }

  void _clearSignUpEmailSubmitError() {
    if (_emailSubmitError == null) return;
    setState(() => _emailSubmitError = null);
  }

  void _clearForgotEmailSubmitError() {
    if (_emailSubmitError == null) return;
    setState(() => _emailSubmitError = null);
  }

  void _clearSignInPasswordSubmitError() {
    if (_passwordSubmitError == null) return;
    setState(() => _passwordSubmitError = null);
  }

  void _clearSignUpPasswordSubmitError() {
    if (_passwordSubmitError == null) return;
    setState(() => _passwordSubmitError = null);
  }

  void _clearResetPasswordSubmitError() {
    if (_passwordSubmitError == null) return;
    setState(() => _passwordSubmitError = null);
  }

  void _clearResetCodeSubmitError() {
    if (_resetCodeSubmitError == null) return;
    setState(() => _resetCodeSubmitError = null);
  }

  void _clearTermsSubmitError() {
    if (_termsSubmitError == null) return;
    setState(() => _termsSubmitError = null);
  }

  @override
  void dispose() {
    _signInEmailController.removeListener(_clearSignInEmailSubmitError);
    _signUpEmailController.removeListener(_clearSignUpEmailSubmitError);
    _forgotEmailController.removeListener(_clearForgotEmailSubmitError);
    _signInPasswordController.removeListener(_clearSignInPasswordSubmitError);
    _signUpPasswordController.removeListener(_clearSignUpPasswordSubmitError);
    _resetPasswordController.removeListener(_clearResetPasswordSubmitError);
    _resetTokenController.removeListener(_clearResetCodeSubmitError);
    _nameController.dispose();
    _signInEmailController.dispose();
    _signUpEmailController.dispose();
    _forgotEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmController.dispose();
    _resetPasswordController.dispose();
    _resetConfirmController.dispose();
    _resetTokenController.dispose();
    super.dispose();
  }

  void _switchMode(AuthMode mode) {
    // Clear input buffers of the modes we are leaving so a partially
    // typed email/password in one form does not resurface when the
    // user toggles tabs later. We deliberately keep the active mode's
    // text intact so users don't lose what they were typing.
    setState(() {
      if (mode != AuthMode.signIn) _signInEmailController.clear();
      if (mode != AuthMode.signIn) _signInPasswordController.clear();
      if (mode != AuthMode.signUp) _signUpEmailController.clear();
      if (mode != AuthMode.signUp) _signUpPasswordController.clear();
      if (mode != AuthMode.signUp) _signUpConfirmController.clear();
      if (mode != AuthMode.forgot) _forgotEmailController.clear();
      if (mode != AuthMode.resetPassword) _resetPasswordController.clear();
      if (mode != AuthMode.resetPassword) _resetConfirmController.clear();
      if (mode != AuthMode.resetPassword) _resetTokenController.clear();
      _mode = mode;
    });
  }

  Future<void> _openProductionTerms() async {
    final accepted = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const ProductionTermsScreen()),
    );
    if (mounted && accepted == true) {
      setState(() => _termsAccepted = true);
    }
  }

  /// Returns to the public home screen regardless of how the user landed
  /// here. If the auth screen was opened as the entrypoint (no history
  /// to pop), we push a fresh home page instead.
  void _backToHome() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ReelHomePage()),
        (_) => false,
      );
    }
  }

  Future<void> _handleSignIn() async {
    if (_isLoading) return;
    final l10n = AppLocalizations.of(context);
    // Field-level validators already checked; bail out only on form-level
    // failure (e.g. user pressed Enter mid-edit). All field errors are
    // surfaced inline by the _InputField widgets themselves.
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _signInEmailController.text.trim();
    final password = _signInPasswordController.text;

    setState(() {
      _isLoading = true;
      _emailSubmitError = null;
      _passwordSubmitError = null;
    });
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      final user = Map<String, dynamic>.from(data['user'] as Map);
      await AuthSession.save(
        access: data['access_token'] as String,
        refresh: data['refresh_token'] as String,
        user: user,
        remember: _rememberMe,
      );
      if (!mounted) return;
      final destination = user['role'] == 'admin'
          ? const AdminDashboardScreen()
          : const ReelHomePage();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => destination),
        (_) => false,
      );
    } on DioException catch (error) {
      // Always surface credential failures on the password field — that
      // is where the user can actually do something about them. The
      // email is correct (validator accepted it + server could match
      // it), so flagging it would be misleading.
      if (mounted) {
        setState(() {
          _passwordSubmitError =
              _errorMessage(error, l10n.errorSignInFailed);
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignUp() async {
    if (_isLoading) return;
    final l10n = AppLocalizations.of(context);
    // Form-level validate runs every field validator and surfaces errors
    // inline. We don't need to manually re-check length/equality here.
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Accept-terms is the only "form-level" check left and we surface
    // it inline directly beneath the checkbox, not as a snackbar.
    if (!_termsAccepted) {
      setState(() => _termsSubmitError = l10n.errorAcceptTerms);
      return;
    }
    setState(() {
      _termsSubmitError = null;
      _emailSubmitError = null;
    });
    final name = _nameController.text.trim();
    final email = _signUpEmailController.text.trim();
    final password = _signUpPasswordController.text;

    setState(() => _isLoading = true);
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {'full_name': name, 'email': email, 'password': password},
      );
      // The register response carries the same token pair as
      // /auth/login, so a fresh account is signed in immediately.
      final data = Map<String, dynamic>.from(response.data as Map);
      final user = Map<String, dynamic>.from(data['user'] as Map);
      // The sign-up form has no remember-me checkbox; persist the
      // session so the new account survives an app restart.
      await AuthSession.save(
        access: data['access_token'] as String,
        refresh: data['refresh_token'] as String,
        user: user,
        remember: true,
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ReelHomePage()),
        (_) => false,
      );
    } on DioException catch (error) {
      if (mounted) {
        setState(() {
          // Email-already-registered is the dominant failure mode for
          // a brand-new client; binding the message to the email
          // field is more useful than a generic toast.
          _emailSubmitError =
              _errorMessage(error, l10n.errorSignUpFailed);
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleForgotPassword() async {
    if (_isLoading) return;
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _forgotEmailController.text.trim();
    setState(() {
      _isLoading = true;
      _forgotSubmitNotice = null;
      _emailSubmitError = null;
    });
    try {
      final response = await _dio.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
      // The server never echoes the reset token anymore — the only way
      // the user can obtain it is through the email we just sent. We
      // surface that as an inline "check your inbox" notice directly
      // beneath the email field rather than a transient toast.
      if (!mounted) return;
      _forgotEmailController.clear();
      _switchMode(AuthMode.signIn);
      _forgotSubmitNotice =
          _messageFromResponse(response.data) ?? l10n.successForgotEmail;
      setState(() {}); // pick up the notice on the sign-in form
    } on DioException catch (error) {
      if (mounted) {
        setState(() {
          _emailSubmitError =
              _errorMessage(error, l10n.errorForgotFailed);
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleResetPassword() async {
    if (_isLoading) return;
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final token = _resetTokenController.text.trim();
    final password = _resetPasswordController.text;
    setState(() {
      _isLoading = true;
      _resetCodeSubmitError = null;
    });
    try {
      final response = await _dio.post(
        '/auth/reset-password',
        data: {'token': token, 'new_password': password},
      );
      if (!mounted) return;
      _resetPasswordController.clear();
      _resetConfirmController.clear();
      _resetTokenController.clear();
      _switchMode(AuthMode.signIn);
      // Surface the success inline as a "Password updated" notice
      // beneath the email field on the sign-in form. No toast.
      _signupSuccessNotice =
          _messageFromResponse(response.data) ?? l10n.successResetPassword;
      setState(() {});
    } on DioException catch (error) {
      if (mounted) {
        setState(() {
          // Reset code errors (expired/invalid/used) are by far the
          // most common failure mode — pin them to the token field
          // where the user can act on them.
          _resetCodeSubmitError =
              _errorMessage(error, l10n.errorResetFailed);
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String? _messageFromResponse(dynamic data) {
    return data is Map && data['message'] is String
        ? data['message'] as String
        : null;
  }

  String _errorMessage(DioException error, String fallback) =>
      dioErrorFromContext(context, error, fallback);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    // Split-screen showcase chỉ cho đăng nhập/đăng ký — mockup quên/reset
    // là thẻ căn giữa với một orb duy nhất.
    final showShowcase =
        width >= 960 &&
        (_mode == AuthMode.signIn || _mode == AuthMode.signUp);
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: Stack(
        children: [
          const Positioned.fill(child: ReelBackdrop()),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AuthTopNav(onBackHome: _backToHome),
                  Expanded(
                    child: showShowcase
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Flexible(
                                flex: 105,
                                child: SingleChildScrollView(
                                  child: _Showcase(mode: _mode),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                color: AppColors.lineSoft,
                              ),
                              Flexible(
                                flex: 100,
                                child: Center(
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 24,
                                      horizontal: 32,
                                    ),
                                    child: _buildFormCard(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                  horizontal: 20,
                                ),
                                child: _buildFormCard(),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The glass auth card (mockup .card): header + the active mode's form.
  Widget _buildFormCard() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: ReelGlass(
        radius: 20,
        blur: true,
        padding: const EdgeInsets.all(28),
        child: _AuthFormPanel(
          mode: _mode,
          onModeChanged: _switchMode,
          isLoading: _isLoading,
          nameController: _nameController,
          signInEmailController: _signInEmailController,
          signUpEmailController: _signUpEmailController,
          forgotEmailController: _forgotEmailController,
          signInPasswordController: _signInPasswordController,
          signUpPasswordController: _signUpPasswordController,
          signUpConfirmController: _signUpConfirmController,
          resetPasswordController: _resetPasswordController,
          resetConfirmController: _resetConfirmController,
          resetTokenController: _resetTokenController,
          rememberMe: _rememberMe,
          termsAccepted: _termsAccepted,
          emailSubmitError: _emailSubmitError,
          passwordSubmitError: _passwordSubmitError,
          resetCodeSubmitError: _resetCodeSubmitError,
          termsSubmitError: _termsSubmitError,
          forgotSubmitNotice: _forgotSubmitNotice,
          signupSuccessNotice: _signupSuccessNotice,
          onRememberChanged: (value) => setState(() => _rememberMe = value),
          onTermsChanged: (value) {
            if (value) _clearTermsSubmitError();
            setState(() => _termsAccepted = value);
          },
          onTermsTap: _openProductionTerms,
          onSignInSubmit: _handleSignIn,
          onSignUpSubmit: _handleSignUp,
          onForgotSubmit: _handleForgotPassword,
          onResetSubmit: _handleResetPassword,
          onDismissForgotNotice: () => setState(() => _forgotSubmitNotice = null),
          onDismissSignupNotice: () =>
              setState(() => _signupSuccessNotice = null),
          formKey: _formKey,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../core/app_fonts.dart';
import 'package:dio/dio.dart';

import '../core/app_colors.dart';
import '../core/api_client.dart';
import '../core/auth_session.dart';
import '../core/messages.dart';
import '../core/validators.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/flagship_ui.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _avatarUrlController = TextEditingController();
  bool _isLoading = false;
  bool _isSaving = false;

  // Field-level submission state. Both validators and submit-time
  // errors render inline beneath the field they describe, so the
  // user never has to look away to a transient toast.
  String? _fullNameSubmitError;
  String? _avatarUrlSubmitError;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    if (AuthSession.accessToken == null) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Share the application-wide Dio so the refresh-on-401 interceptor
      // is also active here — a stale token shouldn't kick the user back
      // to the login screen just to load their profile.
      final response = await ApiClient.instance.dio.get('/users/me');

      if (mounted) {
        final data = Map<String, dynamic>.from(response.data as Map);
        _fullNameController.text = data['full_name'] ?? '';
        _avatarUrlController.text = data['avatar_url'] ?? '';
        setState(() => _isLoading = false);
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        // Profile load failure isn't a form submission, so we render a
        // single inline notice under the header rather than chasing the
        // failure to a specific field (no input was supplied yet).
        final l10n = AppLocalizations.of(context);
        _formLevelError =
            l10n.editProfileLoadFailed(e.message ?? '');
      }
    }
  }

  /// Form-level error for outcomes that don't tie to a specific field
  /// (e.g. profile load failure on first open).
  String? _formLevelError;

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (AuthSession.accessToken == null) return;

    setState(() {
      _isSaving = true;
      _fullNameSubmitError = null;
      _avatarUrlSubmitError = null;
      _formLevelError = null;
    });

    try {
      final response = await ApiClient.instance.dio.put(
        '/users/me',
        data: {
          'full_name': _fullNameController.text.trim(),
          'avatar_url': _avatarUrlController.text.trim().isEmpty
              ? null
              : _avatarUrlController.text.trim(),
        },
      );

      if (mounted) {
        final data = Map<String, dynamic>.from(response.data as Map);

        // Update AuthSession
        AuthSession.fullName = data['full_name'];
        // Pop with a `true` argument; profile_screen.dart reads it
        // and renders the inline "profile updated" notice on the
        // profile page itself.
        Navigator.of(context).pop(true);
      }
    } on DioException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        final detail = dioErrorMessage(e, l10n.editProfileSaveFailed);
        // The server typically only validates the full_name on
        // /users/me PUT, so route server-side validation errors
        // back to that field. Anything else falls through to a
        // form-level inline notice.
        setState(() {
          _fullNameSubmitError = detail;
        });
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _avatarUrlController.dispose();
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
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.brass,
                          ),
                        )
                      : _buildForm(l10n),
                ),
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
              l10n.editProfileTitle,
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
                  if (_formLevelError != null) ...[
                    _InlineNotice(
                      message: _formLevelError!,
                      tone: _NoticeTone.error,
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    l10n.editProfileSubhead,
                    style: AppFonts.inter(
                      color: AppColors.parchmentDim,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField(
                    controller: _fullNameController,
                    label: l10n.inputFullNameEdit,
                    hint: l10n.inputFullNameEditHint,
                    externalError: _fullNameSubmitError,
                    onChanged: () {
                      if (_fullNameSubmitError != null) {
                        setState(() => _fullNameSubmitError = null);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.errorFullNameRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: _avatarUrlController,
                    label: l10n.inputAvatarUrl,
                    hint: l10n.inputAvatarUrlHint,
                    externalError: _avatarUrlSubmitError,
                    onChanged: () {
                      if (_avatarUrlSubmitError != null) {
                        setState(() => _avatarUrlSubmitError = null);
                      }
                    },
                    validator: (value) {
                      if (!isValidAvatarUrl(value)) {
                        return l10n.errorInvalidAvatarUrl;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ReelButton(
                      label: l10n.editProfileSave,
                      onPressed: _isSaving ? null : _saveProfile,
                      loading: _isSaving,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
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
          validator: validator,
          onChanged: (_) => onChanged?.call(),
          style: AppFonts.inter(color: AppColors.parchment, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppFonts.inter(color: AppColors.muted, fontSize: 14),
            filled: true,
            fillColor: AppColors.glass,
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

/// Inline notice used inside the edit-profile form card. Mirrors the
/// visual language of the auth screen's `_InlineNotice` so the user
/// sees the same success/error treatment across screens.
enum _NoticeTone { success, info, error }

class _InlineNotice extends StatelessWidget {
  final String message;
  final _NoticeTone tone;
  const _InlineNotice({required this.message, required this.tone});

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

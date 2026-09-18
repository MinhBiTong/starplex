part of '../auth_screen.dart';

/// Lightweight Field-level validator widget.
///
/// We use a plain [FormField] (rather than just [TextFormField]) so we
/// have access to [FormFieldState] from outside — that lets the
/// surrounding container update its border colour when validation
/// transitions between valid/invalid. [TextFormField] only exposes its
/// state through the framework, which makes the visual coupling we
/// want awkward to implement.
class _InputField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  /// Server-side / submission error bound to this specific field.
  ///
  /// When non-null, this overrides the validator output and is shown
  /// beneath the input with the same `_FieldError` styling. The parent
  /// is responsible for clearing it as soon as the user types again so
  /// we don't leave stale server errors lingering after they fix the
  /// underlying issue.
  final String? externalError;

  const _InputField({
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.externalError,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  bool _obscureText = true;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppFonts.jetBrainsMono(
              color: AppColors.smoke,
              fontSize: 10.5,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          FormField<String>(
            // Initial value is the controller's current text so the field
            // starts un-errored when the user hasn't typed anything yet.
            initialValue: widget.controller?.text ?? '',
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (field) {
              final hasError =
                  field.hasError ||
                  (widget.externalError?.isNotEmpty ?? false);
              final errorText = field.errorText ?? widget.externalError;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Focus(
                    onFocusChange: (value) =>
                        setState(() => _focused = value),
                    child: AnimatedContainer(
                      duration:
                          MediaQuery.disableAnimationsOf(context)
                              ? Duration.zero
                              : const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: AppColors.glass,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: hasError
                              ? AppColors.coral
                              : _focused
                                  ? AppColors.azure
                                  : AppColors.line,
                          width: hasError ? 1.5 : 1,
                        ),
                        boxShadow: _focused
                            ? [
                                BoxShadow(
                                  color: AppColors.azure
                                      .withValues(alpha: .16),
                                  spreadRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                      child: TextFormField(
                        controller: widget.controller,
                        obscureText:
                            widget.isPassword && _obscureText,
                        keyboardType: widget.label == 'EMAIL'
                            ? TextInputType.emailAddress
                            : TextInputType.text,
                        autocorrect: !widget.isPassword &&
                            widget.label != 'EMAIL',
                        enableSuggestions: !widget.isPassword,
                        style: AppFonts.inter(
                          color: AppColors.mist,
                          fontSize: 15,
                        ),
                        onChanged: field.didChange,
                        decoration: InputDecoration(
                          hintText: widget.hint,
                          hintStyle: AppFonts.inter(
                            color: AppColors.muted,
                            fontSize: 15,
                          ),
                          // Hide the default error UI — we render the
                          // message ourselves so it matches the surrounding
                          // typography (inter, coral accent).
                          errorStyle:
                              const TextStyle(height: 0, fontSize: 0),
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          suffixIcon: widget.isPassword
                              ? IconButton(
                                  tooltip: _obscureText
                                      ? AppLocalizations.of(context)
                                          .toggleShowPassword
                                      : AppLocalizations.of(context)
                                          .toggleHidePassword,
                                  onPressed: () => setState(
                                      () => _obscureText = !_obscureText),
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 18,
                                    color: AppColors.smoke,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  if (hasError && errorText != null)
                    _FieldError(message: errorText),
                  if (!hasError &&
                      widget.externalError != null &&
                      widget.externalError!.isNotEmpty)
                    _FieldError(message: widget.externalError!),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Compact, on-brand field-level error row. Mirrors the muted label/typography
/// of the auth form so the validation feedback feels native to the screen.
class _FieldError extends StatelessWidget {
  final String message;
  const _FieldError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              message,
              style: AppFonts.inter(
                color: AppColors.coral,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomCheckbox extends StatefulWidget {
  final Widget label;
  final Widget? trailing;
  final String semanticLabel;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomCheckbox({
    required this.label,
    this.trailing,
    required this.semanticLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<_CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Semantics(
              checked: widget.value,
              label: widget.semanticLabel,
              child: InkWell(
                onTap: () => widget.onChanged(!widget.value),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ), // Tăng vùng nhấn
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: widget.value
                              ? AppColors.azureSoft
                              : Colors.transparent,
                          border: Border.all(color: AppColors.azureSoft),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: widget.value
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: AppColors.ink,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: widget.label),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}

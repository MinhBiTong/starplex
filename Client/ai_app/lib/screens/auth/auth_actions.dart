part of '../auth_screen.dart';

/// Compact back-to-home button used in the auth screen's top bar.
///
/// Mirrors the glass-and-line styling of [LanguagePicker] so the two
/// controls feel like a matched pair. The button has its own 44px-tall
/// hit target — without that explicit tap area, the icon's 18pt size
/// would be too small to hit reliably on touch.
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;

  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: ReelButton(
      label: label,
      onPressed: onTap,
      loading: isLoading,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    ),
  );
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: AppColors.lineSoft, thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.orDivider,
              style: AppFonts.jetBrainsMono(
                color: AppColors.muted,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: AppColors.lineSoft, thickness: 1),
          ),
        ],
      ),
    );
  }
}

class _BottomLink extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;

  const _BottomLink({
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: text1),
                  TextSpan(
                    text: text2,
                    style: const TextStyle(
                      color: AppColors.brass,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: AppFonts.inter(
                color: AppColors.parchmentDim,
                fontSize: 16,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

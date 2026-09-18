import 'package:flutter/material.dart';
import '../core/app_fonts.dart';

import '../core/app_colors.dart';
import '../core/locale_controller.dart';
import '../l10n/generated/app_localizations.dart';

/// Dropdown that lets the visitor pick any of the [LocaleController.supported]
/// languages. Designed to live in the public header — wide enough to show the
/// native name and short enough to survive on a 360px viewport.
class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key, this.compact = false});

  /// When true, only the badge is shown (used in narrow layouts).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final controller = LocaleController.instance;
        final current = controller.findByLocale(controller.locale);
        return Tooltip(
          message: l10n.languagePickerTooltip,
          child: PopupMenuButton<LocaleOption>(
            tooltip: l10n.languagePickerTooltip,
            offset: const Offset(0, 8),
            color: AppColors.surface,
            position: PopupMenuPosition.under,
            elevation: 18,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.lineSoft),
            ),
            onSelected: (option) => controller.setLocale(option.locale),
            itemBuilder: (context) => [
              for (final option in LocaleController.supported)
                PopupMenuItem<LocaleOption>(
                  value: option,
                  height: 44,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    children: [
                      _LanguageBadge(code: option.code),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          option.nativeName,
                          style: GoogleFontsStyle.body(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (current == option)
                        const Icon(
                          Icons.check,
                          size: 14,
                          color: AppColors.azure,
                        ),
                    ],
                  ),
                ),
            ],
            child: _PickerChip(
              current: current,
              compact: compact,
            ),
          ),
        );
      },
    );
  }
}

class _PickerChip extends StatelessWidget {
  const _PickerChip({required this.current, required this.compact});

  final LocaleOption? current;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final option = current;
    final code = (option?.code ?? 'EN').toUpperCase();
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.glass,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _LanguageBadge(code: code),
          if (!compact) ...[
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                option?.nativeName ?? code,
                style: GoogleFontsStyle.body(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          const SizedBox(width: 4),
          const Icon(
            Icons.expand_more,
            size: 16,
            color: AppColors.smoke,
          ),
        ],
      ),
    );
  }
}

/// Small rounded chip rendering the ISO language code. Replaces emoji flags
/// (which Flutter on web does not render as colored glyphs).
class _LanguageBadge extends StatelessWidget {
  final String code;
  const _LanguageBadge({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lineSoft,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        code,
        style: AppFonts.jetBrainsMono(
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          color: AppColors.mist,
          letterSpacing: .8,
        ),
      ),
    );
  }
}

/// Shared text styles — uses GoogleFonts so the picker chip matches the rest
/// of the app's typography.
class GoogleFontsStyle {
  GoogleFontsStyle._();

  static TextStyle body() => AppFonts.inter(
        fontSize: 13,
        color: AppColors.mist,
      );

  static TextStyle code() => AppFonts.jetBrainsMono(
        fontSize: 10.5,
        color: AppColors.smoke,
        letterSpacing: 1,
      );
}

part of 'admin_dashboard_screen.dart';

// ========================== DASHBOARD COMPONENTS ==========================

class _ResponsiveCards extends StatelessWidget {
  final List<Widget> children;
  const _ResponsiveCards({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mirror `.kpi-grid` from the HTML reference.
        final columns = constraints.maxWidth >= 960
            ? 4
            : (constraints.maxWidth >= 520 ? 2 : 1);
        const gap = 14.0;
        final cardWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - (columns - 1) * gap) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: children
              .map((child) => SizedBox(
                    width: cardWidth,
                    child: child,
                  ))
              .toList(),
        );
      },
    );
  }
}

class _PanelBlock extends StatelessWidget {
  final String? title;
  final String? eyebrow;
  final Widget? action;
  final Widget child;

  const _PanelBlock({
    this.title,
    this.eyebrow,
    this.action,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AdminColors.glass,
        border: Border.all(color: AdminColors.line),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AdminColors.lineSoft),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final heading = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (eyebrow != null)
                        Text(
                          eyebrow!,
                          style: AppFonts.jetBrainsMono(
                            fontSize: 9.5,
                            letterSpacing: 1.8,
                            color: AdminColors.goldBright,
                          ),
                        ),
                      if (eyebrow != null) const SizedBox(height: 6),
                      Text(
                        title!,
                        style: AppFonts.spaceGrotesk(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.mist,
                        ),
                      ),
                    ],
                  );

                  if (constraints.maxWidth < 520 && action != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading,
                        const SizedBox(height: 12),
                        action!,
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: heading),
                      ?action,
                    ],
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _AdminDialog extends StatelessWidget {
  final String? eyebrow;
  final String title;
  final Widget content;
  final List<Widget> actions;
  final double maxWidth;

  const _AdminDialog({
    this.eyebrow,
    required this.title,
    required this.content,
    required this.actions,
    this.maxWidth = 520,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: AdminColors.panel,
            border: Border.all(color: AdminColors.line),
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AdminColors.glassStrong, AdminColors.glass],
            ),
            boxShadow: const [
              BoxShadow(color: Color(0x80000000), blurRadius: 40, offset: Offset(0, 18)),
              BoxShadow(color: Color(0x143D7CFF), blurRadius: 60, offset: Offset(0, 0)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (eyebrow != null) ...[
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [AdminColors.gold, AdminColors.coral]),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            eyebrow!,
                            style: AppFonts.jetBrainsMono(
                              fontSize: 9.5, letterSpacing: 2, color: AdminColors.goldBright),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                    Text(
                      title,
                      style: AppFonts.spaceGrotesk(
                        fontSize: 18, fontWeight: FontWeight.w600,
                        color: AdminColors.cream, letterSpacing: -.3),
                    ),
                  ],
                ),
              ),
              Container(height: 1, color: AdminColors.lineSoft),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                  child: content,
                ),
              ),
              Container(height: 1, color: AdminColors.lineSoft),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (var i = 0; i < actions.length; i++) ...[
                      if (i > 0) const SizedBox(width: 10),
                      actions[i],
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminField extends StatelessWidget {
  final String label;
  final Widget child;
  final String? hint;

  const _AdminField({required this.label, required this.child, this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label.toUpperCase(),
              style: AppFonts.jetBrainsMono(
                fontSize: 9.5, letterSpacing: 1.5, color: AdminColors.creamDim),
            ),
            if (hint != null) ...[
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  '— $hint',
                  style: AppFonts.inter(
                    fontSize: 11, fontStyle: FontStyle.italic, color: AdminColors.muted),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 16),
      ],
    );
  }
}

class _AdminDropdown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _AdminDropdown({required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isDense: true,
      isExpanded: true,
      dropdownColor: AdminColors.panel,
      // Cap the menu height so its overlay can't punch through the
      // dialog's `SingleChildScrollView` and overlap whatever sits
      // underneath. 240 ≈ 4 items at 56px, which is plenty for our
      // short admin pickers (role, status, billing period).
      menuMaxHeight: 240,
      elevation: 18,
      borderRadius: BorderRadius.circular(11),
      icon: const Icon(Icons.expand_more_rounded, size: 18, color: AdminColors.creamDim),
      style: AppFonts.inter(fontSize: 14, color: AdminColors.cream),
      // Use a dedicated builder for the *selected* item so it has a
      // distinct background; otherwise the dropdown's inner Text sits
      // on top of the field's own decoration and looks washed out.
      selectedItemBuilder: (context) => items
          .map(
            (item) => Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: DefaultTextStyle(
                style: AppFonts.inter(
                  fontSize: 14,
                  color: AdminColors.cream,
                  fontWeight: FontWeight.w500,
                ),
                child: item.child,
              ),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(0x40000000),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.gold, width: 1.4),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.line),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item.value,
              child: Container(
                // Each menu row gets an explicit background so the
                // items never read as transparent on top of the
                // dropdown panel — that was the "two labels stacked"
                // bug we saw in the screenshot.
                color: AdminColors.panel,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: DefaultTextStyle(
                  style: AppFonts.inter(
                    fontSize: 14,
                    color: AdminColors.cream,
                  ),
                  child: item.child,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _AdminTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;

  const _AdminTextField({
    required this.controller,
    this.obscure = false,
    this.keyboardType,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      style: AppFonts.inter(fontSize: 14, color: AdminColors.cream),
      cursorColor: AdminColors.gold,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(0x40000000),
        hintStyle: AppFonts.inter(
          fontSize: 14, fontStyle: FontStyle.italic, color: AdminColors.muted),
        counterStyle: AppFonts.inter(
          fontSize: 10.5, color: AdminColors.muted, height: 1.2),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.gold, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.red, width: 1.4),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AdminColors.line),
        ),
      ),
    );
  }
}

class _AdminPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const _AdminPrimaryButton({required this.label, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            gradient: AdminColors.spectrum,
            boxShadow: const [
              BoxShadow(color: Color(0x4D3D7CFF), blurRadius: 20, offset: Offset(0, 8)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: const Color(0xFF06070F)),
                const SizedBox(width: 7),
              ],
              Text(
                label.toUpperCase(),
                style: AppFonts.jetBrainsMono(
                  fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w600,
                  color: const Color(0xFF06070F), height: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminGhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _AdminGhostButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: AdminColors.glass,
            border: Border.all(color: AdminColors.line),
          ),
          child: Text(
            label.toUpperCase(),
            style: AppFonts.jetBrainsMono(
              fontSize: 11, letterSpacing: 1.4, color: AdminColors.creamDim, height: 1.2),
          ),
        ),
      ),
    );
  }
}

class _DangerButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  const _DangerButton({required this.label, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6F91), Color(0xFFFF9466)],
              begin: Alignment.centerLeft, end: Alignment.centerRight,
            ),
            boxShadow: const [
              BoxShadow(color: Color(0x4DFF6F91), blurRadius: 20, offset: Offset(0, 8)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: const Color(0xFF06070F)),
                const SizedBox(width: 7),
              ],
              Text(
                label.toUpperCase(),
                style: AppFonts.jetBrainsMono(
                  fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w600,
                  color: const Color(0xFF06070F), height: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _GlassToggleRow({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(11),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AdminColors.glass,
          border: Border.all(color: AdminColors.line),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 36,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: value ? const Color(0x333D7CFF) : const Color(0x1AFFFFFF),
                border: Border.all(color: value ? AdminColors.gold : AdminColors.line),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 12, height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value ? AdminColors.gold : AdminColors.muted,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppFonts.inter(fontSize: 14, color: AdminColors.cream),
              ),
            ),
            Text(
              value ? 'ON' : 'OFF',
              style: AppFonts.jetBrainsMono(
                fontSize: 9.5, letterSpacing: 1.4,
                color: value ? AdminColors.goldBright : AdminColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}


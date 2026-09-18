part of 'admin_dashboard_screen.dart';

// ========================== UTILITIES ==========================

class _FilterBar extends StatelessWidget {
  final List<Widget> children;
  const _FilterBar({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final items = children
            .where((child) => child is! Spacer)
            .map(
              (child) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: child,
              ),
            )
            .toList();
        final compact = constraints.maxWidth < 720;
        final availableWidth = (constraints.maxWidth - 44)
            .clamp(1.0, double.infinity)
            .toDouble();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AdminColors.lineSoft)),
          ),
          child: compact
              ? Wrap(
                  spacing: 0,
                  runSpacing: 12,
                  children: items
                      .map(
                        (item) => ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: availableWidth),
                          child: SizedBox(width: availableWidth, child: item),
                        ),
                      )
                      .toList(),
                )
              : Row(
                  children: children.map((child) {
                    if (child is Spacer) return child;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: child,
                    );
                  }).toList(),
                ),
        );
      },
    );
  }
}

class _FilterSelect extends StatelessWidget {
  final String label;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final ValueChanged<String?>? onChanged;

  const _FilterSelect({
    required this.label,
    this.value,
    this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 184,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0x40000000),
        border: Border.all(color: AdminColors.line),
        borderRadius: BorderRadius.circular(11),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value ?? label,
          isExpanded: true,
          isDense: true,
          icon: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: AdminColors.muted,
            ),
          ),
          dropdownColor: AdminColors.panel,
          menuMaxHeight: 320,
          elevation: 18,
          borderRadius: BorderRadius.circular(11),
          style: AppFonts.jetBrainsMono(
            fontSize: 11.5,
            color: AdminColors.cream,
          ),
          selectedItemBuilder: (context) {
            return (items ??
                [
                  DropdownMenuItem<String>(
                    value: label,
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]).map((item) => item.child).toList();
          },
          onChanged: onChanged ?? (v) {},
          items:
              items ??
              [
                DropdownMenuItem<String>(
                  value: label,
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
        ),
      ),
    );
  }
}

class _FilterInput extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const _FilterInput({required this.hint, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0x40000000),
        border: Border.all(color: AdminColors.line),
        borderRadius: BorderRadius.circular(11),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppFonts.inter(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          color: AdminColors.cream,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppFonts.inter(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: const Color(0xFF5B4F40),
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _PagerBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback? onTap;
  const _PagerBtn({required this.label, this.active = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: active,
      label: 'Trang $label',
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          margin: const EdgeInsets.only(left: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AdminColors.burgundy : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: active ? AdminColors.burgundyBright : AdminColors.line,
            ),
          ),
          child: Text(
            label,
            style: AppFonts.jetBrainsMono(
              fontSize: 11,
              color: active ? AdminColors.cream : AdminColors.creamDim,
            ),
          ),
        ),
      ),
    );
  }
}

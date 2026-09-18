part of 'admin_dashboard_screen.dart';

// ========================== UI BUTTONS & INPUTS ==========================

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AdminColors.burgundy,
            border: Border.all(color: AdminColors.burgundyBright),
            borderRadius: BorderRadius.circular(11),
            gradient: AdminColors.spectrum,
            boxShadow: const [
              BoxShadow(
                color: Color(0x4D3D7CFF),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            label.toUpperCase(),
            style: AppFonts.jetBrainsMono(
              fontSize: 11.5,
              letterSpacing: 2,
              color: AdminColors.cream,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isFullWidth;

  const _GhostButton({
    required this.label,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          width: isFullWidth ? double.infinity : null,
          height: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: isFullWidth ? 14 : 14,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AdminColors.line),
            color: AdminColors.glass,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            label.toUpperCase(),
            style: AppFonts.jetBrainsMono(
              fontSize: 11,
              letterSpacing: 1.5,
              color: AdminColors.creamDim,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final bool isDanger;
  final VoidCallback? onTap;

  const _ActionBtn({required this.label, this.isDanger = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AdminColors.line),
            color: AdminColors.glass,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            label.toUpperCase(),
            style: AppFonts.jetBrainsMono(
              fontSize: 10,
              letterSpacing: 1,
              color: isDanger ? AdminColors.red : AdminColors.creamDim,
            ),
          ),
        ),
      ),
    );
  }
}

class _Switch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  const _Switch({required this.initialValue, this.onChanged});
  @override
  State<_Switch> createState() => _SwitchState();
}

class _SwitchState extends State<_Switch> {
  late bool value;
  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () {
          final next = !value;
          setState(() => value = next);
          widget.onChanged?.call(next);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: value ? AdminColors.gold : AdminColors.line,
            ),
            color: value ? const Color(0x263D7CFF) : const Color(0x4D000000),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                left: value ? 15 : 2,
                top: 1.5,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value ? AdminColors.gold : AdminColors.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import '../core/app_fonts.dart';

import '../core/app_colors.dart';

/// Ambient mesh, following the three orb paths in the flagship reference.
class ReelBackdrop extends StatefulWidget {
  const ReelBackdrop({super.key});
  @override
  State<ReelBackdrop> createState() => _ReelBackdropState();
}

class _ReelBackdropState extends State<ReelBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 280),
  );
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _clock.stop();
    } else {
      _clock.forward();
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: RepaintBoundary(
      child: AnimatedBuilder(
        animation: _clock,
        builder: (_, _) =>
            CustomPaint(painter: _AuroraPainter(_clock.value * 280)),
      ),
    ),
  );
}

class _AuroraPainter extends CustomPainter {
  final double seconds;
  _AuroraPainter(this.seconds);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(AppColors.ink, BlendMode.src);
    void orb(
      Offset center,
      double diameter,
      Color color,
      double opacity,
      double period,
      Offset drift,
      double growth,
    ) {
      final t = (1 - math.cos(seconds / period * math.pi)) / 2;
      final radius = diameter / 2 * (1 + growth * t);
      final position = center + drift * t;
      final paint = Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100)
        ..shader = ui.Gradient.radial(
          position,
          radius,
          [color.withValues(alpha: opacity), color.withValues(alpha: 0)],
          [0, .7],
        );
      canvas.drawCircle(position, radius, paint);
    }

    orb(
      const Offset(60, 80),
      560,
      AppColors.azure,
      .5,
      28,
      const Offset(70, 50),
      .1,
    );
    orb(
      Offset(size.width - 60, 500),
      520,
      AppColors.indigo,
      .5,
      34,
      const Offset(-60, 60),
      .08,
    );
    orb(
      Offset(size.width * .34 + 190, 1090),
      460,
      AppColors.coral,
      .3,
      40,
      const Offset(50, -40),
      .14,
    );
    // Deterministic film grain; never changes between frames or tests.
    final random = math.Random(42);
    final grain = Paint()..color = Colors.white.withValues(alpha: .023);
    for (var i = 0; i < size.width * size.height / 100; i++) {
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        .6,
        grain,
      );
    }
  }

  @override
  bool shouldRepaint(_AuroraPainter old) => old.seconds != seconds;
}

class ReelBrand extends StatefulWidget {
  final VoidCallback? onTap;
  const ReelBrand({super.key, this.onTap});
  @override
  State<ReelBrand> createState() => _ReelBrandState();
}

class _ReelBrandState extends State<ReelBrand>
    with SingleTickerProviderStateMixin {
  late final AnimationController _halo = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 9),
  );
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _halo.stop();
    } else {
      _halo.forward();
    }
  }

  @override
  void dispose() {
    _halo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: widget.onTap,
    borderRadius: BorderRadius.circular(8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 26,
          height: 26,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: RotationTransition(
                  turns: _halo,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Color(0x668B7BFF), blurRadius: 15),
                      ],
                      gradient: AppColors.spectrum,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.spectrum,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 9),
        Text(
          'REEL',
          style: AppFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: .5,
            color: AppColors.mist,
          ),
        ),
      ],
    ),
  );
}

class ReelGlass extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool blur;
  const ReelGlass({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(22),
    this.radius = 18,
    this.blur = false,
  });
  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.glassStrong, AppColors.glass],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.line),
      ),
      child: child,
    );
    return blur
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: content,
            ),
          )
        : content;
  }
}

class ReelButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool primary, loading;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  const ReelButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.primary = true,
    this.loading = false,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
  });
  @override
  State<ReelButton> createState() => _ReelButtonState();
}

class _ReelButtonState extends State<ReelButton> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hover = true),
    onExit: (_) => setState(() => _hover = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        boxShadow: widget.primary && widget.onPressed != null
            ? [
                BoxShadow(
                  color: (_hover ? AppColors.indigo : AppColors.azure)
                      .withValues(alpha: .3),
                  blurRadius: _hover ? 32 : 26,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: widget.primary ? AppColors.spectrum : null,
                  color: widget.primary
                      ? null
                      : (_hover ? AppColors.glassStrong : AppColors.glass),
                  border: widget.primary
                      ? null
                      : Border.all(color: AppColors.line),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: InkWell(
                  onTap: widget.loading ? null : widget.onPressed,
                  child: Padding(
                    padding: widget.padding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.loading) ...[
                          SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: widget.primary
                                  ? AppColors.ink
                                  : AppColors.mist,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Text(
                            widget.label,
                            textAlign: TextAlign.center,
                            style: AppFonts.inter(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: widget.primary
                                  ? AppColors.ink
                                  : AppColors.mist,
                            ),
                          ),
                        ),
                        if (widget.icon != null) ...[
                          const SizedBox(width: 7),
                          Icon(
                            widget.icon,
                            size: 14,
                            color: widget.primary
                                ? AppColors.ink
                                : AppColors.mist,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.primary)
              Positioned.fill(
                child: IgnorePointer(
                  child: LayoutBuilder(
                    builder: (_, c) => AnimatedSlide(
                      offset: Offset(_hover ? 1.2 : -1.2, 0),
                      duration: MediaQuery.disableAnimationsOf(context)
                          ? Duration.zero
                          : const Duration(milliseconds: 550),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withValues(alpha: .2),
                              Colors.transparent,
                            ],
                            stops: const [.3, .5, .7],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class ReelGradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ReelGradientText(this.text, {super.key, required this.style});
  @override
  Widget build(BuildContext context) => ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: AppColors.spectrum.createShader,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: style.copyWith(color: Colors.white),
    ),
  );
}

/// Reveals once when entering the visible scroll viewport, like IntersectionObserver.
class ReelReveal extends StatefulWidget {
  final Widget child;
  const ReelReveal({super.key, required this.child});
  @override
  State<ReelReveal> createState() => _ReelRevealState();
}

class _ReelRevealState extends State<ReelReveal> {
  ScrollPosition? _position;
  bool _visible = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final next = Scrollable.maybeOf(context)?.position;
    if (_position != next) {
      _position?.removeListener(_check);
      _position = next;
      _position?.addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!mounted || _visible) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final dy = box.localToGlobal(Offset.zero).dy;
    if (MediaQuery.disableAnimationsOf(context) ||
        dy < MediaQuery.sizeOf(context).height - 20) {
      setState(() => _visible = true);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: _visible ? 1 : 0,
    duration: const Duration(milliseconds: 700),
    curve: const Cubic(.2, .7, .2, 1),
    child: AnimatedSlide(
      offset: _visible ? Offset.zero : const Offset(0, .08),
      duration: const Duration(milliseconds: 700),
      curve: const Cubic(.2, .7, .2, 1),
      child: widget.child,
    ),
  );
}

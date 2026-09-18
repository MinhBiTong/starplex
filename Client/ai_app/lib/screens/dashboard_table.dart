part of 'admin_dashboard_screen.dart';

// ========================== TABLE & GENERAL COMPONENTS ==========================

class _AdminTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final List<double>? flexes;

  const _AdminTable({required this.headers, required this.rows, this.flexes});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tableWidth = constraints.maxWidth < 720
            ? 760.0
            : constraints.maxWidth;
        final cellHorizontalPadding = constraints.maxWidth < 720 ? 12.0 : 18.0;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: flexes != null
                  ? {
                      for (int i = 0; i < flexes!.length; i++)
                        i: FlexColumnWidth(flexes![i]),
                    }
                  : null,
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AdminColors.lineSoft),
                    ),
                  ),
                  children: headers
                      .map(
                        (h) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: cellHorizontalPadding,
                            vertical: 10,
                          ),
                          child: Text(
                            h.toUpperCase(),
                            style: AppFonts.jetBrainsMono(
                              fontSize: 9.5,
                              letterSpacing: 1.1,
                              color: AdminColors.muted,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                ...rows.map(
                  (row) => TableRow(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AdminColors.lineSoft),
                      ),
                    ),
                    children: row
                        .map(
                          (cell) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: cellHorizontalPadding,
                              vertical: 12,
                            ),
                            child: DefaultTextStyle(
                              style: AppFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AdminColors.mist,
                              ),
                              child: cell,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Small status pill with a leading dot, mirroring `.pill-*` in the reference.
class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;
  final bool pulse;
  const _StatusPill({
    required this.label,
    required this.color,
    required this.background,
    this.pulse = false,
  });

  factory _StatusPill.done(String text) => _StatusPill(
    label: text,
    color: AdminColors.goldBright,
    background: AdminColors.gold.withValues(alpha: .08),
  );
  factory _StatusPill.processing(String text) => _StatusPill(
    label: text,
    color: AdminColors.indigo,
    background: AdminColors.indigo.withValues(alpha: .1),
    pulse: true,
  );
  factory _StatusPill.failed(String text) => _StatusPill(
    label: text,
    color: AdminColors.coral,
    background: AdminColors.coral.withValues(alpha: .1),
  );
  factory _StatusPill.active(String text) => _StatusPill(
    label: text,
    color: AdminColors.goldBright,
    background: AdminColors.gold.withValues(alpha: .08),
  );
  factory _StatusPill.suspended(String text) => _StatusPill(
    label: text,
    color: AdminColors.muted,
    background: Colors.white.withValues(alpha: .04),
  );
  factory _StatusPill.info(String text) => _StatusPill(
    label: text,
    color: AdminColors.goldBright,
    background: AdminColors.gold.withValues(alpha: .08),
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: AdminColors.line),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: AppFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Plan chip mirroring `.plan-chip` and `.plan-chip.pro` in the HTML.
class _PlanChip extends StatelessWidget {
  final String label;
  final bool pro;
  const _PlanChip({required this.label, this.pro = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(
      border: Border.all(
        color: pro
            ? AdminColors.gold.withValues(alpha: .5)
            : AdminColors.line,
      ),
      borderRadius: BorderRadius.circular(7),
      gradient: pro
          ? const LinearGradient(
              colors: [
                Color(0x383D7CFF),
                Color(0x28FF9466),
              ],
            )
          : null,
      color: pro ? null : Colors.transparent,
    ),
    child: Text(
      label,
      style: AppFonts.jetBrainsMono(
        fontSize: 10,
        letterSpacing: .8,
        color: pro ? AdminColors.cream : AdminColors.muted,
      ),
    ),
  );
}

/// Compact progress track + text used in the user roster.
class _UsageBar extends StatelessWidget {
  final int used;
  final int limit;
  final bool unlimited;
  const _UsageBar({
    required this.used,
    required this.limit,
    this.unlimited = false,
  });

  @override
  Widget build(BuildContext context) {
    if (unlimited) {
      return Text(
        '$used · không giới hạn',
        style: AppFonts.jetBrainsMono(
          fontSize: 10,
          color: AdminColors.muted,
        ),
      );
    }
    final safeLimit = limit <= 0 ? 1 : limit;
    final ratio = (used / safeLimit).clamp(0.0, 1.0).toDouble();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          height: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                Container(color: Colors.white.withValues(alpha: .06)),
                FractionallySizedBox(
                  widthFactor: ratio,
                  child: Container(color: AdminColors.goldBright),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$used/$limit',
          style: AppFonts.jetBrainsMono(
            fontSize: 10,
            color: AdminColors.muted,
          ),
        ),
      ],
    );
  }
}

/// Maps a name to one of the six gradient backgrounds used in the reference.
const List<LinearGradient> kUserGradients = [
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x80FF9466), Color(0x593D7CFF), Color(0xFF06070B)],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x8C3D7CFF), Color(0x14FFFFFF), Color(0xFF06070B)],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x80FF9466), Color(0x668B7BFF), Color(0xFF06070B)],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x808B7BFF), Color(0x593D7CFF), Color(0xFF06070B)],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x73FF9466), Color(0x4D8B7BFF), Color(0xFF06070B)],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x803D7CFF), Color(0x40FF9466), Color(0xFF06070B)],
  ),
];

LinearGradient _gradientFor(String seed) {
  if (seed.isEmpty) return kUserGradients[0];
  final hash = seed.codeUnits.fold<int>(0, (acc, c) => acc + c);
  return kUserGradients[hash % kUserGradients.length];
}

String _initialsOf(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return '?';
  final parts = trimmed.split(RegExp(r'\s+'));
  if (parts.length == 1) return parts.first.characters.first.toUpperCase();
  return (parts.first.characters.first + parts.last.characters.first)
      .toUpperCase();
}

/// Avatar circle used by roster / generation tables.
class _GradientAvatar extends StatelessWidget {
  final String seed;
  final double size;
  const _GradientAvatar({
    required this.seed,
    // ignore: unused_element_parameter
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size * .28),
      gradient: _gradientFor(seed),
    ),
    alignment: Alignment.center,
    child: Text(
      _initialsOf(seed),
      style: AppFonts.spaceGrotesk(
        fontSize: size * .38,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}

/// Avatar + name/email stack used in tables.
class _UserCellRow extends StatelessWidget {
  final String name;
  final String email;
  const _UserCellRow({
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      _GradientAvatar(seed: email),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name.isEmpty ? email : name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AdminColors.mist,
                height: 1.25,
              ),
            ),
            Text(
              email,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.jetBrainsMono(
                fontSize: 10.5,
                color: AdminColors.muted,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


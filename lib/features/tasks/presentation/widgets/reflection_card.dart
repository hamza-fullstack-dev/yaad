import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_radius.dart';

class ReflectionCard extends StatelessWidget {
  final VoidCallback? onTap;

  const ReflectionCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      // .reflect-card: white, 18px radius, border, shadow-sm
      // ::before top gradient line: pink → clay
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: AppShadows.sm,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top gradient line (pink → clay) ─────────────────
          Container(
            height: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.pink, AppColors.clay],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top row: icon + label ──────────────────────
                Row(
                  children: [
                    // .reflect-icon: pink-mist bg, 32x32, 10px radius
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.pinkMist,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomPaint(
                          size: const Size(16, 16),
                          painter: _PenIconPainter(),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // .reflect-label: 13px, weight 600, ink
                        Text(
                          'Aaj ki yaad',
                          style: AppTypography.body(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.ink,
                          ).copyWith(letterSpacing: -0.1),
                        ),
                        const SizedBox(height: 1),
                        // .reflect-sub: 11px, ink-4
                        Text(
                          '2 minute lagein gay',
                          style: AppTypography.body(
                            fontSize: 11,
                            color: AppColors.ink4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ── Italic serif prompt ────────────────────────
                // .reflect-prompt: DM Serif italic, 17px, ink-2
                Text(
                  '"Aaj kis cheez ne sukoon diya?"',
                  style: AppTypography.displayItalic(
                    fontSize: 17,
                    color: AppColors.ink2,
                  ).copyWith(height: 1.45),
                ),

                const SizedBox(height: 14),

                // ── Likho button ───────────────────────────────
                // .reflect-btn: pink, pill, 13px 600
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(
                      color: AppColors.pink,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40D4537E),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomPaint(
                          size: const Size(14, 14),
                          painter: _ArrowIconPainter(),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Likho',
                          style: AppTypography.body(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ).copyWith(letterSpacing: 0.1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pen icon painter ─────────────────────────────────────────────
class _PenIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Pen body path
    final path = Path()
      ..moveTo(2, 14)
      ..lineTo(5, 11)
      ..lineTo(12, 3)
      ..cubicTo(13, 2, 14.5, 2.5, 14, 4)
      ..lineTo(7, 11)
      ..lineTo(4, 14)
      ..close();
    canvas.drawPath(path, paint);

    // Detail line on pen
    canvas.drawLine(
      const Offset(9, 5),
      const Offset(11, 7),
      paint,
    );
  }

  @override
  bool shouldRepaint(_PenIconPainter oldDelegate) => false;
}

// ── Arrow icon painter ───────────────────────────────────────────
class _ArrowIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(const Offset(2, 7), const Offset(12, 7), paint);
    final path = Path()
      ..moveTo(8, 3)
      ..lineTo(12, 7)
      ..lineTo(8, 11);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowIconPainter oldDelegate) => false;
}

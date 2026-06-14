import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class GreetingHeader extends StatelessWidget {
  final String greeting;
  final String namePrefix;
  final String name;
  final String initial;

  const GreetingHeader({
    super.key,
    this.greeting = 'Subah bakhair',
    this.namePrefix = 'Salaam, ',
    this.name = 'Hira',
    this.initial = 'H',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Greeting sub — "Subah bakhair" + sparkle ──────
            Row(
              children: [
                Text(
                  greeting,
                  style: AppTypography.body(
                    fontSize: 13,
                    color: AppColors.ink3,
                  ).copyWith(letterSpacing: 0.1),
                ),
                const SizedBox(width: 6),
                // Sparkle cross icon
                CustomPaint(
                  size: const Size(10, 10),
                  painter: _SparklePainter(),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // ── Greeting name — "Salaam, Hira." ───────────────
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: namePrefix,
                    style: AppTypography.display(
                      fontSize: 32,
                      color: AppColors.ink,
                    ).copyWith(letterSpacing: -0.5, height: 1.1),
                  ),
                  TextSpan(
                    text: '$name.',
                    style: AppTypography.displayItalic(
                      fontSize: 32,
                      color: AppColors.pink,
                    ).copyWith(letterSpacing: -0.5, height: 1.1),
                  ),
                ],
              ),
            ),
          ],
        ),

        // ── Avatar ────────────────────────────────────────────
        // gradient circle with initial
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.pinkSoft, AppColors.pink],
            ),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x38D4537E),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initial,
              style: AppTypography.body(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ).copyWith(letterSpacing: -0.2),
            ),
          ),
        ),
      ],
    );
  }
}

class _SparklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    // vertical line
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    // horizontal line
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(_SparklePainter oldDelegate) => false;
}

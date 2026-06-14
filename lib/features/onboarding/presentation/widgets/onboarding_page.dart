import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_shadows.dart';

class OnboardingPage extends StatelessWidget {
  final String step;
  final String title;
  final String titleItalic;
  final String titleAfter;
  final String desc;
  final String btnLabel;
  final Widget hero;
  final int currentIndex;
  final int totalPages;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPage({
    super.key,
    required this.step,
    required this.title,
    required this.titleItalic,
    required this.titleAfter,
    required this.desc,
    required this.btnLabel,
    required this.hero,
    required this.currentIndex,
    required this.totalPages,
    required this.isLast,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 70, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: step + skip ─────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                step,
                style: AppTypography.mono(
                  fontSize: 11,
                  color: AppColors.ink4,
                ).copyWith(letterSpacing: 2),
              ),
              if (!isLast)
                GestureDetector(
                  onTap: onSkip,
                  child: Text(
                    'Skip',
                    style: AppTypography.body(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink3,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 32),

          // ── Hero illustration ────────────────────────────────
          Expanded(
            child: Center(child: hero),
          ),

          const SizedBox(height: 32),

          // ── Title with italic pink word ──────────────────────
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: AppTypography.display(
                    fontSize: 36,
                    color: AppColors.ink,
                  ).copyWith(letterSpacing: -0.8, height: 1.1),
                ),
                TextSpan(
                  text: titleItalic,
                  style: AppTypography.displayItalic(
                    fontSize: 36,
                    color: AppColors.pink,
                  ).copyWith(letterSpacing: -0.8, height: 1.1),
                ),
                if (titleAfter.isNotEmpty)
                  TextSpan(
                    text: titleAfter,
                    style: AppTypography.display(
                      fontSize: 36,
                      color: AppColors.ink,
                    ).copyWith(letterSpacing: -0.8, height: 1.1),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Description ──────────────────────────────────────
          Text(
            desc,
            style: AppTypography.body(
              fontSize: 15,
              color: AppColors.ink3,
            ).copyWith(height: 1.6),
          ),

          const SizedBox(height: 32),

          // ── Progress dots ────────────────────────────────────
          Row(
            children: List.generate(totalPages, (i) {
              final isActive = i == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(right: 6),
                width: isActive ? 24 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.pink : AppColors.ink5,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }),
          ),

          const SizedBox(height: 20),

          // ── Button ───────────────────────────────────────────
          GestureDetector(
            onTap: onNext,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(100),
                boxShadow: AppShadows.pink,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    btnLabel,
                    style: AppTypography.body(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ).copyWith(letterSpacing: 0.1),
                  ),
                  if (!isLast) ...[
                    const SizedBox(width: 8),
                    const _ArrowIcon(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(14, 14),
      painter: _ArrowPainter(),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
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
  bool shouldRepaint(_ArrowPainter oldDelegate) => false;
}

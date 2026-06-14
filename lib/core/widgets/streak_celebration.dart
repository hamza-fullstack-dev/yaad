import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class StreakCelebration {
  StreakCelebration._();

  static final _milestones = {
    AppConstants.streakMilestone1,
    AppConstants.streakMilestone2,
    AppConstants.streakMilestone3,
  };

  static bool isMilestone(int streak) => _milestones.contains(streak);

  static void show(BuildContext context, int streak) {
    if (!isMilestone(streak)) return;

    HapticFeedback.heavyImpact();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Streak celebration',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, anim, _, child) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: anim,
              curve: Curves.elasticOut,
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 280,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const RadialGradient(
                  center: Alignment(0, -0.4),
                  radius: 1.2,
                  colors: [
                    Color(0xFFE8729A),
                    AppColors.pink,
                    AppColors.pinkDeep,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x44D4537E),
                    blurRadius: 40,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SparkleIcon(),
                  const SizedBox(height: 20),
                  Text(
                    '$streak',
                    style: AppTypography.displayItalic(
                      fontSize: 64,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'din ka silsila!',
                    style: AppTypography.displayItalic(
                      fontSize: 20,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    streak == 7
                        ? 'Ek hafta — zabardast!'
                        : streak == 30
                            ? 'Ek maheena — kya baat!'
                            : 'Sau din — legend ho tum!',
                    style: AppTypography.body(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'Shukriya!',
                        style: AppTypography.body(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SparkleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(40, 40),
      painter: _SparklePainter(),
    );
  }
}

class _SparklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    final path = Path()
      ..moveTo(cx, 0)
      ..quadraticBezierTo(cx + 3, cy - 3, size.width, cy)
      ..quadraticBezierTo(cx + 3, cy + 3, cx, size.height)
      ..quadraticBezierTo(cx - 3, cy + 3, 0, cy)
      ..quadraticBezierTo(cx - 3, cy - 3, cx, 0)
      ..close();
    canvas.drawPath(path, paint);

    final smallPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx + 12, cy - 12), 2.5, smallPaint);
    canvas.drawCircle(Offset(cx - 10, cy + 10), 2, smallPaint);
    canvas.drawCircle(Offset(cx + 14, cy + 8), 1.5, smallPaint);
  }

  @override
  bool shouldRepaint(_SparklePainter old) => false;
}

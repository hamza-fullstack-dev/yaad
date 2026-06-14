import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class YaadErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const YaadErrorState({
    super.key,
    this.message = 'Kuch ghalat hua',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              size: const Size(44, 44),
              painter: _ErrorIconPainter(),
            ),
            const SizedBox(height: 16),
            Text(
              'Kuch ghalat hua',
              style: AppTypography.display(
                fontSize: 20,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.body(
                fontSize: 14,
                color: AppColors.ink3,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Dobara try karein',
                    style: AppTypography.body(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2 - 2;

    final circlePaint = Paint()
      ..color = AppColors.coralBg
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), r, circlePaint);

    final strokePaint = Paint()
      ..color = AppColors.coral
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(cx, cy), r, strokePaint);

    final xPaint = Paint()
      ..color = AppColors.coral
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    final inset = r * 0.4;
    canvas.drawLine(
        Offset(cx - inset, cy - inset), Offset(cx + inset, cy + inset), xPaint);
    canvas.drawLine(
        Offset(cx + inset, cy - inset), Offset(cx - inset, cy + inset), xPaint);
  }

  @override
  bool shouldRepaint(_ErrorIconPainter old) => false;
}

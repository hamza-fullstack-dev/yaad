import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SettingsRow extends StatelessWidget {
  final Color iconBg;
  final Color iconColor;
  final CustomPainter iconPainter;
  final String label;
  final String? value;
  final VoidCallback? onTap;

  const SettingsRow({
    super.key,
    required this.iconBg,
    required this.iconColor,
    required this.iconPainter,
    required this.label,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: Colors.transparent,
        child: Row(
          children: [
            // .settings-icon: 34x34, colored bg, 10px radius
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomPaint(
                  size: const Size(16, 16),
                  painter: iconPainter,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // .settings-name: 14px weight 500 ink
            Expanded(
              child: Text(
                label,
                style: AppTypography.body(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.1),
              ),
            ),

            // Optional value text
            if (value != null) ...[
              Text(
                value!,
                style: AppTypography.body(
                  fontSize: 13,
                  color: AppColors.ink4,
                ),
              ),
              const SizedBox(width: 6),
            ],

            // Chevron
            CustomPaint(
              size: const Size(14, 14),
              painter: _ChevronPainter(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink4
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(5, 3)
      ..lineTo(9, 7)
      ..lineTo(5, 11);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChevronPainter old) => false;
}

// ── Icon painters for each settings row ─────────────────────────

class AccountIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(const Offset(8, 6), 2.5, p);
    final path = Path()
      ..moveTo(3, 14)
      ..quadraticBezierTo(3, 9.5, 8, 9.5)
      ..quadraticBezierTo(13, 9.5, 13, 14);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(AccountIconPainter old) => false;
}

class NotifIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.coral
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(8, 2)
      ..cubicTo(10, 4, 12, 6, 12, 9)
      ..cubicTo(12, 11, 10, 13, 8, 13)
      ..cubicTo(6, 13, 4, 11, 4, 9)
      ..cubicTo(4, 6, 6, 4, 8, 2)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(NotifIconPainter old) => false;
}

class LockIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.sage
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          const Rect.fromLTWH(3, 5, 10, 8), const Radius.circular(1.2)),
      p,
    );
    final path = Path()
      ..moveTo(5, 5)
      ..lineTo(5, 3.5)
      ..quadraticBezierTo(5, 1, 8, 1)
      ..quadraticBezierTo(11, 1, 11, 3.5)
      ..lineTo(11, 5);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(LockIconPainter old) => false;
}

class LanguageIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.clay
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(const Offset(8, 8), 6, p);
    canvas.drawLine(const Offset(2, 8), const Offset(14, 8), p);
    final path = Path()
      ..moveTo(8, 2)
      ..cubicTo(10, 4, 11, 6, 11, 8)
      ..cubicTo(11, 10, 10, 12, 8, 14)
      ..cubicTo(6, 12, 5, 10, 5, 8)
      ..cubicTo(5, 6, 6, 4, 8, 2);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(LanguageIconPainter old) => false;
}

class AppearanceIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.dusk
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(const Offset(8, 8), 6, p);
    canvas.drawCircle(const Offset(8, 8), 3, p);
    canvas.drawCircle(const Offset(8, 8), 0.8, Paint()..color = AppColors.dusk);
  }

  @override
  bool shouldRepaint(AppearanceIconPainter old) => false;
}

class SharedListsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.dusk
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(const Offset(6, 5.5), 2, p);
    final path1 = Path()
      ..moveTo(2, 12)
      ..quadraticBezierTo(2, 8.5, 6, 8.5)
      ..quadraticBezierTo(10, 8.5, 10, 12);
    canvas.drawPath(path1, p);
    canvas.drawCircle(const Offset(11, 5.5), 1.6, p);
    final path2 = Path()
      ..moveTo(9, 12)
      ..quadraticBezierTo(9, 9, 11, 9)
      ..quadraticBezierTo(14, 9, 14, 12);
    canvas.drawPath(path2, p);
  }

  @override
  bool shouldRepaint(SharedListsIconPainter old) => false;
}

class AboutIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.ink2
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(8, 2)
      ..lineTo(9, 5)
      ..lineTo(12, 5)
      ..lineTo(9.5, 7)
      ..lineTo(10.5, 10)
      ..lineTo(8, 8.5)
      ..lineTo(5.5, 10)
      ..lineTo(6.5, 7)
      ..lineTo(4, 5)
      ..lineTo(7, 5)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(AboutIconPainter old) => false;
}

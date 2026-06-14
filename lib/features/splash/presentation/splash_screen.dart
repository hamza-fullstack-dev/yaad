import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/l10n/language_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _dotsController;
  late AnimationController _pulseController;

  late Animation<double> _fadeIn;
  late Animation<double> _slideUp;
  late Animation<double> _dot1;
  late Animation<double> _dot2;
  late Animation<double> _dot3;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    // Main fade + slide
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeIn = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _slideUp = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    // Dots staggered pulse
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _dot1 = Tween<double>(begin: 1.0, end: 0.3).animate(CurvedAnimation(
        parent: _dotsController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut)));
    _dot2 = Tween<double>(begin: 0.6, end: 1.0).animate(CurvedAnimation(
        parent: _dotsController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeInOut)));
    _dot3 = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(
        parent: _dotsController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeInOut)));

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      context.go(RouteNames.signIn);
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _dotsController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pink,
      body: Stack(
        children: [
          // ── Radial glow top-center ──────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.3),
                  radius: 0.9,
                  colors: [
                    Colors.white.withOpacity(0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Radial glow bottom-right ────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.6, 0.6),
                  radius: 0.6,
                  colors: [
                    Colors.white.withOpacity(0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Main center content ─────────────────────────────
          Center(
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) => Opacity(
                opacity: _fadeIn.value,
                child: Transform.translate(
                  offset: Offset(0, _slideUp.value),
                  child: child,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── White logo card with book icon ──────────
                  AnimatedBuilder(
                    animation: _pulse,
                    builder: (context, child) => Transform.scale(
                      scale: _pulse.value,
                      child: child,
                    ),
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x2E000000),
                            blurRadius: 40,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Center(
                        child: CustomPaint(
                          size: const Size(64, 64),
                          painter: _BookIconPainter(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Title: Y + italic "aa" + d ──────────────
                  // matches HTML: <div class="splash-title">Y<em>aa</em>d</div>
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Y',
                          style: AppTypography.display(
                            fontSize: 56,
                            color: Colors.white,
                          ).copyWith(letterSpacing: -2, height: 1),
                        ),
                        TextSpan(
                          text: 'aa',
                          style: AppTypography.displayItalic(
                            fontSize: 56,
                            color: Colors.white,
                          ).copyWith(letterSpacing: -2, height: 1),
                        ),
                        TextSpan(
                          text: 'd',
                          style: AppTypography.display(
                            fontSize: 56,
                            color: Colors.white,
                          ).copyWith(letterSpacing: -2, height: 1),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ── Tagline ─────────────────────────────────
                  Text(
                    ref.read(stringsProvider).splashTagline,
                    style: AppTypography.displayItalic(
                      fontSize: 17,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Loading dots — bottom of screen ────────────────
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _dotsController,
              builder: (context, _) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Dot(opacity: _dot1.value),
                  const SizedBox(width: 6),
                  _Dot(opacity: _dot2.value),
                  const SizedBox(width: 6),
                  _Dot(opacity: _dot3.value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dot widget ───────────────────────────────────────────────────
class _Dot extends StatelessWidget {
  final double opacity;
  const _Dot({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity.clamp(0.0, 1.0)),
        shape: BoxShape.circle,
      ),
    );
  }
}

// ── Book icon painter — exact match to HTML SVG ──────────────────
// viewBox: 0 0 200 200, drawn at 64×64
class _BookIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 200; // scale
    canvas.scale(s, s);

    // ── Left page ─────────────────────────────────────────────
    final leftPath = Path()
      ..moveTo(40, 60)
      ..lineTo(40, 148)
      ..quadraticBezierTo(40, 152, 44, 152)
      ..lineTo(94, 152)
      ..quadraticBezierTo(98, 148, 98, 142)
      ..lineTo(98, 50)
      ..quadraticBezierTo(98, 46, 94, 46)
      ..lineTo(44, 46)
      ..quadraticBezierTo(40, 46, 40, 50)
      ..close();
    canvas.drawPath(leftPath, Paint()..color = const Color(0xFFFDFCF9));

    // ── Right page ────────────────────────────────────────────
    final rightPath = Path()
      ..moveTo(102, 50)
      ..lineTo(102, 142)
      ..quadraticBezierTo(102, 148, 106, 152)
      ..lineTo(156, 152)
      ..quadraticBezierTo(160, 152, 160, 148)
      ..lineTo(160, 60)
      ..close();
    canvas.drawPath(rightPath, Paint()..color = Colors.white);

    // ── Lines on left page ────────────────────────────────────
    final lp = Paint()
      ..color = const Color(0xFFD4537E).withOpacity(0.4)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(52, 74), const Offset(86, 74), lp);
    canvas.drawLine(const Offset(52, 86), const Offset(86, 86), lp);
    canvas.drawLine(const Offset(52, 98), const Offset(78, 98), lp);

    // ── Spine divider ─────────────────────────────────────────
    canvas.drawLine(
      const Offset(100, 50),
      const Offset(100, 152),
      Paint()
        ..color = const Color(0xFFD4537E).withOpacity(0.25)
        ..strokeWidth = 1,
    );

    // ── Flower/tulip — 3 petals (translate 118, 88) ───────────
    canvas.save();
    canvas.translate(118, 88);

    void drawPetal(double tx, double ty, double angleDeg, double opacity) {
      canvas.save();
      canvas.translate(tx, ty);
      canvas.rotate(angleDeg * 3.14159265 / 180);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 10, height: 22),
        Paint()..color = const Color(0xFFD4537E).withOpacity(opacity),
      );
      canvas.restore();
    }

    drawPetal(0, 0, -30, 0.95);
    drawPetal(8, 4, 25, 0.80);
    drawPetal(-4, 10, 65, 0.65);

    // Center white dot
    canvas.drawCircle(
      const Offset(2, 3),
      2,
      Paint()..color = const Color(0xFFFDFCF9),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BookIconPainter oldDelegate) => false;
}

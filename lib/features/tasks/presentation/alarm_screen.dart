import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/services/notification_service.dart';

class AlarmScreen extends StatefulWidget {
  final String taskTitle;
  final int notificationId;
  final String timeUpLabel;
  final String snoozeLabel;
  final String dismissLabel;

  const AlarmScreen({
    super.key,
    required this.taskTitle,
    required this.notificationId,
    this.timeUpLabel = 'Waqt ho gaya!',
    this.snoozeLabel = '5 min baad',
    this.dismissLabel = 'Band karo',
  });

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;
  Timer? _autoCloseTimer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _autoCloseTimer = Timer(const Duration(minutes: 2), () {
      if (mounted) _dismiss();
    });
  }

  @override
  void dispose() {
    _autoCloseTimer?.cancel();
    _pulseController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _dismiss() {
    NotificationService().cancelAlarmById(widget.notificationId);
    if (mounted) Navigator.of(context).pop();
  }

  void _snooze() {
    NotificationService().snoozeAlarm(
      id: widget.notificationId,
      title: widget.taskTitle,
      minutes: 5,
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final timeStr =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1917),
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              AnimatedBuilder(
                animation: _pulseAnim,
                builder: (context, child) => Transform.scale(
                  scale: _pulseAnim.value,
                  child: child,
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.pink.withValues(alpha: 0.15),
                    border: Border.all(
                      color: AppColors.pink.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: _AlarmBellIcon(),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                timeStr,
                style: AppTypography.display(
                  fontSize: 56,
                  color: Colors.white,
                ).copyWith(letterSpacing: -2),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  widget.taskTitle,
                  style: AppTypography.body(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.pink,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.timeUpLabel,
                style: AppTypography.body(
                  fontSize: 15,
                  color: AppColors.ink4,
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          _snooze();
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.snoozeLabel,
                              style: AppTypography.body(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          _dismiss();
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.pink,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.pink.withValues(alpha: 0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              widget.dismissLabel,
                              style: AppTypography.body(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlarmBellIcon extends StatelessWidget {
  const _AlarmBellIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(40, 40),
      painter: _BellPainter(),
    );
  }
}

class _BellPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;

    final bellPath = Path()
      ..moveTo(cx - 12, cy + 4)
      ..quadraticBezierTo(cx - 12, cy - 8, cx - 6, cy - 10)
      ..quadraticBezierTo(cx, cy - 14, cx + 6, cy - 10)
      ..quadraticBezierTo(cx + 12, cy - 8, cx + 12, cy + 4)
      ..lineTo(cx + 14, cy + 8)
      ..lineTo(cx - 14, cy + 8)
      ..close();

    canvas.drawPath(bellPath, paint);

    canvas.drawLine(
      Offset(cx - 3, cy + 8),
      Offset(cx - 3, cy + 11),
      paint,
    );
    canvas.drawLine(
      Offset(cx + 3, cy + 8),
      Offset(cx + 3, cy + 11),
      paint,
    );
    final clapperPath = Path()
      ..moveTo(cx - 3, cy + 11)
      ..quadraticBezierTo(cx, cy + 14, cx + 3, cy + 11);
    canvas.drawPath(clapperPath, paint);

    canvas.drawLine(Offset(cx - 13, cy - 10), Offset(cx - 16, cy - 13), paint);
    canvas.drawLine(Offset(cx + 13, cy - 10), Offset(cx + 16, cy - 13), paint);
  }

  @override
  bool shouldRepaint(_BellPainter old) => false;
}

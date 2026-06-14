import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../auth/data/auth_providers.dart';
import '../../../core/l10n/language_provider.dart';

class DiaryLockScreen extends ConsumerStatefulWidget {
  const DiaryLockScreen({super.key});

  @override
  ConsumerState<DiaryLockScreen> createState() => _DiaryLockScreenState();
}

class _DiaryLockScreenState extends ConsumerState<DiaryLockScreen>
    with SingleTickerProviderStateMixin {
  String _pin = '';
  bool _hasError = false;
  int _attempts = 0;
  static const _maxAttempts = 5;

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onKey(String digit) {
    if (_attempts >= _maxAttempts) return;
    if (_pin.length < 6) {
      setState(() {
        _pin += digit;
        _hasError = false;
      });
      if (_pin.length == 6) _verify();
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  Future<void> _verify() async {
    final storage = ref.read(secureStorageServiceProvider);
    final uid = ref.read(currentUserProvider)?.uid ?? '';
    final correct = await storage.verifyPin(_pin, uid: uid);

    if (correct) {
      HapticFeedback.lightImpact();
      if (mounted) {
        ref.read(diaryUnlockedProvider.notifier).state = true;
        context.go(RouteNames.diary);
      }
    } else {
      _attempts++;
      HapticFeedback.heavyImpact();
      setState(() => _hasError = true);
      _shakeController.forward(from: 0);

      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        setState(() {
          _pin = '';
          _hasError = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locked = _attempts >= _maxAttempts;
    final s = ref.watch(stringsProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 60, 28, 40),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.pinkMist,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomPaint(painter: _BigLockPainter()),
              ),
              const SizedBox(height: 20),
              Text(
                s.lockTitle,
                style: AppTypography.display(
                  fontSize: 24,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.3),
              ),
              const SizedBox(height: 6),
              Text(
                locked ? s.lockTooMany : s.lockSubtitle,
                style: AppTypography.body(
                  fontSize: 14,
                  color: locked ? Colors.red : AppColors.ink3,
                ),
              ),
              const SizedBox(height: 40),
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  final dx = sin(_shakeAnimation.value * pi * 4) * 10;
                  return Transform.translate(
                    offset: Offset(dx, 0),
                    child: child,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) {
                    final filled = i < _pin.length;
                    return Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: filled
                            ? (_hasError ? Colors.red : AppColors.pink)
                            : Colors.transparent,
                        border: Border.all(
                          color: filled
                              ? (_hasError ? Colors.red : AppColors.pink)
                              : AppColors.ink5,
                          width: 1.5,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const Spacer(),
              IgnorePointer(
                ignoring: locked,
                child: Opacity(
                  opacity: locked ? 0.3 : 1,
                  child: Column(
                    children: [
                      _KeyRow(keys: ['1', '2', '3'], onKey: _onKey),
                      const SizedBox(height: 12),
                      _KeyRow(keys: ['4', '5', '6'], onKey: _onKey),
                      const SizedBox(height: 12),
                      _KeyRow(keys: ['7', '8', '9'], onKey: _onKey),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 80),
                          const SizedBox(width: 12),
                          _KeyBtn(label: '0', onTap: () => _onKey('0')),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 80,
                            height: 56,
                            child: GestureDetector(
                              onTap: _onDelete,
                              child: const Icon(
                                Icons.backspace_outlined,
                                color: AppColors.ink3,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyRow extends StatelessWidget {
  final List<String> keys;
  final Function(String) onKey;

  const _KeyRow({required this.keys, required this.onKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.asMap().entries.map((e) {
        return Padding(
          padding: EdgeInsets.only(left: e.key > 0 ? 12 : 0),
          child: _KeyBtn(label: e.value, onTap: () => onKey(e.value)),
        );
      }).toList(),
    );
  }
}

class _KeyBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _KeyBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.display(
              fontSize: 24,
              color: AppColors.ink,
            ).copyWith(letterSpacing: -0.5),
          ),
        ),
      ),
    );
  }
}

class _BigLockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 12, cy - 4, 24, 18),
        const Radius.circular(4),
      ),
      paint,
    );

    final shackle = Path()
      ..moveTo(cx - 8, cy - 4)
      ..lineTo(cx - 8, cy - 12)
      ..quadraticBezierTo(cx - 8, cy - 18, cx, cy - 18)
      ..quadraticBezierTo(cx + 8, cy - 18, cx + 8, cy - 12)
      ..lineTo(cx + 8, cy - 4);
    canvas.drawPath(shackle, paint);

    canvas.drawCircle(
      Offset(cx, cy + 5),
      3,
      Paint()..color = AppColors.pink,
    );
  }

  @override
  bool shouldRepaint(_BigLockPainter old) => false;
}

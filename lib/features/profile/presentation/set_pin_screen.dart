import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../auth/data/auth_providers.dart';
import '../../../core/l10n/language_provider.dart';

class SetPinScreen extends ConsumerStatefulWidget {
  const SetPinScreen({super.key});

  @override
  ConsumerState<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends ConsumerState<SetPinScreen>
    with SingleTickerProviderStateMixin {
  String _pin = '';
  String? _firstPin;
  bool _confirming = false;
  bool _hasError = false;

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
    if (_pin.length < 6) {
      setState(() {
        _pin += digit;
        _hasError = false;
      });
      if (_pin.length == 6) _onComplete();
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  Future<void> _onComplete() async {
    if (!_confirming) {
      setState(() {
        _firstPin = _pin;
        _pin = '';
        _confirming = true;
      });
      return;
    }

    if (_pin == _firstPin) {
      final storage = ref.read(secureStorageServiceProvider);
      final uid = ref.read(currentUserProvider)?.uid ?? '';
      await storage.setPin(_pin, uid: uid);
      HapticFeedback.mediumImpact();
      if (mounted) Navigator.of(context).pop(true);
    } else {
      HapticFeedback.heavyImpact();
      setState(() => _hasError = true);
      _shakeController.forward(from: 0);

      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        setState(() {
          _pin = '';
          _firstPin = null;
          _confirming = false;
          _hasError = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: const Icon(
                  Icons.pin_outlined,
                  color: AppColors.pink,
                  size: 28,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _confirming ? s.pinConfirmTitle : s.pinNewTitle,
                style: AppTypography.display(
                  fontSize: 24,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.3),
              ),
              const SizedBox(height: 6),
              Text(
                _confirming ? s.pinConfirmSubtitle : s.pinNewSubtitle,
                style: AppTypography.body(
                  fontSize: 14,
                  color: _hasError ? Colors.red : AppColors.ink3,
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
              Column(
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
              const SizedBox(height: AppSpacing.xl),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  s.cancel,
                  style: AppTypography.body(
                    fontSize: 13,
                    color: AppColors.ink3,
                  ),
                ),
              ),
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

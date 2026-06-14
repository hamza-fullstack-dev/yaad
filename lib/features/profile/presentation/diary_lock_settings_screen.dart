import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../features/auth/data/auth_providers.dart';
import 'widgets/toggle_row.dart';
import 'widgets/settings_row.dart';
import '../../../core/l10n/language_provider.dart';

class DiaryLockSettingsScreen extends ConsumerStatefulWidget {
  const DiaryLockSettingsScreen({super.key});

  @override
  ConsumerState<DiaryLockSettingsScreen> createState() =>
      _DiaryLockSettingsScreenState();
}

class _DiaryLockSettingsScreenState
    extends ConsumerState<DiaryLockSettingsScreen> {
  bool _lockEnabled = false;
  bool _hasPinSet = false;
  bool _loaded = false;

  String get _uid => ref.read(currentUserProvider)?.uid ?? '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final storage = ref.read(secureStorageServiceProvider);
    final uid = _uid;

    final lockEnabled = await storage.isLockEnabled(uid);
    final hasPinSet = await storage.hasPinSet(uid);

    if (mounted) {
      setState(() {
        _lockEnabled = lockEnabled;
        _hasPinSet = hasPinSet;
        _loaded = true;
      });
    }
  }

  Future<void> _onLockToggle(bool value) async {
    final storage = ref.read(secureStorageServiceProvider);
    final uid = _uid;

    if (value && !_hasPinSet) {
      final result = await context.push<bool>(RouteNames.setPin);
      if (result == true) {
        await storage.setLockEnabled(true, uid: uid);
        setState(() {
          _lockEnabled = true;
          _hasPinSet = true;
        });
      }
      return;
    }

    await storage.setLockEnabled(value, uid: uid);
    setState(() => _lockEnabled = value);
  }

  Future<void> _changePin() async {
    final result = await context.push<bool>(RouteNames.setPin);
    if (result == true && mounted) {
      setState(() => _hasPinSet = true);
    }
  }

  Future<void> _removePin() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          ref.read(stringsProvider).lockSettRemoveTitle,
          style: AppTypography.display(fontSize: 18, color: AppColors.ink),
        ),
        content: Text(
          ref.read(stringsProvider).lockSettRemoveBody,
          style: AppTypography.body(fontSize: 14, color: AppColors.ink3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              ref.read(stringsProvider).no,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.ink3,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              ref.read(stringsProvider).yes,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.pink,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(secureStorageServiceProvider).removePin(_uid);
      setState(() {
        _lockEnabled = false;
        _hasPinSet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        backgroundColor: AppColors.cream,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.pink),
        ),
      );
    }

    final s = ref.watch(stringsProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.xl,
            40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 16, color: AppColors.ink3),
                    const SizedBox(width: 4),
                    Text(
                      s.back,
                      style: AppTypography.body(
                        fontSize: 14,
                        color: AppColors.ink3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                s.lockSettTitle,
                style: AppTypography.displayItalic(
                  fontSize: 28,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.5),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  children: [
                    ToggleRow(
                      iconBg: AppColors.sageBg,
                      iconColor: AppColors.sage,
                      iconPainter: LockIconPainter(),
                      label: s.lockSettToggle,
                      value: _lockEnabled,
                      onChanged: _onLockToggle,
                    ),
                  ],
                ),
              ),
              if (_hasPinSet) ...[
                const SizedBox(height: AppSpacing.xl),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: Column(
                    children: [
                      SettingsRow(
                        iconBg: AppColors.pinkMist,
                        iconColor: AppColors.pink,
                        iconPainter: _PinIconPainter(),
                        label: s.lockSettChangePin,
                        onTap: _changePin,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 62),
                        height: 0.5,
                        color: AppColors.border,
                      ),
                      SettingsRow(
                        iconBg: AppColors.coralBg,
                        iconColor: AppColors.coral,
                        iconPainter: _TrashIconPainter(),
                        label: s.lockSettRemovePin,
                        onTap: _removePin,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PinIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        canvas.drawCircle(
          Offset(3.0 + j * 5, 3.0 + i * 5),
          1.5,
          p,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_PinIconPainter old) => false;
}

class _TrashIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.coral
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(2, 4), const Offset(14, 4), p);
    canvas.drawLine(const Offset(6, 2), const Offset(10, 2), p);

    final body = Path()
      ..moveTo(3, 4)
      ..lineTo(4, 14)
      ..lineTo(12, 14)
      ..lineTo(13, 4);
    canvas.drawPath(body, p);

    canvas.drawLine(const Offset(6.5, 7), const Offset(6.5, 11), p);
    canvas.drawLine(const Offset(9.5, 7), const Offset(9.5, 11), p);
  }

  @override
  bool shouldRepaint(_TrashIconPainter old) => false;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import 'widgets/toggle_row.dart';
import 'widgets/settings_row.dart';
import '../../../core/l10n/language_provider.dart';
import '../../../core/l10n/app_strings.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  bool _taskReminders = true;
  bool _streakAlerts = true;
  int _defaultMinutes = 10;
  String _quietHours = 'off';
  bool _loaded = false;

  String get _uid => ref.read(currentUserProvider)?.uid ?? '';
  String _userKey(String key) => '${key}_$_uid';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _taskReminders =
          prefs.getBool(_userKey(AppConstants.notifEnabledKey)) ?? true;
      _streakAlerts = prefs.getBool(_userKey('notif_streak_alerts')) ?? true;
      _defaultMinutes =
          prefs.getInt(_userKey(AppConstants.notifDefaultMinutesKey)) ?? 10;
      _quietHours = prefs.getString(_userKey('notif_quiet_hours')) ?? 'off';
      _loaded = true;
    });
  }

  Future<void> _setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userKey(key), value);
  }

  Future<void> _setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userKey(key), value);
  }

  Future<void> _setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey(key), value);
  }

  String _defaultReminderLabel(AppStrings s) {
    switch (_defaultMinutes) {
      case 0:
        return s.atTime;
      case 5:
        return '5 ${s.minBefore}';
      case 10:
        return '10 ${s.minBefore}';
      case 30:
        return '30 ${s.minBefore}';
      case 60:
        return '1 ${s.hourBefore}';
      default:
        return '$_defaultMinutes min';
    }
  }

  String _quietHoursLabel(AppStrings s) {
    switch (_quietHours) {
      case '10pm-7am':
        return '10 PM – 7 AM';
      case '11pm-8am':
        return '11 PM – 8 AM';
      default:
        return s.notifOff;
    }
  }

  void _showDefaultReminderSheet() {
    final s = ref.read(stringsProvider);
    final options = [
      (0, s.atTime),
      (5, '5 ${s.minBefore}'),
      (10, '10 ${s.minBefore}'),
      (30, '30 ${s.minBefore}'),
      (60, '1 ${s.hourBefore}'),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.ink5,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            ...options.map((opt) => ListTile(
                  title: Text(
                    opt.$2,
                    style: AppTypography.body(
                      fontSize: 15,
                      color: _defaultMinutes == opt.$1
                          ? AppColors.pink
                          : AppColors.ink,
                      fontWeight: _defaultMinutes == opt.$1
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  trailing: _defaultMinutes == opt.$1
                      ? const Icon(Icons.check_rounded,
                          color: AppColors.pink, size: 20)
                      : null,
                  onTap: () {
                    setState(() => _defaultMinutes = opt.$1);
                    _setInt(AppConstants.notifDefaultMinutesKey, opt.$1);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showQuietHoursSheet() {
    final s = ref.read(stringsProvider);
    final options = [
      ('off', s.notifOff),
      ('10pm-7am', '10 PM – 7 AM'),
      ('11pm-8am', '11 PM – 8 AM'),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.ink5,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            ...options.map((opt) => ListTile(
                  title: Text(
                    opt.$2,
                    style: AppTypography.body(
                      fontSize: 15,
                      color: _quietHours == opt.$1
                          ? AppColors.pink
                          : AppColors.ink,
                      fontWeight: _quietHours == opt.$1
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  trailing: _quietHours == opt.$1
                      ? const Icon(Icons.check_rounded,
                          color: AppColors.pink, size: 20)
                      : null,
                  onTap: () {
                    setState(() => _quietHours = opt.$1);
                    _setString('notif_quiet_hours', opt.$1);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
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
                s.notifTitle,
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
                      iconBg: AppColors.coralBg,
                      iconColor: AppColors.coral,
                      iconPainter: NotifIconPainter(),
                      label: s.notifTaskReminders,
                      value: _taskReminders,
                      onChanged: (v) {
                        setState(() => _taskReminders = v);
                        _setBool(AppConstants.notifEnabledKey, v);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 62),
                      height: 0.5,
                      color: AppColors.border,
                    ),
                    ToggleRow(
                      iconBg: AppColors.pinkMist,
                      iconColor: AppColors.pink,
                      iconPainter: _StreakIconPainter(),
                      label: s.notifStreakAlerts,
                      value: _streakAlerts,
                      onChanged: (v) {
                        setState(() => _streakAlerts = v);
                        _setBool('notif_streak_alerts', v);
                      },
                    ),
                  ],
                ),
              ),
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
                      iconBg: AppColors.sageBg,
                      iconColor: AppColors.sage,
                      iconPainter: _ClockIconPainter(),
                      label: s.notifDefaultReminder,
                      value: _defaultReminderLabel(s),
                      onTap: _showDefaultReminderSheet,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 62),
                      height: 0.5,
                      color: AppColors.border,
                    ),
                    SettingsRow(
                      iconBg: AppColors.duskBg,
                      iconColor: AppColors.dusk,
                      iconPainter: _MoonIconPainter(),
                      label: s.notifQuietHours,
                      value: _quietHoursLabel(s),
                      onTap: _showQuietHoursSheet,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreakIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(8, 2)
      ..cubicTo(8, 6, 12, 7, 10, 11)
      ..cubicTo(9, 13, 5, 13, 4, 11)
      ..cubicTo(2, 8, 5, 4, 8, 2)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(_StreakIconPainter old) => false;
}

class _ClockIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.sage
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(const Offset(8, 8), 6, p);
    canvas.drawLine(const Offset(8, 5), const Offset(8, 8), p);
    canvas.drawLine(const Offset(8, 8), const Offset(10.5, 10), p);
  }

  @override
  bool shouldRepaint(_ClockIconPainter old) => false;
}

class _MoonIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.dusk
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(12, 3)
      ..cubicTo(8, 3, 4, 6, 4, 9)
      ..cubicTo(4, 13, 8, 15, 12, 13)
      ..cubicTo(9, 14, 6, 11, 6, 8)
      ..cubicTo(6, 5, 9, 3, 12, 3)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(_MoonIconPainter old) => false;
}

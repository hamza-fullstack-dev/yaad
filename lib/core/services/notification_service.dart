import 'dart:developer' as dev;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../../features/tasks/domain/task_model.dart';
import '../../features/tasks/domain/task_category.dart';
import '../l10n/app_strings.dart';

part 'notification_service.g.dart';

@pragma('vm:entry-point')
void _onBackgroundNotificationAction(NotificationResponse response) {
  NotificationService._handleAction(response);
}

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService._instance;
}

class NotificationService {
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void Function(String taskTitle, int notificationId)? onAlarmTap;

  Future<void> init() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Karachi'));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse:
          _onBackgroundNotificationAction,
    );

    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
      await androidPlugin.requestExactAlarmsPermission();

      const reminderChannel = AndroidNotificationChannel(
        'task_reminders',
        'Task Reminders',
        description: 'Reminders for your tasks',
        importance: Importance.high,
      );
      await androidPlugin.createNotificationChannel(reminderChannel);

      const alarmChannel = AndroidNotificationChannel(
        'task_alarms',
        'Task Alarms',
        description: 'Full-screen alarms for important tasks',
        importance: Importance.max,
        enableVibration: true,
        playSound: true,
      );
      await androidPlugin.createNotificationChannel(alarmChannel);
    }

    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp == true) {
      final response = launchDetails!.notificationResponse;
      if (response != null) {
        _onNotificationTap(response);
      }
    }

    _initialized = true;
    dev.log('NotificationService: initialized successfully');
  }

  static void _onNotificationTap(NotificationResponse response) {
    _handleAction(response);
  }

  static void _handleAction(NotificationResponse response) {
    final payload = response.payload;
    final actionId = response.actionId;
    final notifId = response.id ?? 0;

    if (actionId == 'dismiss') {
      _instance._plugin.cancel(notifId);
      dev.log('Alarm dismissed: id=$notifId');
      return;
    }

    if (actionId == 'snooze') {
      _instance._plugin.cancel(notifId);
      final title = _extractTitle(payload);
      _instance.snoozeAlarm(id: notifId, title: title);
      dev.log('Alarm snoozed from button: id=$notifId');
      return;
    }

    if (payload != null && payload.startsWith('alarm:')) {
      final parts = payload.split(':');
      if (parts.length >= 3) {
        final id = int.tryParse(parts[1]) ?? 0;
        final taskTitle = parts.sublist(2).join(':');
        if (onAlarmTap != null) {
          onAlarmTap!(taskTitle, id);
        }
      }
    }
  }

  static String _extractTitle(String? payload) {
    if (payload == null) return 'Task';
    if (payload.startsWith('alarm:')) {
      final parts = payload.split(':');
      if (parts.length >= 3) return parts.sublist(2).join(':');
    }
    return 'Task';
  }

  Future<void> showInstant({
    required String title,
    required String body,
    int id = 0,
  }) async {
    if (!_initialized) {
      dev.log('NotificationService: showInstant called before init()');
      return;
    }
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleTaskReminder(Task task,
      {int remindBeforeMinutes = 10,
      AppStrings strings = AppStrings.ur}) async {
    if (!_initialized) {
      dev.log('NotificationService: scheduleTaskReminder called before init()');
      return;
    }
    if (task.dueTimeMinutes == null) return;
    if (task.isCompleted) return;

    final hour = task.dueTimeMinutes! ~/ 60;
    final minute = task.dueTimeMinutes! % 60;

    final dueDate = tz.TZDateTime(
      tz.local,
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
      hour,
      minute,
    );

    final now = tz.TZDateTime.now(tz.local);
    final id = task.id.hashCode.abs() % 100000;

    final reminderDate =
        dueDate.subtract(Duration(minutes: remindBeforeMinutes));

    if (reminderDate.isAfter(now)) {
      await _scheduleOne(
        id: id,
        title: task.title,
        body: _bodyForCategory(task.category, strings),
        dateTime: reminderDate,
      );
    }

    if (dueDate.isAfter(now)) {
      if (task.isAlarm) {
        await _scheduleAlarm(
          id: id + 1,
          title: task.title,
          body: strings.notifDue,
          dateTime: dueDate,
          strings: strings,
        );
      } else {
        await _scheduleOne(
          id: id + 1,
          title: task.title,
          body: strings.notifDue,
          dateTime: dueDate,
          maxImportance: true,
        );
      }
    }

    final overdueDate = dueDate.add(const Duration(minutes: 15));
    if (overdueDate.isAfter(now)) {
      await _scheduleOne(
        id: id + 2,
        title: task.title,
        body: strings.notifOverdue,
        dateTime: overdueDate,
        ongoing: true,
      );
    }
  }

  Future<void> _scheduleAlarm({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime dateTime,
    AppStrings strings = AppStrings.ur,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        dateTime,
        AndroidNotificationDetails(
          'task_alarms',
          'Task Alarms',
          importance: Importance.max,
          priority: Priority.max,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.alarm,
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList(
            [0, 500, 200, 500, 200, 500, 200, 500],
          ),
          ongoing: true,
          autoCancel: false,
          visibility: NotificationVisibility.public,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction(
              'dismiss',
              strings.notifActionDismiss,
              cancelNotification: true,
            ),
            AndroidNotificationAction(
              'snooze',
              strings.notifActionSnooze,
            ),
          ],
        ).toNotificationDetails(),
        payload: 'alarm:$id:$title',
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      dev.log('Alarm scheduled: id=$id at $dateTime for "$title"');
    } catch (e) {
      dev.log('Alarm scheduling failed: $e, falling back to regular notif');
      await _scheduleOne(
        id: id,
        title: title,
        body: body,
        dateTime: dateTime,
        maxImportance: true,
      );
    }
  }

  Future<void> _scheduleOne({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime dateTime,
    bool maxImportance = false,
    bool ongoing = false,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        dateTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'task_reminders',
            'Task Reminders',
            importance: maxImportance ? Importance.max : Importance.high,
            priority: maxImportance ? Priority.max : Priority.high,
            ongoing: ongoing,
            autoCancel: !ongoing,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      dev.log('Notification scheduled: id=$id at $dateTime for "$title"');
    } catch (e) {
      dev.log('Notification scheduling failed: $e');
      try {
        await _plugin.zonedSchedule(
          id,
          title,
          body,
          dateTime,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'task_reminders',
              'Task Reminders',
              importance: maxImportance ? Importance.max : Importance.high,
              priority: maxImportance ? Priority.max : Priority.high,
            ),
            iOS: const DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
        dev.log('Notification scheduled (inexact fallback): id=$id');
      } catch (e2) {
        dev.log('Notification scheduling failed completely: $e2');
      }
    }
  }

  Future<void> snoozeAlarm({
    required int id,
    required String title,
    int minutes = 5,
    AppStrings strings = AppStrings.ur,
  }) async {
    await _plugin.cancel(id);
    final snoozeTime =
        tz.TZDateTime.now(tz.local).add(Duration(minutes: minutes));
    await _scheduleAlarm(
      id: id,
      title: title,
      body: strings.notifSnoozeDone,
      dateTime: snoozeTime,
      strings: strings,
    );
    dev.log('Alarm snoozed: id=$id for $minutes minutes');
  }

  Future<void> cancelAlarmById(int id) async {
    await _plugin.cancel(id);
  }

  Future<void> cancelTaskReminder(String taskId) async {
    final id = taskId.hashCode.abs() % 100000;
    await _plugin.cancel(id);
    await _plugin.cancel(id + 1);
    await _plugin.cancel(id + 2);
  }

  Future<void> cancelAllReminders() async {
    await _plugin.cancelAll();
  }

  Future<void> rescheduleAllReminders(List<Task> tasks,
      {AppStrings strings = AppStrings.ur}) async {
    await cancelAllReminders();
    for (final task in tasks) {
      if (!task.isCompleted && task.dueTimeMinutes != null) {
        await scheduleTaskReminder(task, strings: strings);
      }
    }
  }

  String _bodyForCategory(TaskCategory category, AppStrings s) {
    switch (category) {
      case TaskCategory.self_:
        return s.notifCatSelf;
      case TaskCategory.work:
        return s.notifCatWork;
      case TaskCategory.family:
        return s.notifCatFamily;
      case TaskCategory.deen:
        return s.notifCatDeen;
      case TaskCategory.home:
        return s.notifCatHome;
    }
  }
}

extension _AndroidToFull on AndroidNotificationDetails {
  NotificationDetails toNotificationDetails() {
    return NotificationDetails(
      android: this,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    );
  }
}

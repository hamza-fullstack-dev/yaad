import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/notification_service.dart';
import '../../../shared/database/app_database.dart';
import '../domain/task_model.dart' as domain;
import '../domain/task_category.dart';
import '../domain/task_priority.dart';
import '../domain/task_recurrence.dart';
import 'local/tasks_dao.dart';
import 'task_sync_service.dart';
import '../../../core/l10n/app_strings.dart';

class TaskRepository {
  final TasksDao _dao;
  final NotificationService _notificationService;
  TaskSyncService? _syncService;
  AppStrings _strings;
  static const _uuid = Uuid();

  TaskRepository(this._dao, this._notificationService,
      [this._strings = AppStrings.ur]);

  void setStrings(AppStrings strings) => _strings = strings;

  void setSyncService(TaskSyncService? syncService) {
    _syncService = syncService;
  }

  Stream<List<domain.Task>> watchTodayTasks() {
    return _dao.watchTodayTasks().map(
          (rows) => rows.map(_fromRow).toList(),
        );
  }

  Stream<List<domain.Task>> watchAllTasks() {
    return _dao.watchAllTasks().map(
          (rows) => rows.map(_fromRow).toList(),
        );
  }

  Stream<List<domain.Task>> watchTasksByDate(DateTime date) {
    return _dao.watchTasksByDate(date).map(
          (rows) => rows.map(_fromRow).toList(),
        );
  }

  Stream<int> watchStreak() {
    return _dao.watchAllTasks().map((tasks) {
      final completedDates = <DateTime>{};
      for (final task in tasks) {
        if (task.isCompleted) {
          final d = task.dueDate;
          completedDates.add(DateTime(d.year, d.month, d.day));
        }
      }

      final today = DateTime.now();
      var current = DateTime(today.year, today.month, today.day);
      int streak = 0;

      if (!completedDates.contains(current)) {
        current = current.subtract(const Duration(days: 1));
        if (!completedDates.contains(current)) return 0;
      }

      while (completedDates.contains(current)) {
        streak++;
        current = current.subtract(const Duration(days: 1));
      }

      return streak;
    });
  }

  Stream<List<domain.Task>> watchByCategory(TaskCategory category) {
    return _dao.watchByCategory(category.index).map(
          (rows) => rows.map(_fromRow).toList(),
        );
  }

  Future<void> createTask(domain.Task task) async {
    final id = task.id.isEmpty ? _uuid.v4() : task.id;
    final taskWithId = task.copyWith(id: id);

    await _dao.insertTask(TasksCompanion.insert(
      id: id,
      title: task.title,
      notes: Value(task.notes),
      category: task.category.index,
      dueDate: task.dueDate,
      dueTimeMinutes: Value(task.dueTimeMinutes),
      priority: Value(task.priority.index),
      recurrence: Value(task.recurrence.index),
      isAlarm: Value(task.isAlarm),
      isCompleted: Value(task.isCompleted),
      completedAt: Value(task.completedAt),
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
    ));

    if (taskWithId.dueTimeMinutes != null) {
      await _notificationService.showInstant(
        title: _strings.notifSet,
        body: '${taskWithId.title} ${_strings.notifSetBody}',
        id: 99999,
      );
      await _notificationService.scheduleTaskReminder(taskWithId,
          strings: _strings);
    }
    _syncService?.pushTask(taskWithId);
  }

  Future<void> updateTask(domain.Task task) async {
    await _dao.updateTask(TasksCompanion(
      id: Value(task.id),
      title: Value(task.title),
      notes: Value(task.notes),
      category: Value(task.category.index),
      dueDate: Value(task.dueDate),
      dueTimeMinutes: Value(task.dueTimeMinutes),
      priority: Value(task.priority.index),
      recurrence: Value(task.recurrence.index),
      isAlarm: Value(task.isAlarm),
      isCompleted: Value(task.isCompleted),
      completedAt: Value(task.completedAt),
      updatedAt: Value(DateTime.now()),
    ));

    await _notificationService.cancelTaskReminder(task.id);
    await _notificationService.scheduleTaskReminder(task, strings: _strings);
    _syncService?.pushTask(task);
  }

  Future<void> deleteTask(String id) async {
    await _notificationService.cancelTaskReminder(id);
    await _dao.deleteTask(id);
    _syncService?.removeTask(id);
  }

  Future<void> toggleComplete(String id) async {
    final row = await _dao.getById(id);
    if (row == null) return;

    await _dao.toggleComplete(id);

    final wasCompleted = row.isCompleted;
    if (!wasCompleted) {
      await _notificationService.cancelTaskReminder(id);
    } else {
      final task = _fromRow(row).copyWith(isCompleted: false);
      await _notificationService.scheduleTaskReminder(task, strings: _strings);
    }

    final updatedRow = await _dao.getById(id);
    if (updatedRow != null) {
      _syncService?.pushTask(_fromRow(updatedRow));
    }
  }

  Future<void> upsertTask(domain.Task task) async {
    final existing = await _dao.getById(task.id);
    if (existing != null) {
      await _dao.updateTask(TasksCompanion(
        id: Value(task.id),
        title: Value(task.title),
        notes: Value(task.notes),
        category: Value(task.category.index),
        dueDate: Value(task.dueDate),
        dueTimeMinutes: Value(task.dueTimeMinutes),
        priority: Value(task.priority.index),
        recurrence: Value(task.recurrence.index),
        isAlarm: Value(task.isAlarm),
        isCompleted: Value(task.isCompleted),
        completedAt: Value(task.completedAt),
        updatedAt: Value(task.updatedAt),
      ));
    } else {
      await _dao.insertTask(TasksCompanion.insert(
        id: task.id,
        title: task.title,
        notes: Value(task.notes),
        category: task.category.index,
        dueDate: task.dueDate,
        dueTimeMinutes: Value(task.dueTimeMinutes),
        priority: Value(task.priority.index),
        recurrence: Value(task.recurrence.index),
        isAlarm: Value(task.isAlarm),
        isCompleted: Value(task.isCompleted),
        completedAt: Value(task.completedAt),
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
      ));
    }
  }

  static domain.Task _fromRow(Task row) {
    return domain.Task(
      id: row.id,
      title: row.title,
      notes: row.notes,
      category: TaskCategory.values[row.category],
      dueDate: row.dueDate,
      dueTimeMinutes: row.dueTimeMinutes,
      priority: TaskPriority.values[row.priority],
      recurrence: TaskRecurrence.values[row.recurrence],
      isAlarm: row.isAlarm,
      isCompleted: row.isCompleted,
      completedAt: row.completedAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

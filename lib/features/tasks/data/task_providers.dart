import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/notification_service.dart';
import '../../../shared/database/app_database.dart' hide Task;
import '../../auth/data/auth_providers.dart';
import '../domain/task_model.dart';
import 'cloud/task_cloud_repository.dart';
import 'task_repository.dart';
import 'task_sync_service.dart';
import '../../../core/l10n/language_provider.dart';

part 'task_providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final notifService = ref.watch(notificationServiceProvider);
  final strings = ref.watch(stringsProvider);
  final repo = TaskRepository(db.tasksDao, notifService, strings);

  final user = ref.watch(currentUserProvider);
  final syncService = TaskSyncService(repo, TaskCloudRepository(), user?.uid);
  repo.setSyncService(syncService);

  return repo;
}

@Riverpod(keepAlive: true)
TaskSyncService taskSyncService(TaskSyncServiceRef ref) {
  final repo = ref.watch(taskRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  return TaskSyncService(repo, TaskCloudRepository(), user?.uid);
}

@riverpod
Stream<List<Task>> todayTasks(TodayTasksRef ref) {
  return ref.watch(taskRepositoryProvider).watchTodayTasks();
}

@riverpod
Stream<List<Task>> allTasks(AllTasksRef ref) {
  return ref.watch(taskRepositoryProvider).watchAllTasks();
}

@riverpod
Stream<List<Task>> tasksByDate(TasksByDateRef ref, DateTime date) {
  return ref.watch(taskRepositoryProvider).watchTasksByDate(date);
}

@riverpod
Stream<int> currentStreak(CurrentStreakRef ref) {
  return ref.watch(taskRepositoryProvider).watchStreak();
}

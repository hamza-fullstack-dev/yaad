import 'package:drift/drift.dart';
import '../../../../shared/database/app_database.dart';
import 'tasks_table.dart';

part 'tasks_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(super.db);

  Stream<List<Task>> watchAllTasks() {
    return (select(tasks)
          ..orderBy([
            (t) => OrderingTerm(expression: t.isCompleted),
            (t) => OrderingTerm(expression: t.dueDate),
          ]))
        .watch();
  }

  Stream<List<Task>> watchTodayTasks() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(tasks)
          ..where((t) =>
              t.dueDate.isBiggerOrEqualValue(startOfDay) &
              t.dueDate.isSmallerThanValue(endOfDay))
          ..orderBy([
            (t) => OrderingTerm(expression: t.isCompleted),
            (t) => OrderingTerm(expression: t.dueTimeMinutes),
          ]))
        .watch();
  }

  Stream<List<Task>> watchByCategory(int categoryIndex) {
    return (select(tasks)
          ..where((t) => t.category.equals(categoryIndex))
          ..orderBy([
            (t) => OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<Task?> getById(String id) {
    return (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertTask(TasksCompanion entry) {
    return into(tasks).insert(entry);
  }

  Future<void> updateTask(TasksCompanion entry) {
    return (update(tasks)..where((t) => t.id.equals(entry.id.value)))
        .write(entry);
  }

  Future<void> deleteTask(String id) {
    return (delete(tasks)..where((t) => t.id.equals(id))).go();
  }

  Stream<List<Task>> watchTasksByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(tasks)
          ..where((t) =>
              t.dueDate.isBiggerOrEqualValue(startOfDay) &
              t.dueDate.isSmallerThanValue(endOfDay))
          ..orderBy([
            (t) => OrderingTerm(expression: t.isCompleted),
            (t) => OrderingTerm(expression: t.dueTimeMinutes),
          ]))
        .watch();
  }

  Future<void> deleteAll() async {
    await delete(tasks).go();
  }

  Future<void> toggleComplete(String id) async {
    final task = await getById(id);
    if (task == null) return;

    final nowCompleted = !task.isCompleted;
    await (update(tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isCompleted: Value(nowCompleted),
        completedAt: Value(nowCompleted ? DateTime.now() : null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../tasks/domain/task_model.dart';
import '../../tasks/domain/task_category.dart';
import '../../tasks/domain/task_priority.dart';
import '../../tasks/domain/task_recurrence.dart';

class SharedListTaskRepository {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _tasksCol(String listId) =>
      _firestore.collection('shared_lists').doc(listId).collection('tasks');

  Future<void> addTask(String listId, Task task) async {
    await _tasksCol(listId).doc(task.id).set(_toMap(task));
    await _firestore.collection('shared_lists').doc(listId).update({
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> updateTask(String listId, Task task) async {
    await _tasksCol(listId).doc(task.id).set(_toMap(task));
    await _firestore.collection('shared_lists').doc(listId).update({
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> deleteTask(String listId, String taskId) async {
    await _tasksCol(listId).doc(taskId).delete();
  }

  Future<void> toggleTask(String listId, String taskId, bool completed) async {
    await _tasksCol(listId).doc(taskId).update({
      'isCompleted': completed,
      'completedAt': completed ? DateTime.now().toIso8601String() : null,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  Stream<List<Task>> watchTasks(String listId) {
    return _tasksCol(listId)
        .orderBy('dueDate')
        .snapshots()
        .map((snap) => snap.docs.map((d) => _fromMap(d.data())).toList());
  }

  Map<String, dynamic> _toMap(Task task) => {
        'id': task.id,
        'title': task.title,
        'notes': task.notes,
        'category': task.category.index,
        'dueDate': task.dueDate.toIso8601String(),
        'dueTimeMinutes': task.dueTimeMinutes,
        'priority': task.priority.index,
        'recurrence': task.recurrence.index,
        'isAlarm': task.isAlarm,
        'isCompleted': task.isCompleted,
        'completedAt': task.completedAt?.toIso8601String(),
        'createdAt': task.createdAt.toIso8601String(),
        'updatedAt': task.updatedAt.toIso8601String(),
      };

  Task _fromMap(Map<String, dynamic> m) {
    final catIdx = (m['category'] as int?) ?? 0;
    final priIdx = (m['priority'] as int?) ?? 0;
    final recIdx = (m['recurrence'] as int?) ?? 0;
    return Task(
      id: m['id'] as String,
      title: m['title'] as String,
      notes: m['notes'] as String?,
      category:
          TaskCategory.values[catIdx.clamp(0, TaskCategory.values.length - 1)],
      dueDate: DateTime.parse(m['dueDate'] as String),
      dueTimeMinutes: m['dueTimeMinutes'] as int?,
      priority:
          TaskPriority.values[priIdx.clamp(0, TaskPriority.values.length - 1)],
      recurrence: TaskRecurrence
          .values[recIdx.clamp(0, TaskRecurrence.values.length - 1)],
      isAlarm: (m['isAlarm'] as bool?) ?? false,
      isCompleted: (m['isCompleted'] as bool?) ?? false,
      completedAt: m['completedAt'] != null
          ? DateTime.parse(m['completedAt'] as String)
          : null,
      createdAt: DateTime.parse(m['createdAt'] as String),
      updatedAt: DateTime.parse(m['updatedAt'] as String),
    );
  }
}

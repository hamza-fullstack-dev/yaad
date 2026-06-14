import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/task_model.dart';
import '../../domain/task_category.dart';
import '../../domain/task_priority.dart';
import '../../domain/task_recurrence.dart';

class TaskCloudRepository {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _tasksCol(String uid) =>
      _firestore.collection('users').doc(uid).collection('tasks');

  Future<void> uploadTask(Task task, String uid) async {
    await _tasksCol(uid).doc(task.id).set(_toMap(task));
  }

  Future<void> updateCloudTask(Task task, String uid) async {
    await _tasksCol(uid).doc(task.id).set(_toMap(task));
  }

  Future<void> deleteCloudTask(String taskId, String uid) async {
    await _tasksCol(uid).doc(taskId).delete();
  }

  Future<List<Task>> fetchRemoteTasks(String uid) async {
    final snap = await _tasksCol(uid).get();
    return snap.docs.map((doc) => _fromMap(doc.data())).toList();
  }

  Future<void> batchUploadTasks(List<Task> tasks, String uid) async {
    final batch = _firestore.batch();
    for (final task in tasks) {
      batch.set(_tasksCol(uid).doc(task.id), _toMap(task));
    }
    await batch.commit();
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

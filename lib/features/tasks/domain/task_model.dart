import 'package:freezed_annotation/freezed_annotation.dart';
import 'task_category.dart';
import 'task_priority.dart';
import 'task_recurrence.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    String? notes,
    required TaskCategory category,
    required DateTime dueDate,
    int? dueTimeMinutes,
    @Default(TaskPriority.normal) TaskPriority priority,
    @Default(TaskRecurrence.none) TaskRecurrence recurrence,
    @Default(false) bool isAlarm,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

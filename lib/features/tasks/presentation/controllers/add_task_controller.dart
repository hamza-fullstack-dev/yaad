import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/task_category.dart';
import '../../domain/task_model.dart';
import '../../domain/task_priority.dart';
import '../../domain/task_recurrence.dart';
import '../../data/task_providers.dart';

part 'add_task_controller.freezed.dart';
part 'add_task_controller.g.dart';

@freezed
class AddTaskState with _$AddTaskState {
  const AddTaskState._();

  const factory AddTaskState({
    @Default('') String title,
    @Default(TaskCategory.family) TaskCategory category,
    required DateTime dueDate,
    int? dueTimeMinutes,
    @Default('') String notes,
    @Default(TaskPriority.normal) TaskPriority priority,
    @Default(TaskRecurrence.none) TaskRecurrence recurrence,
    @Default(10) int remindBeforeMinutes,
    @Default(false) bool isAlarm,
    @Default(false) bool isSaving,
  }) = _AddTaskState;

  bool get isValid => title.trim().isNotEmpty;
}

@riverpod
class AddTaskController extends _$AddTaskController {
  @override
  AddTaskState build() {
    return AddTaskState(dueDate: DateTime.now());
  }

  void setTitle(String value) => state = state.copyWith(title: value);
  void setCategory(TaskCategory value) =>
      state = state.copyWith(category: value);
  void setDueDate(DateTime value) => state = state.copyWith(dueDate: value);
  void setDueTimeMinutes(int? value) =>
      state = state.copyWith(dueTimeMinutes: value);
  void setNotes(String value) => state = state.copyWith(notes: value);
  void setPriority(TaskPriority value) =>
      state = state.copyWith(priority: value);
  void setRecurrence(TaskRecurrence value) =>
      state = state.copyWith(recurrence: value);
  void setRemindBeforeMinutes(int value) =>
      state = state.copyWith(remindBeforeMinutes: value);
  void setIsAlarm(bool value) => state = state.copyWith(isAlarm: value);

  Future<bool> save() async {
    if (!state.isValid) return false;
    state = state.copyWith(isSaving: true);

    try {
      final now = DateTime.now();
      final task = Task(
        id: '',
        title: state.title.trim(),
        notes: state.notes.isEmpty ? null : state.notes.trim(),
        category: state.category,
        dueDate: state.dueDate,
        dueTimeMinutes: state.dueTimeMinutes,
        priority: state.priority,
        recurrence: state.recurrence,
        isAlarm: state.isAlarm,
        createdAt: now,
        updatedAt: now,
      );

      await ref.read(taskRepositoryProvider).createTask(task);
      return true;
    } catch (_) {
      return false;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  TaskCategory get category => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  int? get dueTimeMinutes => throw _privateConstructorUsedError;
  TaskPriority get priority => throw _privateConstructorUsedError;
  TaskRecurrence get recurrence => throw _privateConstructorUsedError;
  bool get isAlarm => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? notes,
      TaskCategory category,
      DateTime dueDate,
      int? dueTimeMinutes,
      TaskPriority priority,
      TaskRecurrence recurrence,
      bool isAlarm,
      bool isCompleted,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? notes = freezed,
    Object? category = null,
    Object? dueDate = null,
    Object? dueTimeMinutes = freezed,
    Object? priority = null,
    Object? recurrence = null,
    Object? isAlarm = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TaskCategory,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueTimeMinutes: freezed == dueTimeMinutes
          ? _value.dueTimeMinutes
          : dueTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as TaskRecurrence,
      isAlarm: null == isAlarm
          ? _value.isAlarm
          : isAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? notes,
      TaskCategory category,
      DateTime dueDate,
      int? dueTimeMinutes,
      TaskPriority priority,
      TaskRecurrence recurrence,
      bool isAlarm,
      bool isCompleted,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? notes = freezed,
    Object? category = null,
    Object? dueDate = null,
    Object? dueTimeMinutes = freezed,
    Object? priority = null,
    Object? recurrence = null,
    Object? isAlarm = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TaskCategory,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueTimeMinutes: freezed == dueTimeMinutes
          ? _value.dueTimeMinutes
          : dueTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as TaskRecurrence,
      isAlarm: null == isAlarm
          ? _value.isAlarm
          : isAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {required this.id,
      required this.title,
      this.notes,
      required this.category,
      required this.dueDate,
      this.dueTimeMinutes,
      this.priority = TaskPriority.normal,
      this.recurrence = TaskRecurrence.none,
      this.isAlarm = false,
      this.isCompleted = false,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt});

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? notes;
  @override
  final TaskCategory category;
  @override
  final DateTime dueDate;
  @override
  final int? dueTimeMinutes;
  @override
  @JsonKey()
  final TaskPriority priority;
  @override
  @JsonKey()
  final TaskRecurrence recurrence;
  @override
  @JsonKey()
  final bool isAlarm;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Task(id: $id, title: $title, notes: $notes, category: $category, dueDate: $dueDate, dueTimeMinutes: $dueTimeMinutes, priority: $priority, recurrence: $recurrence, isAlarm: $isAlarm, isCompleted: $isCompleted, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.dueTimeMinutes, dueTimeMinutes) ||
                other.dueTimeMinutes == dueTimeMinutes) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.isAlarm, isAlarm) || other.isAlarm == isAlarm) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      notes,
      category,
      dueDate,
      dueTimeMinutes,
      priority,
      recurrence,
      isAlarm,
      isCompleted,
      completedAt,
      createdAt,
      updatedAt);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {required final String id,
      required final String title,
      final String? notes,
      required final TaskCategory category,
      required final DateTime dueDate,
      final int? dueTimeMinutes,
      final TaskPriority priority,
      final TaskRecurrence recurrence,
      final bool isAlarm,
      final bool isCompleted,
      final DateTime? completedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get notes;
  @override
  TaskCategory get category;
  @override
  DateTime get dueDate;
  @override
  int? get dueTimeMinutes;
  @override
  TaskPriority get priority;
  @override
  TaskRecurrence get recurrence;
  @override
  bool get isAlarm;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

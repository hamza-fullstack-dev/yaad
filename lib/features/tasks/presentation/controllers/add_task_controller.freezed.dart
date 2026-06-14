// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_task_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddTaskState {
  String get title => throw _privateConstructorUsedError;
  TaskCategory get category => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  int? get dueTimeMinutes => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  TaskPriority get priority => throw _privateConstructorUsedError;
  TaskRecurrence get recurrence => throw _privateConstructorUsedError;
  int get remindBeforeMinutes => throw _privateConstructorUsedError;
  bool get isAlarm => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;

  /// Create a copy of AddTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddTaskStateCopyWith<AddTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTaskStateCopyWith<$Res> {
  factory $AddTaskStateCopyWith(
          AddTaskState value, $Res Function(AddTaskState) then) =
      _$AddTaskStateCopyWithImpl<$Res, AddTaskState>;
  @useResult
  $Res call(
      {String title,
      TaskCategory category,
      DateTime dueDate,
      int? dueTimeMinutes,
      String notes,
      TaskPriority priority,
      TaskRecurrence recurrence,
      int remindBeforeMinutes,
      bool isAlarm,
      bool isSaving});
}

/// @nodoc
class _$AddTaskStateCopyWithImpl<$Res, $Val extends AddTaskState>
    implements $AddTaskStateCopyWith<$Res> {
  _$AddTaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddTaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? dueDate = null,
    Object? dueTimeMinutes = freezed,
    Object? notes = null,
    Object? priority = null,
    Object? recurrence = null,
    Object? remindBeforeMinutes = null,
    Object? isAlarm = null,
    Object? isSaving = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
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
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as TaskRecurrence,
      remindBeforeMinutes: null == remindBeforeMinutes
          ? _value.remindBeforeMinutes
          : remindBeforeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isAlarm: null == isAlarm
          ? _value.isAlarm
          : isAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddTaskStateImplCopyWith<$Res>
    implements $AddTaskStateCopyWith<$Res> {
  factory _$$AddTaskStateImplCopyWith(
          _$AddTaskStateImpl value, $Res Function(_$AddTaskStateImpl) then) =
      __$$AddTaskStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      TaskCategory category,
      DateTime dueDate,
      int? dueTimeMinutes,
      String notes,
      TaskPriority priority,
      TaskRecurrence recurrence,
      int remindBeforeMinutes,
      bool isAlarm,
      bool isSaving});
}

/// @nodoc
class __$$AddTaskStateImplCopyWithImpl<$Res>
    extends _$AddTaskStateCopyWithImpl<$Res, _$AddTaskStateImpl>
    implements _$$AddTaskStateImplCopyWith<$Res> {
  __$$AddTaskStateImplCopyWithImpl(
      _$AddTaskStateImpl _value, $Res Function(_$AddTaskStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddTaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? dueDate = null,
    Object? dueTimeMinutes = freezed,
    Object? notes = null,
    Object? priority = null,
    Object? recurrence = null,
    Object? remindBeforeMinutes = null,
    Object? isAlarm = null,
    Object? isSaving = null,
  }) {
    return _then(_$AddTaskStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
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
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as TaskRecurrence,
      remindBeforeMinutes: null == remindBeforeMinutes
          ? _value.remindBeforeMinutes
          : remindBeforeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isAlarm: null == isAlarm
          ? _value.isAlarm
          : isAlarm // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddTaskStateImpl extends _AddTaskState {
  const _$AddTaskStateImpl(
      {this.title = '',
      this.category = TaskCategory.family,
      required this.dueDate,
      this.dueTimeMinutes,
      this.notes = '',
      this.priority = TaskPriority.normal,
      this.recurrence = TaskRecurrence.none,
      this.remindBeforeMinutes = 10,
      this.isAlarm = false,
      this.isSaving = false})
      : super._();

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final TaskCategory category;
  @override
  final DateTime dueDate;
  @override
  final int? dueTimeMinutes;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final TaskPriority priority;
  @override
  @JsonKey()
  final TaskRecurrence recurrence;
  @override
  @JsonKey()
  final int remindBeforeMinutes;
  @override
  @JsonKey()
  final bool isAlarm;
  @override
  @JsonKey()
  final bool isSaving;

  @override
  String toString() {
    return 'AddTaskState(title: $title, category: $category, dueDate: $dueDate, dueTimeMinutes: $dueTimeMinutes, notes: $notes, priority: $priority, recurrence: $recurrence, remindBeforeMinutes: $remindBeforeMinutes, isAlarm: $isAlarm, isSaving: $isSaving)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTaskStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.dueTimeMinutes, dueTimeMinutes) ||
                other.dueTimeMinutes == dueTimeMinutes) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.remindBeforeMinutes, remindBeforeMinutes) ||
                other.remindBeforeMinutes == remindBeforeMinutes) &&
            (identical(other.isAlarm, isAlarm) || other.isAlarm == isAlarm) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      category,
      dueDate,
      dueTimeMinutes,
      notes,
      priority,
      recurrence,
      remindBeforeMinutes,
      isAlarm,
      isSaving);

  /// Create a copy of AddTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTaskStateImplCopyWith<_$AddTaskStateImpl> get copyWith =>
      __$$AddTaskStateImplCopyWithImpl<_$AddTaskStateImpl>(this, _$identity);
}

abstract class _AddTaskState extends AddTaskState {
  const factory _AddTaskState(
      {final String title,
      final TaskCategory category,
      required final DateTime dueDate,
      final int? dueTimeMinutes,
      final String notes,
      final TaskPriority priority,
      final TaskRecurrence recurrence,
      final int remindBeforeMinutes,
      final bool isAlarm,
      final bool isSaving}) = _$AddTaskStateImpl;
  const _AddTaskState._() : super._();

  @override
  String get title;
  @override
  TaskCategory get category;
  @override
  DateTime get dueDate;
  @override
  int? get dueTimeMinutes;
  @override
  String get notes;
  @override
  TaskPriority get priority;
  @override
  TaskRecurrence get recurrence;
  @override
  int get remindBeforeMinutes;
  @override
  bool get isAlarm;
  @override
  bool get isSaving;

  /// Create a copy of AddTaskState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTaskStateImplCopyWith<_$AddTaskStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

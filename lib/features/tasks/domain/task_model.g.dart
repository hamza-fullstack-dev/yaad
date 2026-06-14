// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      category: $enumDecode(_$TaskCategoryEnumMap, json['category']),
      dueDate: DateTime.parse(json['dueDate'] as String),
      dueTimeMinutes: (json['dueTimeMinutes'] as num?)?.toInt(),
      priority: $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
          TaskPriority.normal,
      recurrence:
          $enumDecodeNullable(_$TaskRecurrenceEnumMap, json['recurrence']) ??
              TaskRecurrence.none,
      isAlarm: json['isAlarm'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'notes': instance.notes,
      'category': _$TaskCategoryEnumMap[instance.category]!,
      'dueDate': instance.dueDate.toIso8601String(),
      'dueTimeMinutes': instance.dueTimeMinutes,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'recurrence': _$TaskRecurrenceEnumMap[instance.recurrence]!,
      'isAlarm': instance.isAlarm,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TaskCategoryEnumMap = {
  TaskCategory.self_: 'self_',
  TaskCategory.work: 'work',
  TaskCategory.family: 'family',
  TaskCategory.deen: 'deen',
  TaskCategory.home: 'home',
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.normal: 'normal',
  TaskPriority.high: 'high',
};

const _$TaskRecurrenceEnumMap = {
  TaskRecurrence.none: 'none',
  TaskRecurrence.daily: 'daily',
  TaskRecurrence.weekly: 'weekly',
  TaskRecurrence.monthly: 'monthly',
};

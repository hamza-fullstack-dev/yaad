// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryEntryImpl _$$DiaryEntryImplFromJson(Map<String, dynamic> json) =>
    _$DiaryEntryImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      mood: $enumDecode(_$MoodEnumMap, json['mood']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DiaryEntryImplToJson(_$DiaryEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'mood': _$MoodEnumMap[instance.mood]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$MoodEnumMap = {
  Mood.tired: 'tired',
  Mood.pareshan: 'pareshan',
  Mood.shukar: 'shukar',
  Mood.sukoon: 'sukoon',
  Mood.khush: 'khush',
};

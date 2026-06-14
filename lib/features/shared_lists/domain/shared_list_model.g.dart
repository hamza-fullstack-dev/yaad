// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SharedListImpl _$$SharedListImplFromJson(Map<String, dynamic> json) =>
    _$SharedListImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      ownerName: json['ownerName'] as String,
      collaboratorIds: (json['collaboratorIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SharedListImplToJson(_$SharedListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ownerId': instance.ownerId,
      'ownerName': instance.ownerName,
      'collaboratorIds': instance.collaboratorIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListMemberImpl _$$ListMemberImplFromJson(Map<String, dynamic> json) =>
    _$ListMemberImpl(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      role: $enumDecodeNullable(_$MemberRoleEnumMap, json['role']) ??
          MemberRole.editor,
    );

Map<String, dynamic> _$$ListMemberImplToJson(_$ListMemberImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'role': _$MemberRoleEnumMap[instance.role]!,
    };

const _$MemberRoleEnumMap = {
  MemberRole.owner: 'owner',
  MemberRole.editor: 'editor',
  MemberRole.viewer: 'viewer',
};

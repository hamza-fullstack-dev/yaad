import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_member.freezed.dart';
part 'list_member.g.dart';

enum MemberRole { owner, editor, viewer }

@freezed
class ListMember with _$ListMember {
  const factory ListMember({
    required String uid,
    required String displayName,
    required String email,
    @Default(MemberRole.editor) MemberRole role,
  }) = _ListMember;

  factory ListMember.fromJson(Map<String, dynamic> json) =>
      _$ListMemberFromJson(json);

  factory ListMember.fromFirestore(Map<String, dynamic> data) {
    return ListMember(
      uid: data['uid'] as String? ?? '',
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: MemberRole.values[data['role'] as int? ?? 1],
    );
  }
}

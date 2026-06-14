import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_list_model.freezed.dart';
part 'shared_list_model.g.dart';

@freezed
class SharedList with _$SharedList {
  const factory SharedList({
    required String id,
    required String name,
    required String ownerId,
    required String ownerName,
    @Default([]) List<String> collaboratorIds,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SharedList;

  factory SharedList.fromJson(Map<String, dynamic> json) =>
      _$SharedListFromJson(json);

  factory SharedList.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SharedList(
      id: doc.id,
      name: data['name'] as String? ?? '',
      ownerId: data['ownerId'] as String? ?? '',
      ownerName: data['ownerName'] as String? ?? '',
      collaboratorIds: List<String>.from(data['collaboratorIds'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

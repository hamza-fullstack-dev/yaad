import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/shared_list_model.dart';
import '../domain/list_member.dart';

class SharedListRepository {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _listsCol =>
      _firestore.collection('shared_lists');

  DocumentReference<Map<String, dynamic>> _listDoc(String listId) =>
      _listsCol.doc(listId);

  CollectionReference<Map<String, dynamic>> _membersCol(String listId) =>
      _listDoc(listId).collection('members');

  Future<SharedList> createList({
    required String name,
    required String ownerId,
    required String ownerName,
    required String ownerEmail,
  }) async {
    final doc = _listsCol.doc();
    final now = DateTime.now();
    final list = SharedList(
      id: doc.id,
      name: name,
      ownerId: ownerId,
      ownerName: ownerName,
      collaboratorIds: [ownerId],
      createdAt: now,
      updatedAt: now,
    );

    await doc.set({
      'name': name,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'collaboratorIds': [ownerId],
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });

    await _membersCol(doc.id).doc(ownerId).set({
      'uid': ownerId,
      'displayName': ownerName,
      'email': ownerEmail,
      'role': MemberRole.owner.index,
    });

    return list;
  }

  Stream<List<SharedList>> watchUserLists(String uid) {
    return _listsCol
        .where('collaboratorIds', arrayContains: uid)
        .snapshots()
        .map((snap) {
      final lists = snap.docs.map((d) => SharedList.fromFirestore(d)).toList();
      lists.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return lists;
    });
  }

  Future<SharedList?> getList(String listId) async {
    final doc = await _listDoc(listId).get();
    if (!doc.exists) return null;
    return SharedList.fromFirestore(doc);
  }

  Future<void> updateListName(String listId, String name) async {
    await _listDoc(listId).update({
      'name': name,
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> deleteList(String listId) async {
    final tasksSnap = await _listDoc(listId).collection('tasks').get();
    final membersSnap = await _membersCol(listId).get();
    final batch = _firestore.batch();
    for (final doc in tasksSnap.docs) {
      batch.delete(doc.reference);
    }
    for (final doc in membersSnap.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(_listDoc(listId));
    await batch.commit();
  }

  Future<void> addCollaborator({
    required String listId,
    required String uid,
    required String displayName,
    required String email,
  }) async {
    await _listDoc(listId).update({
      'collaboratorIds': FieldValue.arrayUnion([uid]),
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });

    await _membersCol(listId).doc(uid).set({
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'role': MemberRole.editor.index,
    });
  }

  Future<void> removeCollaborator(String listId, String uid) async {
    await _listDoc(listId).update({
      'collaboratorIds': FieldValue.arrayRemove([uid]),
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
    await _membersCol(listId).doc(uid).delete();
  }

  Stream<List<ListMember>> watchMembers(String listId) {
    return _membersCol(listId).snapshots().map((snap) =>
        snap.docs.map((d) => ListMember.fromFirestore(d.data())).toList());
  }
}

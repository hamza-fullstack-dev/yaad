import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/diary_entry_model.dart';
import '../../domain/mood.dart';

class DiaryCloudRepository {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _entriesCol(String uid) =>
      _firestore.collection('users').doc(uid).collection('diary_entries');

  Future<void> uploadEntry(DiaryEntry entry, String uid) async {
    await _entriesCol(uid).doc(entry.id).set(_toMap(entry));
  }

  Future<void> updateCloudEntry(DiaryEntry entry, String uid) async {
    await _entriesCol(uid).doc(entry.id).set(_toMap(entry));
  }

  Future<void> deleteCloudEntry(String entryId, String uid) async {
    await _entriesCol(uid).doc(entryId).delete();
  }

  Future<List<DiaryEntry>> fetchRemoteEntries(String uid) async {
    final snap = await _entriesCol(uid).get();
    return snap.docs.map((doc) => _fromMap(doc.data())).toList();
  }

  Future<void> batchUploadEntries(List<DiaryEntry> entries, String uid) async {
    final batch = _firestore.batch();
    for (final entry in entries) {
      batch.set(_entriesCol(uid).doc(entry.id), _toMap(entry));
    }
    await batch.commit();
  }

  Map<String, dynamic> _toMap(DiaryEntry entry) => {
        'id': entry.id,
        'title': entry.title,
        'body': entry.body,
        'mood': entry.mood.index,
        'createdAt': entry.createdAt.toIso8601String(),
        'updatedAt': entry.updatedAt.toIso8601String(),
      };

  DiaryEntry _fromMap(Map<String, dynamic> m) {
    final moodIdx = (m['mood'] as int?) ?? 0;
    return DiaryEntry(
      id: m['id'] as String,
      title: m['title'] as String,
      body: m['body'] as String,
      mood: Mood.values[moodIdx.clamp(0, Mood.values.length - 1)],
      createdAt: DateTime.parse(m['createdAt'] as String),
      updatedAt: DateTime.parse(m['updatedAt'] as String),
    );
  }
}

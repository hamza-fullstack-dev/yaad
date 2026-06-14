import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/database/app_database.dart' as db;
import '../domain/diary_entry_model.dart' as domain;
import '../domain/mood.dart';
import 'local/diary_dao.dart';
import 'diary_sync_service.dart';

class DiaryRepository {
  final DiaryDao _dao;
  DiarySyncService? _syncService;
  static const _uuid = Uuid();

  DiaryRepository(this._dao);

  void setSyncService(DiarySyncService? syncService) {
    _syncService = syncService;
  }

  Stream<List<domain.DiaryEntry>> watchAllEntries() {
    return _dao.watchAllEntries().map(
          (rows) => rows.map(_fromRow).toList(),
        );
  }

  Future<domain.DiaryEntry?> getById(String id) async {
    final row = await _dao.getById(id);
    if (row == null) return null;
    return _fromRow(row);
  }

  Future<void> createEntry(domain.DiaryEntry entry) async {
    final id = entry.id.isEmpty ? _uuid.v4() : entry.id;
    final entryWithId = entry.copyWith(id: id);

    await _dao.insertEntry(db.DiaryEntriesCompanion.insert(
      id: id,
      title: entry.title,
      body: entry.body,
      mood: entry.mood.index,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    ));

    _syncService?.pushEntry(entryWithId);
  }

  Future<void> updateEntry(domain.DiaryEntry entry) async {
    await _dao.updateEntry(db.DiaryEntriesCompanion(
      id: Value(entry.id),
      title: Value(entry.title),
      body: Value(entry.body),
      mood: Value(entry.mood.index),
      updatedAt: Value(DateTime.now()),
    ));

    _syncService?.pushEntry(entry);
  }

  Future<void> deleteEntry(String id) async {
    await _dao.deleteEntry(id);
    _syncService?.removeEntry(id);
  }

  Future<void> upsertEntry(domain.DiaryEntry entry) async {
    final existing = await _dao.getById(entry.id);
    if (existing != null) {
      await _dao.updateEntry(db.DiaryEntriesCompanion(
        id: Value(entry.id),
        title: Value(entry.title),
        body: Value(entry.body),
        mood: Value(entry.mood.index),
        updatedAt: Value(entry.updatedAt),
      ));
    } else {
      await _dao.insertEntry(db.DiaryEntriesCompanion.insert(
        id: entry.id,
        title: entry.title,
        body: entry.body,
        mood: entry.mood.index,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
      ));
    }
  }

  static domain.DiaryEntry _fromRow(db.DiaryEntry row) {
    return domain.DiaryEntry(
      id: row.id,
      title: row.title,
      body: row.body,
      mood: Mood.values[row.mood],
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

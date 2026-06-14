import 'package:drift/drift.dart';
import '../../../../shared/database/app_database.dart';
import 'diary_table.dart';

part 'diary_dao.g.dart';

@DriftAccessor(tables: [DiaryEntries])
class DiaryDao extends DatabaseAccessor<AppDatabase> with _$DiaryDaoMixin {
  DiaryDao(super.db);

  Stream<List<DiaryEntry>> watchAllEntries() {
    return (select(diaryEntries)
          ..orderBy([
            (e) =>
                OrderingTerm(expression: e.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<DiaryEntry?> getById(String id) {
    return (select(diaryEntries)..where((e) => e.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertEntry(DiaryEntriesCompanion entry) {
    return into(diaryEntries).insert(entry);
  }

  Future<void> updateEntry(DiaryEntriesCompanion entry) {
    return (update(diaryEntries)..where((e) => e.id.equals(entry.id.value)))
        .write(entry);
  }

  Future<void> deleteEntry(String id) {
    return (delete(diaryEntries)..where((e) => e.id.equals(id))).go();
  }

  Future<void> deleteAll() async {
    await delete(diaryEntries).go();
  }
}

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../../features/tasks/data/local/tasks_table.dart';
import '../../features/tasks/data/local/tasks_dao.dart';
import '../../features/diary/data/local/diary_table.dart';
import '../../features/diary/data/local/diary_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tasks, DiaryEntries], daos: [TasksDao, DiaryDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(diaryEntries);
          }
          if (from < 3) {
            await m.addColumn(tasks, tasks.isAlarm);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'yaad_db');
  }
}

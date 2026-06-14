import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/data/auth_providers.dart';
import '../../tasks/data/task_providers.dart';
import '../domain/diary_entry_model.dart';
import 'cloud/diary_cloud_repository.dart';
import 'diary_repository.dart';
import 'diary_sync_service.dart';

part 'diary_providers.g.dart';

@riverpod
DiaryRepository diaryRepository(DiaryRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final repo = DiaryRepository(db.diaryDao);

  final user = ref.watch(currentUserProvider);
  final syncService = DiarySyncService(repo, DiaryCloudRepository(), user?.uid);
  repo.setSyncService(syncService);

  return repo;
}

@Riverpod(keepAlive: true)
DiarySyncService diarySyncService(DiarySyncServiceRef ref) {
  final repo = ref.watch(diaryRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  return DiarySyncService(repo, DiaryCloudRepository(), user?.uid);
}

@riverpod
Stream<List<DiaryEntry>> allDiaryEntries(AllDiaryEntriesRef ref) {
  return ref.watch(diaryRepositoryProvider).watchAllEntries();
}

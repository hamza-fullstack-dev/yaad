import '../domain/diary_entry_model.dart';
import 'cloud/diary_cloud_repository.dart';
import 'diary_repository.dart';

class DiarySyncService {
  final DiaryRepository _localRepo;
  final DiaryCloudRepository _cloudRepo;
  final String? _uid;

  DiarySyncService(this._localRepo, this._cloudRepo, this._uid);

  Future<void> syncOnLogin() async {
    if (_uid == null) return;
    try {
      final remoteEntries = await _cloudRepo.fetchRemoteEntries(_uid);
      final localEntries = await _localRepo.watchAllEntries().first;

      final localMap = {for (final e in localEntries) e.id: e};

      for (final remote in remoteEntries) {
        final local = localMap[remote.id];
        if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
          await _localRepo.upsertEntry(remote);
        }
      }

      final remoteIds = {for (final e in remoteEntries) e.id};
      final toUpload =
          localEntries.where((e) => !remoteIds.contains(e.id)).toList();
      if (toUpload.isNotEmpty) {
        await _cloudRepo.batchUploadEntries(toUpload, _uid);
      }
    } catch (_) {
      // Sync failures are silent — local DB is source of truth
    }
  }

  Future<void> pushEntry(DiaryEntry entry) async {
    if (_uid == null) return;
    try {
      await _cloudRepo.uploadEntry(entry, _uid);
    } catch (_) {}
  }

  Future<void> removeEntry(String entryId) async {
    if (_uid == null) return;
    try {
      await _cloudRepo.deleteCloudEntry(entryId, _uid);
    } catch (_) {}
  }
}

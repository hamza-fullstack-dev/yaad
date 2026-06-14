import '../domain/task_model.dart';
import 'cloud/task_cloud_repository.dart';
import 'task_repository.dart';

class TaskSyncService {
  final TaskRepository _localRepo;
  final TaskCloudRepository _cloudRepo;
  final String? _uid;

  TaskSyncService(this._localRepo, this._cloudRepo, this._uid);

  Future<void> syncOnLogin() async {
    if (_uid == null) return;
    try {
      final remoteTasks = await _cloudRepo.fetchRemoteTasks(_uid);
      final localTasks = await _localRepo.watchAllTasks().first;

      final localMap = {for (final t in localTasks) t.id: t};

      for (final remote in remoteTasks) {
        final local = localMap[remote.id];
        if (local == null || remote.updatedAt.isAfter(local.updatedAt)) {
          await _localRepo.upsertTask(remote);
        }
      }

      final remoteIds = {for (final t in remoteTasks) t.id};
      final toUpload =
          localTasks.where((t) => !remoteIds.contains(t.id)).toList();
      if (toUpload.isNotEmpty) {
        await _cloudRepo.batchUploadTasks(toUpload, _uid);
      }
    } catch (_) {
      // Sync failures are silent — local DB is source of truth
    }
  }

  Future<void> pushTask(Task task) async {
    if (_uid == null) return;
    try {
      await _cloudRepo.uploadTask(task, _uid);
    } catch (_) {}
  }

  Future<void> removeTask(String taskId) async {
    if (_uid == null) return;
    try {
      await _cloudRepo.deleteCloudTask(taskId, _uid);
    } catch (_) {}
  }
}

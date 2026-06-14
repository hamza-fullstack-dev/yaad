import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/data/auth_providers.dart';
import '../../tasks/domain/task_model.dart';
import '../domain/shared_list_model.dart';
import '../domain/list_member.dart';
import 'shared_list_repository.dart';
import 'shared_list_task_repository.dart';

part 'shared_list_providers.g.dart';

@Riverpod(keepAlive: true)
SharedListRepository sharedListRepository(SharedListRepositoryRef ref) {
  return SharedListRepository();
}

@Riverpod(keepAlive: true)
SharedListTaskRepository sharedListTaskRepository(
    SharedListTaskRepositoryRef ref) {
  return SharedListTaskRepository();
}

@riverpod
Stream<List<SharedList>> userSharedLists(UserSharedListsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref.watch(sharedListRepositoryProvider).watchUserLists(user.uid);
}

@riverpod
Stream<List<Task>> sharedListTasks(SharedListTasksRef ref, String listId) {
  return ref.watch(sharedListTaskRepositoryProvider).watchTasks(listId);
}

@riverpod
Stream<List<ListMember>> sharedListMembers(
    SharedListMembersRef ref, String listId) {
  return ref.watch(sharedListRepositoryProvider).watchMembers(listId);
}

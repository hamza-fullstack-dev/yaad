import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user_model.dart';
import 'auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

@riverpod
Stream<YaadUser?> authState(AuthStateRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

@riverpod
YaadUser? currentUser(CurrentUserRef ref) {
  return ref.watch(authStateProvider).valueOrNull;
}

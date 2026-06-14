import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/auth_providers.dart';
import '../../../tasks/data/task_providers.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/l10n/language_provider.dart';

part 'auth_controller.freezed.dart';
part 'auth_controller.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _AuthState;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() => const AuthState();

  Future<bool> signInWithEmail(String email, String password) async {
    state = const AuthState(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).signInWithEmail(email, password);
      state = const AuthState();
      return true;
    } on FirebaseAuthException catch (e) {
      state = AuthState(errorMessage: _localizedError(e.code));
      return false;
    } catch (_) {
      state = AuthState(errorMessage: ref.read(stringsProvider).errGeneric);
      return false;
    }
  }

  Future<bool> signUpWithEmail(
      String email, String password, String name) async {
    state = const AuthState(isLoading: true);
    try {
      await ref
          .read(authRepositoryProvider)
          .signUpWithEmail(email, password, name);
      state = const AuthState();
      return true;
    } on FirebaseAuthException catch (e) {
      state = AuthState(errorMessage: _localizedError(e.code));
      return false;
    } catch (_) {
      state = AuthState(errorMessage: ref.read(stringsProvider).errGeneric);
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    state = const AuthState(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      state = const AuthState();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'sign-in-cancelled') {
        state = const AuthState();
        return false;
      }
      state = AuthState(errorMessage: _localizedError(e.code));
      return false;
    } catch (_) {
      state = AuthState(errorMessage: ref.read(stringsProvider).errGeneric);
      return false;
    }
  }

  Future<void> signOut() async {
    final db = ref.read(appDatabaseProvider);
    await db.tasksDao.deleteAll();
    await db.diaryDao.deleteAll();
    await ref.read(notificationServiceProvider).cancelAllReminders();
    ref.read(diaryUnlockedProvider.notifier).state = false;
    await ref.read(authRepositoryProvider).signOut();
  }

  Future<bool> sendPasswordReset(String email) async {
    state = const AuthState(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).sendPasswordReset(email);
      state = const AuthState();
      return true;
    } on FirebaseAuthException catch (e) {
      state = AuthState(errorMessage: _localizedError(e.code));
      return false;
    } catch (_) {
      state = AuthState(errorMessage: ref.read(stringsProvider).errGeneric);
      return false;
    }
  }

  Future<void> deleteAccount() async {
    state = const AuthState(isLoading: true);
    try {
      final user = ref.read(authStateProvider).valueOrNull;
      if (user != null) {
        final uid = user.uid;
        final firestore = FirebaseFirestore.instance;

        final taskSnap = await firestore
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .get();
        final diarySnap = await firestore
            .collection('users')
            .doc(uid)
            .collection('diary_entries')
            .get();
        final batch = firestore.batch();
        for (final doc in taskSnap.docs) {
          batch.delete(doc.reference);
        }
        for (final doc in diarySnap.docs) {
          batch.delete(doc.reference);
        }
        batch.delete(firestore.collection('users').doc(uid));
        await batch.commit();

        await ref.read(secureStorageServiceProvider).removePin(uid);

        final db = ref.read(appDatabaseProvider);
        await db.tasksDao.deleteAll();
        await db.diaryDao.deleteAll();
        await ref.read(notificationServiceProvider).cancelAllReminders();
        ref.read(diaryUnlockedProvider.notifier).state = false;
      }

      await ref.read(authRepositoryProvider).deleteAccount();
      state = const AuthState();
    } on FirebaseAuthException catch (e) {
      state = AuthState(errorMessage: _localizedError(e.code));
    } catch (_) {
      state = AuthState(errorMessage: ref.read(stringsProvider).errGeneric);
    }
  }

  void clearError() {
    state = const AuthState();
  }

  String _localizedError(String code) {
    final s = ref.read(stringsProvider);
    switch (code) {
      case 'user-not-found':
        return s.errUserNotFound;
      case 'wrong-password':
        return s.errWrongPassword;
      case 'email-already-in-use':
        return s.errEmailInUse;
      case 'weak-password':
        return s.errWeakPassword;
      case 'network-request-failed':
        return s.errNoInternet;
      case 'invalid-email':
        return s.errInvalidEmail;
      case 'too-many-requests':
        return s.errTooManyRequests;
      case 'invalid-credential':
        return s.errInvalidCredential;
      case 'requires-recent-login':
        return s.errRecentLogin;
      default:
        return s.errGeneric;
    }
  }
}

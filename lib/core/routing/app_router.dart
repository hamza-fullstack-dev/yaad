import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

import '../../features/splash/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/auth/presentation/sign_up_screen.dart';
import '../../features/auth/data/auth_providers.dart';
import '../../features/tasks/data/task_providers.dart';
import '../../features/diary/data/diary_providers.dart';
import '../../core/services/secure_storage_service.dart';
import '../../features/tasks/presentation/home_screen.dart';
import '../../features/calendar/presentation/calendar_screen.dart';
import '../../features/diary/presentation/diary_list_screen.dart';
import '../../features/diary/presentation/diary_write_screen.dart';
import '../../features/diary/presentation/diary_lock_screen.dart';
import '../../features/diary/domain/diary_entry_model.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/notification_settings_screen.dart';
import '../../features/profile/presentation/diary_lock_settings_screen.dart';
import '../../features/profile/presentation/set_pin_screen.dart';
import '../../features/profile/presentation/account_screen.dart';
import '../../features/shared_lists/presentation/shared_lists_screen.dart';
import '../../features/shared_lists/presentation/shared_list_detail_screen.dart';
import '../../features/shared_lists/presentation/invite_screen.dart';
import '../../features/shared_lists/data/shared_list_repository.dart';
import '../../features/tasks/presentation/alarm_screen.dart';
import 'route_names.dart';
import '../l10n/language_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final diaryUnlockedProvider = StateProvider<bool>((ref) => false);

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final publicRoutes = [
        RouteNames.splash,
        RouteNames.onboarding,
        RouteNames.signIn,
        RouteNames.signUp,
        RouteNames.alarm,
      ];

      final currentPath = state.matchedLocation;

      if (authState.isLoading) return null;

      final user = authState.valueOrNull;
      final isPublicRoute = publicRoutes.contains(currentPath);

      if (user == null && !isPublicRoute) {
        return RouteNames.signIn;
      }

      if (user != null &&
          (currentPath == RouteNames.signIn ||
              currentPath == RouteNames.signUp)) {
        ref.read(taskSyncServiceProvider).syncOnLogin();
        ref.read(diarySyncServiceProvider).syncOnLogin();
        final prefs = await SharedPreferences.getInstance();
        final seen = prefs.getBool(AppConstants.onboardingSeenKey) ?? false;
        if (!seen) return RouteNames.onboarding;
        return RouteNames.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RouteNames.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.calendar,
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: RouteNames.diary,
        redirect: (context, state) async {
          if (ref.read(diaryUnlockedProvider)) return null;
          final uid = ref.read(authStateProvider).valueOrNull?.uid;
          if (uid == null) return null;
          final storage = ref.read(secureStorageServiceProvider);
          final lockEnabled = await storage.isLockEnabled(uid);
          final hasPin = await storage.hasPinSet(uid);
          if (lockEnabled && hasPin) return RouteNames.diaryLock;
          return null;
        },
        builder: (context, state) => const DiaryListScreen(),
      ),
      GoRoute(
        path: RouteNames.diaryWrite,
        redirect: (context, state) async {
          if (ref.read(diaryUnlockedProvider)) return null;
          final uid = ref.read(authStateProvider).valueOrNull?.uid;
          if (uid == null) return null;
          final storage = ref.read(secureStorageServiceProvider);
          final lockEnabled = await storage.isLockEnabled(uid);
          final hasPin = await storage.hasPinSet(uid);
          if (lockEnabled && hasPin) return RouteNames.diaryLock;
          return null;
        },
        builder: (context, state) {
          final entry = state.extra as DiaryEntry?;
          return DiaryWriteScreen(existingEntry: entry);
        },
      ),
      GoRoute(
        path: RouteNames.diaryLock,
        builder: (context, state) => const DiaryLockScreen(),
      ),
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.notificationSettings,
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: RouteNames.diaryLockSettings,
        builder: (context, state) => const DiaryLockSettingsScreen(),
      ),
      GoRoute(
        path: RouteNames.setPin,
        builder: (context, state) => const SetPinScreen(),
      ),
      GoRoute(
        path: RouteNames.account,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: RouteNames.sharedLists,
        builder: (context, state) => const SharedListsScreen(),
      ),
      GoRoute(
        path: RouteNames.sharedListDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SharedListDetailScreen(listId: id);
        },
      ),
      GoRoute(
        path: RouteNames.invite,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return InviteScreen(listId: id);
        },
      ),
      GoRoute(
        path: RouteNames.alarm,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          final alarmStrings = ref.read(stringsProvider);
          return AlarmScreen(
            taskTitle: args?['taskTitle'] as String? ?? 'Task',
            notificationId: args?['notificationId'] as int? ?? 0,
            timeUpLabel: alarmStrings.alarmTimeUp,
            snoozeLabel: alarmStrings.alarmSnooze,
            dismissLabel: alarmStrings.alarmDismiss,
          );
        },
      ),
      GoRoute(
        path: '/join/:id',
        redirect: (context, state) async {
          final listId = state.pathParameters['id']!;
          final user = ref.read(authStateProvider).valueOrNull;
          if (user == null) return RouteNames.signIn;

          try {
            await SharedListRepository().addCollaborator(
              listId: listId,
              uid: user.uid,
              displayName: user.displayName ?? '',
              email: user.email,
            );
          } catch (_) {}
          return '/shared-lists/$listId';
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('${ref.read(stringsProvider).routeNotFound}: ${state.uri}'),
      ),
    ),
  );
});

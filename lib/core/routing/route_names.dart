/// Central place for all route paths.
/// Never hardcode '/' strings in your widgets — always use these constants.
class RouteNames {
  RouteNames._(); // prevent instantiation

  // ── Core ────────────────────────────────────────────────────
  static const String splash = '/';
  static const String onboarding = '/onboarding';

  // ── Auth ────────────────────────────────────────────────────
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  // ── Main tabs ───────────────────────────────────────────────
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String diary = '/diary';
  static const String profile = '/profile';

  // ── Sub screens ─────────────────────────────────────────────
  static const String taskDetail = '/home/task/:id';
  static const String diaryWrite = '/diary/write';
  static const String diaryEntry = '/diary/entry/:id';
  static const String diaryLock = '/diary/lock';
  static const String settings = '/profile/settings';
  static const String notificationSettings = '/profile/notifications';
  static const String diaryLockSettings = '/profile/diary-lock';
  static const String setPin = '/profile/set-pin';
  static const String account = '/profile/account';
  static const String sharedLists = '/shared-lists';
  static const String sharedListDetail = '/shared-lists/:id';
  static const String invite = '/invite/:id';

  // ── Alarm ───────────────────────────────────────────────────
  static const String alarm = '/alarm';
}

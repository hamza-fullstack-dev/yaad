class AppStrings {
  const AppStrings._({
    // ── Common ─────────────────────────────────────────────
    required this.appName,
    required this.back,
    required this.cancel,
    required this.save,
    required this.done,
    required this.no,
    required this.yes,
    required this.today,
    required this.tomorrow,
    required this.routeNotFound,
    required this.splashTagline,
    // ── Auth ──────────────────────────────────────────────
    required this.signInTitle,
    required this.signInSubtitle,
    required this.emailHint,
    required this.passwordHint,
    required this.nameHint,
    required this.forgotPassword,
    required this.signInButton,
    required this.googleSignIn,
    required this.newHere,
    required this.createAccount,
    required this.alreadyHaveAccount,
    required this.signInLink,
    required this.resetLinkSent,
    required this.signUpTitle,
    required this.signUpSubtitle,
    required this.signUpButton,
    // ── Auth errors ──────────────────────────────────────
    required this.errUserNotFound,
    required this.errWrongPassword,
    required this.errEmailInUse,
    required this.errWeakPassword,
    required this.errNoInternet,
    required this.errInvalidEmail,
    required this.errTooManyRequests,
    required this.errInvalidCredential,
    required this.errRecentLogin,
    required this.errGeneric,
    // ── Onboarding ───────────────────────────────────────
    required this.onb1Step,
    required this.onb1Title,
    required this.onb1TitleItalic,
    required this.onb1Desc,
    required this.onb1Btn,
    required this.onb2Step,
    required this.onb2Title,
    required this.onb2TitleItalic,
    required this.onb2TitleAfter,
    required this.onb2Desc,
    required this.onb2Btn,
    required this.onb3Step,
    required this.onb3Title,
    required this.onb3TitleItalic,
    required this.onb3TitleAfter,
    required this.onb3Desc,
    required this.onb3Btn,
    required this.skip,
    // ── Home / Tasks ─────────────────────────────────────
    required this.greetMorning,
    required this.greetAfternoon,
    required this.greetEvening,
    required this.greetNamePrefix,
    required this.sharedLists,
    required this.completed,
    required this.remaining,
    required this.emptyTodayTitle,
    required this.emptyTodaySubtitle,
    required this.addTaskCta,
    required this.addTaskTooltip,
    required this.tasksLoadError,
    required this.dayNames,
    // ── Add Task Modal ───────────────────────────────────
    required this.newTaskTitle,
    required this.newTaskTitleItalic,
    required this.taskNameHint,
    required this.dateLabel,
    required this.timeLabel,
    required this.setTime,
    required this.repeatLabel,
    required this.remindLabel,
    required this.alarmLabel,
    required this.notesHint,
    required this.never,
    required this.daily,
    required this.weekly,
    required this.monthly,
    required this.atTime,
    required this.minBefore,
    required this.hourBefore,
    // ── Task Item ────────────────────────────────────────
    required this.deleteTaskTitle,
    required this.deleteTaskBody,
    required this.confirmDelete,
    // ── Alarm Screen ─────────────────────────────────────
    required this.alarmTimeUp,
    required this.alarmSnooze,
    required this.alarmDismiss,
    // ── Calendar ─────────────────────────────────────────
    required this.calTasksHeader,
    required this.calEmptyTitle,
    required this.calEmptySubtitle,
    required this.calRemaining,
    required this.monthNames,
    // ── Diary ────────────────────────────────────────────
    required this.diaryTitle,
    required this.diaryLocked,
    required this.diaryUnlocked,
    required this.diaryLoadError,
    required this.diaryWriteTooltip,
    required this.diaryEmptyTitle,
    required this.diaryEmptySubtitle,
    required this.diaryEmptyCta,
    required this.diaryDeleteTitle,
    required this.diaryDeleteBody,
    required this.diaryDeleteConfirm,
    required this.diaryLeaveTitleText,
    required this.diaryLeaveBody,
    required this.diaryLeaveConfirm,
    required this.diaryTitleHint,
    required this.diaryBodyHint,
    // ── Diary Moods ──────────────────────────────────────
    required this.moodTired,
    required this.moodUpset,
    required this.moodGrateful,
    required this.moodPeaceful,
    required this.moodHappy,
    // ── Diary Lock ───────────────────────────────────────
    required this.lockTitle,
    required this.lockSubtitle,
    required this.lockTooMany,
    // ── Shared Lists ─────────────────────────────────────
    required this.sharedTitle,
    required this.sharedEmptyTitle,
    required this.sharedEmptySubtitle,
    required this.sharedEmptyCta,
    required this.sharedNewTitle,
    required this.sharedNewHint,
    required this.sharedNewCancel,
    required this.sharedNewCreate,
    required this.sharedLoadError,
    required this.sharedTaskHint,
    required this.sharedTasksError,
    required this.sharedTasksEmpty,
    required this.sharedPending,
    required this.sharedCompleted,
    required this.sharedDeleteTitle,
    required this.sharedDeleteBody,
    required this.sharedDeleteConfirm,
    // ── Invite ───────────────────────────────────────────
    required this.inviteTitle,
    required this.inviteLinkSection,
    required this.inviteLinkDesc,
    required this.inviteCopyLink,
    required this.inviteLinkCopied,
    required this.inviteMembersSection,
    required this.inviteOnlyYou,
    required this.inviteMembersError,
    // ── Profile & Settings ───────────────────────────────
    required this.settAccount,
    required this.settSharedLists,
    required this.settNotifications,
    required this.settPrivacy,
    required this.settLanguage,
    required this.settAppearance,
    required this.settAbout,
    // ── Account ──────────────────────────────────────────
    required this.accountTitle,
    required this.signOut,
    required this.deleteAccountLink,
    required this.deleteAccountTitle,
    required this.deleteAccountBody,
    required this.deleteAccountConfirm,
    // ── Notification Settings ────────────────────────────
    required this.notifTitle,
    required this.notifTaskReminders,
    required this.notifStreakAlerts,
    required this.notifDefaultReminder,
    required this.notifQuietHours,
    required this.notifOff,
    // ── Diary Lock Settings ──────────────────────────────
    required this.lockSettTitle,
    required this.lockSettToggle,
    required this.lockSettChangePin,
    required this.lockSettRemovePin,
    required this.lockSettRemoveTitle,
    required this.lockSettRemoveBody,
    // ── Set PIN ──────────────────────────────────────────
    required this.pinNewTitle,
    required this.pinNewSubtitle,
    required this.pinConfirmTitle,
    required this.pinConfirmSubtitle,
    // ── Stats ────────────────────────────────────────────
    required this.statStreak,
    required this.statDays,
    required this.statTasksDone,
    required this.statEntries,
    required this.statWeek,
    required this.statRemaining,
    required this.statRemainingToday,
    // ── Notifications (push) ─────────────────────────────
    required this.notifSet,
    required this.notifSetBody,
    required this.notifDue,
    required this.notifOverdue,
    required this.notifSnoozeDone,
    required this.notifCatSelf,
    required this.notifCatWork,
    required this.notifCatFamily,
    required this.notifCatDeen,
    required this.notifCatHome,
    required this.notifActionDismiss,
    required this.notifActionSnooze,
    // ── Tab Bar ──────────────────────────────────────────
    required this.tabToday,
    required this.tabCalendar,
    required this.tabDiary,
    required this.tabProfile,
    // ── Category Names ───────────────────────────────────
    required this.catSelf,
    required this.catWork,
    required this.catFamily,
    required this.catDeen,
    required this.catHome,
  });

  // ── Common ─────────────────────────────────────────────
  final String appName;
  final String back;
  final String cancel;
  final String save;
  final String done;
  final String no;
  final String yes;
  final String today;
  final String tomorrow;
  final String routeNotFound;
  final String splashTagline;
  // ── Auth ──────────────────────────────────────────────
  final String signInTitle;
  final String signInSubtitle;
  final String emailHint;
  final String passwordHint;
  final String nameHint;
  final String forgotPassword;
  final String signInButton;
  final String googleSignIn;
  final String newHere;
  final String createAccount;
  final String alreadyHaveAccount;
  final String signInLink;
  final String resetLinkSent;
  final String signUpTitle;
  final String signUpSubtitle;
  final String signUpButton;
  // ── Auth errors ──────────────────────────────────────
  final String errUserNotFound;
  final String errWrongPassword;
  final String errEmailInUse;
  final String errWeakPassword;
  final String errNoInternet;
  final String errInvalidEmail;
  final String errTooManyRequests;
  final String errInvalidCredential;
  final String errRecentLogin;
  final String errGeneric;
  // ── Onboarding ───────────────────────────────────────
  final String onb1Step;
  final String onb1Title;
  final String onb1TitleItalic;
  final String onb1Desc;
  final String onb1Btn;
  final String onb2Step;
  final String onb2Title;
  final String onb2TitleItalic;
  final String onb2TitleAfter;
  final String onb2Desc;
  final String onb2Btn;
  final String onb3Step;
  final String onb3Title;
  final String onb3TitleItalic;
  final String onb3TitleAfter;
  final String onb3Desc;
  final String onb3Btn;
  final String skip;
  // ── Home / Tasks ─────────────────────────────────────
  final String greetMorning;
  final String greetAfternoon;
  final String greetEvening;
  final String greetNamePrefix;
  final String sharedLists;
  final String completed;
  final String remaining;
  final String emptyTodayTitle;
  final String emptyTodaySubtitle;
  final String addTaskCta;
  final String addTaskTooltip;
  final String tasksLoadError;
  final List<String> dayNames;
  // ── Add Task Modal ───────────────────────────────────
  final String newTaskTitle;
  final String newTaskTitleItalic;
  final String taskNameHint;
  final String dateLabel;
  final String timeLabel;
  final String setTime;
  final String repeatLabel;
  final String remindLabel;
  final String alarmLabel;
  final String notesHint;
  final String never;
  final String daily;
  final String weekly;
  final String monthly;
  final String atTime;
  final String minBefore;
  final String hourBefore;
  // ── Task Item ────────────────────────────────────────
  final String deleteTaskTitle;
  final String deleteTaskBody;
  final String confirmDelete;
  // ── Alarm Screen ─────────────────────────────────────
  final String alarmTimeUp;
  final String alarmSnooze;
  final String alarmDismiss;
  // ── Calendar ─────────────────────────────────────────
  final String calTasksHeader;
  final String calEmptyTitle;
  final String calEmptySubtitle;
  final String calRemaining;
  final List<String> monthNames;
  // ── Diary ────────────────────────────────────────────
  final String diaryTitle;
  final String diaryLocked;
  final String diaryUnlocked;
  final String diaryLoadError;
  final String diaryWriteTooltip;
  final String diaryEmptyTitle;
  final String diaryEmptySubtitle;
  final String diaryEmptyCta;
  final String diaryDeleteTitle;
  final String diaryDeleteBody;
  final String diaryDeleteConfirm;
  final String diaryLeaveTitleText;
  final String diaryLeaveBody;
  final String diaryLeaveConfirm;
  final String diaryTitleHint;
  final String diaryBodyHint;
  // ── Diary Moods ──────────────────────────────────────
  final String moodTired;
  final String moodUpset;
  final String moodGrateful;
  final String moodPeaceful;
  final String moodHappy;
  // ── Diary Lock ───────────────────────────────────────
  final String lockTitle;
  final String lockSubtitle;
  final String lockTooMany;
  // ── Shared Lists ─────────────────────────────────────
  final String sharedTitle;
  final String sharedEmptyTitle;
  final String sharedEmptySubtitle;
  final String sharedEmptyCta;
  final String sharedNewTitle;
  final String sharedNewHint;
  final String sharedNewCancel;
  final String sharedNewCreate;
  final String sharedLoadError;
  final String sharedTaskHint;
  final String sharedTasksError;
  final String sharedTasksEmpty;
  final String sharedPending;
  final String sharedCompleted;
  final String sharedDeleteTitle;
  final String sharedDeleteBody;
  final String sharedDeleteConfirm;
  // ── Invite ───────────────────────────────────────────
  final String inviteTitle;
  final String inviteLinkSection;
  final String inviteLinkDesc;
  final String inviteCopyLink;
  final String inviteLinkCopied;
  final String inviteMembersSection;
  final String inviteOnlyYou;
  final String inviteMembersError;
  // ── Profile & Settings ───────────────────────────────
  final String settAccount;
  final String settSharedLists;
  final String settNotifications;
  final String settPrivacy;
  final String settLanguage;
  final String settAppearance;
  final String settAbout;
  // ── Account ──────────────────────────────────────────
  final String accountTitle;
  final String signOut;
  final String deleteAccountLink;
  final String deleteAccountTitle;
  final String deleteAccountBody;
  final String deleteAccountConfirm;
  // ── Notification Settings ────────────────────────────
  final String notifTitle;
  final String notifTaskReminders;
  final String notifStreakAlerts;
  final String notifDefaultReminder;
  final String notifQuietHours;
  final String notifOff;
  // ── Diary Lock Settings ──────────────────────────────
  final String lockSettTitle;
  final String lockSettToggle;
  final String lockSettChangePin;
  final String lockSettRemovePin;
  final String lockSettRemoveTitle;
  final String lockSettRemoveBody;
  // ── Set PIN ──────────────────────────────────────────
  final String pinNewTitle;
  final String pinNewSubtitle;
  final String pinConfirmTitle;
  final String pinConfirmSubtitle;
  // ── Stats ────────────────────────────────────────────
  final String statStreak;
  final String statDays;
  final String statTasksDone;
  final String statEntries;
  final String statWeek;
  final String statRemaining;
  final String statRemainingToday;
  // ── Notifications (push) ─────────────────────────────
  final String notifSet;
  final String notifSetBody;
  final String notifDue;
  final String notifOverdue;
  final String notifSnoozeDone;
  final String notifCatSelf;
  final String notifCatWork;
  final String notifCatFamily;
  final String notifCatDeen;
  final String notifCatHome;
  final String notifActionDismiss;
  final String notifActionSnooze;
  // ── Tab Bar ──────────────────────────────────────────
  final String tabToday;
  final String tabCalendar;
  final String tabDiary;
  final String tabProfile;
  // ── Category Names ───────────────────────────────────
  final String catSelf;
  final String catWork;
  final String catFamily;
  final String catDeen;
  final String catHome;

  // ═════════════════════════════════════════════════════════
  //  URDU (Roman)
  // ═════════════════════════════════════════════════════════
  static const ur = AppStrings._(
    appName: 'Yaad',
    back: 'Back',
    cancel: 'Cancel',
    save: 'Save',
    done: 'Done',
    no: 'Nahi',
    yes: 'Haan',
    today: 'Today',
    tomorrow: 'Tomorrow',
    routeNotFound: 'Ye page nahi mila',
    splashTagline: 'yaadon ki kitaab',
    // Auth
    signInTitle: 'Yaad',
    signInSubtitle: 'Apni yaadein wapas lao',
    emailHint: 'Email',
    passwordHint: 'Password',
    nameHint: 'Naam',
    forgotPassword: 'Bhool gaye?',
    signInButton: 'Daakhil hoon',
    googleSignIn: 'Google se daakhil hoon',
    newHere: 'Naye hain?',
    createAccount: 'Account banao',
    alreadyHaveAccount: 'Pehle se hain?',
    signInLink: 'Daakhil hoon',
    resetLinkSent: 'Reset link bhej diya — email check karein',
    signUpTitle: 'Account banao',
    signUpSubtitle: 'Yaad mein khush aamdeed',
    signUpButton: 'Account banao',
    // Auth errors
    errUserNotFound: 'Email registered nahi hai',
    errWrongPassword: 'Galat password',
    errEmailInUse: 'Email pehle se registered hai',
    errWeakPassword: 'Password kamzor hai — 6+ haroof',
    errNoInternet: 'Internet connection check karein',
    errInvalidEmail: 'Email sahi nahi hai',
    errTooManyRequests: 'Zyada koshishein — thodi der baad try karein',
    errInvalidCredential: 'Email ya password galat hai',
    errRecentLogin: 'Dobara login karein phir try karein',
    errGeneric: 'Kuch gadbad ho gayi',
    // Onboarding
    onb1Step: '01 / 03',
    onb1Title: 'Apne din ko ',
    onb1TitleItalic: 'sambhalo',
    onb1Desc:
        'Rozana ke kaam, yaadein, aur lamhaat — sab ek jagah. Simple, khoobsurat, aur sirf tumhara.',
    onb1Btn: 'Aage barho',
    onb2Step: '02 / 03',
    onb2Title: 'Apne ',
    onb2TitleItalic: 'khayal',
    onb2TitleAfter: ' mehfooz',
    onb2Desc:
        'Diary likho jo sirf tumhari ho. PIN se locked — koi aur kabhi nahi padhega.',
    onb2Btn: 'Aage barho',
    onb3Step: '03 / 03',
    onb3Title: 'Tumhari ',
    onb3TitleItalic: 'kahaani',
    onb3TitleAfter: ', tumhari rakhwali',
    onb3Desc:
        'Cloud sync, end-to-end protected. Tumhari yaadein sirf tumhare paas. Hum sirf dekhne wale hain.',
    onb3Btn: 'Shuru karte hain',
    skip: 'Skip',
    // Home
    greetMorning: 'Subah bakhair',
    greetAfternoon: 'Dopeher bakhair',
    greetEvening: 'Shaam bakhair',
    greetNamePrefix: 'Salaam, ',
    sharedLists: 'Saath mein',
    completed: 'mukammal',
    remaining: 'baaqi',
    emptyTodayTitle: 'Sukoon ka din',
    emptyTodaySubtitle: 'Aaj koi kaam nahi — saans lo',
    addTaskCta: 'Kaam add karein',
    addTaskTooltip: 'Naya kaam add karein',
    tasksLoadError: 'Tasks load nahi ho sakay',
    dayNames: ['Itwar', 'Peer', 'Mangal', 'Budh', 'Jumeraat', 'Juma', 'Hafta'],
    // Add Task Modal
    newTaskTitle: 'Naya ',
    newTaskTitleItalic: 'kaam',
    taskNameHint: 'Kaam ka naam...',
    dateLabel: 'Date',
    timeLabel: 'Time',
    setTime: 'Set time',
    repeatLabel: 'Repeat',
    remindLabel: 'Remind',
    alarmLabel: 'Alarm',
    notesHint: 'Notes likho... (optional)',
    never: 'Never',
    daily: 'Daily',
    weekly: 'Weekly',
    monthly: 'Monthly',
    atTime: 'At time',
    minBefore: 'min before',
    hourBefore: 'hour before',
    // Task Item
    deleteTaskTitle: 'Kaam hatayein?',
    deleteTaskBody: 'ko hata dein?',
    confirmDelete: 'Haan, hatao',
    // Alarm
    alarmTimeUp: 'Waqt ho gaya!',
    alarmSnooze: '5 min baad',
    alarmDismiss: 'Band karo',
    // Calendar
    calTasksHeader: 'Aaj ke kaam',
    calEmptyTitle: 'Koi kaam nahi',
    calEmptySubtitle: 'Is din kuch schedule nahi hai',
    calRemaining: 'baaqi',
    monthNames: [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ],
    // Diary
    diaryTitle: 'Diary',
    diaryLocked: 'Mehfooz',
    diaryUnlocked: 'Khula',
    diaryLoadError: 'Diary entries load nahi ho sakeen',
    diaryWriteTooltip: 'Nayi diary entry likhein',
    diaryEmptyTitle: 'Pehla khayal',
    diaryEmptySubtitle: 'Apni pehli yaad yahan darz karein',
    diaryEmptyCta: 'Likhna shuru karein',
    diaryDeleteTitle: 'Entry mitayein?',
    diaryDeleteBody: 'ko mita dein?',
    diaryDeleteConfirm: 'Haan, mitao',
    diaryLeaveTitleText: 'Likhai chor dein?',
    diaryLeaveBody: 'Jo likha hai woh save nahi hoga.',
    diaryLeaveConfirm: 'Haan, chor do',
    diaryTitleHint: 'Aaj ka unwan...',
    diaryBodyHint: 'Apne khayal yahaan likho...',
    // Moods
    moodTired: 'Tired',
    moodUpset: 'Pareshan',
    moodGrateful: 'Shukar',
    moodPeaceful: 'Sukoon',
    moodHappy: 'Khush',
    // Diary Lock
    lockTitle: 'Diary kholein',
    lockSubtitle: 'Apna PIN daalo',
    lockTooMany: 'Bohat zyada koshishein — baad mein aayein',
    // Shared Lists
    sharedTitle: 'Saath mein',
    sharedEmptyTitle: 'Saath mein kaam',
    sharedEmptySubtitle: 'Kisi ke saath mil ke list banao',
    sharedEmptyCta: 'List banao',
    sharedNewTitle: 'Naya shared list',
    sharedNewHint: 'List ka naam',
    sharedNewCancel: 'Ruko',
    sharedNewCreate: 'Banao',
    sharedLoadError: 'Lists load nahi ho sakeen',
    sharedTaskHint: 'Naya kaam likho...',
    sharedTasksError: 'Tasks load nahi ho sakay',
    sharedTasksEmpty: 'Abhi koi task nahi — add karo!',
    sharedPending: 'Baqi kaam',
    sharedCompleted: 'Mukammal',
    sharedDeleteTitle: 'List delete karein?',
    sharedDeleteBody:
        'Ye list aur saaray tasks permanently delete ho jaayenge.',
    sharedDeleteConfirm: 'Haan, delete karo',
    // Invite
    inviteTitle: 'Invite karo',
    inviteLinkSection: 'Invite link share karo',
    inviteLinkDesc: 'Jo bhi ye link khole, woh is list mein shaamil ho jaayega',
    inviteCopyLink: 'Link copy karo',
    inviteLinkCopied: 'Link copy ho gaya!',
    inviteMembersSection: 'Members',
    inviteOnlyYou: 'Sirf aap',
    inviteMembersError: 'Members load nahi ho sakay',
    // Profile
    settAccount: 'Account',
    settSharedLists: 'Shared Lists',
    settNotifications: 'Notifications',
    settPrivacy: 'Privacy',
    settLanguage: 'Language',
    settAppearance: 'Appearance',
    settAbout: 'About',
    // Account
    accountTitle: 'Account',
    signOut: 'Sign Out',
    deleteAccountLink: 'Account delete karein',
    deleteAccountTitle: 'Waqai delete karein?',
    deleteAccountBody: 'Ye wapas nahi hoga. Saara data mit jaayega.',
    deleteAccountConfirm: 'Haan, delete karo',
    // Notification Settings
    notifTitle: 'Notifications',
    notifTaskReminders: 'Task reminders',
    notifStreakAlerts: 'Streak alerts',
    notifDefaultReminder: 'Default reminder',
    notifQuietHours: 'Quiet hours',
    notifOff: 'Off',
    // Diary Lock Settings
    lockSettTitle: 'Diary Lock',
    lockSettToggle: 'Diary lock',
    lockSettChangePin: 'Change PIN',
    lockSettRemovePin: 'Remove PIN',
    lockSettRemoveTitle: 'PIN hatana chahte ho?',
    lockSettRemoveBody: 'Diary ka lock hat jaayega.',
    // Set PIN
    pinNewTitle: 'Naya PIN banao',
    pinNewSubtitle: '6 digit ka PIN choose karo',
    pinConfirmTitle: 'Dobara daalo',
    pinConfirmSubtitle: 'Confirm karne ke liye wahi PIN daalo',
    // Stats
    statStreak: 'Streak',
    statDays: 'din',
    statTasksDone: 'Tasks done',
    statEntries: 'Entries',
    statWeek: 'Hafte',
    statRemaining: 'Baaqi',
    statRemainingToday: 'aaj ke',
    // Notifications (push)
    notifSet: 'Yaad set!',
    notifSetBody: 'ka reminder laga diya',
    notifDue: 'Waqt ho gaya — abhi kar lo!',
    notifOverdue: 'Yeh kaam abhi tak baaqi hai!',
    notifSnoozeDone: 'Snooze khatam — ab kar lo!',
    notifCatSelf: 'Apna khayal rakho',
    notifCatWork: 'Kaam ka waqt aa gaya',
    notifCatFamily: 'Family important hai',
    notifCatDeen: 'Waqt ki pabandi karo',
    notifCatHome: 'Ghar ka kaam yaad hai',
    notifActionDismiss: 'Band karo',
    notifActionSnooze: '5 min baad',
    // Tab Bar
    tabToday: 'Aaj',
    tabCalendar: 'Mahina',
    tabDiary: 'Diary',
    tabProfile: 'Mein',
    // Category Names
    catSelf: 'Self',
    catWork: 'Work',
    catFamily: 'Family',
    catDeen: 'Deen',
    catHome: 'Ghar',
  );

  // ═════════════════════════════════════════════════════════
  //  ENGLISH
  // ═════════════════════════════════════════════════════════
  static const en = AppStrings._(
    appName: 'Yaad',
    back: 'Back',
    cancel: 'Cancel',
    save: 'Save',
    done: 'Done',
    no: 'No',
    yes: 'Yes',
    today: 'Today',
    tomorrow: 'Tomorrow',
    routeNotFound: 'Page not found',
    splashTagline: 'book of memories',
    // Auth
    signInTitle: 'Yaad',
    signInSubtitle: 'Your memories, all in one place',
    emailHint: 'Email',
    passwordHint: 'Password',
    nameHint: 'Full name',
    forgotPassword: 'Forgot password?',
    signInButton: 'Sign In',
    googleSignIn: 'Sign in with Google',
    newHere: 'New here?',
    createAccount: 'Create account',
    alreadyHaveAccount: 'Already have an account?',
    signInLink: 'Sign In',
    resetLinkSent: 'Reset link sent — check your email',
    signUpTitle: 'Create Account',
    signUpSubtitle: 'Welcome to Yaad',
    signUpButton: 'Create Account',
    // Auth errors
    errUserNotFound: 'No account found with this email',
    errWrongPassword: 'Incorrect password',
    errEmailInUse: 'This email is already registered',
    errWeakPassword: 'Password is too weak — use 6+ characters',
    errNoInternet: 'Please check your internet connection',
    errInvalidEmail: 'Please enter a valid email',
    errTooManyRequests: 'Too many attempts — try again later',
    errInvalidCredential: 'Incorrect email or password',
    errRecentLogin: 'Please sign in again and retry',
    errGeneric: 'Something went wrong',
    // Onboarding
    onb1Step: '01 / 03',
    onb1Title: 'Organize your ',
    onb1TitleItalic: 'day',
    onb1Desc:
        'Tasks, memories, and moments — all in one place. Simple, beautiful, and yours alone.',
    onb1Btn: 'Continue',
    onb2Step: '02 / 03',
    onb2Title: 'Your ',
    onb2TitleItalic: 'thoughts',
    onb2TitleAfter: ', protected',
    onb2Desc:
        'Write a diary that belongs only to you. Locked with a PIN — no one else can ever read it.',
    onb2Btn: 'Continue',
    onb3Step: '03 / 03',
    onb3Title: 'Your ',
    onb3TitleItalic: 'story',
    onb3TitleAfter: ', your vault',
    onb3Desc:
        'Cloud synced and end-to-end protected. Your memories stay with you. We just keep them safe.',
    onb3Btn: 'Get Started',
    skip: 'Skip',
    // Home
    greetMorning: 'Good morning',
    greetAfternoon: 'Good afternoon',
    greetEvening: 'Good evening',
    greetNamePrefix: 'Hello, ',
    sharedLists: 'Shared',
    completed: 'done',
    remaining: 'left',
    emptyTodayTitle: 'All clear',
    emptyTodaySubtitle: 'Nothing scheduled for today — take a breather',
    addTaskCta: 'Add a task',
    addTaskTooltip: 'Add a new task',
    tasksLoadError: 'Could not load tasks',
    dayNames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    // Add Task Modal
    newTaskTitle: 'New ',
    newTaskTitleItalic: 'task',
    taskNameHint: 'Task name...',
    dateLabel: 'Date',
    timeLabel: 'Time',
    setTime: 'Set time',
    repeatLabel: 'Repeat',
    remindLabel: 'Remind',
    alarmLabel: 'Alarm',
    notesHint: 'Add notes... (optional)',
    never: 'Never',
    daily: 'Daily',
    weekly: 'Weekly',
    monthly: 'Monthly',
    atTime: 'At time',
    minBefore: 'min before',
    hourBefore: 'hour before',
    // Task Item
    deleteTaskTitle: 'Delete task?',
    deleteTaskBody: 'will be removed.',
    confirmDelete: 'Yes, delete',
    // Alarm
    alarmTimeUp: "Time's up!",
    alarmSnooze: '5 min later',
    alarmDismiss: 'Dismiss',
    // Calendar
    calTasksHeader: "Today's tasks",
    calEmptyTitle: 'No tasks',
    calEmptySubtitle: 'Nothing scheduled for this day',
    calRemaining: 'left',
    monthNames: [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ],
    // Diary
    diaryTitle: 'Diary',
    diaryLocked: 'Locked',
    diaryUnlocked: 'Open',
    diaryLoadError: 'Could not load diary entries',
    diaryWriteTooltip: 'Write a new entry',
    diaryEmptyTitle: 'First thought',
    diaryEmptySubtitle: 'Capture your first memory here',
    diaryEmptyCta: 'Start writing',
    diaryDeleteTitle: 'Delete entry?',
    diaryDeleteBody: 'will be deleted.',
    diaryDeleteConfirm: 'Yes, delete',
    diaryLeaveTitleText: 'Discard changes?',
    diaryLeaveBody: 'Your unsaved changes will be lost.',
    diaryLeaveConfirm: 'Yes, discard',
    diaryTitleHint: 'Title...',
    diaryBodyHint: 'Write your thoughts here...',
    // Moods
    moodTired: 'Tired',
    moodUpset: 'Upset',
    moodGrateful: 'Grateful',
    moodPeaceful: 'Peaceful',
    moodHappy: 'Happy',
    // Diary Lock
    lockTitle: 'Open Diary',
    lockSubtitle: 'Enter your PIN',
    lockTooMany: 'Too many attempts — try again later',
    // Shared Lists
    sharedTitle: 'Shared',
    sharedEmptyTitle: 'Collaborate',
    sharedEmptySubtitle: 'Create a shared list with anyone',
    sharedEmptyCta: 'Create list',
    sharedNewTitle: 'New shared list',
    sharedNewHint: 'List name',
    sharedNewCancel: 'Cancel',
    sharedNewCreate: 'Create',
    sharedLoadError: 'Could not load lists',
    sharedTaskHint: 'Add a new task...',
    sharedTasksError: 'Could not load tasks',
    sharedTasksEmpty: 'No tasks yet — add one!',
    sharedPending: 'Pending',
    sharedCompleted: 'Completed',
    sharedDeleteTitle: 'Delete list?',
    sharedDeleteBody:
        'This list and all its tasks will be permanently deleted.',
    sharedDeleteConfirm: 'Yes, delete',
    // Invite
    inviteTitle: 'Invite',
    inviteLinkSection: 'Share invite link',
    inviteLinkDesc: 'Anyone who opens this link will join this list',
    inviteCopyLink: 'Copy link',
    inviteLinkCopied: 'Link copied!',
    inviteMembersSection: 'Members',
    inviteOnlyYou: 'Just you',
    inviteMembersError: 'Could not load members',
    // Profile
    settAccount: 'Account',
    settSharedLists: 'Shared Lists',
    settNotifications: 'Notifications',
    settPrivacy: 'Privacy',
    settLanguage: 'Language',
    settAppearance: 'Appearance',
    settAbout: 'About',
    // Account
    accountTitle: 'Account',
    signOut: 'Sign Out',
    deleteAccountLink: 'Delete account',
    deleteAccountTitle: 'Delete account?',
    deleteAccountBody: 'This cannot be undone. All your data will be erased.',
    deleteAccountConfirm: 'Yes, delete',
    // Notification Settings
    notifTitle: 'Notifications',
    notifTaskReminders: 'Task reminders',
    notifStreakAlerts: 'Streak alerts',
    notifDefaultReminder: 'Default reminder',
    notifQuietHours: 'Quiet hours',
    notifOff: 'Off',
    // Diary Lock Settings
    lockSettTitle: 'Diary Lock',
    lockSettToggle: 'Diary lock',
    lockSettChangePin: 'Change PIN',
    lockSettRemovePin: 'Remove PIN',
    lockSettRemoveTitle: 'Remove PIN?',
    lockSettRemoveBody: 'Your diary lock will be removed.',
    // Set PIN
    pinNewTitle: 'Create new PIN',
    pinNewSubtitle: 'Choose a 6-digit PIN',
    pinConfirmTitle: 'Confirm PIN',
    pinConfirmSubtitle: 'Enter the same PIN again',
    // Stats
    statStreak: 'Streak',
    statDays: 'days',
    statTasksDone: 'Tasks done',
    statEntries: 'Entries',
    statWeek: 'Week',
    statRemaining: 'Left',
    statRemainingToday: 'today',
    // Notifications (push)
    notifSet: 'Reminder set!',
    notifSetBody: 'reminder is active',
    notifDue: "Time's up — get it done!",
    notifOverdue: 'This task is still pending!',
    notifSnoozeDone: 'Snooze over — time to act!',
    notifCatSelf: 'Take care of yourself',
    notifCatWork: 'Time to work',
    notifCatFamily: 'Family matters',
    notifCatDeen: 'Stay on schedule',
    notifCatHome: 'Home tasks waiting',
    notifActionDismiss: 'Dismiss',
    notifActionSnooze: '5 min later',
    // Tab Bar
    tabToday: 'Today',
    tabCalendar: 'Calendar',
    tabDiary: 'Diary',
    tabProfile: 'Profile',
    // Category Names
    catSelf: 'Self',
    catWork: 'Work',
    catFamily: 'Family',
    catDeen: 'Faith',
    catHome: 'Home',
  );
}

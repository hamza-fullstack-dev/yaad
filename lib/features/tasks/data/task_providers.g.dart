// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'105bd8a8ef41e172ff5db2d8e451479a0697fd42';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
String _$taskRepositoryHash() => r'eceae62c73b0becba0041fc38059b56ab072669a';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = AutoDisposeProviderRef<TaskRepository>;
String _$taskSyncServiceHash() => r'081f34e839c68eba2c0b40024969a7043c12f486';

/// See also [taskSyncService].
@ProviderFor(taskSyncService)
final taskSyncServiceProvider = Provider<TaskSyncService>.internal(
  taskSyncService,
  name: r'taskSyncServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskSyncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskSyncServiceRef = ProviderRef<TaskSyncService>;
String _$todayTasksHash() => r'f0b35d26a958fbe9203fdbb29d15a8094e86fc5d';

/// See also [todayTasks].
@ProviderFor(todayTasks)
final todayTasksProvider = AutoDisposeStreamProvider<List<Task>>.internal(
  todayTasks,
  name: r'todayTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayTasksRef = AutoDisposeStreamProviderRef<List<Task>>;
String _$allTasksHash() => r'415081f89b290860e2652ab2de064d271850d124';

/// See also [allTasks].
@ProviderFor(allTasks)
final allTasksProvider = AutoDisposeStreamProvider<List<Task>>.internal(
  allTasks,
  name: r'allTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllTasksRef = AutoDisposeStreamProviderRef<List<Task>>;
String _$tasksByDateHash() => r'4a60ffb2c5fec246af4564a0abe098f386f8616b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [tasksByDate].
@ProviderFor(tasksByDate)
const tasksByDateProvider = TasksByDateFamily();

/// See also [tasksByDate].
class TasksByDateFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [tasksByDate].
  const TasksByDateFamily();

  /// See also [tasksByDate].
  TasksByDateProvider call(
    DateTime date,
  ) {
    return TasksByDateProvider(
      date,
    );
  }

  @override
  TasksByDateProvider getProviderOverride(
    covariant TasksByDateProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tasksByDateProvider';
}

/// See also [tasksByDate].
class TasksByDateProvider extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [tasksByDate].
  TasksByDateProvider(
    DateTime date,
  ) : this._internal(
          (ref) => tasksByDate(
            ref as TasksByDateRef,
            date,
          ),
          from: tasksByDateProvider,
          name: r'tasksByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tasksByDateHash,
          dependencies: TasksByDateFamily._dependencies,
          allTransitiveDependencies:
              TasksByDateFamily._allTransitiveDependencies,
          date: date,
        );

  TasksByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    Stream<List<Task>> Function(TasksByDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TasksByDateProvider._internal(
        (ref) => create(ref as TasksByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Task>> createElement() {
    return _TasksByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TasksByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TasksByDateRef on AutoDisposeStreamProviderRef<List<Task>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _TasksByDateProviderElement
    extends AutoDisposeStreamProviderElement<List<Task>> with TasksByDateRef {
  _TasksByDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as TasksByDateProvider).date;
}

String _$currentStreakHash() => r'bfad9f85c16bbb90599db77804d0a4c4117fa442';

/// See also [currentStreak].
@ProviderFor(currentStreak)
final currentStreakProvider = AutoDisposeStreamProvider<int>.internal(
  currentStreak,
  name: r'currentStreakProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentStreakHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentStreakRef = AutoDisposeStreamProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_list_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedListRepositoryHash() =>
    r'21fb9ff7e21e69ac663521f495f5075cf5127e3f';

/// See also [sharedListRepository].
@ProviderFor(sharedListRepository)
final sharedListRepositoryProvider = Provider<SharedListRepository>.internal(
  sharedListRepository,
  name: r'sharedListRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedListRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedListRepositoryRef = ProviderRef<SharedListRepository>;
String _$sharedListTaskRepositoryHash() =>
    r'c3518515ffedfb8b2cedbcdb71f13d7623141e70';

/// See also [sharedListTaskRepository].
@ProviderFor(sharedListTaskRepository)
final sharedListTaskRepositoryProvider =
    Provider<SharedListTaskRepository>.internal(
  sharedListTaskRepository,
  name: r'sharedListTaskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedListTaskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedListTaskRepositoryRef = ProviderRef<SharedListTaskRepository>;
String _$userSharedListsHash() => r'5fbc1c928a7b0adec986110316398c0095d2d682';

/// See also [userSharedLists].
@ProviderFor(userSharedLists)
final userSharedListsProvider =
    AutoDisposeStreamProvider<List<SharedList>>.internal(
  userSharedLists,
  name: r'userSharedListsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userSharedListsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserSharedListsRef = AutoDisposeStreamProviderRef<List<SharedList>>;
String _$sharedListTasksHash() => r'b5bce43d855aa3cb9686d507269c22be68116066';

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

/// See also [sharedListTasks].
@ProviderFor(sharedListTasks)
const sharedListTasksProvider = SharedListTasksFamily();

/// See also [sharedListTasks].
class SharedListTasksFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [sharedListTasks].
  const SharedListTasksFamily();

  /// See also [sharedListTasks].
  SharedListTasksProvider call(
    String listId,
  ) {
    return SharedListTasksProvider(
      listId,
    );
  }

  @override
  SharedListTasksProvider getProviderOverride(
    covariant SharedListTasksProvider provider,
  ) {
    return call(
      provider.listId,
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
  String? get name => r'sharedListTasksProvider';
}

/// See also [sharedListTasks].
class SharedListTasksProvider extends AutoDisposeStreamProvider<List<Task>> {
  /// See also [sharedListTasks].
  SharedListTasksProvider(
    String listId,
  ) : this._internal(
          (ref) => sharedListTasks(
            ref as SharedListTasksRef,
            listId,
          ),
          from: sharedListTasksProvider,
          name: r'sharedListTasksProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sharedListTasksHash,
          dependencies: SharedListTasksFamily._dependencies,
          allTransitiveDependencies:
              SharedListTasksFamily._allTransitiveDependencies,
          listId: listId,
        );

  SharedListTasksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    Stream<List<Task>> Function(SharedListTasksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SharedListTasksProvider._internal(
        (ref) => create(ref as SharedListTasksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Task>> createElement() {
    return _SharedListTasksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SharedListTasksProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SharedListTasksRef on AutoDisposeStreamProviderRef<List<Task>> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _SharedListTasksProviderElement
    extends AutoDisposeStreamProviderElement<List<Task>>
    with SharedListTasksRef {
  _SharedListTasksProviderElement(super.provider);

  @override
  String get listId => (origin as SharedListTasksProvider).listId;
}

String _$sharedListMembersHash() => r'd0f8727f883b41fe91d486a376941e50fb3f3405';

/// See also [sharedListMembers].
@ProviderFor(sharedListMembers)
const sharedListMembersProvider = SharedListMembersFamily();

/// See also [sharedListMembers].
class SharedListMembersFamily extends Family<AsyncValue<List<ListMember>>> {
  /// See also [sharedListMembers].
  const SharedListMembersFamily();

  /// See also [sharedListMembers].
  SharedListMembersProvider call(
    String listId,
  ) {
    return SharedListMembersProvider(
      listId,
    );
  }

  @override
  SharedListMembersProvider getProviderOverride(
    covariant SharedListMembersProvider provider,
  ) {
    return call(
      provider.listId,
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
  String? get name => r'sharedListMembersProvider';
}

/// See also [sharedListMembers].
class SharedListMembersProvider
    extends AutoDisposeStreamProvider<List<ListMember>> {
  /// See also [sharedListMembers].
  SharedListMembersProvider(
    String listId,
  ) : this._internal(
          (ref) => sharedListMembers(
            ref as SharedListMembersRef,
            listId,
          ),
          from: sharedListMembersProvider,
          name: r'sharedListMembersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sharedListMembersHash,
          dependencies: SharedListMembersFamily._dependencies,
          allTransitiveDependencies:
              SharedListMembersFamily._allTransitiveDependencies,
          listId: listId,
        );

  SharedListMembersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    Stream<List<ListMember>> Function(SharedListMembersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SharedListMembersProvider._internal(
        (ref) => create(ref as SharedListMembersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ListMember>> createElement() {
    return _SharedListMembersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SharedListMembersProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SharedListMembersRef on AutoDisposeStreamProviderRef<List<ListMember>> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _SharedListMembersProviderElement
    extends AutoDisposeStreamProviderElement<List<ListMember>>
    with SharedListMembersRef {
  _SharedListMembersProviderElement(super.provider);

  @override
  String get listId => (origin as SharedListMembersProvider).listId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$diaryRepositoryHash() => r'0398523d9af6b94db36a23bd87df9012157f1ac9';

/// See also [diaryRepository].
@ProviderFor(diaryRepository)
final diaryRepositoryProvider = AutoDisposeProvider<DiaryRepository>.internal(
  diaryRepository,
  name: r'diaryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$diaryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DiaryRepositoryRef = AutoDisposeProviderRef<DiaryRepository>;
String _$diarySyncServiceHash() => r'6090e2b4fd40f385994bee924b5dd8254fb28a0c';

/// See also [diarySyncService].
@ProviderFor(diarySyncService)
final diarySyncServiceProvider = Provider<DiarySyncService>.internal(
  diarySyncService,
  name: r'diarySyncServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$diarySyncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DiarySyncServiceRef = ProviderRef<DiarySyncService>;
String _$allDiaryEntriesHash() => r'72016fa700fb2d97829c5e5a07911b485cb58f2f';

/// See also [allDiaryEntries].
@ProviderFor(allDiaryEntries)
final allDiaryEntriesProvider =
    AutoDisposeStreamProvider<List<DiaryEntry>>.internal(
  allDiaryEntries,
  name: r'allDiaryEntriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allDiaryEntriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllDiaryEntriesRef = AutoDisposeStreamProviderRef<List<DiaryEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

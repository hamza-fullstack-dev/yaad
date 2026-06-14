// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SharedList _$SharedListFromJson(Map<String, dynamic> json) {
  return _SharedList.fromJson(json);
}

/// @nodoc
mixin _$SharedList {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  List<String> get collaboratorIds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SharedList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SharedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SharedListCopyWith<SharedList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedListCopyWith<$Res> {
  factory $SharedListCopyWith(
          SharedList value, $Res Function(SharedList) then) =
      _$SharedListCopyWithImpl<$Res, SharedList>;
  @useResult
  $Res call(
      {String id,
      String name,
      String ownerId,
      String ownerName,
      List<String> collaboratorIds,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$SharedListCopyWithImpl<$Res, $Val extends SharedList>
    implements $SharedListCopyWith<$Res> {
  _$SharedListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SharedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerId = null,
    Object? ownerName = null,
    Object? collaboratorIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      collaboratorIds: null == collaboratorIds
          ? _value.collaboratorIds
          : collaboratorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SharedListImplCopyWith<$Res>
    implements $SharedListCopyWith<$Res> {
  factory _$$SharedListImplCopyWith(
          _$SharedListImpl value, $Res Function(_$SharedListImpl) then) =
      __$$SharedListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String ownerId,
      String ownerName,
      List<String> collaboratorIds,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$SharedListImplCopyWithImpl<$Res>
    extends _$SharedListCopyWithImpl<$Res, _$SharedListImpl>
    implements _$$SharedListImplCopyWith<$Res> {
  __$$SharedListImplCopyWithImpl(
      _$SharedListImpl _value, $Res Function(_$SharedListImpl) _then)
      : super(_value, _then);

  /// Create a copy of SharedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerId = null,
    Object? ownerName = null,
    Object? collaboratorIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SharedListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      collaboratorIds: null == collaboratorIds
          ? _value._collaboratorIds
          : collaboratorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SharedListImpl implements _SharedList {
  const _$SharedListImpl(
      {required this.id,
      required this.name,
      required this.ownerId,
      required this.ownerName,
      final List<String> collaboratorIds = const [],
      required this.createdAt,
      required this.updatedAt})
      : _collaboratorIds = collaboratorIds;

  factory _$SharedListImpl.fromJson(Map<String, dynamic> json) =>
      _$$SharedListImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String ownerId;
  @override
  final String ownerName;
  final List<String> _collaboratorIds;
  @override
  @JsonKey()
  List<String> get collaboratorIds {
    if (_collaboratorIds is EqualUnmodifiableListView) return _collaboratorIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collaboratorIds);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SharedList(id: $id, name: $name, ownerId: $ownerId, ownerName: $ownerName, collaboratorIds: $collaboratorIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SharedListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            const DeepCollectionEquality()
                .equals(other._collaboratorIds, _collaboratorIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      ownerId,
      ownerName,
      const DeepCollectionEquality().hash(_collaboratorIds),
      createdAt,
      updatedAt);

  /// Create a copy of SharedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SharedListImplCopyWith<_$SharedListImpl> get copyWith =>
      __$$SharedListImplCopyWithImpl<_$SharedListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SharedListImplToJson(
      this,
    );
  }
}

abstract class _SharedList implements SharedList {
  const factory _SharedList(
      {required final String id,
      required final String name,
      required final String ownerId,
      required final String ownerName,
      final List<String> collaboratorIds,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$SharedListImpl;

  factory _SharedList.fromJson(Map<String, dynamic> json) =
      _$SharedListImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get ownerId;
  @override
  String get ownerName;
  @override
  List<String> get collaboratorIds;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of SharedList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SharedListImplCopyWith<_$SharedListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

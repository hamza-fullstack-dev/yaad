// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

YaadUser _$YaadUserFromJson(Map<String, dynamic> json) {
  return _YaadUser.fromJson(json);
}

/// @nodoc
mixin _$YaadUser {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this YaadUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YaadUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YaadUserCopyWith<YaadUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YaadUserCopyWith<$Res> {
  factory $YaadUserCopyWith(YaadUser value, $Res Function(YaadUser) then) =
      _$YaadUserCopyWithImpl<$Res, YaadUser>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoUrl,
      DateTime createdAt});
}

/// @nodoc
class _$YaadUserCopyWithImpl<$Res, $Val extends YaadUser>
    implements $YaadUserCopyWith<$Res> {
  _$YaadUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YaadUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YaadUserImplCopyWith<$Res>
    implements $YaadUserCopyWith<$Res> {
  factory _$$YaadUserImplCopyWith(
          _$YaadUserImpl value, $Res Function(_$YaadUserImpl) then) =
      __$$YaadUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoUrl,
      DateTime createdAt});
}

/// @nodoc
class __$$YaadUserImplCopyWithImpl<$Res>
    extends _$YaadUserCopyWithImpl<$Res, _$YaadUserImpl>
    implements _$$YaadUserImplCopyWith<$Res> {
  __$$YaadUserImplCopyWithImpl(
      _$YaadUserImpl _value, $Res Function(_$YaadUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of YaadUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$YaadUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YaadUserImpl implements _YaadUser {
  const _$YaadUserImpl(
      {required this.uid,
      required this.email,
      this.displayName,
      this.photoUrl,
      required this.createdAt});

  factory _$YaadUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$YaadUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'YaadUser(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YaadUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, email, displayName, photoUrl, createdAt);

  /// Create a copy of YaadUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YaadUserImplCopyWith<_$YaadUserImpl> get copyWith =>
      __$$YaadUserImplCopyWithImpl<_$YaadUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YaadUserImplToJson(
      this,
    );
  }
}

abstract class _YaadUser implements YaadUser {
  const factory _YaadUser(
      {required final String uid,
      required final String email,
      final String? displayName,
      final String? photoUrl,
      required final DateTime createdAt}) = _$YaadUserImpl;

  factory _YaadUser.fromJson(Map<String, dynamic> json) =
      _$YaadUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  DateTime get createdAt;

  /// Create a copy of YaadUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YaadUserImplCopyWith<_$YaadUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_write_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DiaryWriteState {
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  Mood get mood => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  String? get editingId => throw _privateConstructorUsedError;

  /// Create a copy of DiaryWriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiaryWriteStateCopyWith<DiaryWriteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryWriteStateCopyWith<$Res> {
  factory $DiaryWriteStateCopyWith(
          DiaryWriteState value, $Res Function(DiaryWriteState) then) =
      _$DiaryWriteStateCopyWithImpl<$Res, DiaryWriteState>;
  @useResult
  $Res call(
      {String title, String body, Mood mood, bool isSaving, String? editingId});
}

/// @nodoc
class _$DiaryWriteStateCopyWithImpl<$Res, $Val extends DiaryWriteState>
    implements $DiaryWriteStateCopyWith<$Res> {
  _$DiaryWriteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiaryWriteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? mood = null,
    Object? isSaving = null,
    Object? editingId = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as Mood,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      editingId: freezed == editingId
          ? _value.editingId
          : editingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiaryWriteStateImplCopyWith<$Res>
    implements $DiaryWriteStateCopyWith<$Res> {
  factory _$$DiaryWriteStateImplCopyWith(_$DiaryWriteStateImpl value,
          $Res Function(_$DiaryWriteStateImpl) then) =
      __$$DiaryWriteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title, String body, Mood mood, bool isSaving, String? editingId});
}

/// @nodoc
class __$$DiaryWriteStateImplCopyWithImpl<$Res>
    extends _$DiaryWriteStateCopyWithImpl<$Res, _$DiaryWriteStateImpl>
    implements _$$DiaryWriteStateImplCopyWith<$Res> {
  __$$DiaryWriteStateImplCopyWithImpl(
      _$DiaryWriteStateImpl _value, $Res Function(_$DiaryWriteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiaryWriteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? mood = null,
    Object? isSaving = null,
    Object? editingId = freezed,
  }) {
    return _then(_$DiaryWriteStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as Mood,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      editingId: freezed == editingId
          ? _value.editingId
          : editingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DiaryWriteStateImpl implements _DiaryWriteState {
  const _$DiaryWriteStateImpl(
      {this.title = '',
      this.body = '',
      this.mood = Mood.shukar,
      this.isSaving = false,
      this.editingId});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String body;
  @override
  @JsonKey()
  final Mood mood;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final String? editingId;

  @override
  String toString() {
    return 'DiaryWriteState(title: $title, body: $body, mood: $mood, isSaving: $isSaving, editingId: $editingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryWriteStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.mood, mood) || other.mood == mood) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.editingId, editingId) ||
                other.editingId == editingId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, body, mood, isSaving, editingId);

  /// Create a copy of DiaryWriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryWriteStateImplCopyWith<_$DiaryWriteStateImpl> get copyWith =>
      __$$DiaryWriteStateImplCopyWithImpl<_$DiaryWriteStateImpl>(
          this, _$identity);
}

abstract class _DiaryWriteState implements DiaryWriteState {
  const factory _DiaryWriteState(
      {final String title,
      final String body,
      final Mood mood,
      final bool isSaving,
      final String? editingId}) = _$DiaryWriteStateImpl;

  @override
  String get title;
  @override
  String get body;
  @override
  Mood get mood;
  @override
  bool get isSaving;
  @override
  String? get editingId;

  /// Create a copy of DiaryWriteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiaryWriteStateImplCopyWith<_$DiaryWriteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

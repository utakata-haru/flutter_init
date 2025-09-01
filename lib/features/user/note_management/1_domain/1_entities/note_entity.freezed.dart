// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NoteEntity _$NoteEntityFromJson(Map<String, dynamic> json) {
  return _NoteEntity.fromJson(json);
}

/// @nodoc
mixin _$NoteEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NoteEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteEntityCopyWith<NoteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteEntityCopyWith<$Res> {
  factory $NoteEntityCopyWith(
    NoteEntity value,
    $Res Function(NoteEntity) then,
  ) = _$NoteEntityCopyWithImpl<$Res, NoteEntity>;
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$NoteEntityCopyWithImpl<$Res, $Val extends NoteEntity>
    implements $NoteEntityCopyWith<$Res> {
  _$NoteEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NoteEntityImplCopyWith<$Res>
    implements $NoteEntityCopyWith<$Res> {
  factory _$$NoteEntityImplCopyWith(
    _$NoteEntityImpl value,
    $Res Function(_$NoteEntityImpl) then,
  ) = __$$NoteEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$NoteEntityImplCopyWithImpl<$Res>
    extends _$NoteEntityCopyWithImpl<$Res, _$NoteEntityImpl>
    implements _$$NoteEntityImplCopyWith<$Res> {
  __$$NoteEntityImplCopyWithImpl(
    _$NoteEntityImpl _value,
    $Res Function(_$NoteEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NoteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$NoteEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteEntityImpl extends _NoteEntity {
  const _$NoteEntityImpl({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  factory _$NoteEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'NoteEntity(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, content, createdAt, updatedAt);

  /// Create a copy of NoteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteEntityImplCopyWith<_$NoteEntityImpl> get copyWith =>
      __$$NoteEntityImplCopyWithImpl<_$NoteEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteEntityImplToJson(this);
  }
}

abstract class _NoteEntity extends NoteEntity {
  const factory _NoteEntity({
    required final String id,
    required final String title,
    required final String content,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$NoteEntityImpl;
  const _NoteEntity._() : super._();

  factory _NoteEntity.fromJson(Map<String, dynamic> json) =
      _$NoteEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of NoteEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteEntityImplCopyWith<_$NoteEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

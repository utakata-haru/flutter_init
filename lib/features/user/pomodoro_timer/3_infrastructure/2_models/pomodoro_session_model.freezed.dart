// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PomodoroSessionModel _$PomodoroSessionModelFromJson(Map<String, dynamic> json) {
  return _PomodoroSessionModel.fromJson(json);
}

/// @nodoc
mixin _$PomodoroSessionModel {
  String get id => throw _privateConstructorUsedError;
  String get phase => throw _privateConstructorUsedError; // enum を文字列として保存
  int get remainingSeconds => throw _privateConstructorUsedError;
  int get elapsedSeconds => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError; // enum を文字列として保存
  int get completedFocusCount => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;

  /// Serializes this PomodoroSessionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PomodoroSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PomodoroSessionModelCopyWith<PomodoroSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PomodoroSessionModelCopyWith<$Res> {
  factory $PomodoroSessionModelCopyWith(
    PomodoroSessionModel value,
    $Res Function(PomodoroSessionModel) then,
  ) = _$PomodoroSessionModelCopyWithImpl<$Res, PomodoroSessionModel>;
  @useResult
  $Res call({
    String id,
    String phase,
    int remainingSeconds,
    int elapsedSeconds,
    String status,
    int completedFocusCount,
    DateTime startedAt,
  });
}

/// @nodoc
class _$PomodoroSessionModelCopyWithImpl<
  $Res,
  $Val extends PomodoroSessionModel
>
    implements $PomodoroSessionModelCopyWith<$Res> {
  _$PomodoroSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PomodoroSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phase = null,
    Object? remainingSeconds = null,
    Object? elapsedSeconds = null,
    Object? status = null,
    Object? completedFocusCount = null,
    Object? startedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            phase: null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as String,
            remainingSeconds: null == remainingSeconds
                ? _value.remainingSeconds
                : remainingSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            elapsedSeconds: null == elapsedSeconds
                ? _value.elapsedSeconds
                : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            completedFocusCount: null == completedFocusCount
                ? _value.completedFocusCount
                : completedFocusCount // ignore: cast_nullable_to_non_nullable
                      as int,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PomodoroSessionModelImplCopyWith<$Res>
    implements $PomodoroSessionModelCopyWith<$Res> {
  factory _$$PomodoroSessionModelImplCopyWith(
    _$PomodoroSessionModelImpl value,
    $Res Function(_$PomodoroSessionModelImpl) then,
  ) = __$$PomodoroSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phase,
    int remainingSeconds,
    int elapsedSeconds,
    String status,
    int completedFocusCount,
    DateTime startedAt,
  });
}

/// @nodoc
class __$$PomodoroSessionModelImplCopyWithImpl<$Res>
    extends _$PomodoroSessionModelCopyWithImpl<$Res, _$PomodoroSessionModelImpl>
    implements _$$PomodoroSessionModelImplCopyWith<$Res> {
  __$$PomodoroSessionModelImplCopyWithImpl(
    _$PomodoroSessionModelImpl _value,
    $Res Function(_$PomodoroSessionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PomodoroSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phase = null,
    Object? remainingSeconds = null,
    Object? elapsedSeconds = null,
    Object? status = null,
    Object? completedFocusCount = null,
    Object? startedAt = null,
  }) {
    return _then(
      _$PomodoroSessionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as String,
        remainingSeconds: null == remainingSeconds
            ? _value.remainingSeconds
            : remainingSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        elapsedSeconds: null == elapsedSeconds
            ? _value.elapsedSeconds
            : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        completedFocusCount: null == completedFocusCount
            ? _value.completedFocusCount
            : completedFocusCount // ignore: cast_nullable_to_non_nullable
                  as int,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PomodoroSessionModelImpl implements _PomodoroSessionModel {
  const _$PomodoroSessionModelImpl({
    required this.id,
    required this.phase,
    required this.remainingSeconds,
    required this.elapsedSeconds,
    required this.status,
    required this.completedFocusCount,
    required this.startedAt,
  });

  factory _$PomodoroSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PomodoroSessionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String phase;
  // enum を文字列として保存
  @override
  final int remainingSeconds;
  @override
  final int elapsedSeconds;
  @override
  final String status;
  // enum を文字列として保存
  @override
  final int completedFocusCount;
  @override
  final DateTime startedAt;

  @override
  String toString() {
    return 'PomodoroSessionModel(id: $id, phase: $phase, remainingSeconds: $remainingSeconds, elapsedSeconds: $elapsedSeconds, status: $status, completedFocusCount: $completedFocusCount, startedAt: $startedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PomodoroSessionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds) &&
            (identical(other.elapsedSeconds, elapsedSeconds) ||
                other.elapsedSeconds == elapsedSeconds) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.completedFocusCount, completedFocusCount) ||
                other.completedFocusCount == completedFocusCount) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phase,
    remainingSeconds,
    elapsedSeconds,
    status,
    completedFocusCount,
    startedAt,
  );

  /// Create a copy of PomodoroSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PomodoroSessionModelImplCopyWith<_$PomodoroSessionModelImpl>
  get copyWith =>
      __$$PomodoroSessionModelImplCopyWithImpl<_$PomodoroSessionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PomodoroSessionModelImplToJson(this);
  }
}

abstract class _PomodoroSessionModel implements PomodoroSessionModel {
  const factory _PomodoroSessionModel({
    required final String id,
    required final String phase,
    required final int remainingSeconds,
    required final int elapsedSeconds,
    required final String status,
    required final int completedFocusCount,
    required final DateTime startedAt,
  }) = _$PomodoroSessionModelImpl;

  factory _PomodoroSessionModel.fromJson(Map<String, dynamic> json) =
      _$PomodoroSessionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get phase; // enum を文字列として保存
  @override
  int get remainingSeconds;
  @override
  int get elapsedSeconds;
  @override
  String get status; // enum を文字列として保存
  @override
  int get completedFocusCount;
  @override
  DateTime get startedAt;

  /// Create a copy of PomodoroSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PomodoroSessionModelImplCopyWith<_$PomodoroSessionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

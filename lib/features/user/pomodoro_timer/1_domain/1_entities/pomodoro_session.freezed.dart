// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PomodoroSession {
  // セッションID（履歴管理用）
  String get id => throw _privateConstructorUsedError; // 現在のフェーズ
  PomodoroPhase get phase => throw _privateConstructorUsedError; // 残り秒数
  int get remainingSeconds => throw _privateConstructorUsedError; // 経過秒数
  int get elapsedSeconds => throw _privateConstructorUsedError; // 状態
  SessionStatus get status =>
      throw _privateConstructorUsedError; // 完了済みフォーカス数（長休憩判定用）
  int get completedFocusCount => throw _privateConstructorUsedError; // 開始時刻
  DateTime get startedAt => throw _privateConstructorUsedError;

  /// Create a copy of PomodoroSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PomodoroSessionCopyWith<PomodoroSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PomodoroSessionCopyWith<$Res> {
  factory $PomodoroSessionCopyWith(
    PomodoroSession value,
    $Res Function(PomodoroSession) then,
  ) = _$PomodoroSessionCopyWithImpl<$Res, PomodoroSession>;
  @useResult
  $Res call({
    String id,
    PomodoroPhase phase,
    int remainingSeconds,
    int elapsedSeconds,
    SessionStatus status,
    int completedFocusCount,
    DateTime startedAt,
  });
}

/// @nodoc
class _$PomodoroSessionCopyWithImpl<$Res, $Val extends PomodoroSession>
    implements $PomodoroSessionCopyWith<$Res> {
  _$PomodoroSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PomodoroSession
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
                      as PomodoroPhase,
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
                      as SessionStatus,
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
abstract class _$$PomodoroSessionImplCopyWith<$Res>
    implements $PomodoroSessionCopyWith<$Res> {
  factory _$$PomodoroSessionImplCopyWith(
    _$PomodoroSessionImpl value,
    $Res Function(_$PomodoroSessionImpl) then,
  ) = __$$PomodoroSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PomodoroPhase phase,
    int remainingSeconds,
    int elapsedSeconds,
    SessionStatus status,
    int completedFocusCount,
    DateTime startedAt,
  });
}

/// @nodoc
class __$$PomodoroSessionImplCopyWithImpl<$Res>
    extends _$PomodoroSessionCopyWithImpl<$Res, _$PomodoroSessionImpl>
    implements _$$PomodoroSessionImplCopyWith<$Res> {
  __$$PomodoroSessionImplCopyWithImpl(
    _$PomodoroSessionImpl _value,
    $Res Function(_$PomodoroSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PomodoroSession
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
      _$PomodoroSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as PomodoroPhase,
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
                  as SessionStatus,
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

class _$PomodoroSessionImpl implements _PomodoroSession {
  const _$PomodoroSessionImpl({
    required this.id,
    required this.phase,
    required this.remainingSeconds,
    required this.elapsedSeconds,
    required this.status,
    this.completedFocusCount = 0,
    required this.startedAt,
  });

  // セッションID（履歴管理用）
  @override
  final String id;
  // 現在のフェーズ
  @override
  final PomodoroPhase phase;
  // 残り秒数
  @override
  final int remainingSeconds;
  // 経過秒数
  @override
  final int elapsedSeconds;
  // 状態
  @override
  final SessionStatus status;
  // 完了済みフォーカス数（長休憩判定用）
  @override
  @JsonKey()
  final int completedFocusCount;
  // 開始時刻
  @override
  final DateTime startedAt;

  @override
  String toString() {
    return 'PomodoroSession(id: $id, phase: $phase, remainingSeconds: $remainingSeconds, elapsedSeconds: $elapsedSeconds, status: $status, completedFocusCount: $completedFocusCount, startedAt: $startedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PomodoroSessionImpl &&
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

  /// Create a copy of PomodoroSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PomodoroSessionImplCopyWith<_$PomodoroSessionImpl> get copyWith =>
      __$$PomodoroSessionImplCopyWithImpl<_$PomodoroSessionImpl>(
        this,
        _$identity,
      );
}

abstract class _PomodoroSession implements PomodoroSession {
  const factory _PomodoroSession({
    required final String id,
    required final PomodoroPhase phase,
    required final int remainingSeconds,
    required final int elapsedSeconds,
    required final SessionStatus status,
    final int completedFocusCount,
    required final DateTime startedAt,
  }) = _$PomodoroSessionImpl;

  // セッションID（履歴管理用）
  @override
  String get id; // 現在のフェーズ
  @override
  PomodoroPhase get phase; // 残り秒数
  @override
  int get remainingSeconds; // 経過秒数
  @override
  int get elapsedSeconds; // 状態
  @override
  SessionStatus get status; // 完了済みフォーカス数（長休憩判定用）
  @override
  int get completedFocusCount; // 開始時刻
  @override
  DateTime get startedAt;

  /// Create a copy of PomodoroSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PomodoroSessionImplCopyWith<_$PomodoroSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

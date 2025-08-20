// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PomodoroState {
  // 現在のセッション（ない場合null）
  PomodoroSession? get currentSession =>
      throw _privateConstructorUsedError; // 使用中の設定
  TimerConfig get config => throw _privateConstructorUsedError; // UI状態のメタ情報
  bool get isStarting => throw _privateConstructorUsedError; // 開始処理中フラグ
  bool get isUpdating => throw _privateConstructorUsedError; // 状態変更処理中フラグ
  // エラーハンドリング
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of PomodoroState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PomodoroStateCopyWith<PomodoroState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PomodoroStateCopyWith<$Res> {
  factory $PomodoroStateCopyWith(
    PomodoroState value,
    $Res Function(PomodoroState) then,
  ) = _$PomodoroStateCopyWithImpl<$Res, PomodoroState>;
  @useResult
  $Res call({
    PomodoroSession? currentSession,
    TimerConfig config,
    bool isStarting,
    bool isUpdating,
    String? errorMessage,
  });

  $PomodoroSessionCopyWith<$Res>? get currentSession;
  $TimerConfigCopyWith<$Res> get config;
}

/// @nodoc
class _$PomodoroStateCopyWithImpl<$Res, $Val extends PomodoroState>
    implements $PomodoroStateCopyWith<$Res> {
  _$PomodoroStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PomodoroState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSession = freezed,
    Object? config = null,
    Object? isStarting = null,
    Object? isUpdating = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentSession: freezed == currentSession
                ? _value.currentSession
                : currentSession // ignore: cast_nullable_to_non_nullable
                      as PomodoroSession?,
            config: null == config
                ? _value.config
                : config // ignore: cast_nullable_to_non_nullable
                      as TimerConfig,
            isStarting: null == isStarting
                ? _value.isStarting
                : isStarting // ignore: cast_nullable_to_non_nullable
                      as bool,
            isUpdating: null == isUpdating
                ? _value.isUpdating
                : isUpdating // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of PomodoroState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PomodoroSessionCopyWith<$Res>? get currentSession {
    if (_value.currentSession == null) {
      return null;
    }

    return $PomodoroSessionCopyWith<$Res>(_value.currentSession!, (value) {
      return _then(_value.copyWith(currentSession: value) as $Val);
    });
  }

  /// Create a copy of PomodoroState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimerConfigCopyWith<$Res> get config {
    return $TimerConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PomodoroStateImplCopyWith<$Res>
    implements $PomodoroStateCopyWith<$Res> {
  factory _$$PomodoroStateImplCopyWith(
    _$PomodoroStateImpl value,
    $Res Function(_$PomodoroStateImpl) then,
  ) = __$$PomodoroStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PomodoroSession? currentSession,
    TimerConfig config,
    bool isStarting,
    bool isUpdating,
    String? errorMessage,
  });

  @override
  $PomodoroSessionCopyWith<$Res>? get currentSession;
  @override
  $TimerConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$PomodoroStateImplCopyWithImpl<$Res>
    extends _$PomodoroStateCopyWithImpl<$Res, _$PomodoroStateImpl>
    implements _$$PomodoroStateImplCopyWith<$Res> {
  __$$PomodoroStateImplCopyWithImpl(
    _$PomodoroStateImpl _value,
    $Res Function(_$PomodoroStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PomodoroState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSession = freezed,
    Object? config = null,
    Object? isStarting = null,
    Object? isUpdating = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$PomodoroStateImpl(
        currentSession: freezed == currentSession
            ? _value.currentSession
            : currentSession // ignore: cast_nullable_to_non_nullable
                  as PomodoroSession?,
        config: null == config
            ? _value.config
            : config // ignore: cast_nullable_to_non_nullable
                  as TimerConfig,
        isStarting: null == isStarting
            ? _value.isStarting
            : isStarting // ignore: cast_nullable_to_non_nullable
                  as bool,
        isUpdating: null == isUpdating
            ? _value.isUpdating
            : isUpdating // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PomodoroStateImpl extends _PomodoroState {
  const _$PomodoroStateImpl({
    this.currentSession,
    this.config = TimerConfig.defaultConfig,
    this.isStarting = false,
    this.isUpdating = false,
    this.errorMessage,
  }) : super._();

  // 現在のセッション（ない場合null）
  @override
  final PomodoroSession? currentSession;
  // 使用中の設定
  @override
  @JsonKey()
  final TimerConfig config;
  // UI状態のメタ情報
  @override
  @JsonKey()
  final bool isStarting;
  // 開始処理中フラグ
  @override
  @JsonKey()
  final bool isUpdating;
  // 状態変更処理中フラグ
  // エラーハンドリング
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PomodoroState(currentSession: $currentSession, config: $config, isStarting: $isStarting, isUpdating: $isUpdating, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PomodoroStateImpl &&
            (identical(other.currentSession, currentSession) ||
                other.currentSession == currentSession) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.isStarting, isStarting) ||
                other.isStarting == isStarting) &&
            (identical(other.isUpdating, isUpdating) ||
                other.isUpdating == isUpdating) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentSession,
    config,
    isStarting,
    isUpdating,
    errorMessage,
  );

  /// Create a copy of PomodoroState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PomodoroStateImplCopyWith<_$PomodoroStateImpl> get copyWith =>
      __$$PomodoroStateImplCopyWithImpl<_$PomodoroStateImpl>(this, _$identity);
}

abstract class _PomodoroState extends PomodoroState {
  const factory _PomodoroState({
    final PomodoroSession? currentSession,
    final TimerConfig config,
    final bool isStarting,
    final bool isUpdating,
    final String? errorMessage,
  }) = _$PomodoroStateImpl;
  const _PomodoroState._() : super._();

  // 現在のセッション（ない場合null）
  @override
  PomodoroSession? get currentSession; // 使用中の設定
  @override
  TimerConfig get config; // UI状態のメタ情報
  @override
  bool get isStarting; // 開始処理中フラグ
  @override
  bool get isUpdating; // 状態変更処理中フラグ
  // エラーハンドリング
  @override
  String? get errorMessage;

  /// Create a copy of PomodoroState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PomodoroStateImplCopyWith<_$PomodoroStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

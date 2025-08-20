// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TimerConfig {
  // 集中（フォーカス）時間（分）
  int get focusMinutes => throw _privateConstructorUsedError; // 短い休憩（分）
  int get shortBreakMinutes => throw _privateConstructorUsedError; // 長い休憩（分）
  int get longBreakMinutes =>
      throw _privateConstructorUsedError; // 長い休憩の間隔（n回のフォーカスごと）
  int get longBreakInterval => throw _privateConstructorUsedError;

  /// Create a copy of TimerConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimerConfigCopyWith<TimerConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerConfigCopyWith<$Res> {
  factory $TimerConfigCopyWith(
    TimerConfig value,
    $Res Function(TimerConfig) then,
  ) = _$TimerConfigCopyWithImpl<$Res, TimerConfig>;
  @useResult
  $Res call({
    int focusMinutes,
    int shortBreakMinutes,
    int longBreakMinutes,
    int longBreakInterval,
  });
}

/// @nodoc
class _$TimerConfigCopyWithImpl<$Res, $Val extends TimerConfig>
    implements $TimerConfigCopyWith<$Res> {
  _$TimerConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimerConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusMinutes = null,
    Object? shortBreakMinutes = null,
    Object? longBreakMinutes = null,
    Object? longBreakInterval = null,
  }) {
    return _then(
      _value.copyWith(
            focusMinutes: null == focusMinutes
                ? _value.focusMinutes
                : focusMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            shortBreakMinutes: null == shortBreakMinutes
                ? _value.shortBreakMinutes
                : shortBreakMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            longBreakMinutes: null == longBreakMinutes
                ? _value.longBreakMinutes
                : longBreakMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            longBreakInterval: null == longBreakInterval
                ? _value.longBreakInterval
                : longBreakInterval // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimerConfigImplCopyWith<$Res>
    implements $TimerConfigCopyWith<$Res> {
  factory _$$TimerConfigImplCopyWith(
    _$TimerConfigImpl value,
    $Res Function(_$TimerConfigImpl) then,
  ) = __$$TimerConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int focusMinutes,
    int shortBreakMinutes,
    int longBreakMinutes,
    int longBreakInterval,
  });
}

/// @nodoc
class __$$TimerConfigImplCopyWithImpl<$Res>
    extends _$TimerConfigCopyWithImpl<$Res, _$TimerConfigImpl>
    implements _$$TimerConfigImplCopyWith<$Res> {
  __$$TimerConfigImplCopyWithImpl(
    _$TimerConfigImpl _value,
    $Res Function(_$TimerConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimerConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusMinutes = null,
    Object? shortBreakMinutes = null,
    Object? longBreakMinutes = null,
    Object? longBreakInterval = null,
  }) {
    return _then(
      _$TimerConfigImpl(
        focusMinutes: null == focusMinutes
            ? _value.focusMinutes
            : focusMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        shortBreakMinutes: null == shortBreakMinutes
            ? _value.shortBreakMinutes
            : shortBreakMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        longBreakMinutes: null == longBreakMinutes
            ? _value.longBreakMinutes
            : longBreakMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        longBreakInterval: null == longBreakInterval
            ? _value.longBreakInterval
            : longBreakInterval // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$TimerConfigImpl extends _TimerConfig {
  const _$TimerConfigImpl({
    required this.focusMinutes,
    required this.shortBreakMinutes,
    required this.longBreakMinutes,
    required this.longBreakInterval,
  }) : super._();

  // 集中（フォーカス）時間（分）
  @override
  final int focusMinutes;
  // 短い休憩（分）
  @override
  final int shortBreakMinutes;
  // 長い休憩（分）
  @override
  final int longBreakMinutes;
  // 長い休憩の間隔（n回のフォーカスごと）
  @override
  final int longBreakInterval;

  @override
  String toString() {
    return 'TimerConfig(focusMinutes: $focusMinutes, shortBreakMinutes: $shortBreakMinutes, longBreakMinutes: $longBreakMinutes, longBreakInterval: $longBreakInterval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerConfigImpl &&
            (identical(other.focusMinutes, focusMinutes) ||
                other.focusMinutes == focusMinutes) &&
            (identical(other.shortBreakMinutes, shortBreakMinutes) ||
                other.shortBreakMinutes == shortBreakMinutes) &&
            (identical(other.longBreakMinutes, longBreakMinutes) ||
                other.longBreakMinutes == longBreakMinutes) &&
            (identical(other.longBreakInterval, longBreakInterval) ||
                other.longBreakInterval == longBreakInterval));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    focusMinutes,
    shortBreakMinutes,
    longBreakMinutes,
    longBreakInterval,
  );

  /// Create a copy of TimerConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerConfigImplCopyWith<_$TimerConfigImpl> get copyWith =>
      __$$TimerConfigImplCopyWithImpl<_$TimerConfigImpl>(this, _$identity);
}

abstract class _TimerConfig extends TimerConfig {
  const factory _TimerConfig({
    required final int focusMinutes,
    required final int shortBreakMinutes,
    required final int longBreakMinutes,
    required final int longBreakInterval,
  }) = _$TimerConfigImpl;
  const _TimerConfig._() : super._();

  // 集中（フォーカス）時間（分）
  @override
  int get focusMinutes; // 短い休憩（分）
  @override
  int get shortBreakMinutes; // 長い休憩（分）
  @override
  int get longBreakMinutes; // 長い休憩の間隔（n回のフォーカスごと）
  @override
  int get longBreakInterval;

  /// Create a copy of TimerConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimerConfigImplCopyWith<_$TimerConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

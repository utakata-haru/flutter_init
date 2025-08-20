// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimerConfigModel _$TimerConfigModelFromJson(Map<String, dynamic> json) {
  return _TimerConfigModel.fromJson(json);
}

/// @nodoc
mixin _$TimerConfigModel {
  int get focusMinutes => throw _privateConstructorUsedError;
  int get shortBreakMinutes => throw _privateConstructorUsedError;
  int get longBreakMinutes => throw _privateConstructorUsedError;
  int get longBreakInterval => throw _privateConstructorUsedError;

  /// Serializes this TimerConfigModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimerConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimerConfigModelCopyWith<TimerConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerConfigModelCopyWith<$Res> {
  factory $TimerConfigModelCopyWith(
    TimerConfigModel value,
    $Res Function(TimerConfigModel) then,
  ) = _$TimerConfigModelCopyWithImpl<$Res, TimerConfigModel>;
  @useResult
  $Res call({
    int focusMinutes,
    int shortBreakMinutes,
    int longBreakMinutes,
    int longBreakInterval,
  });
}

/// @nodoc
class _$TimerConfigModelCopyWithImpl<$Res, $Val extends TimerConfigModel>
    implements $TimerConfigModelCopyWith<$Res> {
  _$TimerConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimerConfigModel
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
abstract class _$$TimerConfigModelImplCopyWith<$Res>
    implements $TimerConfigModelCopyWith<$Res> {
  factory _$$TimerConfigModelImplCopyWith(
    _$TimerConfigModelImpl value,
    $Res Function(_$TimerConfigModelImpl) then,
  ) = __$$TimerConfigModelImplCopyWithImpl<$Res>;
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
class __$$TimerConfigModelImplCopyWithImpl<$Res>
    extends _$TimerConfigModelCopyWithImpl<$Res, _$TimerConfigModelImpl>
    implements _$$TimerConfigModelImplCopyWith<$Res> {
  __$$TimerConfigModelImplCopyWithImpl(
    _$TimerConfigModelImpl _value,
    $Res Function(_$TimerConfigModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimerConfigModel
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
      _$TimerConfigModelImpl(
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
@JsonSerializable()
class _$TimerConfigModelImpl implements _TimerConfigModel {
  const _$TimerConfigModelImpl({
    required this.focusMinutes,
    required this.shortBreakMinutes,
    required this.longBreakMinutes,
    required this.longBreakInterval,
  });

  factory _$TimerConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimerConfigModelImplFromJson(json);

  @override
  final int focusMinutes;
  @override
  final int shortBreakMinutes;
  @override
  final int longBreakMinutes;
  @override
  final int longBreakInterval;

  @override
  String toString() {
    return 'TimerConfigModel(focusMinutes: $focusMinutes, shortBreakMinutes: $shortBreakMinutes, longBreakMinutes: $longBreakMinutes, longBreakInterval: $longBreakInterval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerConfigModelImpl &&
            (identical(other.focusMinutes, focusMinutes) ||
                other.focusMinutes == focusMinutes) &&
            (identical(other.shortBreakMinutes, shortBreakMinutes) ||
                other.shortBreakMinutes == shortBreakMinutes) &&
            (identical(other.longBreakMinutes, longBreakMinutes) ||
                other.longBreakMinutes == longBreakMinutes) &&
            (identical(other.longBreakInterval, longBreakInterval) ||
                other.longBreakInterval == longBreakInterval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    focusMinutes,
    shortBreakMinutes,
    longBreakMinutes,
    longBreakInterval,
  );

  /// Create a copy of TimerConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerConfigModelImplCopyWith<_$TimerConfigModelImpl> get copyWith =>
      __$$TimerConfigModelImplCopyWithImpl<_$TimerConfigModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimerConfigModelImplToJson(this);
  }
}

abstract class _TimerConfigModel implements TimerConfigModel {
  const factory _TimerConfigModel({
    required final int focusMinutes,
    required final int shortBreakMinutes,
    required final int longBreakMinutes,
    required final int longBreakInterval,
  }) = _$TimerConfigModelImpl;

  factory _TimerConfigModel.fromJson(Map<String, dynamic> json) =
      _$TimerConfigModelImpl.fromJson;

  @override
  int get focusMinutes;
  @override
  int get shortBreakMinutes;
  @override
  int get longBreakMinutes;
  @override
  int get longBreakInterval;

  /// Create a copy of TimerConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimerConfigModelImplCopyWith<_$TimerConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

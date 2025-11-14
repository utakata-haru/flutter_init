// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoutineTime {

 int get hour; int get minute;
/// Create a copy of RoutineTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineTimeCopyWith<RoutineTime> get copyWith => _$RoutineTimeCopyWithImpl<RoutineTime>(this as RoutineTime, _$identity);

  /// Serializes this RoutineTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'RoutineTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class $RoutineTimeCopyWith<$Res>  {
  factory $RoutineTimeCopyWith(RoutineTime value, $Res Function(RoutineTime) _then) = _$RoutineTimeCopyWithImpl;
@useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class _$RoutineTimeCopyWithImpl<$Res>
    implements $RoutineTimeCopyWith<$Res> {
  _$RoutineTimeCopyWithImpl(this._self, this._then);

  final RoutineTime _self;
  final $Res Function(RoutineTime) _then;

/// Create a copy of RoutineTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_self.copyWith(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineTime].
extension RoutineTimePatterns on RoutineTime {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineTime() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineTime value)  $default,){
final _that = this;
switch (_that) {
case _RoutineTime():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineTime value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineTime() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int hour,  int minute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineTime() when $default != null:
return $default(_that.hour,_that.minute);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int hour,  int minute)  $default,) {final _that = this;
switch (_that) {
case _RoutineTime():
return $default(_that.hour,_that.minute);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int hour,  int minute)?  $default,) {final _that = this;
switch (_that) {
case _RoutineTime() when $default != null:
return $default(_that.hour,_that.minute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineTime extends RoutineTime {
  const _RoutineTime({required this.hour, required this.minute}): super._();
  factory _RoutineTime.fromJson(Map<String, dynamic> json) => _$RoutineTimeFromJson(json);

@override final  int hour;
@override final  int minute;

/// Create a copy of RoutineTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineTimeCopyWith<_RoutineTime> get copyWith => __$RoutineTimeCopyWithImpl<_RoutineTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'RoutineTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$RoutineTimeCopyWith<$Res> implements $RoutineTimeCopyWith<$Res> {
  factory _$RoutineTimeCopyWith(_RoutineTime value, $Res Function(_RoutineTime) _then) = __$RoutineTimeCopyWithImpl;
@override @useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class __$RoutineTimeCopyWithImpl<$Res>
    implements _$RoutineTimeCopyWith<$Res> {
  __$RoutineTimeCopyWithImpl(this._self, this._then);

  final _RoutineTime _self;
  final $Res Function(_RoutineTime) _then;

/// Create a copy of RoutineTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_RoutineTime(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RoutineThresholdSetting {

 int get allowableDelayMinutes; int get criticalDelayMinutes;
/// Create a copy of RoutineThresholdSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineThresholdSettingCopyWith<RoutineThresholdSetting> get copyWith => _$RoutineThresholdSettingCopyWithImpl<RoutineThresholdSetting>(this as RoutineThresholdSetting, _$identity);

  /// Serializes this RoutineThresholdSetting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineThresholdSetting&&(identical(other.allowableDelayMinutes, allowableDelayMinutes) || other.allowableDelayMinutes == allowableDelayMinutes)&&(identical(other.criticalDelayMinutes, criticalDelayMinutes) || other.criticalDelayMinutes == criticalDelayMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allowableDelayMinutes,criticalDelayMinutes);

@override
String toString() {
  return 'RoutineThresholdSetting(allowableDelayMinutes: $allowableDelayMinutes, criticalDelayMinutes: $criticalDelayMinutes)';
}


}

/// @nodoc
abstract mixin class $RoutineThresholdSettingCopyWith<$Res>  {
  factory $RoutineThresholdSettingCopyWith(RoutineThresholdSetting value, $Res Function(RoutineThresholdSetting) _then) = _$RoutineThresholdSettingCopyWithImpl;
@useResult
$Res call({
 int allowableDelayMinutes, int criticalDelayMinutes
});




}
/// @nodoc
class _$RoutineThresholdSettingCopyWithImpl<$Res>
    implements $RoutineThresholdSettingCopyWith<$Res> {
  _$RoutineThresholdSettingCopyWithImpl(this._self, this._then);

  final RoutineThresholdSetting _self;
  final $Res Function(RoutineThresholdSetting) _then;

/// Create a copy of RoutineThresholdSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allowableDelayMinutes = null,Object? criticalDelayMinutes = null,}) {
  return _then(_self.copyWith(
allowableDelayMinutes: null == allowableDelayMinutes ? _self.allowableDelayMinutes : allowableDelayMinutes // ignore: cast_nullable_to_non_nullable
as int,criticalDelayMinutes: null == criticalDelayMinutes ? _self.criticalDelayMinutes : criticalDelayMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineThresholdSetting].
extension RoutineThresholdSettingPatterns on RoutineThresholdSetting {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineThresholdSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineThresholdSetting() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineThresholdSetting value)  $default,){
final _that = this;
switch (_that) {
case _RoutineThresholdSetting():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineThresholdSetting value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineThresholdSetting() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int allowableDelayMinutes,  int criticalDelayMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineThresholdSetting() when $default != null:
return $default(_that.allowableDelayMinutes,_that.criticalDelayMinutes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int allowableDelayMinutes,  int criticalDelayMinutes)  $default,) {final _that = this;
switch (_that) {
case _RoutineThresholdSetting():
return $default(_that.allowableDelayMinutes,_that.criticalDelayMinutes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int allowableDelayMinutes,  int criticalDelayMinutes)?  $default,) {final _that = this;
switch (_that) {
case _RoutineThresholdSetting() when $default != null:
return $default(_that.allowableDelayMinutes,_that.criticalDelayMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineThresholdSetting extends RoutineThresholdSetting {
  const _RoutineThresholdSetting({this.allowableDelayMinutes = 5, this.criticalDelayMinutes = 15}): super._();
  factory _RoutineThresholdSetting.fromJson(Map<String, dynamic> json) => _$RoutineThresholdSettingFromJson(json);

@override@JsonKey() final  int allowableDelayMinutes;
@override@JsonKey() final  int criticalDelayMinutes;

/// Create a copy of RoutineThresholdSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineThresholdSettingCopyWith<_RoutineThresholdSetting> get copyWith => __$RoutineThresholdSettingCopyWithImpl<_RoutineThresholdSetting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineThresholdSettingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineThresholdSetting&&(identical(other.allowableDelayMinutes, allowableDelayMinutes) || other.allowableDelayMinutes == allowableDelayMinutes)&&(identical(other.criticalDelayMinutes, criticalDelayMinutes) || other.criticalDelayMinutes == criticalDelayMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allowableDelayMinutes,criticalDelayMinutes);

@override
String toString() {
  return 'RoutineThresholdSetting(allowableDelayMinutes: $allowableDelayMinutes, criticalDelayMinutes: $criticalDelayMinutes)';
}


}

/// @nodoc
abstract mixin class _$RoutineThresholdSettingCopyWith<$Res> implements $RoutineThresholdSettingCopyWith<$Res> {
  factory _$RoutineThresholdSettingCopyWith(_RoutineThresholdSetting value, $Res Function(_RoutineThresholdSetting) _then) = __$RoutineThresholdSettingCopyWithImpl;
@override @useResult
$Res call({
 int allowableDelayMinutes, int criticalDelayMinutes
});




}
/// @nodoc
class __$RoutineThresholdSettingCopyWithImpl<$Res>
    implements _$RoutineThresholdSettingCopyWith<$Res> {
  __$RoutineThresholdSettingCopyWithImpl(this._self, this._then);

  final _RoutineThresholdSetting _self;
  final $Res Function(_RoutineThresholdSetting) _then;

/// Create a copy of RoutineThresholdSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allowableDelayMinutes = null,Object? criticalDelayMinutes = null,}) {
  return _then(_RoutineThresholdSetting(
allowableDelayMinutes: null == allowableDelayMinutes ? _self.allowableDelayMinutes : allowableDelayMinutes // ignore: cast_nullable_to_non_nullable
as int,criticalDelayMinutes: null == criticalDelayMinutes ? _self.criticalDelayMinutes : criticalDelayMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RoutineEntity {

 String get id; String get name; RoutineTime get targetTime; RoutineThresholdSetting get thresholds; RoutineCompletionResultEntity? get lastResult; int get sortIndex;
/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineEntityCopyWith<RoutineEntity> get copyWith => _$RoutineEntityCopyWithImpl<RoutineEntity>(this as RoutineEntity, _$identity);

  /// Serializes this RoutineEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.sortIndex, sortIndex) || other.sortIndex == sortIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,targetTime,thresholds,lastResult,sortIndex);

@override
String toString() {
  return 'RoutineEntity(id: $id, name: $name, targetTime: $targetTime, thresholds: $thresholds, lastResult: $lastResult, sortIndex: $sortIndex)';
}


}

/// @nodoc
abstract mixin class $RoutineEntityCopyWith<$Res>  {
  factory $RoutineEntityCopyWith(RoutineEntity value, $Res Function(RoutineEntity) _then) = _$RoutineEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, RoutineTime targetTime, RoutineThresholdSetting thresholds, RoutineCompletionResultEntity? lastResult, int sortIndex
});


$RoutineTimeCopyWith<$Res> get targetTime;$RoutineThresholdSettingCopyWith<$Res> get thresholds;$RoutineCompletionResultEntityCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$RoutineEntityCopyWithImpl<$Res>
    implements $RoutineEntityCopyWith<$Res> {
  _$RoutineEntityCopyWithImpl(this._self, this._then);

  final RoutineEntity _self;
  final $Res Function(RoutineEntity) _then;

/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? targetTime = null,Object? thresholds = null,Object? lastResult = freezed,Object? sortIndex = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as RoutineTime,thresholds: null == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as RoutineThresholdSetting,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as RoutineCompletionResultEntity?,sortIndex: null == sortIndex ? _self.sortIndex : sortIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineTimeCopyWith<$Res> get targetTime {
  
  return $RoutineTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineThresholdSettingCopyWith<$Res> get thresholds {
  
  return $RoutineThresholdSettingCopyWith<$Res>(_self.thresholds, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineCompletionResultEntityCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $RoutineCompletionResultEntityCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutineEntity].
extension RoutineEntityPatterns on RoutineEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineEntity value)  $default,){
final _that = this;
switch (_that) {
case _RoutineEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  RoutineTime targetTime,  RoutineThresholdSetting thresholds,  RoutineCompletionResultEntity? lastResult,  int sortIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineEntity() when $default != null:
return $default(_that.id,_that.name,_that.targetTime,_that.thresholds,_that.lastResult,_that.sortIndex);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  RoutineTime targetTime,  RoutineThresholdSetting thresholds,  RoutineCompletionResultEntity? lastResult,  int sortIndex)  $default,) {final _that = this;
switch (_that) {
case _RoutineEntity():
return $default(_that.id,_that.name,_that.targetTime,_that.thresholds,_that.lastResult,_that.sortIndex);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  RoutineTime targetTime,  RoutineThresholdSetting thresholds,  RoutineCompletionResultEntity? lastResult,  int sortIndex)?  $default,) {final _that = this;
switch (_that) {
case _RoutineEntity() when $default != null:
return $default(_that.id,_that.name,_that.targetTime,_that.thresholds,_that.lastResult,_that.sortIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineEntity extends RoutineEntity {
  const _RoutineEntity({required this.id, required this.name, required this.targetTime, this.thresholds = const RoutineThresholdSetting(), this.lastResult, this.sortIndex = 0}): super._();
  factory _RoutineEntity.fromJson(Map<String, dynamic> json) => _$RoutineEntityFromJson(json);

@override final  String id;
@override final  String name;
@override final  RoutineTime targetTime;
@override@JsonKey() final  RoutineThresholdSetting thresholds;
@override final  RoutineCompletionResultEntity? lastResult;
@override@JsonKey() final  int sortIndex;

/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineEntityCopyWith<_RoutineEntity> get copyWith => __$RoutineEntityCopyWithImpl<_RoutineEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.sortIndex, sortIndex) || other.sortIndex == sortIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,targetTime,thresholds,lastResult,sortIndex);

@override
String toString() {
  return 'RoutineEntity(id: $id, name: $name, targetTime: $targetTime, thresholds: $thresholds, lastResult: $lastResult, sortIndex: $sortIndex)';
}


}

/// @nodoc
abstract mixin class _$RoutineEntityCopyWith<$Res> implements $RoutineEntityCopyWith<$Res> {
  factory _$RoutineEntityCopyWith(_RoutineEntity value, $Res Function(_RoutineEntity) _then) = __$RoutineEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, RoutineTime targetTime, RoutineThresholdSetting thresholds, RoutineCompletionResultEntity? lastResult, int sortIndex
});


@override $RoutineTimeCopyWith<$Res> get targetTime;@override $RoutineThresholdSettingCopyWith<$Res> get thresholds;@override $RoutineCompletionResultEntityCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$RoutineEntityCopyWithImpl<$Res>
    implements _$RoutineEntityCopyWith<$Res> {
  __$RoutineEntityCopyWithImpl(this._self, this._then);

  final _RoutineEntity _self;
  final $Res Function(_RoutineEntity) _then;

/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? targetTime = null,Object? thresholds = null,Object? lastResult = freezed,Object? sortIndex = null,}) {
  return _then(_RoutineEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as RoutineTime,thresholds: null == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as RoutineThresholdSetting,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as RoutineCompletionResultEntity?,sortIndex: null == sortIndex ? _self.sortIndex : sortIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineTimeCopyWith<$Res> get targetTime {
  
  return $RoutineTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineThresholdSettingCopyWith<$Res> get thresholds {
  
  return $RoutineThresholdSettingCopyWith<$Res>(_self.thresholds, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}/// Create a copy of RoutineEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineCompletionResultEntityCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $RoutineCompletionResultEntityCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}

// dart format on

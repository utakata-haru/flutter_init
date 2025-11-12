// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoutineDashboardState {

 List<RoutineEntity> get routines; RoutineThresholdSetting? get thresholds; bool get isLoading; bool get isRefreshing; String? get errorMessage;
/// Create a copy of RoutineDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineDashboardStateCopyWith<RoutineDashboardState> get copyWith => _$RoutineDashboardStateCopyWithImpl<RoutineDashboardState>(this as RoutineDashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineDashboardState&&const DeepCollectionEquality().equals(other.routines, routines)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(routines),thresholds,isLoading,isRefreshing,errorMessage);

@override
String toString() {
  return 'RoutineDashboardState(routines: $routines, thresholds: $thresholds, isLoading: $isLoading, isRefreshing: $isRefreshing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $RoutineDashboardStateCopyWith<$Res>  {
  factory $RoutineDashboardStateCopyWith(RoutineDashboardState value, $Res Function(RoutineDashboardState) _then) = _$RoutineDashboardStateCopyWithImpl;
@useResult
$Res call({
 List<RoutineEntity> routines, RoutineThresholdSetting? thresholds, bool isLoading, bool isRefreshing, String? errorMessage
});


$RoutineThresholdSettingCopyWith<$Res>? get thresholds;

}
/// @nodoc
class _$RoutineDashboardStateCopyWithImpl<$Res>
    implements $RoutineDashboardStateCopyWith<$Res> {
  _$RoutineDashboardStateCopyWithImpl(this._self, this._then);

  final RoutineDashboardState _self;
  final $Res Function(RoutineDashboardState) _then;

/// Create a copy of RoutineDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routines = null,Object? thresholds = freezed,Object? isLoading = null,Object? isRefreshing = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
routines: null == routines ? _self.routines : routines // ignore: cast_nullable_to_non_nullable
as List<RoutineEntity>,thresholds: freezed == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as RoutineThresholdSetting?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RoutineDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineThresholdSettingCopyWith<$Res>? get thresholds {
    if (_self.thresholds == null) {
    return null;
  }

  return $RoutineThresholdSettingCopyWith<$Res>(_self.thresholds!, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutineDashboardState].
extension RoutineDashboardStatePatterns on RoutineDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineDashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineDashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineDashboardState value)  $default,){
final _that = this;
switch (_that) {
case _RoutineDashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineDashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineDashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RoutineEntity> routines,  RoutineThresholdSetting? thresholds,  bool isLoading,  bool isRefreshing,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineDashboardState() when $default != null:
return $default(_that.routines,_that.thresholds,_that.isLoading,_that.isRefreshing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RoutineEntity> routines,  RoutineThresholdSetting? thresholds,  bool isLoading,  bool isRefreshing,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _RoutineDashboardState():
return $default(_that.routines,_that.thresholds,_that.isLoading,_that.isRefreshing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RoutineEntity> routines,  RoutineThresholdSetting? thresholds,  bool isLoading,  bool isRefreshing,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _RoutineDashboardState() when $default != null:
return $default(_that.routines,_that.thresholds,_that.isLoading,_that.isRefreshing,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineDashboardState extends RoutineDashboardState {
  const _RoutineDashboardState({final  List<RoutineEntity> routines = const <RoutineEntity>[], this.thresholds, this.isLoading = false, this.isRefreshing = false, this.errorMessage}): _routines = routines,super._();
  

 final  List<RoutineEntity> _routines;
@override@JsonKey() List<RoutineEntity> get routines {
  if (_routines is EqualUnmodifiableListView) return _routines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routines);
}

@override final  RoutineThresholdSetting? thresholds;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
@override final  String? errorMessage;

/// Create a copy of RoutineDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineDashboardStateCopyWith<_RoutineDashboardState> get copyWith => __$RoutineDashboardStateCopyWithImpl<_RoutineDashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineDashboardState&&const DeepCollectionEquality().equals(other._routines, _routines)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_routines),thresholds,isLoading,isRefreshing,errorMessage);

@override
String toString() {
  return 'RoutineDashboardState(routines: $routines, thresholds: $thresholds, isLoading: $isLoading, isRefreshing: $isRefreshing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$RoutineDashboardStateCopyWith<$Res> implements $RoutineDashboardStateCopyWith<$Res> {
  factory _$RoutineDashboardStateCopyWith(_RoutineDashboardState value, $Res Function(_RoutineDashboardState) _then) = __$RoutineDashboardStateCopyWithImpl;
@override @useResult
$Res call({
 List<RoutineEntity> routines, RoutineThresholdSetting? thresholds, bool isLoading, bool isRefreshing, String? errorMessage
});


@override $RoutineThresholdSettingCopyWith<$Res>? get thresholds;

}
/// @nodoc
class __$RoutineDashboardStateCopyWithImpl<$Res>
    implements _$RoutineDashboardStateCopyWith<$Res> {
  __$RoutineDashboardStateCopyWithImpl(this._self, this._then);

  final _RoutineDashboardState _self;
  final $Res Function(_RoutineDashboardState) _then;

/// Create a copy of RoutineDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routines = null,Object? thresholds = freezed,Object? isLoading = null,Object? isRefreshing = null,Object? errorMessage = freezed,}) {
  return _then(_RoutineDashboardState(
routines: null == routines ? _self._routines : routines // ignore: cast_nullable_to_non_nullable
as List<RoutineEntity>,thresholds: freezed == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as RoutineThresholdSetting?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RoutineDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineThresholdSettingCopyWith<$Res>? get thresholds {
    if (_self.thresholds == null) {
    return null;
  }

  return $RoutineThresholdSettingCopyWith<$Res>(_self.thresholds!, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}
}

// dart format on

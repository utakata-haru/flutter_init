// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoutineSettingsState {

 RoutineThresholdSetting? get setting; bool get isLoading; bool get isSaving; String? get errorMessage; bool? get saveSucceeded;
/// Create a copy of RoutineSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineSettingsStateCopyWith<RoutineSettingsState> get copyWith => _$RoutineSettingsStateCopyWithImpl<RoutineSettingsState>(this as RoutineSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineSettingsState&&(identical(other.setting, setting) || other.setting == setting)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSucceeded, saveSucceeded) || other.saveSucceeded == saveSucceeded));
}


@override
int get hashCode => Object.hash(runtimeType,setting,isLoading,isSaving,errorMessage,saveSucceeded);

@override
String toString() {
  return 'RoutineSettingsState(setting: $setting, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage, saveSucceeded: $saveSucceeded)';
}


}

/// @nodoc
abstract mixin class $RoutineSettingsStateCopyWith<$Res>  {
  factory $RoutineSettingsStateCopyWith(RoutineSettingsState value, $Res Function(RoutineSettingsState) _then) = _$RoutineSettingsStateCopyWithImpl;
@useResult
$Res call({
 RoutineThresholdSetting? setting, bool isLoading, bool isSaving, String? errorMessage, bool? saveSucceeded
});


$RoutineThresholdSettingCopyWith<$Res>? get setting;

}
/// @nodoc
class _$RoutineSettingsStateCopyWithImpl<$Res>
    implements $RoutineSettingsStateCopyWith<$Res> {
  _$RoutineSettingsStateCopyWithImpl(this._self, this._then);

  final RoutineSettingsState _self;
  final $Res Function(RoutineSettingsState) _then;

/// Create a copy of RoutineSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? setting = freezed,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,Object? saveSucceeded = freezed,}) {
  return _then(_self.copyWith(
setting: freezed == setting ? _self.setting : setting // ignore: cast_nullable_to_non_nullable
as RoutineThresholdSetting?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSucceeded: freezed == saveSucceeded ? _self.saveSucceeded : saveSucceeded // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of RoutineSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineThresholdSettingCopyWith<$Res>? get setting {
    if (_self.setting == null) {
    return null;
  }

  return $RoutineThresholdSettingCopyWith<$Res>(_self.setting!, (value) {
    return _then(_self.copyWith(setting: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutineSettingsState].
extension RoutineSettingsStatePatterns on RoutineSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _RoutineSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RoutineThresholdSetting? setting,  bool isLoading,  bool isSaving,  String? errorMessage,  bool? saveSucceeded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineSettingsState() when $default != null:
return $default(_that.setting,_that.isLoading,_that.isSaving,_that.errorMessage,_that.saveSucceeded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RoutineThresholdSetting? setting,  bool isLoading,  bool isSaving,  String? errorMessage,  bool? saveSucceeded)  $default,) {final _that = this;
switch (_that) {
case _RoutineSettingsState():
return $default(_that.setting,_that.isLoading,_that.isSaving,_that.errorMessage,_that.saveSucceeded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RoutineThresholdSetting? setting,  bool isLoading,  bool isSaving,  String? errorMessage,  bool? saveSucceeded)?  $default,) {final _that = this;
switch (_that) {
case _RoutineSettingsState() when $default != null:
return $default(_that.setting,_that.isLoading,_that.isSaving,_that.errorMessage,_that.saveSucceeded);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineSettingsState extends RoutineSettingsState {
  const _RoutineSettingsState({this.setting, this.isLoading = false, this.isSaving = false, this.errorMessage, this.saveSucceeded}): super._();
  

@override final  RoutineThresholdSetting? setting;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? errorMessage;
@override final  bool? saveSucceeded;

/// Create a copy of RoutineSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineSettingsStateCopyWith<_RoutineSettingsState> get copyWith => __$RoutineSettingsStateCopyWithImpl<_RoutineSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineSettingsState&&(identical(other.setting, setting) || other.setting == setting)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSucceeded, saveSucceeded) || other.saveSucceeded == saveSucceeded));
}


@override
int get hashCode => Object.hash(runtimeType,setting,isLoading,isSaving,errorMessage,saveSucceeded);

@override
String toString() {
  return 'RoutineSettingsState(setting: $setting, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage, saveSucceeded: $saveSucceeded)';
}


}

/// @nodoc
abstract mixin class _$RoutineSettingsStateCopyWith<$Res> implements $RoutineSettingsStateCopyWith<$Res> {
  factory _$RoutineSettingsStateCopyWith(_RoutineSettingsState value, $Res Function(_RoutineSettingsState) _then) = __$RoutineSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 RoutineThresholdSetting? setting, bool isLoading, bool isSaving, String? errorMessage, bool? saveSucceeded
});


@override $RoutineThresholdSettingCopyWith<$Res>? get setting;

}
/// @nodoc
class __$RoutineSettingsStateCopyWithImpl<$Res>
    implements _$RoutineSettingsStateCopyWith<$Res> {
  __$RoutineSettingsStateCopyWithImpl(this._self, this._then);

  final _RoutineSettingsState _self;
  final $Res Function(_RoutineSettingsState) _then;

/// Create a copy of RoutineSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? setting = freezed,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,Object? saveSucceeded = freezed,}) {
  return _then(_RoutineSettingsState(
setting: freezed == setting ? _self.setting : setting // ignore: cast_nullable_to_non_nullable
as RoutineThresholdSetting?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSucceeded: freezed == saveSucceeded ? _self.saveSucceeded : saveSucceeded // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of RoutineSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineThresholdSettingCopyWith<$Res>? get setting {
    if (_self.setting == null) {
    return null;
  }

  return $RoutineThresholdSettingCopyWith<$Res>(_self.setting!, (value) {
    return _then(_self.copyWith(setting: value));
  });
}
}

// dart format on

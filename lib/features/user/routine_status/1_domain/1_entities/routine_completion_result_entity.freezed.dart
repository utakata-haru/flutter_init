// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_completion_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoutineCompletionResultEntity {

 String get routineId; DateTime get scheduledDateTime; DateTime get completedAt; RoutineComplianceStatus get status; int get delayMinutes; bool get edited;
/// Create a copy of RoutineCompletionResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineCompletionResultEntityCopyWith<RoutineCompletionResultEntity> get copyWith => _$RoutineCompletionResultEntityCopyWithImpl<RoutineCompletionResultEntity>(this as RoutineCompletionResultEntity, _$identity);

  /// Serializes this RoutineCompletionResultEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineCompletionResultEntity&&(identical(other.routineId, routineId) || other.routineId == routineId)&&(identical(other.scheduledDateTime, scheduledDateTime) || other.scheduledDateTime == scheduledDateTime)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.delayMinutes, delayMinutes) || other.delayMinutes == delayMinutes)&&(identical(other.edited, edited) || other.edited == edited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routineId,scheduledDateTime,completedAt,status,delayMinutes,edited);

@override
String toString() {
  return 'RoutineCompletionResultEntity(routineId: $routineId, scheduledDateTime: $scheduledDateTime, completedAt: $completedAt, status: $status, delayMinutes: $delayMinutes, edited: $edited)';
}


}

/// @nodoc
abstract mixin class $RoutineCompletionResultEntityCopyWith<$Res>  {
  factory $RoutineCompletionResultEntityCopyWith(RoutineCompletionResultEntity value, $Res Function(RoutineCompletionResultEntity) _then) = _$RoutineCompletionResultEntityCopyWithImpl;
@useResult
$Res call({
 String routineId, DateTime scheduledDateTime, DateTime completedAt, RoutineComplianceStatus status, int delayMinutes, bool edited
});




}
/// @nodoc
class _$RoutineCompletionResultEntityCopyWithImpl<$Res>
    implements $RoutineCompletionResultEntityCopyWith<$Res> {
  _$RoutineCompletionResultEntityCopyWithImpl(this._self, this._then);

  final RoutineCompletionResultEntity _self;
  final $Res Function(RoutineCompletionResultEntity) _then;

/// Create a copy of RoutineCompletionResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routineId = null,Object? scheduledDateTime = null,Object? completedAt = null,Object? status = null,Object? delayMinutes = null,Object? edited = null,}) {
  return _then(_self.copyWith(
routineId: null == routineId ? _self.routineId : routineId // ignore: cast_nullable_to_non_nullable
as String,scheduledDateTime: null == scheduledDateTime ? _self.scheduledDateTime : scheduledDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoutineComplianceStatus,delayMinutes: null == delayMinutes ? _self.delayMinutes : delayMinutes // ignore: cast_nullable_to_non_nullable
as int,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineCompletionResultEntity].
extension RoutineCompletionResultEntityPatterns on RoutineCompletionResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineCompletionResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineCompletionResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineCompletionResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _RoutineCompletionResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineCompletionResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineCompletionResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String routineId,  DateTime scheduledDateTime,  DateTime completedAt,  RoutineComplianceStatus status,  int delayMinutes,  bool edited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineCompletionResultEntity() when $default != null:
return $default(_that.routineId,_that.scheduledDateTime,_that.completedAt,_that.status,_that.delayMinutes,_that.edited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String routineId,  DateTime scheduledDateTime,  DateTime completedAt,  RoutineComplianceStatus status,  int delayMinutes,  bool edited)  $default,) {final _that = this;
switch (_that) {
case _RoutineCompletionResultEntity():
return $default(_that.routineId,_that.scheduledDateTime,_that.completedAt,_that.status,_that.delayMinutes,_that.edited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String routineId,  DateTime scheduledDateTime,  DateTime completedAt,  RoutineComplianceStatus status,  int delayMinutes,  bool edited)?  $default,) {final _that = this;
switch (_that) {
case _RoutineCompletionResultEntity() when $default != null:
return $default(_that.routineId,_that.scheduledDateTime,_that.completedAt,_that.status,_that.delayMinutes,_that.edited);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutineCompletionResultEntity extends RoutineCompletionResultEntity {
  const _RoutineCompletionResultEntity({required this.routineId, required this.scheduledDateTime, required this.completedAt, required this.status, required this.delayMinutes, this.edited = false}): super._();
  factory _RoutineCompletionResultEntity.fromJson(Map<String, dynamic> json) => _$RoutineCompletionResultEntityFromJson(json);

@override final  String routineId;
@override final  DateTime scheduledDateTime;
@override final  DateTime completedAt;
@override final  RoutineComplianceStatus status;
@override final  int delayMinutes;
@override@JsonKey() final  bool edited;

/// Create a copy of RoutineCompletionResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineCompletionResultEntityCopyWith<_RoutineCompletionResultEntity> get copyWith => __$RoutineCompletionResultEntityCopyWithImpl<_RoutineCompletionResultEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutineCompletionResultEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineCompletionResultEntity&&(identical(other.routineId, routineId) || other.routineId == routineId)&&(identical(other.scheduledDateTime, scheduledDateTime) || other.scheduledDateTime == scheduledDateTime)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.delayMinutes, delayMinutes) || other.delayMinutes == delayMinutes)&&(identical(other.edited, edited) || other.edited == edited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routineId,scheduledDateTime,completedAt,status,delayMinutes,edited);

@override
String toString() {
  return 'RoutineCompletionResultEntity(routineId: $routineId, scheduledDateTime: $scheduledDateTime, completedAt: $completedAt, status: $status, delayMinutes: $delayMinutes, edited: $edited)';
}


}

/// @nodoc
abstract mixin class _$RoutineCompletionResultEntityCopyWith<$Res> implements $RoutineCompletionResultEntityCopyWith<$Res> {
  factory _$RoutineCompletionResultEntityCopyWith(_RoutineCompletionResultEntity value, $Res Function(_RoutineCompletionResultEntity) _then) = __$RoutineCompletionResultEntityCopyWithImpl;
@override @useResult
$Res call({
 String routineId, DateTime scheduledDateTime, DateTime completedAt, RoutineComplianceStatus status, int delayMinutes, bool edited
});




}
/// @nodoc
class __$RoutineCompletionResultEntityCopyWithImpl<$Res>
    implements _$RoutineCompletionResultEntityCopyWith<$Res> {
  __$RoutineCompletionResultEntityCopyWithImpl(this._self, this._then);

  final _RoutineCompletionResultEntity _self;
  final $Res Function(_RoutineCompletionResultEntity) _then;

/// Create a copy of RoutineCompletionResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routineId = null,Object? scheduledDateTime = null,Object? completedAt = null,Object? status = null,Object? delayMinutes = null,Object? edited = null,}) {
  return _then(_RoutineCompletionResultEntity(
routineId: null == routineId ? _self.routineId : routineId // ignore: cast_nullable_to_non_nullable
as String,scheduledDateTime: null == scheduledDateTime ? _self.scheduledDateTime : scheduledDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoutineComplianceStatus,delayMinutes: null == delayMinutes ? _self.delayMinutes : delayMinutes // ignore: cast_nullable_to_non_nullable
as int,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FileHistory {

 String get id; String get path; DateTime get lastAccessed;
/// Create a copy of FileHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileHistoryCopyWith<FileHistory> get copyWith => _$FileHistoryCopyWithImpl<FileHistory>(this as FileHistory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.path, path) || other.path == path)&&(identical(other.lastAccessed, lastAccessed) || other.lastAccessed == lastAccessed));
}


@override
int get hashCode => Object.hash(runtimeType,id,path,lastAccessed);

@override
String toString() {
  return 'FileHistory(id: $id, path: $path, lastAccessed: $lastAccessed)';
}


}

/// @nodoc
abstract mixin class $FileHistoryCopyWith<$Res>  {
  factory $FileHistoryCopyWith(FileHistory value, $Res Function(FileHistory) _then) = _$FileHistoryCopyWithImpl;
@useResult
$Res call({
 String id, String path, DateTime lastAccessed
});




}
/// @nodoc
class _$FileHistoryCopyWithImpl<$Res>
    implements $FileHistoryCopyWith<$Res> {
  _$FileHistoryCopyWithImpl(this._self, this._then);

  final FileHistory _self;
  final $Res Function(FileHistory) _then;

/// Create a copy of FileHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? path = null,Object? lastAccessed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,lastAccessed: null == lastAccessed ? _self.lastAccessed : lastAccessed // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FileHistory].
extension FileHistoryPatterns on FileHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileHistory value)  $default,){
final _that = this;
switch (_that) {
case _FileHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileHistory value)?  $default,){
final _that = this;
switch (_that) {
case _FileHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String path,  DateTime lastAccessed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileHistory() when $default != null:
return $default(_that.id,_that.path,_that.lastAccessed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String path,  DateTime lastAccessed)  $default,) {final _that = this;
switch (_that) {
case _FileHistory():
return $default(_that.id,_that.path,_that.lastAccessed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String path,  DateTime lastAccessed)?  $default,) {final _that = this;
switch (_that) {
case _FileHistory() when $default != null:
return $default(_that.id,_that.path,_that.lastAccessed);case _:
  return null;

}
}

}

/// @nodoc


class _FileHistory implements FileHistory {
  const _FileHistory({required this.id, required this.path, required this.lastAccessed});
  

@override final  String id;
@override final  String path;
@override final  DateTime lastAccessed;

/// Create a copy of FileHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileHistoryCopyWith<_FileHistory> get copyWith => __$FileHistoryCopyWithImpl<_FileHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.path, path) || other.path == path)&&(identical(other.lastAccessed, lastAccessed) || other.lastAccessed == lastAccessed));
}


@override
int get hashCode => Object.hash(runtimeType,id,path,lastAccessed);

@override
String toString() {
  return 'FileHistory(id: $id, path: $path, lastAccessed: $lastAccessed)';
}


}

/// @nodoc
abstract mixin class _$FileHistoryCopyWith<$Res> implements $FileHistoryCopyWith<$Res> {
  factory _$FileHistoryCopyWith(_FileHistory value, $Res Function(_FileHistory) _then) = __$FileHistoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String path, DateTime lastAccessed
});




}
/// @nodoc
class __$FileHistoryCopyWithImpl<$Res>
    implements _$FileHistoryCopyWith<$Res> {
  __$FileHistoryCopyWithImpl(this._self, this._then);

  final _FileHistory _self;
  final $Res Function(_FileHistory) _then;

/// Create a copy of FileHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? path = null,Object? lastAccessed = null,}) {
  return _then(_FileHistory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,lastAccessed: null == lastAccessed ? _self.lastAccessed : lastAccessed // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

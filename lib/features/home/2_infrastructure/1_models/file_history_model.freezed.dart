// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileHistoryModel {

 String get id; String get path; DateTime get lastAccessed;
/// Create a copy of FileHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileHistoryModelCopyWith<FileHistoryModel> get copyWith => _$FileHistoryModelCopyWithImpl<FileHistoryModel>(this as FileHistoryModel, _$identity);

  /// Serializes this FileHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.path, path) || other.path == path)&&(identical(other.lastAccessed, lastAccessed) || other.lastAccessed == lastAccessed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,path,lastAccessed);

@override
String toString() {
  return 'FileHistoryModel(id: $id, path: $path, lastAccessed: $lastAccessed)';
}


}

/// @nodoc
abstract mixin class $FileHistoryModelCopyWith<$Res>  {
  factory $FileHistoryModelCopyWith(FileHistoryModel value, $Res Function(FileHistoryModel) _then) = _$FileHistoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String path, DateTime lastAccessed
});




}
/// @nodoc
class _$FileHistoryModelCopyWithImpl<$Res>
    implements $FileHistoryModelCopyWith<$Res> {
  _$FileHistoryModelCopyWithImpl(this._self, this._then);

  final FileHistoryModel _self;
  final $Res Function(FileHistoryModel) _then;

/// Create a copy of FileHistoryModel
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


/// Adds pattern-matching-related methods to [FileHistoryModel].
extension FileHistoryModelPatterns on FileHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _FileHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _FileHistoryModel() when $default != null:
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
case _FileHistoryModel() when $default != null:
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
case _FileHistoryModel():
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
case _FileHistoryModel() when $default != null:
return $default(_that.id,_that.path,_that.lastAccessed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileHistoryModel implements FileHistoryModel {
  const _FileHistoryModel({required this.id, required this.path, required this.lastAccessed});
  factory _FileHistoryModel.fromJson(Map<String, dynamic> json) => _$FileHistoryModelFromJson(json);

@override final  String id;
@override final  String path;
@override final  DateTime lastAccessed;

/// Create a copy of FileHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileHistoryModelCopyWith<_FileHistoryModel> get copyWith => __$FileHistoryModelCopyWithImpl<_FileHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.path, path) || other.path == path)&&(identical(other.lastAccessed, lastAccessed) || other.lastAccessed == lastAccessed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,path,lastAccessed);

@override
String toString() {
  return 'FileHistoryModel(id: $id, path: $path, lastAccessed: $lastAccessed)';
}


}

/// @nodoc
abstract mixin class _$FileHistoryModelCopyWith<$Res> implements $FileHistoryModelCopyWith<$Res> {
  factory _$FileHistoryModelCopyWith(_FileHistoryModel value, $Res Function(_FileHistoryModel) _then) = __$FileHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String path, DateTime lastAccessed
});




}
/// @nodoc
class __$FileHistoryModelCopyWithImpl<$Res>
    implements _$FileHistoryModelCopyWith<$Res> {
  __$FileHistoryModelCopyWithImpl(this._self, this._then);

  final _FileHistoryModel _self;
  final $Res Function(_FileHistoryModel) _then;

/// Create a copy of FileHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? path = null,Object? lastAccessed = null,}) {
  return _then(_FileHistoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,lastAccessed: null == lastAccessed ? _self.lastAccessed : lastAccessed // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

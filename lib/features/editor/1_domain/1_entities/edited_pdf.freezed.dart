// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edited_pdf.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditedPdf {

 String get id; String get originalPath; List<Uint8List> get pageImages;// Thumbnails for grid
 List<int> get pageOrder;// Indices of original pages
 Map<int, int> get pageRotations;// Rotation in degrees (0, 90, 180, 270) per current page index
 Map<int, List<double>> get pageCrops;
/// Create a copy of EditedPdf
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditedPdfCopyWith<EditedPdf> get copyWith => _$EditedPdfCopyWithImpl<EditedPdf>(this as EditedPdf, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditedPdf&&(identical(other.id, id) || other.id == id)&&(identical(other.originalPath, originalPath) || other.originalPath == originalPath)&&const DeepCollectionEquality().equals(other.pageImages, pageImages)&&const DeepCollectionEquality().equals(other.pageOrder, pageOrder)&&const DeepCollectionEquality().equals(other.pageRotations, pageRotations)&&const DeepCollectionEquality().equals(other.pageCrops, pageCrops));
}


@override
int get hashCode => Object.hash(runtimeType,id,originalPath,const DeepCollectionEquality().hash(pageImages),const DeepCollectionEquality().hash(pageOrder),const DeepCollectionEquality().hash(pageRotations),const DeepCollectionEquality().hash(pageCrops));

@override
String toString() {
  return 'EditedPdf(id: $id, originalPath: $originalPath, pageImages: $pageImages, pageOrder: $pageOrder, pageRotations: $pageRotations, pageCrops: $pageCrops)';
}


}

/// @nodoc
abstract mixin class $EditedPdfCopyWith<$Res>  {
  factory $EditedPdfCopyWith(EditedPdf value, $Res Function(EditedPdf) _then) = _$EditedPdfCopyWithImpl;
@useResult
$Res call({
 String id, String originalPath, List<Uint8List> pageImages, List<int> pageOrder, Map<int, int> pageRotations, Map<int, List<double>> pageCrops
});




}
/// @nodoc
class _$EditedPdfCopyWithImpl<$Res>
    implements $EditedPdfCopyWith<$Res> {
  _$EditedPdfCopyWithImpl(this._self, this._then);

  final EditedPdf _self;
  final $Res Function(EditedPdf) _then;

/// Create a copy of EditedPdf
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? originalPath = null,Object? pageImages = null,Object? pageOrder = null,Object? pageRotations = null,Object? pageCrops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,originalPath: null == originalPath ? _self.originalPath : originalPath // ignore: cast_nullable_to_non_nullable
as String,pageImages: null == pageImages ? _self.pageImages : pageImages // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,pageOrder: null == pageOrder ? _self.pageOrder : pageOrder // ignore: cast_nullable_to_non_nullable
as List<int>,pageRotations: null == pageRotations ? _self.pageRotations : pageRotations // ignore: cast_nullable_to_non_nullable
as Map<int, int>,pageCrops: null == pageCrops ? _self.pageCrops : pageCrops // ignore: cast_nullable_to_non_nullable
as Map<int, List<double>>,
  ));
}

}


/// Adds pattern-matching-related methods to [EditedPdf].
extension EditedPdfPatterns on EditedPdf {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditedPdf value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditedPdf() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditedPdf value)  $default,){
final _that = this;
switch (_that) {
case _EditedPdf():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditedPdf value)?  $default,){
final _that = this;
switch (_that) {
case _EditedPdf() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String originalPath,  List<Uint8List> pageImages,  List<int> pageOrder,  Map<int, int> pageRotations,  Map<int, List<double>> pageCrops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditedPdf() when $default != null:
return $default(_that.id,_that.originalPath,_that.pageImages,_that.pageOrder,_that.pageRotations,_that.pageCrops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String originalPath,  List<Uint8List> pageImages,  List<int> pageOrder,  Map<int, int> pageRotations,  Map<int, List<double>> pageCrops)  $default,) {final _that = this;
switch (_that) {
case _EditedPdf():
return $default(_that.id,_that.originalPath,_that.pageImages,_that.pageOrder,_that.pageRotations,_that.pageCrops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String originalPath,  List<Uint8List> pageImages,  List<int> pageOrder,  Map<int, int> pageRotations,  Map<int, List<double>> pageCrops)?  $default,) {final _that = this;
switch (_that) {
case _EditedPdf() when $default != null:
return $default(_that.id,_that.originalPath,_that.pageImages,_that.pageOrder,_that.pageRotations,_that.pageCrops);case _:
  return null;

}
}

}

/// @nodoc


class _EditedPdf implements EditedPdf {
  const _EditedPdf({required this.id, required this.originalPath, required final  List<Uint8List> pageImages, required final  List<int> pageOrder, required final  Map<int, int> pageRotations, required final  Map<int, List<double>> pageCrops}): _pageImages = pageImages,_pageOrder = pageOrder,_pageRotations = pageRotations,_pageCrops = pageCrops;
  

@override final  String id;
@override final  String originalPath;
 final  List<Uint8List> _pageImages;
@override List<Uint8List> get pageImages {
  if (_pageImages is EqualUnmodifiableListView) return _pageImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pageImages);
}

// Thumbnails for grid
 final  List<int> _pageOrder;
// Thumbnails for grid
@override List<int> get pageOrder {
  if (_pageOrder is EqualUnmodifiableListView) return _pageOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pageOrder);
}

// Indices of original pages
 final  Map<int, int> _pageRotations;
// Indices of original pages
@override Map<int, int> get pageRotations {
  if (_pageRotations is EqualUnmodifiableMapView) return _pageRotations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pageRotations);
}

// Rotation in degrees (0, 90, 180, 270) per current page index
 final  Map<int, List<double>> _pageCrops;
// Rotation in degrees (0, 90, 180, 270) per current page index
@override Map<int, List<double>> get pageCrops {
  if (_pageCrops is EqualUnmodifiableMapView) return _pageCrops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pageCrops);
}


/// Create a copy of EditedPdf
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditedPdfCopyWith<_EditedPdf> get copyWith => __$EditedPdfCopyWithImpl<_EditedPdf>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditedPdf&&(identical(other.id, id) || other.id == id)&&(identical(other.originalPath, originalPath) || other.originalPath == originalPath)&&const DeepCollectionEquality().equals(other._pageImages, _pageImages)&&const DeepCollectionEquality().equals(other._pageOrder, _pageOrder)&&const DeepCollectionEquality().equals(other._pageRotations, _pageRotations)&&const DeepCollectionEquality().equals(other._pageCrops, _pageCrops));
}


@override
int get hashCode => Object.hash(runtimeType,id,originalPath,const DeepCollectionEquality().hash(_pageImages),const DeepCollectionEquality().hash(_pageOrder),const DeepCollectionEquality().hash(_pageRotations),const DeepCollectionEquality().hash(_pageCrops));

@override
String toString() {
  return 'EditedPdf(id: $id, originalPath: $originalPath, pageImages: $pageImages, pageOrder: $pageOrder, pageRotations: $pageRotations, pageCrops: $pageCrops)';
}


}

/// @nodoc
abstract mixin class _$EditedPdfCopyWith<$Res> implements $EditedPdfCopyWith<$Res> {
  factory _$EditedPdfCopyWith(_EditedPdf value, $Res Function(_EditedPdf) _then) = __$EditedPdfCopyWithImpl;
@override @useResult
$Res call({
 String id, String originalPath, List<Uint8List> pageImages, List<int> pageOrder, Map<int, int> pageRotations, Map<int, List<double>> pageCrops
});




}
/// @nodoc
class __$EditedPdfCopyWithImpl<$Res>
    implements _$EditedPdfCopyWith<$Res> {
  __$EditedPdfCopyWithImpl(this._self, this._then);

  final _EditedPdf _self;
  final $Res Function(_EditedPdf) _then;

/// Create a copy of EditedPdf
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? originalPath = null,Object? pageImages = null,Object? pageOrder = null,Object? pageRotations = null,Object? pageCrops = null,}) {
  return _then(_EditedPdf(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,originalPath: null == originalPath ? _self.originalPath : originalPath // ignore: cast_nullable_to_non_nullable
as String,pageImages: null == pageImages ? _self._pageImages : pageImages // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,pageOrder: null == pageOrder ? _self._pageOrder : pageOrder // ignore: cast_nullable_to_non_nullable
as List<int>,pageRotations: null == pageRotations ? _self._pageRotations : pageRotations // ignore: cast_nullable_to_non_nullable
as Map<int, int>,pageCrops: null == pageCrops ? _self._pageCrops : pageCrops // ignore: cast_nullable_to_non_nullable
as Map<int, List<double>>,
  ));
}


}

// dart format on

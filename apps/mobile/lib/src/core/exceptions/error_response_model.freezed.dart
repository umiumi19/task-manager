// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorResponseModel implements DiagnosticableTreeMixin {

 String get message; String get code;
/// Create a copy of ErrorResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorResponseModelCopyWith<ErrorResponseModel> get copyWith => _$ErrorResponseModelCopyWithImpl<ErrorResponseModel>(this as ErrorResponseModel, _$identity);

  /// Serializes this ErrorResponseModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ErrorResponseModel'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('code', code));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorResponseModel&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ErrorResponseModel(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $ErrorResponseModelCopyWith<$Res>  {
  factory $ErrorResponseModelCopyWith(ErrorResponseModel value, $Res Function(ErrorResponseModel) _then) = _$ErrorResponseModelCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$ErrorResponseModelCopyWithImpl<$Res>
    implements $ErrorResponseModelCopyWith<$Res> {
  _$ErrorResponseModelCopyWithImpl(this._self, this._then);

  final ErrorResponseModel _self;
  final $Res Function(ErrorResponseModel) _then;

/// Create a copy of ErrorResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? code = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorResponseModel].
extension ErrorResponseModelPatterns on ErrorResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ErrorResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorResponseModel() when $default != null:
return $default(_that.message,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String code)  $default,) {final _that = this;
switch (_that) {
case _ErrorResponseModel():
return $default(_that.message,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String code)?  $default,) {final _that = this;
switch (_that) {
case _ErrorResponseModel() when $default != null:
return $default(_that.message,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorResponseModel with DiagnosticableTreeMixin implements ErrorResponseModel {
  const _ErrorResponseModel({required this.message, required this.code});
  factory _ErrorResponseModel.fromJson(Map<String, dynamic> json) => _$ErrorResponseModelFromJson(json);

@override final  String message;
@override final  String code;

/// Create a copy of ErrorResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorResponseModelCopyWith<_ErrorResponseModel> get copyWith => __$ErrorResponseModelCopyWithImpl<_ErrorResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorResponseModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ErrorResponseModel'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('code', code));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorResponseModel&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ErrorResponseModel(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ErrorResponseModelCopyWith<$Res> implements $ErrorResponseModelCopyWith<$Res> {
  factory _$ErrorResponseModelCopyWith(_ErrorResponseModel value, $Res Function(_ErrorResponseModel) _then) = __$ErrorResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class __$ErrorResponseModelCopyWithImpl<$Res>
    implements _$ErrorResponseModelCopyWith<$Res> {
  __$ErrorResponseModelCopyWithImpl(this._self, this._then);

  final _ErrorResponseModel _self;
  final $Res Function(_ErrorResponseModel) _then;

/// Create a copy of ErrorResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(_ErrorResponseModel(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

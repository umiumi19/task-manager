// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Field<T> {

 T get value; String? get errorMessage; bool get isValid;
/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldCopyWith<T, Field<T>> get copyWith => _$FieldCopyWithImpl<T, Field<T>>(this as Field<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Field<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),errorMessage,isValid);

@override
String toString() {
  return 'Field<$T>(value: $value, errorMessage: $errorMessage, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $FieldCopyWith<T,$Res>  {
  factory $FieldCopyWith(Field<T> value, $Res Function(Field<T>) _then) = _$FieldCopyWithImpl;
@useResult
$Res call({
 T value, String? errorMessage, bool isValid
});




}
/// @nodoc
class _$FieldCopyWithImpl<T,$Res>
    implements $FieldCopyWith<T, $Res> {
  _$FieldCopyWithImpl(this._self, this._then);

  final Field<T> _self;
  final $Res Function(Field<T>) _then;

/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? errorMessage = freezed,Object? isValid = null,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Field].
extension FieldPatterns<T> on Field<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Field<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Field() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Field<T> value)  $default,){
final _that = this;
switch (_that) {
case _Field():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Field<T> value)?  $default,){
final _that = this;
switch (_that) {
case _Field() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T value,  String? errorMessage,  bool isValid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Field() when $default != null:
return $default(_that.value,_that.errorMessage,_that.isValid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T value,  String? errorMessage,  bool isValid)  $default,) {final _that = this;
switch (_that) {
case _Field():
return $default(_that.value,_that.errorMessage,_that.isValid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T value,  String? errorMessage,  bool isValid)?  $default,) {final _that = this;
switch (_that) {
case _Field() when $default != null:
return $default(_that.value,_that.errorMessage,_that.isValid);case _:
  return null;

}
}

}

/// @nodoc


class _Field<T> implements Field<T> {
  const _Field({required this.value, this.errorMessage, this.isValid = false});
  

@override final  T value;
@override final  String? errorMessage;
@override@JsonKey() final  bool isValid;

/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldCopyWith<T, _Field<T>> get copyWith => __$FieldCopyWithImpl<T, _Field<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Field<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),errorMessage,isValid);

@override
String toString() {
  return 'Field<$T>(value: $value, errorMessage: $errorMessage, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class _$FieldCopyWith<T,$Res> implements $FieldCopyWith<T, $Res> {
  factory _$FieldCopyWith(_Field<T> value, $Res Function(_Field<T>) _then) = __$FieldCopyWithImpl;
@override @useResult
$Res call({
 T value, String? errorMessage, bool isValid
});




}
/// @nodoc
class __$FieldCopyWithImpl<T,$Res>
    implements _$FieldCopyWith<T, $Res> {
  __$FieldCopyWithImpl(this._self, this._then);

  final _Field<T> _self;
  final $Res Function(_Field<T>) _then;

/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? errorMessage = freezed,Object? isValid = null,}) {
  return _then(_Field<T>(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

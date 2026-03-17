// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_schedule_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditScheduleState {

 Field<String> get title; String? get memo; Field<DateTime?> get startAt; DateTime? get endAt; String? get location; Schedule? get previousSchedule; AsyncValue<void> get asyncValue;
/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditScheduleStateCopyWith<EditScheduleState> get copyWith => _$EditScheduleStateCopyWithImpl<EditScheduleState>(this as EditScheduleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditScheduleState&&(identical(other.title, title) || other.title == title)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.previousSchedule, previousSchedule) || other.previousSchedule == previousSchedule)&&(identical(other.asyncValue, asyncValue) || other.asyncValue == asyncValue));
}


@override
int get hashCode => Object.hash(runtimeType,title,memo,startAt,endAt,location,previousSchedule,asyncValue);

@override
String toString() {
  return 'EditScheduleState(title: $title, memo: $memo, startAt: $startAt, endAt: $endAt, location: $location, previousSchedule: $previousSchedule, asyncValue: $asyncValue)';
}


}

/// @nodoc
abstract mixin class $EditScheduleStateCopyWith<$Res>  {
  factory $EditScheduleStateCopyWith(EditScheduleState value, $Res Function(EditScheduleState) _then) = _$EditScheduleStateCopyWithImpl;
@useResult
$Res call({
 Field<String> title, String? memo, Field<DateTime?> startAt, DateTime? endAt, String? location, Schedule? previousSchedule, AsyncValue<void> asyncValue
});


$FieldCopyWith<String, $Res> get title;$FieldCopyWith<DateTime?, $Res> get startAt;$ScheduleCopyWith<$Res>? get previousSchedule;

}
/// @nodoc
class _$EditScheduleStateCopyWithImpl<$Res>
    implements $EditScheduleStateCopyWith<$Res> {
  _$EditScheduleStateCopyWithImpl(this._self, this._then);

  final EditScheduleState _self;
  final $Res Function(EditScheduleState) _then;

/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? memo = freezed,Object? startAt = null,Object? endAt = freezed,Object? location = freezed,Object? previousSchedule = freezed,Object? asyncValue = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Field<String>,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as Field<DateTime?>,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,previousSchedule: freezed == previousSchedule ? _self.previousSchedule : previousSchedule // ignore: cast_nullable_to_non_nullable
as Schedule?,asyncValue: null == asyncValue ? _self.asyncValue : asyncValue // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,
  ));
}
/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<String, $Res> get title {
  
  return $FieldCopyWith<String, $Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<DateTime?, $Res> get startAt {
  
  return $FieldCopyWith<DateTime?, $Res>(_self.startAt, (value) {
    return _then(_self.copyWith(startAt: value));
  });
}/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScheduleCopyWith<$Res>? get previousSchedule {
    if (_self.previousSchedule == null) {
    return null;
  }

  return $ScheduleCopyWith<$Res>(_self.previousSchedule!, (value) {
    return _then(_self.copyWith(previousSchedule: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditScheduleState].
extension EditScheduleStatePatterns on EditScheduleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditScheduleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditScheduleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditScheduleState value)  $default,){
final _that = this;
switch (_that) {
case _EditScheduleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditScheduleState value)?  $default,){
final _that = this;
switch (_that) {
case _EditScheduleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Field<String> title,  String? memo,  Field<DateTime?> startAt,  DateTime? endAt,  String? location,  Schedule? previousSchedule,  AsyncValue<void> asyncValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditScheduleState() when $default != null:
return $default(_that.title,_that.memo,_that.startAt,_that.endAt,_that.location,_that.previousSchedule,_that.asyncValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Field<String> title,  String? memo,  Field<DateTime?> startAt,  DateTime? endAt,  String? location,  Schedule? previousSchedule,  AsyncValue<void> asyncValue)  $default,) {final _that = this;
switch (_that) {
case _EditScheduleState():
return $default(_that.title,_that.memo,_that.startAt,_that.endAt,_that.location,_that.previousSchedule,_that.asyncValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Field<String> title,  String? memo,  Field<DateTime?> startAt,  DateTime? endAt,  String? location,  Schedule? previousSchedule,  AsyncValue<void> asyncValue)?  $default,) {final _that = this;
switch (_that) {
case _EditScheduleState() when $default != null:
return $default(_that.title,_that.memo,_that.startAt,_that.endAt,_that.location,_that.previousSchedule,_that.asyncValue);case _:
  return null;

}
}

}

/// @nodoc


class _EditScheduleState extends EditScheduleState {
  const _EditScheduleState({this.title = const Field(value: ''), this.memo, this.startAt = const Field(value: null), this.endAt, this.location, this.previousSchedule, this.asyncValue = const AsyncData<void>(null)}): super._();
  

@override@JsonKey() final  Field<String> title;
@override final  String? memo;
@override@JsonKey() final  Field<DateTime?> startAt;
@override final  DateTime? endAt;
@override final  String? location;
@override final  Schedule? previousSchedule;
@override@JsonKey() final  AsyncValue<void> asyncValue;

/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditScheduleStateCopyWith<_EditScheduleState> get copyWith => __$EditScheduleStateCopyWithImpl<_EditScheduleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditScheduleState&&(identical(other.title, title) || other.title == title)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.previousSchedule, previousSchedule) || other.previousSchedule == previousSchedule)&&(identical(other.asyncValue, asyncValue) || other.asyncValue == asyncValue));
}


@override
int get hashCode => Object.hash(runtimeType,title,memo,startAt,endAt,location,previousSchedule,asyncValue);

@override
String toString() {
  return 'EditScheduleState(title: $title, memo: $memo, startAt: $startAt, endAt: $endAt, location: $location, previousSchedule: $previousSchedule, asyncValue: $asyncValue)';
}


}

/// @nodoc
abstract mixin class _$EditScheduleStateCopyWith<$Res> implements $EditScheduleStateCopyWith<$Res> {
  factory _$EditScheduleStateCopyWith(_EditScheduleState value, $Res Function(_EditScheduleState) _then) = __$EditScheduleStateCopyWithImpl;
@override @useResult
$Res call({
 Field<String> title, String? memo, Field<DateTime?> startAt, DateTime? endAt, String? location, Schedule? previousSchedule, AsyncValue<void> asyncValue
});


@override $FieldCopyWith<String, $Res> get title;@override $FieldCopyWith<DateTime?, $Res> get startAt;@override $ScheduleCopyWith<$Res>? get previousSchedule;

}
/// @nodoc
class __$EditScheduleStateCopyWithImpl<$Res>
    implements _$EditScheduleStateCopyWith<$Res> {
  __$EditScheduleStateCopyWithImpl(this._self, this._then);

  final _EditScheduleState _self;
  final $Res Function(_EditScheduleState) _then;

/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? memo = freezed,Object? startAt = null,Object? endAt = freezed,Object? location = freezed,Object? previousSchedule = freezed,Object? asyncValue = null,}) {
  return _then(_EditScheduleState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Field<String>,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as Field<DateTime?>,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,previousSchedule: freezed == previousSchedule ? _self.previousSchedule : previousSchedule // ignore: cast_nullable_to_non_nullable
as Schedule?,asyncValue: null == asyncValue ? _self.asyncValue : asyncValue // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,
  ));
}

/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<String, $Res> get title {
  
  return $FieldCopyWith<String, $Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<DateTime?, $Res> get startAt {
  
  return $FieldCopyWith<DateTime?, $Res>(_self.startAt, (value) {
    return _then(_self.copyWith(startAt: value));
  });
}/// Create a copy of EditScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScheduleCopyWith<$Res>? get previousSchedule {
    if (_self.previousSchedule == null) {
    return null;
  }

  return $ScheduleCopyWith<$Res>(_self.previousSchedule!, (value) {
    return _then(_self.copyWith(previousSchedule: value));
  });
}
}

// dart format on

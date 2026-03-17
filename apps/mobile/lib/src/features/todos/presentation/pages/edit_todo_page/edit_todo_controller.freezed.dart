// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_todo_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditTodoState {

 Field<String> get title; String? get memo; Field<DateTime?> get dueAt; bool get isDone; Todo? get previousTodo; AsyncValue<void> get asyncValue;
/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTodoStateCopyWith<EditTodoState> get copyWith => _$EditTodoStateCopyWithImpl<EditTodoState>(this as EditTodoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTodoState&&(identical(other.title, title) || other.title == title)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.previousTodo, previousTodo) || other.previousTodo == previousTodo)&&(identical(other.asyncValue, asyncValue) || other.asyncValue == asyncValue));
}


@override
int get hashCode => Object.hash(runtimeType,title,memo,dueAt,isDone,previousTodo,asyncValue);

@override
String toString() {
  return 'EditTodoState(title: $title, memo: $memo, dueAt: $dueAt, isDone: $isDone, previousTodo: $previousTodo, asyncValue: $asyncValue)';
}


}

/// @nodoc
abstract mixin class $EditTodoStateCopyWith<$Res>  {
  factory $EditTodoStateCopyWith(EditTodoState value, $Res Function(EditTodoState) _then) = _$EditTodoStateCopyWithImpl;
@useResult
$Res call({
 Field<String> title, String? memo, Field<DateTime?> dueAt, bool isDone, Todo? previousTodo, AsyncValue<void> asyncValue
});


$FieldCopyWith<String, $Res> get title;$FieldCopyWith<DateTime?, $Res> get dueAt;$TodoCopyWith<$Res>? get previousTodo;

}
/// @nodoc
class _$EditTodoStateCopyWithImpl<$Res>
    implements $EditTodoStateCopyWith<$Res> {
  _$EditTodoStateCopyWithImpl(this._self, this._then);

  final EditTodoState _self;
  final $Res Function(EditTodoState) _then;

/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? memo = freezed,Object? dueAt = null,Object? isDone = null,Object? previousTodo = freezed,Object? asyncValue = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Field<String>,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as Field<DateTime?>,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,previousTodo: freezed == previousTodo ? _self.previousTodo : previousTodo // ignore: cast_nullable_to_non_nullable
as Todo?,asyncValue: null == asyncValue ? _self.asyncValue : asyncValue // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,
  ));
}
/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<String, $Res> get title {
  
  return $FieldCopyWith<String, $Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<DateTime?, $Res> get dueAt {
  
  return $FieldCopyWith<DateTime?, $Res>(_self.dueAt, (value) {
    return _then(_self.copyWith(dueAt: value));
  });
}/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoCopyWith<$Res>? get previousTodo {
    if (_self.previousTodo == null) {
    return null;
  }

  return $TodoCopyWith<$Res>(_self.previousTodo!, (value) {
    return _then(_self.copyWith(previousTodo: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditTodoState].
extension EditTodoStatePatterns on EditTodoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditTodoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditTodoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditTodoState value)  $default,){
final _that = this;
switch (_that) {
case _EditTodoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditTodoState value)?  $default,){
final _that = this;
switch (_that) {
case _EditTodoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Field<String> title,  String? memo,  Field<DateTime?> dueAt,  bool isDone,  Todo? previousTodo,  AsyncValue<void> asyncValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditTodoState() when $default != null:
return $default(_that.title,_that.memo,_that.dueAt,_that.isDone,_that.previousTodo,_that.asyncValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Field<String> title,  String? memo,  Field<DateTime?> dueAt,  bool isDone,  Todo? previousTodo,  AsyncValue<void> asyncValue)  $default,) {final _that = this;
switch (_that) {
case _EditTodoState():
return $default(_that.title,_that.memo,_that.dueAt,_that.isDone,_that.previousTodo,_that.asyncValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Field<String> title,  String? memo,  Field<DateTime?> dueAt,  bool isDone,  Todo? previousTodo,  AsyncValue<void> asyncValue)?  $default,) {final _that = this;
switch (_that) {
case _EditTodoState() when $default != null:
return $default(_that.title,_that.memo,_that.dueAt,_that.isDone,_that.previousTodo,_that.asyncValue);case _:
  return null;

}
}

}

/// @nodoc


class _EditTodoState extends EditTodoState {
  const _EditTodoState({this.title = const Field(value: ''), this.memo, this.dueAt = const Field(value: null), this.isDone = false, this.previousTodo, this.asyncValue = const AsyncData<void>(null)}): super._();
  

@override@JsonKey() final  Field<String> title;
@override final  String? memo;
@override@JsonKey() final  Field<DateTime?> dueAt;
@override@JsonKey() final  bool isDone;
@override final  Todo? previousTodo;
@override@JsonKey() final  AsyncValue<void> asyncValue;

/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditTodoStateCopyWith<_EditTodoState> get copyWith => __$EditTodoStateCopyWithImpl<_EditTodoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditTodoState&&(identical(other.title, title) || other.title == title)&&(identical(other.memo, memo) || other.memo == memo)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.previousTodo, previousTodo) || other.previousTodo == previousTodo)&&(identical(other.asyncValue, asyncValue) || other.asyncValue == asyncValue));
}


@override
int get hashCode => Object.hash(runtimeType,title,memo,dueAt,isDone,previousTodo,asyncValue);

@override
String toString() {
  return 'EditTodoState(title: $title, memo: $memo, dueAt: $dueAt, isDone: $isDone, previousTodo: $previousTodo, asyncValue: $asyncValue)';
}


}

/// @nodoc
abstract mixin class _$EditTodoStateCopyWith<$Res> implements $EditTodoStateCopyWith<$Res> {
  factory _$EditTodoStateCopyWith(_EditTodoState value, $Res Function(_EditTodoState) _then) = __$EditTodoStateCopyWithImpl;
@override @useResult
$Res call({
 Field<String> title, String? memo, Field<DateTime?> dueAt, bool isDone, Todo? previousTodo, AsyncValue<void> asyncValue
});


@override $FieldCopyWith<String, $Res> get title;@override $FieldCopyWith<DateTime?, $Res> get dueAt;@override $TodoCopyWith<$Res>? get previousTodo;

}
/// @nodoc
class __$EditTodoStateCopyWithImpl<$Res>
    implements _$EditTodoStateCopyWith<$Res> {
  __$EditTodoStateCopyWithImpl(this._self, this._then);

  final _EditTodoState _self;
  final $Res Function(_EditTodoState) _then;

/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? memo = freezed,Object? dueAt = null,Object? isDone = null,Object? previousTodo = freezed,Object? asyncValue = null,}) {
  return _then(_EditTodoState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Field<String>,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as Field<DateTime?>,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,previousTodo: freezed == previousTodo ? _self.previousTodo : previousTodo // ignore: cast_nullable_to_non_nullable
as Todo?,asyncValue: null == asyncValue ? _self.asyncValue : asyncValue // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>,
  ));
}

/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<String, $Res> get title {
  
  return $FieldCopyWith<String, $Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<DateTime?, $Res> get dueAt {
  
  return $FieldCopyWith<DateTime?, $Res>(_self.dueAt, (value) {
    return _then(_self.copyWith(dueAt: value));
  });
}/// Create a copy of EditTodoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodoCopyWith<$Res>? get previousTodo {
    if (_self.previousTodo == null) {
    return null;
  }

  return $TodoCopyWith<$Res>(_self.previousTodo!, (value) {
    return _then(_self.copyWith(previousTodo: value));
  });
}
}

// dart format on

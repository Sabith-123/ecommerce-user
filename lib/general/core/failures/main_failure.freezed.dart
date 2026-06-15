// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainFailure {

 String get errorMsg;
/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainFailureCopyWith<MainFailure> get copyWith => _$MainFailureCopyWithImpl<MainFailure>(this as MainFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainFailure&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class $MainFailureCopyWith<$Res>  {
  factory $MainFailureCopyWith(MainFailure value, $Res Function(MainFailure) _then) = _$MainFailureCopyWithImpl;
@useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class _$MainFailureCopyWithImpl<$Res>
    implements $MainFailureCopyWith<$Res> {
  _$MainFailureCopyWithImpl(this._self, this._then);

  final MainFailure _self;
  final $Res Function(MainFailure) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errorMsg = null,}) {
  return _then(_self.copyWith(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MainFailure].
extension MainFailurePatterns on MainFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerFailure value)?  serverFailure,TResult Function( _AlredyExist value)?  alreadyExists,TResult Function( DataNotFount value)?  dataNotFound,TResult Function( _LocationFailure value)?  locationFailure,TResult Function( _PermissionDenied value)?  permissionDenied,TResult Function( _PickFailed value)?  pickFailed,TResult Function( AuthenticationFailure value)?  authenticationFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that);case _AlredyExist() when alreadyExists != null:
return alreadyExists(_that);case DataNotFount() when dataNotFound != null:
return dataNotFound(_that);case _LocationFailure() when locationFailure != null:
return locationFailure(_that);case _PermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case _PickFailed() when pickFailed != null:
return pickFailed(_that);case AuthenticationFailure() when authenticationFailure != null:
return authenticationFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerFailure value)  serverFailure,required TResult Function( _AlredyExist value)  alreadyExists,required TResult Function( DataNotFount value)  dataNotFound,required TResult Function( _LocationFailure value)  locationFailure,required TResult Function( _PermissionDenied value)  permissionDenied,required TResult Function( _PickFailed value)  pickFailed,required TResult Function( AuthenticationFailure value)  authenticationFailure,}){
final _that = this;
switch (_that) {
case ServerFailure():
return serverFailure(_that);case _AlredyExist():
return alreadyExists(_that);case DataNotFount():
return dataNotFound(_that);case _LocationFailure():
return locationFailure(_that);case _PermissionDenied():
return permissionDenied(_that);case _PickFailed():
return pickFailed(_that);case AuthenticationFailure():
return authenticationFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerFailure value)?  serverFailure,TResult? Function( _AlredyExist value)?  alreadyExists,TResult? Function( DataNotFount value)?  dataNotFound,TResult? Function( _LocationFailure value)?  locationFailure,TResult? Function( _PermissionDenied value)?  permissionDenied,TResult? Function( _PickFailed value)?  pickFailed,TResult? Function( AuthenticationFailure value)?  authenticationFailure,}){
final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that);case _AlredyExist() when alreadyExists != null:
return alreadyExists(_that);case DataNotFount() when dataNotFound != null:
return dataNotFound(_that);case _LocationFailure() when locationFailure != null:
return locationFailure(_that);case _PermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case _PickFailed() when pickFailed != null:
return pickFailed(_that);case AuthenticationFailure() when authenticationFailure != null:
return authenticationFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String errorMsg)?  serverFailure,TResult Function( String errorMsg)?  alreadyExists,TResult Function( String errorMsg)?  dataNotFound,TResult Function( String errorMsg)?  locationFailure,TResult Function( String errorMsg)?  permissionDenied,TResult Function( String errorMsg)?  pickFailed,TResult Function( String errorMsg)?  authenticationFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that.errorMsg);case _AlredyExist() when alreadyExists != null:
return alreadyExists(_that.errorMsg);case DataNotFount() when dataNotFound != null:
return dataNotFound(_that.errorMsg);case _LocationFailure() when locationFailure != null:
return locationFailure(_that.errorMsg);case _PermissionDenied() when permissionDenied != null:
return permissionDenied(_that.errorMsg);case _PickFailed() when pickFailed != null:
return pickFailed(_that.errorMsg);case AuthenticationFailure() when authenticationFailure != null:
return authenticationFailure(_that.errorMsg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String errorMsg)  serverFailure,required TResult Function( String errorMsg)  alreadyExists,required TResult Function( String errorMsg)  dataNotFound,required TResult Function( String errorMsg)  locationFailure,required TResult Function( String errorMsg)  permissionDenied,required TResult Function( String errorMsg)  pickFailed,required TResult Function( String errorMsg)  authenticationFailure,}) {final _that = this;
switch (_that) {
case ServerFailure():
return serverFailure(_that.errorMsg);case _AlredyExist():
return alreadyExists(_that.errorMsg);case DataNotFount():
return dataNotFound(_that.errorMsg);case _LocationFailure():
return locationFailure(_that.errorMsg);case _PermissionDenied():
return permissionDenied(_that.errorMsg);case _PickFailed():
return pickFailed(_that.errorMsg);case AuthenticationFailure():
return authenticationFailure(_that.errorMsg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String errorMsg)?  serverFailure,TResult? Function( String errorMsg)?  alreadyExists,TResult? Function( String errorMsg)?  dataNotFound,TResult? Function( String errorMsg)?  locationFailure,TResult? Function( String errorMsg)?  permissionDenied,TResult? Function( String errorMsg)?  pickFailed,TResult? Function( String errorMsg)?  authenticationFailure,}) {final _that = this;
switch (_that) {
case ServerFailure() when serverFailure != null:
return serverFailure(_that.errorMsg);case _AlredyExist() when alreadyExists != null:
return alreadyExists(_that.errorMsg);case DataNotFount() when dataNotFound != null:
return dataNotFound(_that.errorMsg);case _LocationFailure() when locationFailure != null:
return locationFailure(_that.errorMsg);case _PermissionDenied() when permissionDenied != null:
return permissionDenied(_that.errorMsg);case _PickFailed() when pickFailed != null:
return pickFailed(_that.errorMsg);case AuthenticationFailure() when authenticationFailure != null:
return authenticationFailure(_that.errorMsg);case _:
  return null;

}
}

}

/// @nodoc


class ServerFailure implements MainFailure {
  const ServerFailure({required this.errorMsg});
  

@override final  String errorMsg;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure.serverFailure(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $MainFailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@override @useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMsg = null,}) {
  return _then(ServerFailure(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AlredyExist implements MainFailure {
  const _AlredyExist({required this.errorMsg});
  

@override final  String errorMsg;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlredyExistCopyWith<_AlredyExist> get copyWith => __$AlredyExistCopyWithImpl<_AlredyExist>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlredyExist&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure.alreadyExists(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class _$AlredyExistCopyWith<$Res> implements $MainFailureCopyWith<$Res> {
  factory _$AlredyExistCopyWith(_AlredyExist value, $Res Function(_AlredyExist) _then) = __$AlredyExistCopyWithImpl;
@override @useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class __$AlredyExistCopyWithImpl<$Res>
    implements _$AlredyExistCopyWith<$Res> {
  __$AlredyExistCopyWithImpl(this._self, this._then);

  final _AlredyExist _self;
  final $Res Function(_AlredyExist) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMsg = null,}) {
  return _then(_AlredyExist(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DataNotFount implements MainFailure {
  const DataNotFount({required this.errorMsg});
  

@override final  String errorMsg;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataNotFountCopyWith<DataNotFount> get copyWith => _$DataNotFountCopyWithImpl<DataNotFount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataNotFount&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure.dataNotFound(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class $DataNotFountCopyWith<$Res> implements $MainFailureCopyWith<$Res> {
  factory $DataNotFountCopyWith(DataNotFount value, $Res Function(DataNotFount) _then) = _$DataNotFountCopyWithImpl;
@override @useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class _$DataNotFountCopyWithImpl<$Res>
    implements $DataNotFountCopyWith<$Res> {
  _$DataNotFountCopyWithImpl(this._self, this._then);

  final DataNotFount _self;
  final $Res Function(DataNotFount) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMsg = null,}) {
  return _then(DataNotFount(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LocationFailure implements MainFailure {
  const _LocationFailure({required this.errorMsg});
  

@override final  String errorMsg;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationFailureCopyWith<_LocationFailure> get copyWith => __$LocationFailureCopyWithImpl<_LocationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationFailure&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure.locationFailure(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class _$LocationFailureCopyWith<$Res> implements $MainFailureCopyWith<$Res> {
  factory _$LocationFailureCopyWith(_LocationFailure value, $Res Function(_LocationFailure) _then) = __$LocationFailureCopyWithImpl;
@override @useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class __$LocationFailureCopyWithImpl<$Res>
    implements _$LocationFailureCopyWith<$Res> {
  __$LocationFailureCopyWithImpl(this._self, this._then);

  final _LocationFailure _self;
  final $Res Function(_LocationFailure) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMsg = null,}) {
  return _then(_LocationFailure(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PermissionDenied implements MainFailure {
  const _PermissionDenied({required this.errorMsg});
  

@override final  String errorMsg;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PermissionDeniedCopyWith<_PermissionDenied> get copyWith => __$PermissionDeniedCopyWithImpl<_PermissionDenied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionDenied&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure.permissionDenied(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class _$PermissionDeniedCopyWith<$Res> implements $MainFailureCopyWith<$Res> {
  factory _$PermissionDeniedCopyWith(_PermissionDenied value, $Res Function(_PermissionDenied) _then) = __$PermissionDeniedCopyWithImpl;
@override @useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class __$PermissionDeniedCopyWithImpl<$Res>
    implements _$PermissionDeniedCopyWith<$Res> {
  __$PermissionDeniedCopyWithImpl(this._self, this._then);

  final _PermissionDenied _self;
  final $Res Function(_PermissionDenied) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMsg = null,}) {
  return _then(_PermissionDenied(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PickFailed implements MainFailure {
  const _PickFailed({required this.errorMsg});
  

@override final  String errorMsg;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PickFailedCopyWith<_PickFailed> get copyWith => __$PickFailedCopyWithImpl<_PickFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PickFailed&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure.pickFailed(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class _$PickFailedCopyWith<$Res> implements $MainFailureCopyWith<$Res> {
  factory _$PickFailedCopyWith(_PickFailed value, $Res Function(_PickFailed) _then) = __$PickFailedCopyWithImpl;
@override @useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class __$PickFailedCopyWithImpl<$Res>
    implements _$PickFailedCopyWith<$Res> {
  __$PickFailedCopyWithImpl(this._self, this._then);

  final _PickFailed _self;
  final $Res Function(_PickFailed) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMsg = null,}) {
  return _then(_PickFailed(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthenticationFailure implements MainFailure {
  const AuthenticationFailure({required this.errorMsg});
  

@override final  String errorMsg;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationFailureCopyWith<AuthenticationFailure> get copyWith => _$AuthenticationFailureCopyWithImpl<AuthenticationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationFailure&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode => Object.hash(runtimeType,errorMsg);

@override
String toString() {
  return 'MainFailure.authenticationFailure(errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class $AuthenticationFailureCopyWith<$Res> implements $MainFailureCopyWith<$Res> {
  factory $AuthenticationFailureCopyWith(AuthenticationFailure value, $Res Function(AuthenticationFailure) _then) = _$AuthenticationFailureCopyWithImpl;
@override @useResult
$Res call({
 String errorMsg
});




}
/// @nodoc
class _$AuthenticationFailureCopyWithImpl<$Res>
    implements $AuthenticationFailureCopyWith<$Res> {
  _$AuthenticationFailureCopyWithImpl(this._self, this._then);

  final AuthenticationFailure _self;
  final $Res Function(AuthenticationFailure) _then;

/// Create a copy of MainFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMsg = null,}) {
  return _then(AuthenticationFailure(
errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

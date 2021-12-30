// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'checkin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CheckinStateTearOff {
  const _$CheckinStateTearOff();

  Loading loading() {
    return const Loading();
  }

  Error error(String error) {
    return Error(
      error,
    );
  }

  NoCheckin noCheckin() {
    return const NoCheckin();
  }

  HasCheckin hasCheckin(Checkin checkin) {
    return HasCheckin(
      checkin,
    );
  }
}

/// @nodoc
const $CheckinState = _$CheckinStateTearOff();

/// @nodoc
mixin _$CheckinState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) error,
    required TResult Function() noCheckin,
    required TResult Function(Checkin checkin) hasCheckin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(NoCheckin value) noCheckin,
    required TResult Function(HasCheckin value) hasCheckin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckinStateCopyWith<$Res> {
  factory $CheckinStateCopyWith(
          CheckinState value, $Res Function(CheckinState) then) =
      _$CheckinStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$CheckinStateCopyWithImpl<$Res> implements $CheckinStateCopyWith<$Res> {
  _$CheckinStateCopyWithImpl(this._value, this._then);

  final CheckinState _value;
  // ignore: unused_field
  final $Res Function(CheckinState) _then;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$CheckinStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

/// @nodoc

class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'CheckinState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) error,
    required TResult Function() noCheckin,
    required TResult Function(Checkin checkin) hasCheckin,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(NoCheckin value) noCheckin,
    required TResult Function(HasCheckin value) hasCheckin,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements CheckinState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$CheckinStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(Error(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Error implements Error {
  const _$Error(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'CheckinState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Error &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) error,
    required TResult Function() noCheckin,
    required TResult Function(Checkin checkin) hasCheckin,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(NoCheckin value) noCheckin,
    required TResult Function(HasCheckin value) hasCheckin,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements CheckinState {
  const factory Error(String error) = _$Error;

  String get error;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoCheckinCopyWith<$Res> {
  factory $NoCheckinCopyWith(NoCheckin value, $Res Function(NoCheckin) then) =
      _$NoCheckinCopyWithImpl<$Res>;
}

/// @nodoc
class _$NoCheckinCopyWithImpl<$Res> extends _$CheckinStateCopyWithImpl<$Res>
    implements $NoCheckinCopyWith<$Res> {
  _$NoCheckinCopyWithImpl(NoCheckin _value, $Res Function(NoCheckin) _then)
      : super(_value, (v) => _then(v as NoCheckin));

  @override
  NoCheckin get _value => super._value as NoCheckin;
}

/// @nodoc

class _$NoCheckin implements NoCheckin {
  const _$NoCheckin();

  @override
  String toString() {
    return 'CheckinState.noCheckin()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoCheckin);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) error,
    required TResult Function() noCheckin,
    required TResult Function(Checkin checkin) hasCheckin,
  }) {
    return noCheckin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
  }) {
    return noCheckin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
    required TResult orElse(),
  }) {
    if (noCheckin != null) {
      return noCheckin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(NoCheckin value) noCheckin,
    required TResult Function(HasCheckin value) hasCheckin,
  }) {
    return noCheckin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
  }) {
    return noCheckin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
    required TResult orElse(),
  }) {
    if (noCheckin != null) {
      return noCheckin(this);
    }
    return orElse();
  }
}

abstract class NoCheckin implements CheckinState {
  const factory NoCheckin() = _$NoCheckin;
}

/// @nodoc
abstract class $HasCheckinCopyWith<$Res> {
  factory $HasCheckinCopyWith(
          HasCheckin value, $Res Function(HasCheckin) then) =
      _$HasCheckinCopyWithImpl<$Res>;
  $Res call({Checkin checkin});
}

/// @nodoc
class _$HasCheckinCopyWithImpl<$Res> extends _$CheckinStateCopyWithImpl<$Res>
    implements $HasCheckinCopyWith<$Res> {
  _$HasCheckinCopyWithImpl(HasCheckin _value, $Res Function(HasCheckin) _then)
      : super(_value, (v) => _then(v as HasCheckin));

  @override
  HasCheckin get _value => super._value as HasCheckin;

  @override
  $Res call({
    Object? checkin = freezed,
  }) {
    return _then(HasCheckin(
      checkin == freezed
          ? _value.checkin
          : checkin // ignore: cast_nullable_to_non_nullable
              as Checkin,
    ));
  }
}

/// @nodoc

class _$HasCheckin implements HasCheckin {
  const _$HasCheckin(this.checkin);

  @override
  final Checkin checkin;

  @override
  String toString() {
    return 'CheckinState.hasCheckin(checkin: $checkin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HasCheckin &&
            const DeepCollectionEquality().equals(other.checkin, checkin));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(checkin));

  @JsonKey(ignore: true)
  @override
  $HasCheckinCopyWith<HasCheckin> get copyWith =>
      _$HasCheckinCopyWithImpl<HasCheckin>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error) error,
    required TResult Function() noCheckin,
    required TResult Function(Checkin checkin) hasCheckin,
  }) {
    return hasCheckin(checkin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
  }) {
    return hasCheckin?.call(checkin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error)? error,
    TResult Function()? noCheckin,
    TResult Function(Checkin checkin)? hasCheckin,
    required TResult orElse(),
  }) {
    if (hasCheckin != null) {
      return hasCheckin(checkin);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
    required TResult Function(NoCheckin value) noCheckin,
    required TResult Function(HasCheckin value) hasCheckin,
  }) {
    return hasCheckin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
  }) {
    return hasCheckin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    TResult Function(NoCheckin value)? noCheckin,
    TResult Function(HasCheckin value)? hasCheckin,
    required TResult orElse(),
  }) {
    if (hasCheckin != null) {
      return hasCheckin(this);
    }
    return orElse();
  }
}

abstract class HasCheckin implements CheckinState {
  const factory HasCheckin(Checkin checkin) = _$HasCheckin;

  Checkin get checkin;
  @JsonKey(ignore: true)
  $HasCheckinCopyWith<HasCheckin> get copyWith =>
      throw _privateConstructorUsedError;
}

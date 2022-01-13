// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scan_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ScanServiceStateTearOff {
  const _$ScanServiceStateTearOff();

  Loading loading() {
    return const Loading();
  }

  Running running() {
    return const Running();
  }

  Stopped stopped() {
    return const Stopped();
  }
}

/// @nodoc
const $ScanServiceState = _$ScanServiceStateTearOff();

/// @nodoc
mixin _$ScanServiceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() running,
    required TResult Function() stopped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Running value) running,
    required TResult Function(Stopped value) stopped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanServiceStateCopyWith<$Res> {
  factory $ScanServiceStateCopyWith(
          ScanServiceState value, $Res Function(ScanServiceState) then) =
      _$ScanServiceStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ScanServiceStateCopyWithImpl<$Res>
    implements $ScanServiceStateCopyWith<$Res> {
  _$ScanServiceStateCopyWithImpl(this._value, this._then);

  final ScanServiceState _value;
  // ignore: unused_field
  final $Res Function(ScanServiceState) _then;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$ScanServiceStateCopyWithImpl<$Res>
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
    return 'ScanServiceState.loading()';
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
    required TResult Function() running,
    required TResult Function() stopped,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
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
    required TResult Function(Running value) running,
    required TResult Function(Stopped value) stopped,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements ScanServiceState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $RunningCopyWith<$Res> {
  factory $RunningCopyWith(Running value, $Res Function(Running) then) =
      _$RunningCopyWithImpl<$Res>;
}

/// @nodoc
class _$RunningCopyWithImpl<$Res> extends _$ScanServiceStateCopyWithImpl<$Res>
    implements $RunningCopyWith<$Res> {
  _$RunningCopyWithImpl(Running _value, $Res Function(Running) _then)
      : super(_value, (v) => _then(v as Running));

  @override
  Running get _value => super._value as Running;
}

/// @nodoc

class _$Running implements Running {
  const _$Running();

  @override
  String toString() {
    return 'ScanServiceState.running()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Running);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() running,
    required TResult Function() stopped,
  }) {
    return running();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
  }) {
    return running?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Running value) running,
    required TResult Function(Stopped value) stopped,
  }) {
    return running(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
  }) {
    return running?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(this);
    }
    return orElse();
  }
}

abstract class Running implements ScanServiceState {
  const factory Running() = _$Running;
}

/// @nodoc
abstract class $StoppedCopyWith<$Res> {
  factory $StoppedCopyWith(Stopped value, $Res Function(Stopped) then) =
      _$StoppedCopyWithImpl<$Res>;
}

/// @nodoc
class _$StoppedCopyWithImpl<$Res> extends _$ScanServiceStateCopyWithImpl<$Res>
    implements $StoppedCopyWith<$Res> {
  _$StoppedCopyWithImpl(Stopped _value, $Res Function(Stopped) _then)
      : super(_value, (v) => _then(v as Stopped));

  @override
  Stopped get _value => super._value as Stopped;
}

/// @nodoc

class _$Stopped implements Stopped {
  const _$Stopped();

  @override
  String toString() {
    return 'ScanServiceState.stopped()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Stopped);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() running,
    required TResult Function() stopped,
  }) {
    return stopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
  }) {
    return stopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? running,
    TResult Function()? stopped,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Running value) running,
    required TResult Function(Stopped value) stopped,
  }) {
    return stopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
  }) {
    return stopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Running value)? running,
    TResult Function(Stopped value)? stopped,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped(this);
    }
    return orElse();
  }
}

abstract class Stopped implements ScanServiceState {
  const factory Stopped() = _$Stopped;
}

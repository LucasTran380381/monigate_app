// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bluetooth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BluetoothStateTearOff {
  const _$BluetoothStateTearOff();

  Error error(String error) {
    return Error(
      error,
    );
  }

  Data data(List<BluetoothDevice> devices, bool isScanning) {
    return Data(
      devices,
      isScanning,
    );
  }

  Empty empty() {
    return const Empty();
  }

  Initial initial() {
    return const Initial();
  }
}

/// @nodoc
const $BluetoothState = _$BluetoothStateTearOff();

/// @nodoc
mixin _$BluetoothState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String error) error,
    required TResult Function(List<BluetoothDevice> devices, bool isScanning)
        data,
    required TResult Function() empty,
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Error value) error,
    required TResult Function(Data value) data,
    required TResult Function(Empty value) empty,
    required TResult Function(Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothStateCopyWith<$Res> {
  factory $BluetoothStateCopyWith(
          BluetoothState value, $Res Function(BluetoothState) then) =
      _$BluetoothStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BluetoothStateCopyWithImpl<$Res>
    implements $BluetoothStateCopyWith<$Res> {
  _$BluetoothStateCopyWithImpl(this._value, this._then);

  final BluetoothState _value;
  // ignore: unused_field
  final $Res Function(BluetoothState) _then;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$BluetoothStateCopyWithImpl<$Res>
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
    return 'BluetoothState.error(error: $error)';
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
    required TResult Function(String error) error,
    required TResult Function(List<BluetoothDevice> devices, bool isScanning)
        data,
    required TResult Function() empty,
    required TResult Function() initial,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
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
    required TResult Function(Error value) error,
    required TResult Function(Data value) data,
    required TResult Function(Empty value) empty,
    required TResult Function(Initial value) initial,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements BluetoothState {
  const factory Error(String error) = _$Error;

  String get error;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  $Res call({List<BluetoothDevice> devices, bool isScanning});
}

/// @nodoc
class _$DataCopyWithImpl<$Res> extends _$BluetoothStateCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;

  @override
  $Res call({
    Object? devices = freezed,
    Object? isScanning = freezed,
  }) {
    return _then(Data(
      devices == freezed
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<BluetoothDevice>,
      isScanning == freezed
          ? _value.isScanning
          : isScanning // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Data implements Data {
  const _$Data(this.devices, this.isScanning);

  @override
  final List<BluetoothDevice> devices;
  @override
  final bool isScanning;

  @override
  String toString() {
    return 'BluetoothState.data(devices: $devices, isScanning: $isScanning)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Data &&
            const DeepCollectionEquality().equals(other.devices, devices) &&
            const DeepCollectionEquality()
                .equals(other.isScanning, isScanning));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(devices),
      const DeepCollectionEquality().hash(isScanning));

  @JsonKey(ignore: true)
  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String error) error,
    required TResult Function(List<BluetoothDevice> devices, bool isScanning)
        data,
    required TResult Function() empty,
    required TResult Function() initial,
  }) {
    return data(devices, isScanning);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
  }) {
    return data?.call(devices, isScanning);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(devices, isScanning);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Error value) error,
    required TResult Function(Data value) data,
    required TResult Function(Empty value) empty,
    required TResult Function(Initial value) initial,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class Data implements BluetoothState {
  const factory Data(List<BluetoothDevice> devices, bool isScanning) = _$Data;

  List<BluetoothDevice> get devices;
  bool get isScanning;
  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmptyCopyWith<$Res> {
  factory $EmptyCopyWith(Empty value, $Res Function(Empty) then) =
      _$EmptyCopyWithImpl<$Res>;
}

/// @nodoc
class _$EmptyCopyWithImpl<$Res> extends _$BluetoothStateCopyWithImpl<$Res>
    implements $EmptyCopyWith<$Res> {
  _$EmptyCopyWithImpl(Empty _value, $Res Function(Empty) _then)
      : super(_value, (v) => _then(v as Empty));

  @override
  Empty get _value => super._value as Empty;
}

/// @nodoc

class _$Empty implements Empty {
  const _$Empty();

  @override
  String toString() {
    return 'BluetoothState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Empty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String error) error,
    required TResult Function(List<BluetoothDevice> devices, bool isScanning)
        data,
    required TResult Function() empty,
    required TResult Function() initial,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Error value) error,
    required TResult Function(Data value) data,
    required TResult Function(Empty value) empty,
    required TResult Function(Initial value) initial,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class Empty implements BluetoothState {
  const factory Empty() = _$Empty;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$BluetoothStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'BluetoothState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String error) error,
    required TResult Function(List<BluetoothDevice> devices, bool isScanning)
        data,
    required TResult Function() empty,
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String error)? error,
    TResult Function(List<BluetoothDevice> devices, bool isScanning)? data,
    TResult Function()? empty,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Error value) error,
    required TResult Function(Data value) data,
    required TResult Function(Empty value) empty,
    required TResult Function(Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Error value)? error,
    TResult Function(Data value)? data,
    TResult Function(Empty value)? empty,
    TResult Function(Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements BluetoothState {
  const factory Initial() = _$Initial;
}

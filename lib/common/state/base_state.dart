import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

@freezed
class BaseState<T> with _$BaseState {
  const factory BaseState.empty() = Empty;

  const factory BaseState.loading() = Loading;

  const factory BaseState.loaded(T data) = Loaded;

  const factory BaseState.error(dynamic error) = Error;
}

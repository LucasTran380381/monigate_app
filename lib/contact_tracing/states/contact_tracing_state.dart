import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monigate_app/contact_tracing/model/contact_tracing.dart';

part 'contact_tracing_state.freezed.dart';

@freezed
class ContractTracingState with _$ContractTracingState {
  const factory ContractTracingState.initial() = Initial;
  const factory ContractTracingState.empty() = Empty;
  const factory ContractTracingState.data(List<ContactTracing> data) = Data;
}

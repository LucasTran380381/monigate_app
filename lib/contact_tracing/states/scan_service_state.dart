import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_service_state.freezed.dart';

@freezed
class ScanServiceState with _$ScanServiceState {
  const factory ScanServiceState.loading() = Loading;
  const factory ScanServiceState.running() = Running;
  const factory ScanServiceState.stopped() = Stopped;
}

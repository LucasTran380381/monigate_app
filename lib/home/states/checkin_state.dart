import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monigate_app/models/checkin.dart';

part 'checkin_state.freezed.dart';

@freezed
class CheckinState with _$CheckinState {
  const factory CheckinState.loading() = Loading;
  const factory CheckinState.error(String error) = Error;
  const factory CheckinState.noCheckin() = NoCheckin;
  const factory CheckinState.hasCheckin(Checkin checkin) = HasCheckin;
}

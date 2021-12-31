import 'package:json_annotation/json_annotation.dart';
import 'package:monigate_app/models/user.dart';

part 'checkin.g.dart';

@JsonSerializable()
class Checkin {
  String id;
  DateTime checkinTime;
  double temperature;
  String? faceMaskImageUrl;
  int faceMaskStatus, status;
  User user;

  Checkin(
      {required this.id,
      required this.checkinTime,
      required this.temperature,
      this.faceMaskImageUrl,
      required this.faceMaskStatus,
      required this.status,
      required this.user});

  factory Checkin.fromJson(Map<String, dynamic> json) => _$CheckinFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$CheckinToJson(this);

  get statusTitle {
    switch (status) {
      case 100:
        return 'Checkin thành công';
      case 200:
        return 'Lưu ý checkin';
      case 110:
        return 'Checkin thất bại';
    }
  }
}

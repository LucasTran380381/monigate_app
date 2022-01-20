import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracing.g.dart';

@JsonSerializable()
class Tracing {
  String userId;
  DateTime time;
  bool isSynced;

  Tracing({required this.userId, required this.time, required this.isSynced});

  factory Tracing.fromJson(Map<String, dynamic> json) => _$TracingFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$TracingToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'contact_tracing.g.dart';

@JsonSerializable()
class ContactTracing {
  ContactTracing({required this.macAddress, required this.isSynced, required this.time, required this.rssi});

  String macAddress;
  bool isSynced;
  DateTime time;
  int rssi;

  factory ContactTracing.fromJson(Map<String, dynamic> json) => _$ContactTracingFromJson(json);

  Map<String, dynamic> toJson() => _$ContactTracingToJson(this);
}

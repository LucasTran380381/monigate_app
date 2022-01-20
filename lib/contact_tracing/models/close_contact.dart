import 'package:freezed_annotation/freezed_annotation.dart';

part 'close_contact.g.dart';

@JsonSerializable()
class CloseContact {
  DateTime date;
  String id;
  bool isSynced;
  String userId;

  CloseContact({required this.date, required this.id, required this.userId, required this.isSynced});

  factory CloseContact.fromJson(Map<String, dynamic> json) => _$CloseContactFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$CloseContactToJson(this);
}

@JsonSerializable()
class CloseContactForManipulation {
  DateTime contactDate;
  List<String> contactedWithUserId;

  CloseContactForManipulation(this.contactDate, this.contactedWithUserId);

  factory CloseContactForManipulation.fromJson(Map<String, dynamic> json) => _$CloseContactForManipulationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$CloseContactForManipulationToJson(this);
}

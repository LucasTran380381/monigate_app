import 'package:freezed_annotation/freezed_annotation.dart';

part 'close_contact.g.dart';

@JsonSerializable()
class CloseContact {
  DateTime date;
  String id;
  bool isSynced;
  String contactWithUserId;

  CloseContact({required this.date, required this.id, required this.contactWithUserId, required this.isSynced});

  factory CloseContact.fromJson(Map<String, dynamic> json) => _$CloseContactFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$CloseContactToJson(this);

  factory CloseContact.fromMap(Map<String, dynamic> map) {
    return CloseContact(
        date: DateTime.parse(map['date']), id: map['id'], contactWithUserId: map['contactWithUserId'], isSynced: map['isSynced'] == 1);
  }
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

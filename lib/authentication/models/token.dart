import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  String token;
  DateTime expiryDate;

  Token(this.token, this.expiryDate);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

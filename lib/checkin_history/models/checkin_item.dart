class CheckinItem {
  CheckinItem({
    required this.checkinDate,
    this.checkoutDate,
    required this.checkinId,
    required this.checkinStatusCode,
    required this.faceMaskStatusCode,
    required this.temperatureStatusCode,
    required this.temperature,
  });

  DateTime checkinDate;
  DateTime? checkoutDate;
  String checkinId;
  int checkinStatusCode;
  int faceMaskStatusCode;
  int temperatureStatusCode;
  double temperature;

  factory CheckinItem.fromJson(Map<String, dynamic> json) => CheckinItem(
        checkinDate: DateTime.parse(json["checkinDate"]),
        checkoutDate: DateTime.tryParse(json["checkoutDate"] ?? ''),
        checkinId: json["checkinId"],
        checkinStatusCode: json["checkinStatusCode"],
        faceMaskStatusCode: json["faceMaskStatusCode"],
        temperatureStatusCode: json["temperatureStatusCode"],
        temperature: json["temperature"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "checkinDate": checkinDate.toIso8601String(),
        "checkoutDate": checkoutDate,
        "checkinId": checkinId,
        "checkinStatusCode": checkinStatusCode,
        "faceMaskStatusCode": faceMaskStatusCode,
        "temperatureStatusCode": temperatureStatusCode,
        "temperature": temperature,
      };
}

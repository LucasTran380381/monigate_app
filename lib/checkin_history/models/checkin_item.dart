class CheckinItem {
  CheckinItem({
    required this.checkinDate,
    required this.checkinId,
    required this.checkinStatusCode,
    required this.faceMaskStatusCode,
    required this.temperatureStatusCode,
  });

  DateTime checkinDate;
  String checkinId;
  int checkinStatusCode;
  int faceMaskStatusCode;
  int temperatureStatusCode;

  factory CheckinItem.fromJson(Map<String, dynamic> json) => CheckinItem(
        checkinDate: DateTime.parse(json["checkinDate"]),
        checkinId: json["checkinId"],
        checkinStatusCode: json["checkinStatusCode"],
        faceMaskStatusCode: json["faceMaskStatusCode"],
        temperatureStatusCode: json["temperatureStatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "checkinDate": checkinDate.toIso8601String(),
        "checkinId": checkinId,
        "checkinStatusCode": checkinStatusCode,
        "faceMaskStatusCode": faceMaskStatusCode,
        "temperatureStatusCode": temperatureStatusCode,
      };
}

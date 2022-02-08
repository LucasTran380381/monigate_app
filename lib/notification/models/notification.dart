class Notification {
  String id, sourceUserId;
  int dateRange;
  DateTime dateReceived;

  Notification({required this.id, required this.sourceUserId, required this.dateRange, required this.dateReceived});

  factory Notification.fromNotification(String userId, int dateRange) {
    final now = DateTime.now();
    final dateReceived = DateTime(now.year, now.month, now.day);

    return Notification(id: '$userId.$dateRange.$dateReceived', sourceUserId: userId, dateRange: dateRange, dateReceived: dateReceived);
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{'id': id, 'sourceUserId': sourceUserId, 'dateRange': dateRange, 'dateReceived': dateReceived.toIso8601String()};
    return map;
  }

  factory Notification.fromMap(Map<String, dynamic> map) => Notification(
      id: map['id'], sourceUserId: map['sourceUserId'], dateRange: map['dateRange'] as int, dateReceived: DateTime.parse(map['dateReceived']));

  String get message => 'Chú ý tiếp xúc với nhân viên $sourceUserId trong vòng $dateRange ngày gần đây';
}

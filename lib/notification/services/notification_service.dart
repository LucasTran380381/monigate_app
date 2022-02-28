import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/database/db_helpers.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';
import 'package:monigate_app/notification/models/notification.dart';

final notificationPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref);
});

class NotificationService {
  NotificationService(this._ref) {
    _notification = _ref.watch(notificationPluginProvider);
    _notification.initialize(
        const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: IOSInitializationSettings()),
        onSelectNotification: _handleSelectNotification);
  }

  late final FlutterLocalNotificationsPlugin _notification;
  final Ref _ref;

  showNotification(String? title, String? body, String? payload) async {
    _notification.show(23423434, title, body, _setupNotificationDetail(), payload: payload);
  }

  NotificationDetails _setupNotificationDetail() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description', importance: Importance.max, priority: Priority.high, icon: '@mipmap/ic_launcher'),
        iOS: IOSNotificationDetails());
  }

  _handleSelectNotification(String? payload) {
    print('$payload');
  }

  handleNotification(RemoteMessage message) {
    print('message: ${message.data}');
    final String? checkinStatus = message.data['checkinStatusCode'];
    final String? checkoutDate = message.data['checkoutDate'];
    if (checkinStatus != null) {
      checkoutDate == null
          ? showNotification('Checkin', 'Đã cập nhật checkin', 'payload')
          : showNotification(
              'Checkout',
              'Checkout thành công',
              'pay'
                  'load');
      _ref.read(checkinProvider.notifier).fetchCheckin();
    } else if (message.data['SourceUserId'] != null) {
      final userId = message.data['SourceUserId'] as String;
      final dateRange = int.parse(message.data['DayRange']);
      showNotification('Chú ý tiếp xúc', 'Chú ý tiếp xúc với nhân viên $userId trong vòng $dateRange ngày gần đây', '');
      _saveNotification(userId, dateRange);
    }
  }

  _saveNotification(String userId, int dateRange) async {
    print('save notificaion');
    final db = await _ref.read(dbHelperProvider).openDb();
    final needToSaveNotification = Notification.fromNotification(userId, dateRange);
    final result = await db.insert('notifications', needToSaveNotification.toMap());
    print('save notification: $result');
  }

  Future<List<Notification>> getNotification() async {
    final db = await _ref.read(dbHelperProvider).openDb();
    final result = await db.query('notifications');
    return result.map((element) => Notification.fromMap(element)).toList();
  }
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationPluginProvider = Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref.read(notificationPluginProvider));
});

class NotificationService {
  NotificationService(this._notification);

  final FlutterLocalNotificationsPlugin _notification;

  showNotification(String? title, String? body, String? payload) async {
    _notification.show(23423434, title, body, _setupNotificationDetail(), payload: payload);
  }

  NotificationDetails _setupNotificationDetail() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description', importance: Importance.max, priority: Priority.high, icon: '@mipmap/ic_launcher'),
        iOS: IOSNotificationDetails());
  }
}

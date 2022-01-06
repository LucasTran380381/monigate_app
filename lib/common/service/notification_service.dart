import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}

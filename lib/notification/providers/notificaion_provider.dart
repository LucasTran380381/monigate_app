import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/notification/services/notification_service.dart';

final notificationProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(notificationServiceProvider).getNotification();
});

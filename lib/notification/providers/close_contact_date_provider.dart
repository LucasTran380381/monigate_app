import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/services/tracing_service.dart';
import 'package:monigate_app/notification/models/notification.dart';

final closeContactDateProvider = FutureProvider.autoDispose.family((ref, Notification notification) async {
  return ref.read(tracingServiceProvider).findCloseContactDate(notification);
});

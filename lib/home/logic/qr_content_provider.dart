import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/providers/user_provider.dart';
import 'package:monigate_app/home/logic/device_id_provider.dart';
import 'package:tiengviet/tiengviet.dart';

final qrContentProvider = Provider<AsyncValue<String>>((ref) {
  final user = ref.watch(userProvider);
  final deviceId = ref.watch(deviceIdProvider);
  if (user is AsyncLoading || deviceId is AsyncLoading) {
    return const AsyncValue.loading();
  }
  if (user is AsyncError || deviceId is AsyncError) {
    return const AsyncValue.error('some thing wrong');
  }
  final firstName = TiengViet.parse(user.value!.firstName);
  final lastName = TiengViet.parse(user.value!.lastName);
  final id = user.value!.id;

  return AsyncValue.data('$id, $firstName, $lastName');
});

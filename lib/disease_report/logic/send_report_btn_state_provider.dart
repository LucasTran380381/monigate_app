import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/disease_report/logic/confirm_checkbox_provider.dart';
import 'package:monigate_app/disease_report/logic/image_provider.dart';

final submitButtonProvider = Provider.autoDispose<bool>((ref) {
  final isChecked = ref.watch(confirmCheckboxProvider);
  final isLoadedImage = ref.watch(imagesProvider) is AsyncData;
  return isChecked && isLoadedImage;
});

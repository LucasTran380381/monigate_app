import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagesProvider = StateNotifierProvider.autoDispose<ImageNotifier, AsyncValue<List<Image>>>((ref) {
  return ImageNotifier();
});

class ImageNotifier extends StateNotifier<AsyncValue<List<Image>>> {
  ImageNotifier() : super(const AsyncValue.data([]));

  List<File> _files = [];
  final _picker = ImagePicker();

  pickImagesFromGallery() async {
    state = const AsyncValue.loading();
    final files = await _picker.pickMultiImage();
    _files = files?.map((file) => File(file.path)).toList() ?? [];
    state = AsyncValue.data(files?.map((file) => Image.file(File(file.path))).toList() ?? []);
  }

  pickImagesFromCamara() async {
    final previousImages = state.value;
    state = const AsyncValue.loading();
    final file = await _picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      state = AsyncValue.data([...?previousImages, Image.file(File(file.path))]);
      _files.add(File(file.path));
    }
  }

  deleteImage(int index) {
    // state.removeAt(index);
    // state = state;
  }

  get imageFiles => _files;
}

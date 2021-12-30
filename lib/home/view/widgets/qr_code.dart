import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/home/logic/qr_content_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends ConsumerWidget {
  const QrCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(qrContentProvider);

    return content.when(
        data: (value) => QrImage(
              data: value,
              version: QrVersions.auto,
              size: 200,
            ),
        error: (error, stack) => Text(error.toString()),
        loading: () => const CircularProgressIndicator.adaptive());
  }
}

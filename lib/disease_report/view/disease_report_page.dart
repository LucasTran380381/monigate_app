import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/disease_report/logic/image_provider.dart';
import 'package:monigate_app/disease_report/services/disease_report_service.dart';
import 'package:monigate_app/notification/services/notification_service.dart';

class DiseaseReportPage extends StatefulWidget {
  const DiseaseReportPage({Key? key}) : super(key: key);

  @override
  State<DiseaseReportPage> createState() => _DiseaseReportPageState();
}

class _DiseaseReportPageState extends State<DiseaseReportPage> {
  String diseaseId = '';
  String note = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo sức khoẻ'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Text(
                  'Ngày',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColor.primaryColor),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  DateTime.now().shortFormatDate,
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => diseaseId = value,
                    decoration: const InputDecoration(
                      label: Text('Mã chuẩn đoán'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) => note = value,
                    decoration: const InputDecoration(
                      label: Text('Ghi chú thêm'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return Row(
                        children: [
                          const Text(
                            'Thêm hình ảnh',
                          ),
                          IconButton(
                            onPressed: () => ref.read(imagesProvider.notifier).pickImagesFromGallery(),
                            icon: const Icon(
                              Icons.image_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref.read(imagesProvider.notifier).pickImagesFromCamara(),
                            icon: const Icon(
                              Icons.photo_camera_outlined,
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              )),
          Consumer(
            builder: (context, ref, child) {
              final images = ref.watch(imagesProvider);
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: SizedBox(
                      height: 375,
                      child: images[index],
                    ));
                  },
                  itemCount: images.length,
                ),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    final files = ref.read(imagesProvider.notifier).imageFiles;
                    final isSuccess = await ref.read(diseaseReportServiceProvider).sendReport(diseaseId, note, files);
                    if (isSuccess) {
                      ref.read(notificationServiceProvider).showNotification('Báo cáo thành công', '', '');
                      Navigator.of(context).pop();
                    } else {
                      ref.read(notificationServiceProvider).showNotification('Báo cáo thất bại', '', '');
                    }
                  },
                  child: const Text('Gửi'),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

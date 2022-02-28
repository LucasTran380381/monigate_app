import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/disease_report/logic/confirm_checkbox_provider.dart';
import 'package:monigate_app/disease_report/logic/image_provider.dart';
import 'package:monigate_app/disease_report/logic/send_report_btn_state_provider.dart';
import 'package:monigate_app/disease_report/models/disease_report.dart';
import 'package:monigate_app/disease_report/services/disease_report_service.dart';
import 'package:monigate_app/notification/services/notification_service.dart';

class UpdateDiseaseReportPage extends ConsumerWidget {
  final DiseaseReport report;

  const UpdateDiseaseReportPage(
    this.report, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Cập nhật báo cáo',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    report.reportDate.shortFormatDate,
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => report.diseaseCode = value,
                      decoration: const InputDecoration(
                        label: Text('Mã chuẩn đoán'),
                        border: OutlineInputBorder(),
                      ),
                      initialValue: report.diseaseCode,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => report.note = value,
                      decoration: const InputDecoration(
                        label: Text('Ghi chú thêm'),
                        border: OutlineInputBorder(),
                      ),
                      initialValue: report.note,
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
                final state = ref.watch(imagesProvider);
                return state.when(data: (List<Image> data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: SizedBox(
                        height: 375,
                        child: data[index],
                      ));
                    },
                    itemCount: data.length,
                  );
                }, error: (Object error, StackTrace? stackTrace) {
                  return const SizedBox();
                }, loading: () {
                  return const CircularProgressIndicator.adaptive();
                });
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final imgUrl = report.reportImageUrls?.elementAt(index);
                return GestureDetector(
                    child: SizedBox(
                  height: 375,
                  child: Image.network(imgUrl ?? ''),
                ));
              },
              itemCount: report.reportImageUrls?.length,
            ),
            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final isChecked = ref.watch(confirmCheckboxProvider);
                    return Checkbox(
                      onChanged: (bool? value) {
                        ref.read(confirmCheckboxProvider.notifier).toggle();
                      },
                      value: isChecked,
                    );
                  },
                ),
                const Expanded(child: Text('Tôi cam kết khai báo đúng sự thật và thông tin bệnh liên quan đến nhiệt độ và truyền nhiễm'))
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final isReadyToSubmit = ref.watch(submitButtonProvider);
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: !isReadyToSubmit
                        ? null
                        : () async {
                            final files = ref.read(imagesProvider.notifier).imageFiles;
                            final isSuccess = await ref.read(diseaseReportServiceProvider).updateReport(report, files);
                            // final isSuccess = true;
                            if (isSuccess) {
                              ref.read(notificationServiceProvider).showNotification('Cập nhật thành công', '', '');
                              Navigator.of(context).pop();
                            } else {
                              ref.read(notificationServiceProvider).showNotification('Cập nhật thất bại', '', '');
                            }
                          },
                    child: const Text('Cập nhật'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/disease_report/logic/confirm_checkbox_provider.dart';
import 'package:monigate_app/disease_report/logic/disease_report_state_provider.dart';
import 'package:monigate_app/disease_report/logic/image_provider.dart';
import 'package:monigate_app/disease_report/logic/send_report_btn_state_provider.dart';
import 'package:monigate_app/disease_report/models/disease_report.dart';
import 'package:monigate_app/disease_report/services/disease_report_service.dart';
import 'package:monigate_app/disease_report/view/update_disease_report_page.dart';
import 'package:monigate_app/notification/services/notification_service.dart';

class DiseaseReportPage extends ConsumerStatefulWidget {
  const DiseaseReportPage({Key? key}) : super(key: key);

  @override
  createState() => _DiseaseReportPageState();
}

class _DiseaseReportPageState extends ConsumerState<DiseaseReportPage> {
  String diseaseId = '';
  String note = '';

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(diseaseReportStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo sức khoẻ'),
        centerTitle: false,
      ),
      body: state.when(empty: () {
        return SingleChildScrollView(
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
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }, error: (err) {
        return SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Đã có lỗi xảy ra',
              ),
              TextButton(
                onPressed: () {
                  ref.read(diseaseReportStateProvider.notifier).getDiseaseReportToday();
                },
                child: const Text('Thử lại'),
              )
            ],
          ),
        );
      }, approved: () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
              child: Text(
            'Báo cáo của bạn đã được duyệt, không cần phải báo cáo lại',
            style: Theme.of(context).textTheme.headline6,
          )),
        );
      }, submitted: (DiseaseReport report) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Hiện có báo cáo chưa duyệt bạn muốn cập nhật không',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
                  return UpdateDiseaseReportPage(report);
                }));
              },
              child: const Text('Cập nhật'),
            ),
          ],
        );
      }),
    );
  }
}

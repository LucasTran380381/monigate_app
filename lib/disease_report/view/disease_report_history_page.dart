import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/disease_report/logic/disease_report_history_provider.dart';
import 'package:monigate_app/disease_report/models/disease_report.dart';

class DiseaseReportHistoryPage extends ConsumerWidget {
  const DiseaseReportHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(diseaseReportHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử bệnh án'),
        centerTitle: false,
      ),
      body: state.when(error: (Object error, StackTrace? stackTrace) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('đã có lỗi $error'),
            TextButton(
              child: Text('thử lại'),
              onPressed: () => ref.refresh(diseaseReportHistoryProvider),
            ),
          ],
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }, data: (List<DiseaseReport> data) {
        return data.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(diseaseReportHistoryProvider);
                },
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final report = data[index];
                    return DiseaseReportCard(
                      report: report,
                    );
                  },
                  itemCount: data.length,
                ),
              )
            : const Center(child: Text('Chưa có lịch sử bệnh án'));
      }),
    );
  }
}

class DiseaseReportCard extends StatelessWidget {
  final DiseaseReport report;

  const DiseaseReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    report.reportDate.shortFormatDate,
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      report.note,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Mã chuẩn đoán: ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      report.diseaseCode,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Trạng thái: ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Tooltip(
                    message: report.statusTitle,
                    child: report.statusIcon,
                  ),
                  // Text(
                  //   report.statusTitle,
                  //   style: Theme.of(context).textTheme.headline6,
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

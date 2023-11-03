import 'package:flutter_ducafecat_news_getx/common/apis/statistics.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/statistics.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:get/get.dart';

class StatisticsRiverLogic extends GetxController with StateMixin {
  final quarters = [
    {'title': '一季度', 'id': 1},
    {'title': '二季度', 'id': 2},
    {'title': '三季度', 'id': 3},
    {'title': '四季度', 'id': 4},
  ];
  PieChartBean? pieChartData;
  int selectQuarter = 1;

  @override
  void onInit() {
    super.onInit();
    getPatrolUserNumber();
  }

  Future getPatrolUserNumber() async {
    StatisticsApi.getPatrolUserNumber(quarter: selectQuarter).then((value) {
      pieChartData = PieChartBean(count: value.data['userCount'], data: [
        {
          'num': value.data['finishCount'],
          'title': '完成巡河人次:${value.data['finishCount']}',
          'color': AppColor.mainColor
        },
        {
          'num': value.data['unfinishedCount'],
          'title': '未完成巡河人次:${value.data['unfinishedCount']}',
          'color': AppColor.pinkColor
        },
      ]);
      change(null,
          status: value.data == null ? RxStatus.empty() : RxStatus.success());
    }).onError((error, stackTrace) {
      change(null, status: RxStatus.error());
    });
  }
}

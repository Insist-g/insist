import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/statistics.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/statistics.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:get/get.dart';

class BarChartViewLogic extends GetxController
    with StateMixin<List<BarChartBean>> {
  int timeRange;

  BarChartViewLogic({required this.timeRange});

  final timeRanges = [
    {'title': '本周', 'id': 1},
    {'title': '本月', 'id': 2},
    {'title': '本季', 'id': 3},
    {'title': '本年', 'id': 4},
  ];

  double maxY = 20;
  int touchedGroupIndex = -1;

  @override
  void onReady() {
    super.onReady();
    getPatrolDataCount();
  }

  void getPatrolDataCount() {
    change([], status: RxStatus.loading());
    StatisticsApi.getPatrolDataCount(timeRange: timeRange).then((value) {
      maxY = 20;
      for (var element in value.data ?? []) {
        if ((element.patrolNumber ?? 0) > 0) {
          state?.add(element);
        }
        if ((element.maxNumber ?? 0) > maxY) {
          if (element.maxNumber! % 10 == 0) {
            maxY = (element.maxNumber!).toDouble(); // 如果已经是10的倍数，不需要舍入
          } else {
            maxY = (((element.maxNumber! ~/ 10) + 1) * 10)
                .toDouble(); // 向上舍入到最近的10的倍数
          }
        }
      }
      maxY += 5;
      change(
        state,
        status: (state ?? []).isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    }).onError<DioException>((error, stackTrace) {
      change([], status: RxStatus.error(error.message));
    });
  }

  BarChartGroupData generateBarGroup(
    int x,
    double value1,
    double value2,
    double value3,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value1,
          color: AppColor.mainColor,
          width: 8,
        ),
        BarChartRodData(
          toY: value3,
          color: AppColor.pinkColor,
          width: 8,
        ),
        BarChartRodData(
          toY: value2,
          color: AppColor.green,
          width: 8,
        ),
      ],
      // showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/chart/chart.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/chart/bar_chart/view.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'logic.dart';

class StatisticsRiverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(StatisticsRiverLogic());
    return GetBuilder<StatisticsRiverLogic>(builder: (logic) {
      return logic.obx(
        (state) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    PieChartView(data: logic.pieChartData).expanded(),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: logic.quarters.map((e) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              margin: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                e['title'].toString(),
                                style: TextStyle(
                                    color: logic.selectQuarter == e['id']
                                        ? AppColor.mainColor
                                        : AppColor.dividerColor),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: logic.selectQuarter == e['id']
                                          ? AppColor.mainColor
                                          : AppColor.dividerColor)),
                            ).gestures(onTap: () {
                              logic.selectQuarter = e['id'] as int;
                              logic.getPatrolUserNumber();
                            });
                          }).toList(),
                        ).marginOnly(right: 20),
                        Column(
                          children: (logic.pieChartData?.data ?? []).map((e) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Indicator(
                                color: e['color'] ?? AppColor.primaryBackground,
                                text: e['title'] ?? '',
                                isSquare: true,
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              BarChartView(timeRange: 1),
            ],
          );
        },
        onEmpty: StateWidget.empty(),
        onError: (err) => StateWidget.error(),
        onLoading: StateWidget.loading(),
      );
    });
  }
}

import 'package:easy_refresh/easy_refresh.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BarChartView extends StatelessWidget {
  final int timeRange;

  BarChartView({this.timeRange = 0});

  @override
  Widget build(BuildContext context) {
    Get.put(BarChartViewLogic(timeRange: timeRange), tag: '$timeRange');
    return GetBuilder<BarChartViewLogic>(
      tag: '$timeRange',
      builder: (logic) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (timeRange != 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("巡河统计"),
                    Row(
                      children: logic.timeRanges.map((e) {
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              e['title'].toString(),
                              style: TextStyle(
                                  color: logic.timeRange == e['id']
                                      ? AppColor.mainColor
                                      : AppColor.dividerColor),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: logic.timeRange == e['id']
                                        ? AppColor.mainColor
                                        : AppColor.dividerColor)),
                          ),
                          onTap: () {
                            logic.timeRange = e['id'] as int;
                            logic.getPatrolDataCount();
                          },
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            SizedBox(
              height: Get.height * 0.4,
              child: logic.obx(
                (state) {
                  return EasyRefresh(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: (state?.length ?? 0) * 60,
                        padding: const EdgeInsets.all(24),
                        child: BarChart(
                          BarChartData(
                            maxY: logic.maxY,
                            minY: 0,
                            alignment: BarChartAlignment.spaceAround,
                            borderData: FlBorderData(
                              show: true,
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: AppColor.black.withOpacity(0.2),
                                ),
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              leftTitles: AxisTitles(
                                drawBelowEverything: true,
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      textAlign: TextAlign.left,
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 36,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Container(
                                          width: 50,
                                          child: Center(
                                              child: Text(
                                                  state?[index].riverName ?? '',
                                                  style:
                                                      AppTextStyle.primary_12,
                                                  maxLines: 1))),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: const AxisTitles(),
                              topTitles: const AxisTitles(),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: AppColor.black.withOpacity(0.2),
                                strokeWidth: 1,
                              ),
                            ),
                            barGroups: state?.asMap().keys.map((index) {
                              return logic.generateBarGroup(
                                index,
                                (state[index].patrolNumber ?? 0).toDouble(),
                                (state[index].disposeNumber ?? 0).toDouble(),
                                (state[index].questionsNumber ?? 0).toDouble(),
                              );
                            }).toList(),
                            barTouchData: BarTouchData(
                              enabled: true,
                              handleBuiltInTouches: true,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                tooltipMargin: 0,
                                getTooltipItem: (
                                  BarChartGroupData group,
                                  int groupIndex,
                                  BarChartRodData rod,
                                  int rodIndex,
                                ) {
                                  return BarTooltipItem(
                                    (rodIndex == 0
                                            ? '巡河次数:'
                                            : rodIndex == 1
                                                ? '问题个数:'
                                                : '处理个数') +
                                        rod.toY.toString(),
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: rod.color,
                                      fontSize: 18,
                                      shadows: const [
                                        Shadow(
                                          color: Colors.black26,
                                          blurRadius: 12,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                              touchCallback: (event, response) {
                                if (event.isInterestedForInteractions &&
                                    response != null &&
                                    response.spot != null) {
                                  logic.touchedGroupIndex =
                                      response.spot!.touchedBarGroupIndex;
                                  logic.update();
                                } else {
                                  logic.touchedGroupIndex = -1;
                                  logic.update();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onEmpty: StateWidget.empty(),
                onError: (err) => StateWidget.error(message: err),
                onLoading: Center(
                  child: SpinKitFadingCube(size: 30, color: AppColor.mainColor),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

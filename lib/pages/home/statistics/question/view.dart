import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/chart/chart.dart' as a;
import 'package:flutter_ducafecat_news_getx/common/widgets/chart/chart.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'logic.dart';

class StatisticsQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(StatisticsQuestionLogic());
    return GetBuilder<StatisticsQuestionLogic>(builder: (logic) {
      return Column(
        children: [
          Row(
            children: [
              PieChartView(data: logic.pieChartData).expanded(),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: (logic.pieChartData?.data ?? []).map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: a.Indicator(
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
          ), // PieChartSample2(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "问题类型",
                style: AppTextStyle.primary_16_w500,
              ),
              Text("问题内容", style: AppTextStyle.primary_16_w500),
              Text("问题来源", style: AppTextStyle.primary_16_w500)
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 16),
          divider1Px(),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: logic.obx((state) {
              return EasyRefresh(
                onRefresh: logic.onRefresh,
                onLoad: logic.onLoading,
                controller: logic.refreshController,
                child: ListView.builder(
                    itemCount: state?.list?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: Get.width / 4,
                                  child: Text(
                                    DictStore.to.findLabel(
                                        type: DictKeys.CTRL_PATROL_TYPE,
                                        value: (state?.list?[index].problemType ?? '')
                                            .toString()),
                                  )),
                              Expanded(
                                  child: Text(
                                state?.list?[index].problemDescribe ?? '',
                                maxLines: 1,
                                    textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                  width: Get.width / 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          DictStore.to.findLabel(
                                              type:
                                                  DictKeys.CTRL_PROBLEM_SOURCES,
                                              value: (state?.list?[index]
                                                          .problemSources ??
                                                      '')
                                                  .toString()),
                                          style: AppTextStyle.secondary_12),
                                      Text(
                                          DictStore.to.findLabel(
                                              type: DictKeys.CTRL_DISPOSE_STATE,
                                              value:
                                                  (state?.list?[index].disposeState ??
                                                          '')
                                                      .toString()),
                                          style: AppTextStyle.secondary_12),
                                    ],
                                  ))
                            ],
                          ).padding(all: 10),
                          dividerSolid1Px(),
                        ],
                      );
                    }).paddingAll(5),
              );
            }),
          )
        ],
      );
    });
  }
}

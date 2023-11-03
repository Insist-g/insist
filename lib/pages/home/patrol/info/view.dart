import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_ducafecat_news_getx/common/values/radii.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/item.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:flutter_ducafecat_news_getx/pages/map/widget/fl_map.dart';
import 'package:get/get.dart';
import 'logic.dart';

class PatrolInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(PatrolInfoLogic());
    return GetBuilder<PatrolInfoLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: Text("巡察详情"),
          actions: (logic.state?.uploadStatus ?? 1) != 1
              ? [
                  TextButton(
                    child: Text(
                      "记录列表",
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                    onPressed: () {
                      if (logic.state?.patrolId == null) return;
                      NavigationUtil.toPatrolHistoryPage(
                          id: logic.state!.patrolId!);
                    },
                  )
                ]
              : null,
        ),
        body: logic.obx(
          (state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 300,
                        child: FLMap(),
                      ),
                      // _patrolCard(),
                      PatrolCard(
                        data: state,
                        isCard: false,
                      ),
                      divider20Px(),
                      // Row(
                      //   children: [
                      //     dividerVertical(),
                      //     Text(
                      //       "点位信息",
                      //       style: AppTextStyle.primary_14_w500,
                      //     )
                      //   ],
                      // ).paddingAll(5),
                      // Column(
                      //   children: logic.list
                      //       .map((e) => Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       buildText("点位名称", e["name"]),
                      //       buildText("点位编号", e["number"]),
                      //       buildText("点位内容", e["content"]),
                      //       dividerSolid1Px(indent: 10)
                      //     ],
                      //   ).marginSymmetric(vertical: 5))
                      //       .toList(),
                      // ),
                      // SizedBox(
                      //   height: 80,
                      // )
                    ],
                  ),
                ),
                // if (state?.uploadStatus != 3)
                //   Positioned(
                //     bottom: 0,
                //     left: 0,
                //     right: 0,
                //     child: Container(
                //       color: AppColor.white,
                //       child: btnFlatButtonWidget(
                //           width: Get.width - 50,
                //           title: "开始巡察",
                //           gbColor: PositionStore.to.isRunning
                //               ? AppColor.dividerColor
                //               : AppColor.yellow,
                //           onPressed: () {
                //             logic.startPatrol();
                //           }).marginAll(10),
                //     ),
                //   )
              ],
            );
          },
          onEmpty: StateWidget.empty(),
          onError: (err) => StateWidget.error(),
          onLoading: StateWidget.loading(),
        ),
      );

      return logic.obx(
        (state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("巡察详情"),
              actions: state?.uploadStatus != 1
                  ? [
                      TextButton(
                        child: Text(
                          "记录列表",
                          style: TextStyle(
                            color: AppColor.white,
                          ),
                        ),
                        onPressed: () {
                          if (state?.patrolId == null) return;
                          NavigationUtil.toPatrolHistoryPage(
                              id: state!.patrolId!);
                        },
                      )
                    ]
                  : null,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 300,
                        child: FLMap(),
                      ),
                      // _patrolCard(),
                      PatrolCard(
                        data: state,
                        isCard: false,
                      ),
                      divider20Px(),
                      // Row(
                      //   children: [
                      //     dividerVertical(),
                      //     Text(
                      //       "点位信息",
                      //       style: AppTextStyle.primary_14_w500,
                      //     )
                      //   ],
                      // ).paddingAll(5),
                      // Column(
                      //   children: logic.list
                      //       .map((e) => Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       buildText("点位名称", e["name"]),
                      //       buildText("点位编号", e["number"]),
                      //       buildText("点位内容", e["content"]),
                      //       dividerSolid1Px(indent: 10)
                      //     ],
                      //   ).marginSymmetric(vertical: 5))
                      //       .toList(),
                      // ),
                      // SizedBox(
                      //   height: 80,
                      // )
                    ],
                  ),
                ),
                // if (state?.uploadStatus != 3)
                //   Positioned(
                //     bottom: 0,
                //     left: 0,
                //     right: 0,
                //     child: Container(
                //       color: AppColor.white,
                //       child: btnFlatButtonWidget(
                //           width: Get.width - 50,
                //           title: "开始巡察",
                //           gbColor: PositionStore.to.isRunning
                //               ? AppColor.dividerColor
                //               : AppColor.yellow,
                //           onPressed: () {
                //             logic.startPatrol();
                //           }).marginAll(10),
                //     ),
                //   )
              ],
            ),
          );
        },
        onEmpty: StateWidget.empty(),
        onError: (err) => StateWidget.error(),
        onLoading: StateWidget.loading(),
      );
    });
  }

  _patrolCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            dividerVertical(),
            Expanded(
                child: Text(
              "巡河名称：蚂蚁河常山镇北加油站段",
              style: AppTextStyle.primary_14_w500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: Radii.k3pxRadius, color: Colors.blue),
              child: Text(
                "未开始",
                style: TextStyle(fontSize: 12, color: AppColor.white),
              ),
            )
          ],
        ).paddingAll(5),
        buildText("巡河河段", "阿说了对哦叫你来拿文件"),
        buildText("巡察起点", "阿说了对哦叫你来拿文件"),
        buildText("巡察终点", "阿说了对哦叫你来拿文件"),
      ],
    );
  }
}

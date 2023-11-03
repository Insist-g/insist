import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/patroling/widget/issue/view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/content/logic.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/patroling/logic.dart';
import 'package:flutter_ducafecat_news_getx/pages/map/widget/fl_map.dart';

class PatrolIngPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(PatrolIngLogic());
    return GetBuilder<PatrolIngLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: Text("巡察中"),
          actions: [
            if (logic.state == PatrolState.running)
              TextButton(
                child: Text(
                  '记录列表',
                  style: TextStyle(color: AppColor.white),
                ),
                onPressed: () {
                  // if (state?.patrolId == null) return;
                  // NavigationUtil.toPatrolHistoryPage(
                  //     id: state!.patrolId!);
                },
              )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 60,
                child: FLMap(
                  currentLocation: true,
                  drawPath: true,
                  controller: logic.mapController,
                )),
            if (logic.state == PatrolState.running)
              Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton(
                  mini: true,
                  child: Icon(Icons.my_location),
                  onPressed: () {
                    logic.move();
                  },
                ),
              ),
            logic.state == null
                ? SizedBox.shrink()
                : logic.state == PatrolState.running
                    ? waitingWidget()
                    : runningWidget(),
          ],
        ),
      );
    });
  }

  Widget runningWidget() {
    final logic = Get.find<PatrolIngLogic>();
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 10,
            child: btnFlatButtonWidget(
                width: 90,
                height: 40,
                fontSize: 12,
                gbColor: AppColor.green,
                title: "定位",
                onPressed: () {
                  logic.move();
                }),
          ),
          Positioned(
            right: 20,
            bottom: 10,
            child: btnFlatButtonWidget(
                width: 90,
                height: 40,
                fontSize: 12,
                title: "问题上报",
                gbColor: AppColor.yellow,
                onPressed: () {
                  Get.toNamed(AppRoutes.EventAdd);
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    color: AppColor.primaryBackground, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    "开始巡察",
                    style: AppTextStyle.primary_16_w500
                        .copyWith(color: AppColor.white),
                  ),
                ),
              ),
              onTap: () {
                logic.startPatrol();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget waitingWidget() {
    return Positioned(
      left: 10,
      right: 10,
      bottom: 0,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("某某点位名称：Q123"),
                Text(
                  "您已经到达点位，请按要求逐项检查",
                  style: AppTextStyle.secondary_12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btnFlatButtonWidget(
                    width: 80,
                    height: 35,
                    fontSize: 12,
                    title: "记录",
                    gbColor: AppColor.green,
                    onPressed: () {
                      Get.bottomSheet(IssueUploadView());
                    }),
                btnFlatButtonWidget(
                  width: 80,
                  height: 35,
                  fontSize: 12,
                  title: "结束巡察",
                  gbColor: AppColor.red,
                  onPressed: () {
                    Get.find<PatrolIngLogic>().finishPatrol();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

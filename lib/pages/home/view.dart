import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/chart/bar_chart/view.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/item.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/logic.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/widget/item_banner.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'widget/item.dart';

class HomePage extends GetView<HomeLogic> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeLogic());
    return GetBuilder<HomeLogic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            APP_NAME,
            style: TextStyle(color: AppColor.primaryBackground),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: EasyRefresh(
          refreshOnStart: true,
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomScrollView(
              slivers: [
                buildBanner(),
                buildTip(),
                buildMenu(),
                buildTitle(title: "我的河道", route: AppRoutes.River),
                buildRow(),
                buildTitle(title: "我的巡察", route: AppRoutes.PatrolIndex),
                buildCard(),
                buildTitle(title: "巡河统计", route: AppRoutes.StatisticsIndex),
                sliverMargin(
                  child: BarChartView(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildBanner() {
    return SliverToBoxAdapter(
      child: Container(
          height: 150,
          child: EasyRefresh(
            child: CarouselSlider(
              options: CarouselOptions().copyWith(
                height: double.infinity,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
              items: controller.newList.map((item) {
                String url = item.attachFiles?.first.url ?? '';
                Log().d(item.toJson().toString());
                return InkWell(
                  child: ItemBanner(
                    imgUrl: url,
                    title: item.title ?? '',
                  ),
                  onTap: () {
                    controller.getNewsInfo(item.id);
                  },
                );
              }).toList(),
            ),
          )),
    );
  }

  Widget buildTip() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "通知",
              style: TextStyle(
                color: AppColor.red,
                fontWeight: FontWeight.w600,
              ),
            ).marginOnly(right: 10),
            Expanded(
                child: Container(
                    height: 40,
                    child: EasyRefresh(
                      child: CarouselSlider(
                        options: CarouselOptions().copyWith(
                          scrollDirection: Axis.vertical,
                          height: double.infinity,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                        ),
                        items: controller.messageList
                            .map((item) => Text(
                                  item.title ?? "",
                                  maxLines: 1,
                                ))
                            .toList(),
                      ),
                    ))),
            // Badge.count(count: 10)
          ],
        ),
        onTap: () {
          Get.toNamed(AppRoutes.Message);
        },
      ),
    );
  }

  Widget buildMenu() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Image(
                      image: AssetImage(controller.menuList[index]['icon']),
                    ),
                  ),
                ),
                Text(controller.menuList[index]['title'].toString())
              ],
            ),
            onTap: () {
              Get.toNamed(controller.menuList[index]['route']);
            },
          );
        },
        childCount: controller.menuList.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        childAspectRatio: 1,
      ),
    );
  }

  Widget buildRow() {
    return sliverMargin(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: controller.riverList.asMap().keys.map((index) {
            return Expanded(
              flex: 1,
              child: itemRow(
                margin: index == 0
                    ? EdgeInsets.only(right: 5)
                    : EdgeInsets.only(left: 5),
                title: controller.riverList[index].riverName,
                num: index == 0 ? "Ⅰ" : "Ⅱ",
                color: index == 0 ? AppColor.pinkColor : AppColor.green,
              ).gestures(onTap: () {
                if (controller.riverList[index].id == null) return;
                NavigationUtil.toRiverIndexPage(
                    riverId: controller.riverList[index].id!,
                    riverName: controller.riverList[index].riverName ?? "");
              }),
            );
          }).toList(),
        ));
  }

  Widget buildCard() {
    return sliverMargin(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: controller.patrolList.map((e) {
        return PatrolCard(
          data: e,
          isCard: true,
        );
      }).toList(),
    ));
  }

  Widget buildTitle({String? title, String? route}) {
    return sliverMargin(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title ?? "",
              style: AppTextStyle.primary_16
                  .copyWith(fontWeight: FontWeight.w600)),
          GestureDetector(
            child: Text(
              "更多>>",
              style: AppTextStyle.secondary_12,
            ),
            onTap: () {
              if (route != null) {
                Get.toNamed(route);
              }
            },
          ),
        ],
      ),
    );
  }
}

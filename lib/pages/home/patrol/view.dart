import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/indicator.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/content/view.dart';
import 'package:get/get.dart';
import 'logic.dart';

class PatrolIndexPage extends GetView<PatrolIndexLogic> {
  const PatrolIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatrolIndexLogic>(
        init: PatrolIndexLogic(),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: Text('移动巡察'),
            ),
            body: _buildDefaultContent(),
          );
        });
  }

  Widget _buildDefaultContent() {
    return DefaultTabController(
      length: controller.tabList.length ?? 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildTabBar(), Expanded(child: _buildContent())],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      padding: EdgeInsets.symmetric(horizontal: 10),
      isScrollable: false,
      labelStyle: TextStyle(
          color: AppColor.primaryBackground, fontSize: 15, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(
          color: AppColor.primaryText, fontSize: 14, fontWeight: FontWeight.bold),
      labelColor: AppColor.primaryBackground,
      unselectedLabelColor: AppColor.primaryText,
      controller: controller.tabCtl,
      indicator: ContainerTabIndicator(
          height: 2.5,
          width: 27,
          radius: BorderRadius.circular(20),
          padding: EdgeInsets.only(top: 20),
          color: AppColor.primaryBackground),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: controller.tabList.map((e) {
        return Tab(text: e);
      }).toList(),
    );
  }

  Widget _buildContent() {
    return TabBarView(
      controller: controller.tabCtl,
      children: controller.tabList
          .asMap()
          .keys
          .map((e) => PatrolListPage(topicId: e))
          .toList(),
    );
  }
}

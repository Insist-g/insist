import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/indicator.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/search.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/leader/lake/view.dart';
import 'package:get/get.dart';
import 'leader/view.dart';
import 'logic.dart';

class LeaderIndexPage extends GetView<LeaderIndexLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaderIndexLogic>(
        init: LeaderIndexLogic(),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: Text('河长治名录'),
            ),
            body: _buildDefaultContent(),
          );
        });
  }

  Widget _buildDefaultContent() {
    return DefaultTabController(
      length: controller.tabList.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTabBar(),
          Container(
            color: AppColor.grayBackground,
            child: SearchEdit(controller: controller.searchCtl),
          ),
          Expanded(child: _buildContent())
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: false,
      labelStyle: TextStyle(
          color: AppColor.primaryBackground,
          fontSize: 14,
          fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(color: AppColor.primaryText, fontSize: 13),
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
      children: [LeaderListPage(), LakeLeaderPage()],
    );
  }
}
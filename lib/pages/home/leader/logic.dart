import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/leader/lake/logic.dart';
import 'package:get/get.dart';

import 'leader/logic.dart';

class LeaderIndexLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabCtl;
  late final TextEditingController searchCtl;
  final tabList = [
    '河长名录',
    '河湖名录',
    // '部门名录',
    // '督查名录',
  ];

  @override
  void onInit() {
    super.onInit();
    tabCtl = TabController(length: tabList.length, vsync: this);
    searchCtl = TextEditingController();
    searchCtl.addListener(() {
      switch (tabCtl.index) {
        case 0:
          Get.find<LeaderListLogic>().onRefresh(value: searchCtl.text);
          break;
        case 1:
          Get.find<LakeLeaderLogic>().onRefresh(value: searchCtl.text);
          break;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchCtl.dispose();
    tabCtl.dispose();
  }
}

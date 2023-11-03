import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsIndexLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabCtl;
  int tabIndex = 0;
  final tabList = [
    '巡河统计',
    '问题统计',
  ];

  @override
  void onInit() {
    super.onInit();
    tabCtl = TabController(length: tabList.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabCtl.dispose();
  }
}

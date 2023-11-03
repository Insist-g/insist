import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatrolIndexLogic extends GetxController with GetSingleTickerProviderStateMixin {
  late final TabController tabCtl;
  var orderState = 0;

  var tabList = [
    '待进行',
    '进行中',
    '已完成',
  ];

  int tabIndex = 0;

  @override
  void onInit() {
    super.onInit();
    tabCtl = TabController(length: tabList.length, vsync: this);
  }
}
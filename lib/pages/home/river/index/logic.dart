import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/river.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:get/get.dart';

class RiverIndexLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabCtl;
  var orderState = 0;

  var tabList = [
    '基本信息',
    // '河段信息',
    '一河一策',
    // '巡河记录',
  ];

  int tabIndex = 0;

  String? riverId;
  String? riverName;

  @override
  void onInit() {
    super.onInit();
    tabCtl = TabController(length: tabList.length, vsync: this);
    riverId = Get.parameters['riverId'];
    riverName = Get.parameters['riverName'];
  }


}

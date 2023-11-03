import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/file/logic.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/law/logic.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/river/logic.dart';
import 'package:get/get.dart';

class FileIndexLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabCtl;
  late final TextEditingController searchCtl;
  final tabList = [
    '一河一策',
    '法规与制度',
    '文件',
  ];

  @override
  void onInit() {
    super.onInit();
    tabCtl = TabController(length: tabList.length, vsync: this);
    searchCtl = TextEditingController();
    searchCtl.addListener(() {
      if (tabCtl.index == 0) {
        Get.find<RiverFileLogic>().onRefresh(value: searchCtl.text);
      } else if (tabCtl.index == 1) {
        // Get.find<LawFileLogic>().getData();
      } else if (tabCtl.index == 2) {
        Get.find<FileListLogic>().onRefresh(value: searchCtl.text);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    searchCtl.dispose();
    tabCtl.dispose();
  }
}

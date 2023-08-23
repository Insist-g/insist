import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/iconfont.dart';
import 'package:flutter_ducafecat_news_getx/pages/book/listener/index.dart';
import 'package:get/get.dart';
import 'recommended/view.dart';

class BookLogic extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final menuList = UnitIcon.getUnitIcons();
  final List<String> imgList = [
    'https://img1.baidu.com/it/u=303094771,63641732&fm=253&fmt=auto&app=138&f=JPEG?w=499&h=302',
    'https://img.zcool.cn/community/0123f35ece306ea801215aa01d4ccd.jpg@2o.jpg',
    'https://youimg1.c-ctrip.com/target/fd/tg/g6/M09/56/7C/CggYs1buvJWAFrKCABSjuvR0CM0128.jpg',
  ];
  final List<Map> tabs = [
    {"title": "最新", "view": RecommendedPage()},
    {"title": "聆听", "view": ListenerPage()},
    {"title": "推荐", "view": Container()},
    {"title": "围观", "view": Container()},
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/icons.dart';
import 'package:get/get.dart';

class BookLogic extends GetxController with GetSingleTickerProviderStateMixin {

  //在这里标签页面使用的是TabView所以需要创建一个控制器
  late TabController tabController;

  final List<String> imgList = [
    'https://img1.baidu.com/it/u=303094771,63641732&fm=253&fmt=auto&app=138&f=JPEG?w=499&h=302',
    'https://img.zcool.cn/community/0123f35ece306ea801215aa01d4ccd.jpg@2o.jpg',
    'https://youimg1.c-ctrip.com/target/fd/tg/g6/M09/56/7C/CggYs1buvJWAFrKCABSjuvR0CM0128.jpg',
  ];

  final menuList = UnitIcon.getUnitIcons();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }


}

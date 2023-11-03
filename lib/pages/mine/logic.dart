import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class MineLogic extends GetxController {
  final menuList = [
    {"title": "个人资料", "route": AppRoutes.MineInfo},
    {"title": "密码修改", "route": AppRoutes.EditPass},
    {"title": "问题反馈", "route": AppRoutes.Feedback},
    {"title": "关于系统", "route": AppRoutes.About},
    // {"title": "功能介绍", "route": AppRoutes.Readme},
    {"title": "系统设置", "route": AppRoutes.Setting},
  ];

  @override
  void onInit() {
    super.onInit();
    UserStore.to.getProfile();
    if (!kReleaseMode) menuList.add({"title": "测试页面", "route": AppRoutes.Test});
  }
}

import 'package:flutter_ducafecat_news_getx/pages/home/logic.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/logic.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<HomeLogic>(() => HomeLogic());
    Get.lazyPut<MineLogic>(() => MineLogic());
  }
}

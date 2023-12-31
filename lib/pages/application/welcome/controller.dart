import 'package:flutter_ducafecat_news_getx/common/routers/routes.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:get/get.dart';

import 'index.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();

  WelcomeController();

  // 跳转 注册界面
  handleNavLogin() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.Login);
  }

  @override
  void onReady() {
    super.onReady();
  }
}

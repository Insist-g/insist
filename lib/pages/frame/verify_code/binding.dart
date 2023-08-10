import 'package:get/get.dart';

import 'logic.dart';

class VerifyCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyCodeLogic());
  }
}

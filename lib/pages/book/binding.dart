import 'package:get/get.dart';

import 'logic.dart';

class BookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookLogic());
  }
}

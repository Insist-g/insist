import 'package:get/get.dart';

class GuiderInfoController extends GetxController {
  GuiderInfoController();

  _initData() {
    update(["guider_info"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  //   super.onClose();
  // }
}

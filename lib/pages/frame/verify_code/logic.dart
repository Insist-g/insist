import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/pages/frame/sign_up/widget/progress_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class VerifyCodeLogic extends GetxController {
  late String account;

  @override
  void onInit() {
    super.onInit();
    account = Get.arguments?['account'] ?? '';
  }

  @override
  void onReady() {
    super.onReady();
    Get.snackbar("Welcome to register!🤭", "verify code is 123456.");
  }

  //提交验证码
  postVerifyCode(String value) async {
    EasyLoading.show();
    await Future.delayed(Duration(seconds: 3), () {
      if (value == '123456') {
        EasyLoading.showSuccess("操作成功")
            .then((value) => Get.offAllNamed(AppRoutes.SIGN_IN));
      } else {
        EasyLoading.showError("验证码错误");
      }
    });
  }

  //获取验证码
  Future<bool> getVerifyCode() async {
    Get.snackbar("Welcome to register!🤭", "verify code is 123456.");
    return true;
  }
}

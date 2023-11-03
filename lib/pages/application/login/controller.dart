import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/entities.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/routes.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/jpush.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'index.dart';

class LoginController extends GetxController {
  final state = LoginState();

  LoginController();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final ButtonProController buttonProController = ButtonProController();

  @override
  void onInit() {
    super.onInit();
    mobileController.addListener(_verify);
    passController.addListener(_verify);
  }

  @override
  void dispose() {
    mobileController.dispose();
    passController.dispose();
    buttonProController.dispose();
    super.dispose();
  }

  handleLogin() async {
    buttonProController.start();
    (state.loginType ? login() : smsLogin()).then((user) async {
      if (user.code == RSP_OK && user.data != null) {
        await UserStore.to.saveUser(user.data!);
        Get.offAndToNamed(AppRoutes.Application);
      }
      if (user.message != null && user.message.trim().isNotEmpty) {
        EasyLoading.showError(user.message);
      }
    }).whenComplete(() {
      buttonProController.stop();
    });
  }

  Future login() async => await UserAPI.login(
      mobileController.value.text, passController.value.text);

  Future smsLogin() async => await UserAPI.smsLogin(
      mobileController.value.text, passController.value.text);

  Future<bool> getCode() async {
    var result = await UserAPI.sendSmsCode(mobileController.value.text);
    if (result.code != RSP_OK) {
      EasyLoading.showError(result.message ?? "获取验证码失败，请稍后重新获取");
      return false;
    }
    // EasyLoading.showSuccess(result.message ?? "验证码发送成功");
    return true;
  }

  void _verify() {
    String mobile = mobileController.text;
    String passWord = passController.text;
    if (mobile.isEmpty || passWord.isEmpty || !GetUtils.isPhoneNumber(mobile)) {
      if (state.enable) state.enable = false;
    } else {
      if (!state.enable) state.enable = true;
    }
  }

}

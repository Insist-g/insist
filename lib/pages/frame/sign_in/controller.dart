import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/entities.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/routes.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'index.dart';

class SignInController extends GetxController {
  final state = SignInState();
  bool agreement = false;

  SignInController();

  final TextEditingController accountController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final ButtonProController buttonProController = ButtonProController();

  @override
  void onInit() {
    super.onInit();
    accountController.addListener(_verify);
    passController.addListener(_verify);
  }

  @override
  void dispose() {
    accountController.dispose();
    passController.dispose();
    buttonProController.dispose();
    super.dispose();
  }

  handleNavSignUp() {
    Get.toNamed(AppRoutes.SIGN_UP);
  }

  handleFogotPassword() {
    toastInfo(msg: '忘记密码');
  }

  handleSignIn() async {
    buttonProController.start();
    if (!agreement) {
      await Future.delayed(Duration(milliseconds: 1000), () {
        Get.snackbar(
            "Tip:", "You must read and agree to the User Privacy Agreement.");
      });
      return false;
    }
    UserLoginResponseEntity userProfile = await UserAPI.login(
      params: UserLoginRequestEntity(
        email: accountController.value.text,
        password: duSHA256(passController.value.text),
      ),
    );
    if (userProfile != null) {
      UserStore.to.saveProfile(userProfile);
      Get.offAndToNamed(AppRoutes.Application);
    } else {
      EasyLoading.showError("账号或密码有误");
      Get.snackbar("Tip:", "account: admin , password: 123456");
      return false;
    }
  }

  void _verify() {
    String userName = accountController.text;
    String passWord = passController.text;
    if (userName.isEmpty || passWord.isEmpty) {
      if (state.enable) state.enable = false;
    } else {
      if (!state.enable) state.enable = true;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/entities.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widget/progress_button.dart';

class SignUpController extends GetxController {
  final state = SignUpState();
  bool agreement = false;

  final TextEditingController userNameC = TextEditingController();
  final TextEditingController accountC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final ButtonProController buttonC = ButtonProController();

  @override
  void onInit() {
    super.onInit();
    userNameC.addListener(_verify);
    accountC.addListener(_verify);
    passC.addListener(_verify);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    userNameC.dispose();
    accountC.dispose();
    passC.dispose();
    super.dispose();
  }

  Future<bool?> handleSignUp() async {
    buttonC.start();
    if (!agreement) {
      Get.snackbar("提示", "您请阅读并同意用户隐私协议～");
    } else {
      await Future.delayed(Duration(milliseconds: 10000));
    }
    return false;
  }

  void _verify() {
    String userName = userNameC.text;
    String passWord = passC.text;
    String account = accountC.text;
    if (userName.isEmpty || passWord.isEmpty || account.isEmpty) {
      if (state.enable) state.enable = false;
    } else {
      if (!state.enable) state.enable = true;
    }
  }
}

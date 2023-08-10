import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/entities.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:flutter_ducafecat_news_getx/pages/frame/verify_code/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/pinput.dart';
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
      await Future.delayed(Duration(milliseconds: 1000), () {
        Get.snackbar(
            "Tip:", "You must read and agree to the User Privacy Agreement.");
      });
    } else {
      await Future.delayed(Duration(milliseconds: 3000));
      Get.to(VerifyCodePage(), arguments: {'account': '18888888888'});
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

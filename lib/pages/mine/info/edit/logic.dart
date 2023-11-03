import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/user.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditInfoLogic extends GetxController {
  final TextEditingController editController = TextEditingController();
  Map infoMap = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    infoMap = Get.arguments;
    editController.text = infoMap["trailing"] ?? "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    editController.dispose();
  }

  Future onSubmit() async {
    final text = editController.text.trim();
    if (text.isEmpty) {
      EasyLoading.showInfo("内容不能为空");
      return;
    }
    bool? res = await UserAPI.updateNickname(text);
    if (res == true) {
      await UserStore.to.getProfile();
      Get.back();
    }
  }
}

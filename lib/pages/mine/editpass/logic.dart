import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPassLogic extends GetxController {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController vCodeController = TextEditingController();

  bool editType = false; //true原密码修改密码 false验证码修改密码
  final canClick = false.obs;

  void changEditType() {
    editType = !editType;
    passWordController.clear();
    update();
  }

  @override
  void onReady() {
    super.onReady();
    userNameController.addListener(_verify);
    passWordController.addListener(_verify);
    vCodeController.addListener(_verify);
    // 手机登录没返回账号
    // userNameController.text = Utils.isZh()
    //     ? SpUtil.getUserInfo()?.phone
    //     : SpUtil.getUserInfo()?.email;
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passWordController.dispose();
    vCodeController.dispose();
  }

  void _verify() {
    String userName = userNameController.text;
    String passWord = passWordController.text;
    String code = vCodeController.text;
    if ((editType ? true : userName.isNotEmpty) &&
        passWord.isNotEmpty &&
        code.isNotEmpty) {
      if (!canClick.value) canClick.value = true;
    } else {
      if (canClick.value) canClick.value = false;
    }
  }

  ///todo:手机号修改密码 和 手机号 重置密码是一个接口吗？
  Future resetPass() async {
    // var res = false;
    // res = editType
    //     ? await UserApi.updUserPwd(
    //     newPassword: passWordController.text,
    //     oldPassword: vCodeController.text)
    //     : Utils.isZh()
    //     ? await UserApi.phoneFindPwd(
    //     code: vCodeController.text,
    //     phone: userNameController.text,
    //     password: passWordController.text)
    //     : await UserApi.updEmailUserPwd(
    //     code: vCodeController.text, password: passWordController.text);
    // if (res) {
    //   ToastUtils.show(StringStyles.OperationSuccess.tr);
    //   Get.back();
    // }
  }

  Future<bool> getCode() async {
    // return Utils.isZh()
    //     ? await UserApi.sendPhoneCode(
    //     phone: userNameController.text, type: SendCodeType.findPwd)
    //     : await UserApi.getUpdPwdEmailCode(userNameController.text);
    return Future(() => true);
  }

}

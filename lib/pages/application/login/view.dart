import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/timer.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'index.dart';

class LoginPage extends GetView<LoginController> {
  // logo
  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width / 3,
            height: Get.width / 3,
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Text(
              APP_NAME,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: 24,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    ).gestures(onDoubleTap: (){
      if (kReleaseMode) return;
      controller.mobileController.text = '13031714043';
      controller.passController.text = 'admin123';
    });
  }

  // 登录表单
  Widget _buildInputForm() {
    return Container(
      margin: EdgeInsets.only(top: 49),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text("辛苦了，河湖卫士，欢迎登录"),
            ],
          ),
          const SizedBox(height: 20),
          EditText(
            labelText: "手机号",
            controller: controller.mobileController,
            textStyle: TextStyle(
                fontSize: 18,
                color: AppColor.mainColor,
                fontWeight: FontWeight.w800),
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          ),
          const SizedBox(height: 10),
          Obx(() => EditText(
                labelText: controller.state.loginType ? "密码" : "验证码",
                controller: controller.passController,
                isInputPwd: true,
                textStyle: TextStyle(
                    fontSize: 18,
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.w800),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                suffixIcon: Visibility(
                  visible: !controller.state.loginType,
                  child: TimerWidget(
                      backGroundColor: Colors.transparent,
                      textColor: AppColor.secondaryText,
                      text: "获取验证码",
                      fontSize: 14,
                      sendCode: () async {
                        if (GetUtils.isPhoneNumber(
                            controller.mobileController.text)) {
                          Utils.hideKeyboard(Get.context!);
                          return await controller.getCode();
                        }
                        return false;
                      }),
                ),
              )),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                TextButton(
                  onPressed: () {
                    controller.state.loginType = !controller.state.loginType;
                  },
                  child: Text(controller.state.loginType ? "验证码登录" : "密码登录",
                      style: AppTextStyle.secondary_14),
                )
              ],
            );
          }),
          const SizedBox(height: 60),
          Obx(() => ButtonPro(
                text: '确认登录',
                height: 50,
                firstRadius: 20,
                lastRadius: 20,
                enabled: controller.state.enable,
                controller: controller.buttonProController,
                onClick: () {
                  Utils.hideKeyboard(Get.context!);
                  controller.handleLogin();
                },
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        actions: [
          TextButton(
            child: Text(
              "忘记密码",
              style: AppTextStyle.primary_14_w500,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.EditPass);
            },
          )
        ],
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogo(),
              _buildInputForm(),
            ],
          ),
        ),
        onTap: () {
          Utils.hideKeyboard(context);
        },
      ),
    );
  }
}

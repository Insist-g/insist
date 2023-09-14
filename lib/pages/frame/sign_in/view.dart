import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/overlays/true_caller_overlay.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/background.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/selecter.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/web.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/td_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'index.dart';

class SignInPage extends GetView<SignInController> {
  // logo
  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 60),
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
              "INSIST",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                height: 1,
              ),
            ),
          ),
          Text(
            "new",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  // 登录表单
  Widget _buildInputForm() {
    return Container(
      margin: EdgeInsets.only(top: 49.h),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          EditText(
            labelText: "Account",
            controller: controller.accountController,
            textStyle: TextStyle(
                fontSize: 18,
                color: AppColor.mainColor,
                fontWeight: FontWeight.w800),
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          ),
          const SizedBox(height: 10),
          EditText(
            labelText: "Password",
            controller: controller.passController,
            isInputPwd: true,
            textStyle: TextStyle(
                fontSize: 18,
                color: AppColor.mainColor,
                fontWeight: FontWeight.w800),
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckView(
                value: controller.agreement,
                onValueChange: (value) => controller.agreement = value,
              ),
              GestureDetector(
                child: Text(
                  "I have read to the User Privacy Agreement",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.secondaryText, fontSize: 12),
                ),
                onTap: () => Get.to(WebPage(
                  url: "www.baidu.com",
                  jsParameter: "什么？我是参数吗？哈哈哈，没错！",
                  title: "就这样的web",
                )),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Obx(() => ButtonPro(
                text: 'sign in',
                height: 50,
                firstRadius: 20,
                lastRadius: 20,
                enabled: controller.state.enable,
                controller: controller.buttonProController,
                onClick: () async {
                  Utils.hideKeyboard(Get.context!);
                  return await controller.handleSignIn();
                },
              )),
          const SizedBox(height: 20),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              child: OutlinedButton(
                child: Text(
                  'sign up',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: AppColor.primaryText,
                      fontWeight: FontWeight.w500),
                ),
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory, // 没有水波纹效果
                  overlayColor:
                      MaterialStateProperty.all(const Color(0x59FFFFFF)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  controller.handleNavSignUp();
                },
              )),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: controller.handleFogotPassword,
              child: Text(
                "Fogot password?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryElementText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  height: 1, // 设置下行高，否则字体下沉
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 第三方登录
  Widget _buildThirdPartyLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(AlIcon.kg, size: 40),
          onPressed: () {
            Get.to(CurrentPositionPage());
          },
        ),
        IconButton(
          icon: Icon(AlIcon.pxx, size: 40),
          onPressed: () {
            Get.to(TrueCallerOverlay());
          },
        ),
        IconButton(
          icon: Icon(AlIcon.xy, size: 40),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                width: Get.width,
                height: Get.height,
                child: CustomPaint(
                  painter: FirstPainter(),
                ),
              ),
              // Content in the middle of the background
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLogo(),
                    _buildInputForm(),
                    _buildThirdPartyLogin(),
                  ],
                ),
              ),
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

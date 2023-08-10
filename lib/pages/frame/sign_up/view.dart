import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/icons.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:flutter_ducafecat_news_getx/pages/frame/sign_up/widget/bg_paint.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widget/check_box.dart';
import 'widget/edit_widget.dart';
import 'widget/progress_button.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    // Get.put(SignUpController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: BgPainter(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox.shrink(),
            Column(
              children: [
                EditText(
                  labelText: "User Name",
                  controller: controller.userNameC,
                  textStyle: TextStyle(
                      fontSize: 18,
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.w800),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                ),
                const SizedBox(height: 40),
                EditText(
                    labelText: "User Account",
                    controller: controller.accountC,
                    textStyle: TextStyle(
                        fontSize: 18,
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w800),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20)),
                const SizedBox(height: 40),
                EditText(
                    labelText: "Pass Word",
                    controller: controller.passC,
                    textStyle: TextStyle(
                        fontSize: 18,
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w800),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckView(
                        value: controller.agreement,
                        onValueChange: (value) => controller.agreement = value),
                    Text(
                      "I have read to the User Privacy Agreement",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColor.secondaryText, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Obx(() => ButtonPro(
                  text: "SING UP",
                  enabled: controller.state.enable,
                  controller: controller.buttonC,
                  onClick: () => controller.handleSignUp(),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(AlIcon.kg, size: 40),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(AlIcon.pxx, size: 40),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(AlIcon.xy, size: 40),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ).paddingOnly(left: 20, right: 20),
      ),
    );
  }
}

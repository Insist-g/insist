import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/background.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/timer.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'logic.dart';

class VerifyCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeLogic());
    return GetBuilder<VerifyCodeLogic>(builder: (logic) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomPaint(
            painter: SecondPainter(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(backgroundColor: Colors.transparent),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox.shrink(),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("输入验证码",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: AppColor.mainColor,
                              )),
                          SizedBox(height: 10),
                          Text("验证码已发送至 +86 ${logic.account}",
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.primaryText))
                        ],
                      ),
                    ),
                    Pinput(
                        length: 6,
                        onChanged: (value) {
                          if (value.length == 6) logic.postVerifyCode(value);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        defaultPinTheme: PinTheme(
                          width: 40,
                          height: 40,
                          textStyle: TextStyle(
                              color: AppColor.mainColor, fontSize: 16),
                          decoration: BoxDecoration(
                            color: AppColor.borderColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 40,
                          height: 40,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                          decoration: BoxDecoration(
                            color: AppColor.accentColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )),
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width - 100,
                          height: 40,
                          child: TimerWidget(
                            initCount: true,
                            backGroundColor: AppColor.mainColor,
                            sendCode: () => logic.getVerifyCode(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("没有收到验证码？",
                            style: TextStyle(
                                fontSize: 12, color: AppColor.secondaryText)),
                      ],
                    ),
                    const SizedBox.shrink()
                  ],
                ).paddingSymmetric(vertical: 10, horizontal: 20)),
                SizedBox(height: Get.height / 6)
              ],
            ),
          ));
    });
  }
}

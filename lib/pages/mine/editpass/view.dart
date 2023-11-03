import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/input.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/timer.dart';
import 'package:get/get.dart';

import 'logic.dart';

class EditPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(EditPassLogic());
    return GetBuilder<EditPassLogic>(builder: (logic) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("修改密码"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            Visibility(
              maintainState: true,
              maintainSize: true,
              maintainAnimation: true,
              visible: !logic.editType,
              child: EditText(
                controller: logic.userNameController,
                hintText: '手机号码',
                inputType: TextInputType.phone,
                prefixIcon: Icon(Icons.phone_iphone),
              ),
            ),
            const SizedBox(height: 10),
            EditText(
              hintText: logic.editType ? "旧密码" : "验证码",
              controller: logic.vCodeController,
              inputType: !logic.editType ? TextInputType.phone : null,
              prefixIcon:
              Icon(logic.editType ? Icons.pin : Icons.lock_open),
              suffixIcon: Visibility(
                visible: !logic.editType,
                child: TimerWidget(
                    backGroundColor: Colors.transparent,
                    textColor: AppColor.secondaryText,
                    text: "获取验证码",
                    fontSize: 14,
                    sendCode: () async {
                      if (GetUtils.isPhoneNumber(
                          logic.userNameController.text)) {
                        Utils.hideKeyboard(context);
                        return await logic.getCode();
                      }
                      return false;
                    }),
              ),
            ),
            const SizedBox(height: 10),
            EditText(
              controller: logic.passWordController,
              hintText: "新密码",
              prefixIcon: const Icon(Icons.password),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                TextButton(
                  onPressed: () => logic.changEditType(),
                  child: Text(logic.editType
                      ? "验证码修改密码"
                      : "旧密码修改密码",
                      style: AppTextStyle.secondary_14),
                )
              ],
            ),
            SizedBox(height: 20,),
            Obx(() {
              return btnFlatButtonWidget(
                width: double.infinity,
                title: "确认修改",
                onPressed: () {
                  if (logic.canClick.value){
                    Utils.hideKeyboard(context);
                    logic.resetPass();
                  }
                },
                gbColor: logic.canClick.value
                    ? AppColor.primaryBackground
                    : AppColor.dividerColor,
              );
            }),
            const SizedBox.shrink()
          ],
        ).paddingSymmetric(vertical: 10,horizontal: 20),
      );
    });
    ;
  }
}

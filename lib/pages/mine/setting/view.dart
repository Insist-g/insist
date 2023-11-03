import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SettingLogic());

    return Scaffold(
      appBar: AppBar(
        title: Text("系统设置"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "隐私协议",
              style: AppTextStyle.primary_14,
            ),
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: AppColor.borderColor,
          ),
          ListTile(
            title: Text(
              "当前版本",
              style: AppTextStyle.primary_14,
            ),
            trailing: Text(
              "1.0.0",
              style: AppTextStyle.primary_14,
            ),
            onTap: () {},
          ),
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: AppColor.borderColor,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            width: double.infinity,
            child: btnFlatButtonWidget(
              title: "退出登录",
              gbColor: AppColor.dividerColor,
              onPressed: () => logic.logOut(),
            ),
          ),
        ],
      ),
    );
  }
}

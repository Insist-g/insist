import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:get/get.dart';

import 'logic.dart';

class EditInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(EditInfoLogic());
    return GetBuilder<EditInfoLogic>(builder: (logic) {
      return Scaffold(
          appBar: AppBar(
            title: Text("修改${logic.infoMap["title"] ?? ""}"),
            actions: [
              TextButton(
                child: Text(
                  "确定",
                  style: TextStyle(
                    color: AppColor.white,
                  ),
                ),
                onPressed: () {
                  logic.onSubmit();
                },
              )
            ],
          ),
          backgroundColor: AppColor.backgroundColor,
          body: Container(
            color: AppColor.white,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Text(
                  logic.infoMap["title"] ?? "",
                  style: AppTextStyle.primary_16_w500,
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: logic.editController,
                    decoration: InputDecoration(
                      hintText: "请输入${logic.infoMap["title"] ?? ""}",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/decoration.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FeedBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FeedBackLogic());

    return Scaffold(
      appBar: AppBar(
        title: Text("问题反馈"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: AppDecoration.card,
            child: TextField(
              minLines: 5,
              maxLines: 20,
              maxLength: 500,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "您的建议，就是我们的进步。请输入反馈内容...."),
            ),
          ),
          btnFlatButtonWidget(
            width: double.infinity,
            title: "确认提交",
            onPressed: () {

            },
          ).marginSymmetric(vertical: 10, horizontal: 20)
        ],
      ),
    );
  }
}

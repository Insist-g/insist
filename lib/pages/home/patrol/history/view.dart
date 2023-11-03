import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/history/widegt/item.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PatrolHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(PatrolHistoryLogic());
    return GetBuilder<PatrolHistoryLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: Text("记录列表"),
          actions: [
            TextButton(
                child: Text(
                  logic.isEdit ? "保存" : "编辑",
                  style: TextStyle(
                    color: AppColor.white,
                  ),
                ),
                onPressed: () {
                  logic.rightTap();
                })
          ],
        ),
        body: ListView.builder(
            itemCount: logic.state?.length ?? 0,
            itemBuilder: (context, index) {
              return PatrolHistoryItem(
                data: logic.state?[index],
              );
            }),
      );
    });
  }
}

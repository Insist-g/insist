import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/pages/book/recommended/widgets/item.dart';
import 'package:get/get.dart';
import 'index.dart';

class RecommendedPage extends GetView<RecommendedController> {
  const RecommendedPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      itemCount: controller.guiderWords.length,
      itemBuilder: (context, index) {
        return Item(date: controller.guiderWords[index]);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 1.0,
        color: Colors.black12,
        indent: 20,
        endIndent: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendedController>(
      init: RecommendedController(),
      id: "recommended",
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColor.gray,
          body: _buildView(),
        );
      },
    );
  }
}

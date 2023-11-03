import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/decoration.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'widget/item.dart';

class ComplainListPage extends StatelessWidget {
  final int topicId;

  const ComplainListPage({Key? key, required this.topicId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<ComplainListLogic>(ComplainListLogic(topicId), tag: '$topicId');
    return GetBuilder<ComplainListLogic>(
        init: controller,
        global: false,
        tag: '$topicId',
        builder: (logic) {
          return logic.obx(
            (state) => EasyRefresh(
              onRefresh: () => logic.onRefresh(),
              onLoad: () => logic.onLoading(),
              controller: logic.refreshController,
              child: ListView.builder(
                  itemCount: state?.list?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: AppDecoration.card,
                      padding: EdgeInsets.all(10),
                      child: ComPlainItem(data: state?.list?[index]),
                    );
                  }),
            ),
            onEmpty: StateWidget.empty(),
            onError: (err) => StateWidget.error(),
            onLoading: StateWidget.loading(),
          );
        });
  }
}

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/item.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PatrolListPage extends StatelessWidget {
  final int topicId;

  const PatrolListPage({Key? key, required this.topicId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatrolListLogic>(
        init: PatrolListLogic(topicId),
        global: false,
        tag: '$topicId',
        builder: (logic) {
          return logic.obx(
            (state) => EasyRefresh(
              onRefresh: () => logic.onRefresh(),
              onLoad: () => logic.onLoading(),
              child: ListView.builder(
                  itemCount: state?.list?.length ?? 0,
                  itemBuilder: (context, index) {
                    return PatrolCard(data: state?.list?[index]);
                  }),
              controller: logic.refreshController,
            ),
            onEmpty: StateWidget.empty(),
            onError: (err) => StateWidget.error(message: err),
            onLoading: StateWidget.loading(),
          );
        });
  }
}

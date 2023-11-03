import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/widget/item.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FileListPage extends StatelessWidget {
  const FileListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FileListLogic());
    return GetBuilder<FileListLogic>(builder: (logic) {
      return logic.obx(
        (state) => EasyRefresh(
          onRefresh: () => logic.onRefresh(),
          onLoad: () => logic.onLoading(),
          child: ListView.separated(
            itemCount: state?.list?.length ?? 0,
            itemBuilder: (context, index) {
              return FileListItem(
                  title: state?.list?[index].title ?? "",
                  trailing: state?.list?[index].content ?? "",
                  children: (state?.list?[index].attachFiles ?? []).map((e) {
                    return FileListItemChild(attachFiles: e);
                  }).toList());
            },
            separatorBuilder: (BuildContext context, int index) {
              return divider1Px();
            },
          ),
          controller: logic.refreshController,
        ),
        onEmpty: StateWidget.empty(),
        onError: (err) => StateWidget.error(),
        onLoading: StateWidget.loading(),
      );
    });
  }
}

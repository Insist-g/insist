import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/law/logic.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/widget/item.dart';
import 'package:get/get.dart';

class LawFilePage extends StatelessWidget {
  const LawFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LawFileLogic());
    return GetBuilder<LawFileLogic>(builder: (logic) {
      return logic.obx(
        (state) => EasyRefresh(
          onRefresh: () => logic.onRefresh(),
          onLoad: () => logic.onLoading(),
          child: ListView.separated(
            itemCount: state?.list?.length ?? 0,
            itemBuilder: (context, index) {
              return FileListItem(
                  title: state?.list?[index].manDocs?.name ?? "",
                  trailing: DictStore.to.findLabel(
                    type: DictKeys.CTRL_MAN_DOCS_LEVEL,
                    value: (state?.list?[index].manDocs?.level ?? '').toString(),
                  ),
                  children: (state?.list?[index].attachFileList ?? []).map((e) {
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

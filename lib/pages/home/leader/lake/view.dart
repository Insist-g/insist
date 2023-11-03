import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'logic.dart';

class LakeLeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(LakeLeaderLogic());
    return GetBuilder<LakeLeaderLogic>(builder: (logic) {
      return Column(
        children: [
          _buildRow('姓名', '河长职务', '责任河库', '操作', AppColor.white),
          logic.obx(
            (state) {
              return EasyRefresh(
                onRefresh: () => logic.onRefresh(),
                onLoad: () => logic.onLoading(),
                controller: logic.refreshController,
                child: ListView.builder(
                    itemCount: state?.list?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildRow(
                          state?.list?[index].name,
                          DictStore.to.findLabel(
                              type: DictKeys.DR_USER_EXT_DEPT_LEVEL,
                              value: state?.list?[index].riverDuty),
                          buildReachNames(state?.list?[index].reachNames),
                          "查看详情",
                          index % 2 == 1 ? AppColor.white : AppColor.gray,
                          id: state?.list?[index].id);
                    }),
              );
            },
            onEmpty: StateWidget.empty(),
            onError: (err) => StateWidget.error(),
            onLoading: StateWidget.loading(),
          ).expanded()
        ],
      );
    });
  }

  Widget _buildRow(a, b, c, d, color, {int? id}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            a ?? "",
            textAlign: TextAlign.center,
          ),
        ).expanded(flex: 1),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(b ?? '', textAlign: TextAlign.center),
        ).expanded(flex: 1),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            c ?? "",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ).expanded(flex: 1),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(d, textAlign: TextAlign.center)
              .textColor(id == null ? null : AppColor.mainColor)
              .gestures(onTap: () {
            if (id == null) return;
            NavigationUtil.toLeaderInfoPage(id: id);
          }),
        ).expanded(flex: 1),
      ],
    ).backgroundColor(color);
  }

  String buildReachNames(List<String>? data) {
    var result = '';
    for (var item in data ?? []) {
      result += '$item,';
    }
    return result;
  }
}

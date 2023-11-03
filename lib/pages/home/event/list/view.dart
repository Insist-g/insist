import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/decoration.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/date.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/values/radii.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/search.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/selecter.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/list/widget/date_picker.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/list/widget/drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'logic.dart';

class EventListPage extends GetView<EventListLogic> {
  @override
  Widget build(BuildContext context) {
    Get.put(EventListLogic());
    return GetBuilder<EventListLogic>(builder: (logic) {
      return Scaffold(
          key: logic.scaffoldKey,
          appBar: AppBar(
            title: Text("事件处理"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.EventAdd);
            },
            tooltip: '事件上报',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.publish_outlined),
                Text(
                  "事件上报",
                  style: TextStyle(fontSize: 8),
                )
              ],
            ),
            backgroundColor: AppColor.mainColor,
          ),
          endDrawer: SearchDrawer(),
          body: logic.obx(
            (state) {
              return EasyRefresh(
                controller: logic.refreshController,
                onRefresh: logic.onRefresh,
                onLoad: logic.onLoading,
                child: ListView.builder(
                  itemCount: state?.list?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        decoration: AppDecoration.card,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state?.list?[index].title ?? '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ).expanded(),
                                  eventStateWidget((state?.list?[index].status ?? '')
                                          .toString())
                                      .gestures(
                                    onTap: () {
                                      if (state?.list?[index].status == 1 &&
                                          state?.list?[index].id != null) {
                                        logic.problemUpdate(
                                            id: state!.list![index].id!);
                                      }
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    stampTime(
                                                        state?.list?[index].updateTime),
                                                maxLines: 1,
                                                style:
                                                    AppTextStyle.secondary_12,
                                              )),
                                              eventExamineWidget(
                                                  state?.list?[index].checkStatus),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "涉及河道: ${state?.list?[index].riverName ??''}",
                                            style: AppTextStyle.primary_12,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                              "涉及河段: ${state?.list?[index].reachName??''}",
                                              style: AppTextStyle.primary_12),
                                          SizedBox(height: 2),
                                          //todo:等字段
                                          // Text("事件等级: ${DictStore.to.findLabel(value: state?[index].level, type: DictKeys.)}",
                                          //     style: AppTextStyle.primary_12),
                                          SizedBox(height: 2),
                                          Text(
                                              "上报人: ${state?.list?[index].reporter ?? ''}",
                                              style: AppTextStyle.primary_12),
                                          SizedBox(height: 2),
                                        ],
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  if ((state?.list?[index].attachFileList?.length ??
                                          0) >
                                      0)
                                    Expanded(
                                      child: netImageCached(
                                        height: 100,
                                        state?.list?[index]
                                                .attachFileList
                                                ?.first
                                                .url ??
                                            '',
                                      ),
                                      flex: 1,
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        if (state?.list?[index].id == null) return;
                        NavigationUtil.toEventInfoPage(id: state!.list![index].id!);
                      },
                    );
                  },
                ),
              );
            },
            onEmpty: StateWidget.empty(),
            onError: (err) => StateWidget.error(),
            onLoading: StateWidget.loading(),
          ));
    });
  }

  Color getColor(String? value) {
    switch (value) {
      case '1':
        return AppColor.yellow;
      case '2':
        return AppColor.secondaryText;
      case '3':
        return AppColor.green;
      default:
        return AppColor.gray;
    }
  }

//事件状态
  Widget eventStateWidget(String? value) {
    var str = DictStore.to
        .findLabel(value: value, type: DictKeys.CTRL_PROBLEM_STATUS);
    if (str.isEmpty) return SizedBox.shrink();
    if (value == '1') str = '设为跟踪';
    // 1设为跟踪 2已跟踪 2已处理
    final _color = getColor(value);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: Radii.k10pxRadius,
          // border: Border.all(color: AppColor.pinkColor)
          color: _color),
      child: Text(
        str,
        style: TextStyle(
          color: AppColor.white,
          fontSize: 12,
        ),
      ),
    );
  }

//事件审批状态
  Widget eventExamineWidget(String? value) {
    if ((value ?? "").isEmpty) return SizedBox.shrink();
    // 1未批示 2已批示 2无需批示
    final _color = getColor(value);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      decoration: BoxDecoration(
          border: Border.all(color: _color), borderRadius: Radii.k3pxRadius),
      child: Text(
        DictStore.to
            .findLabel(value: value, type: DictKeys.CTRL_PROBLEM_CHECK_STATUS),
        style: TextStyle(fontSize: 8, color: _color),
      ),
    );
  }
}

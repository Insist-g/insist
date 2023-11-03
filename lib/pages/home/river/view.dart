import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/decoration.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/search.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';
import 'logic.dart';

class RiverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(RiverLogic());
    return Scaffold(
      appBar: AppBar(title: Text("我的河道")),
      body: GetBuilder<RiverLogic>(builder: (logic) {
        return Column(
          children: [
            Container(
              color: AppColor.gray,
              child: SearchEdit(controller: logic.searchCtl),
            ),
            Expanded(
                child: logic.obx(
              (state) {
                return EasyRefresh(
                    controller: logic.refreshController,
                    onRefresh: logic.onRefresh,
                    onLoad: logic.onLoading,
                    child: ListView.builder(
                        itemCount: state?.list?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: AppDecoration.card,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: netImageCached(
                                      state?.list?[index].path ?? "",
                                      width: double.infinity,
                                      height: 100,
                                    ),
                                  ),
                                  Container(
                                    width: Get.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state?.list?[index].riverName ?? "",
                                          maxLines: 1,
                                          style: AppTextStyle.primary_14_w500,
                                        ),
                                        Text(
                                          "编码：${state?.list?[index].code ?? ""}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.primary_12,
                                        ).marginOnly(top: 5),
                                        Text(
                                          "类型：${DictStore.to.findLabel(type: DictKeys.CTRL_RIVER_TYPE, value: state?.list?[index].typeId)}",
                                          maxLines: 1,
                                          style: AppTextStyle.primary_12,
                                        ).marginOnly(top: 5),
                                        Text(
                                          "长度：${state?.list?[index].riverLength ?? ""}",
                                          maxLines: 1,
                                          style: AppTextStyle.primary_12,
                                        ).marginOnly(top: 5),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              if (state?.list?[index].id == null) return;
                              NavigationUtil.toRiverIndexPage(
                                  riverId: state!.list![index].id!,
                                  riverName:
                                      state.list![index].riverName ?? "");
                            },
                          );
                        }));
              },
              onEmpty: StateWidget.empty(),
              onError: (err) => StateWidget.error(),
              onLoading: StateWidget.loading(),
            ))
          ],
        );
      }),
    );
  }
}

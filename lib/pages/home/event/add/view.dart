import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/river.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image_wrap.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/search.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/add/widget/star_bar.dart';
import 'package:get/get.dart';
import 'logic.dart';

class EventAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(EventAddLogic());
    return Scaffold(
      appBar: AppBar(
        title: Text("事件上报"),
      ),
      body: GetBuilder<EventAddLogic>(builder: (logic) {
        return Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                divider20Px(),
                TextField(
                  controller: logic.titleCon,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    prefixIcon: Center(
                      widthFactor: 0.0,
                      child: Text(
                        "事件标题",
                        style: AppTextStyle.primary_16_w500,
                      ).marginOnly(left: 10),
                    ),
                    hintText: "请输入",
                    border: InputBorder.none,
                  ),
                ).paddingSymmetric(vertical: 5, horizontal: 10),
                divider1Px(indent: 10),
                SearchEditItem(
                  title: "涉及河道",
                  onSelect: (selectId) {
                    logic.riverId = selectId;
                  },
                  getSearchData: (a) async {
                    return await RiverApi.getRiverSimple(riverName: a) ?? [];
                  },
                ),
                divider1Px(indent: 10),
                SearchEditItem(
                  title: "涉及河段",
                  onSelect: (selectId) {
                    logic.reachId = selectId;
                  },
                  getSearchData: (a) async {
                    return await RiverApi.getReachSimple(reachName: a) ?? [];
                  },
                ),
                divider20Px(),
                TextField(
                  controller: logic.contentCon,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    prefixIcon: Text(
                      "详细内容",
                      style: AppTextStyle.primary_16_w500,
                    ).marginOnly(right: 10),
                    hintText: "请输入",
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 10,
                  maxLength: 500,
                ).paddingSymmetric(vertical: 5, horizontal: 10),
                ImageWrap(
                  onHandlerImageChange: (list) {
                    logic.imagesPath = list;
                    logic.imagesPath.forEach((element) async {
                      File? file = await element.file;
                      Log().d(file?.path ?? "", tag: 'path');
                    });
                    Log().d(logic.imagesPath.length.toString());
                  },
                ).paddingAll(10),
                ListTile(
                  title: Text(
                    logic.currentPosition == null
                        ? "点击右侧按钮获取位置信息"
                        : "${logic.currentPosition?.longitude}，${logic.currentPosition?.latitude}",
                    style: AppTextStyle.secondary_14,
                  ),
                  leading: Icon(
                    Icons.location_on_outlined,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      size: 18,
                    ),
                    onPressed: () {
                      logic.getCurrentPosition();
                    },
                  ),
                ),
                divider20Px(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("是否能够自主处理", style: AppTextStyle.primary_16_w500)
                        .marginOnly(left: 10),
                    Switch(
                        value: logic.selfProcess,
                        onChanged: (value) {
                          logic.selfProcess = value;
                          logic.update();
                        })
                  ],
                ),
                divider1Px(indent: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("事件等级", style: AppTextStyle.primary_16_w500)
                        .marginOnly(left: 10),
                    StarBar(onSelect: (value) => logic.eventLevel = value)
                  ],
                ).paddingSymmetric(vertical: 10),
                divider20Px(),
                TextField(
                  controller: logic.opinionCon,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    prefixIcon: Text(
                      "处理意见",
                      style: AppTextStyle.primary_16_w500,
                    ).marginOnly(right: 10),
                    hintText: "请输入",
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 10,
                  maxLength: 500,
                ).paddingSymmetric(vertical: 5, horizontal: 10),
                divider20Px(),
              ],
            )),
            btnFlatButtonWidget(
                width: double.infinity,
                title: "确定上报",
                onPressed: () => logic.onSubmit()).marginAll(10)
          ],
        );
      }),
    );
  }
}

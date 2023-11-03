import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image_wrap.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/input.dart';
import 'package:get/get.dart';

import 'logic.dart';

class IssueUploadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(IssueUploadLogic());
    return GetBuilder<IssueUploadLogic>(builder: (logic) {
      return Container(
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("某某点位名称：Q123"),
              subtitle: Text(
                "您已经到达点位，请按要求逐项检查",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: btnFlatButtonWidget(
                  width: 80,
                  height: 35,
                  fontSize: 12,
                  title: "确认提交",
                  gbColor: AppColor.yellow,
                  onPressed: () {
                    logic.commit();
                  }),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: logic.bottomSheetData.map((e) {
                      return SwitchListTile(
                          title: Text(e["title"].toString()),
                          value: e["value"] as bool,
                          onChanged: (value) {
                            e["value"] = value;
                            logic.update();
                          });
                    }).toList(),
                  ),
                  ExpansionTile(
                    title: Text(
                      "*如有异常需提交更多信息",
                      style: TextStyle(
                        color: AppColor.red,
                        fontSize: 16,
                      ),
                    ),
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text("巡察结果备注"),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        child: EditText(
                          lines: 10,
                          isShowDelete: false,
                          controller: logic.controller,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text("照片"),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: ImageWrap(),
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    });
  }
}

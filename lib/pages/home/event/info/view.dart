import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/date.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image_wrap.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/item.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';

import 'logic.dart';

class EventInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(EventInfoLogic());

    return Scaffold(
      appBar: AppBar(
        title: Text("事件详情"),
      ),
      body: GetBuilder<EventInfoLogic>(builder: (logic) {
        return logic.obx((state) {
          return ListView(
            children: [
              ListTile(
                title: Text(state?.appProblemRespVo?.title ?? ''),
                subtitle: Text(stampTime(state?.appProblemRespVo?.updateTime)),
                trailing: Text(DictStore.to.findLabel(
                    type: DictKeys.CTRL_PROBLEM_CHECK_STATUS,
                    value: state?.appProblemRespVo?.checkStatus)),
              ),
              divider1Px(),
              SizedBox(height: 10),
              buildText("涉及河道", state?.appProblemRespVo?.riverName ?? ''),
              buildText("涉及河段", state?.appProblemRespVo?.reachName ?? ''),
              buildText(
                  "事件等级",
                  DictStore.to.findLabel(
                    type: DictKeys.CTRL_PROBLEM_LEVEL,
                    value: (state?.appProblemRespVo?.level ?? '').toString(),
                  )),
              buildText("上报人", state?.appProblemRespVo?.reporter ?? ''),
              buildText(
                  "事件状态",
                  DictStore.to.findLabel(
                      type: DictKeys.CTRL_PROBLEM_STATUS,
                      value:
                          (state?.appProblemRespVo?.status ?? '').toString())),
              buildText(
                  "审批状态",
                  DictStore.to.findLabel(
                      type: DictKeys.CTRL_PROBLEM_CHECK_STATUS,
                      value: state?.appProblemRespVo?.checkStatus)),
              buildText("事件内容", state?.appProblemRespVo?.content ?? ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWrap(
                    data: (state?.appProblemRespVo?.attachFileList ?? [])
                        .map((e) => e.url)
                        .toList(),
                    enabled: false,
                  ).marginSymmetric(vertical: 5),
                ],
              ),
              divider20Px(height: 15),
              buildText(
                "处理意见",
                state?.appProblemRespVo?.comment ?? '',
                verticalPadding: 15,
              ),
              divider20Px(height: 15),
              buildText(
                "处理证明",
                state?.appPatrolProblemRespVo?.disposeDescribe ?? '',
                verticalPadding: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWrap(
                    data: (state?.appPatrolProblemRespVo?.attachFiles ?? [])
                        .map((e) => e.url)
                        .toList(),
                    enabled: false,
                  ).marginSymmetric(vertical: 5),
                ],
              ),
              divider20Px(),
            ],
          );
        },onEmpty: StateWidget.empty(),
          onError: (err) => StateWidget.error(message: err),
          onLoading: StateWidget.loading(),);
      }),
    );
  }
}

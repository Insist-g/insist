import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/leader.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/river.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/decoration.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';
import 'logic.dart';

class LeaderInfoPage extends StatelessWidget {
  final logic = Get.put(LeaderInfoLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LeaderInfoLogic>(builder: (logic) {
        return NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  [buildSliverAppBar(logic.state?.userExtDo)],
          body: logic.obx(
            onEmpty: StateWidget.empty(),
            onError: (err) => StateWidget.error(),
            onLoading: StateWidget.loading(),
            (state) {
              return ListView.separated(
                padding: EdgeInsets.all(0),
                itemCount: state?.riverList?.length ?? 0,
                itemBuilder: (context, index) {
                  return buildItem(
                    state?.riverList?[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    dividerSolid1Px(),
              );
            },
          ),
        );
      }),
    );
  }

  Widget buildItem(RiverBean? data) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data?.riverName ?? ''),
          if (data?.gradeId != null)
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                DictStore.to.findLabel(
                    type: DictKeys.CTRL_RIVER_GRADE, value: data?.gradeId),
                style: AppTextStyle.secondary_12.copyWith(fontSize: 10),
              ),
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
              ),
            )
        ],
      ),
      subtitle: Text(data?.riverLength != null
          ? "${data?.riverLength}公里长"
          : "" +
              (data?.mianji != null
                  ? "${data?.riverLength} ｜ ${data?.mianji}平方公里面积"
                  : "")),
      onTap: () {},
    );
  }

  Widget buildSliverAppBar(UserExtDo? userExtDo) {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: AppColor.mainColor,
      pinned: true,
      floating: false,
      snap: false,
      elevation: 0.0,
      expandedHeight: 390,
      title: Text(
        userExtDo?.name ?? "",
      ),
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHeader(userExtDo),
            buildMobile(userExtDo),
            divider20Px(),
          ],
        ),
      )),
      bottom: buildFlexibleTooBarWidget(),
    );
  }

  Widget buildHeader(UserExtDo? userExtDo) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: netImageCached(
              "https://lmg.jj20.com/up/allimg/1114/0G020114924/200G0114924-15-1200.jpg",
              width: double.infinity,
              height: 200,
              radius: 0,
            ),
          ),
          Positioned(
              top: 150,
              left: 20,
              right: 20,
              child: Container(
                decoration: AppDecoration.card,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userExtDo?.name ?? '',
                              style: AppTextStyle.primary_16_w500,
                            ),
                            if ((userExtDo?.adminduty ?? "").isNotEmpty)
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  userExtDo?.adminduty ?? "",
                                  style: AppTextStyle.secondary_12
                                      .copyWith(fontSize: 10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                ),
                              )
                          ],
                        ).marginOnly(bottom: 6),
                        Text("所属机关:${userExtDo?.deptName ?? "暂无"}")
                            .marginOnly(bottom: 6),
                        Text(
                            "等级:${DictStore.to.findLabel(type: DictKeys.DR_USER_EXT_DEPT_LEVEL, value: userExtDo?.riverDuty)}")
                      ],
                    ),
                  ],
                ).marginOnly(right: 20),
              )),
          Positioned(
            top: 120,
            left: 40,
            child: Container(
              width: 100,
              height: 100,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Center(
                child: Text(
                  userExtDo?.name ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMobile(UserExtDo? userExtDo) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: "手机：", style: AppTextStyle.primary_14),
              TextSpan(
                  text: userExtDo?.phone, style: AppTextStyle.secondary_14),
            ])),
            SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: "电话：", style: AppTextStyle.primary_14),
              TextSpan(
                  text: userExtDo?.contacttel,
                  style: AppTextStyle.secondary_14),
            ])),
          ],
        )),
        GestureDetector(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.call_end_outlined,
                color: AppColor.green,
              ),
              Text(
                "拨打手机",
                style: AppTextStyle.secondary_12,
              )
            ],
          ),
          onTap: () {
            logic.launchPhone((userExtDo?.phone ?? '').trim());
          },
        )
      ],
    )
        .paddingSymmetric(
          vertical: 10,
          horizontal: 30,
        )
        .marginOnly(bottom: 20);
  }

  PreferredSizeWidget buildFlexibleTooBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(44),
      child: Container(
        color: AppColor.white,
        alignment: Alignment.center,
        child: Row(
          children: [dividerVertical(color: AppColor.yellow), Text("河长管辖河流")],
        ).paddingAll(10),
      ),
    );
  }
}

String buildDutyText(String? value) {
  switch (value) {
    case '1':
      return '省级河长';
    case '2':
      return '市级河长';
    case '3':
      return '区县级河长';
    case '4':
      return '乡镇级河长';
    case '5':
      return '村级河长';
    default:
      return '';
  }
}

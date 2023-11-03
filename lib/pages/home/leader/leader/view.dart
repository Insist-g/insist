import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LeaderListPage extends StatelessWidget {
  const LeaderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeaderListLogic());
    return GetBuilder<LeaderListLogic>(builder: (logic) {
      return logic.obx(
        (state) => EasyRefresh(
          onRefresh: () => logic.onRefresh(),
          onLoad: () => logic.onLoading(),
          child: ListView.builder(
              itemCount: state?.list?.length ?? 0,
              itemBuilder: (context, index) {
                final _color = Colors.primaries[index % 8];
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (state?.list?[index].name ?? "").substring(0, 2),
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state?.list?[index].name ?? ""),
                      if ((state?.list?[index].adminduty ?? "").isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            state?.list?[index].adminduty ?? '',
                            style: AppTextStyle.secondary_12.copyWith(
                              fontSize: 10,
                              color: _color,
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                          decoration: BoxDecoration(
                            border: Border.all(color: _color),
                          ),
                        )
                    ],
                  ),
                  subtitle:
                      Text("所属机关：${state?.list?[index].deptName ?? '暂无'}"),
                  onTap: () {
                    if (state?.list?[index].id == null) return;
                    NavigationUtil.toLeaderInfoPage(
                        id: state!.list![index].id!);
                  },
                );
              }),
          controller: logic.refreshController,
        ),
        onEmpty: StateWidget.empty(),
        onError: (err) => StateWidget.error(),
        onLoading: StateWidget.loading(),
      );
    });
  }
}

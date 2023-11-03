import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/patrol.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/decoration.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'app.dart';

class PatrolCard extends StatelessWidget {
  final PatrolBean? data;
  final bool isCard;

  const PatrolCard({super.key, this.data, this.isCard = true});

  @override
  Widget build(BuildContext context) {
    final uploadStatus = initData();
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            padding: isCard
                ? EdgeInsets.symmetric(vertical: 10, horizontal: 15)
                : null,
            margin: EdgeInsets.all(isCard ? 10 : 5),
            decoration: isCard ? AppDecoration.card : null,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dividerVertical(color: uploadStatus["color"]),
                    Container(
                        width: 80,
                        child: Text(
                          "巡河名称",
                          style: AppTextStyle.primary_14_w500,
                        )),
                    Text(data?.patrolName ?? '',
                        style: AppTextStyle.primary_14_w500, maxLines: 1,).marginOnly(right: 60).expanded()
                  ],
                ),
                _buildText(
                  "巡河河段",
                  data?.reachName ?? '暂无',
                ),
                _buildText("巡河区域", data?.quyu ?? '暂无'),
                _buildText(
                    "巡河起点",
                    data?.startLatitude == null || data?.startLatitude == null
                        ? '暂无'
                        : '${data?.startLatitude ?? ''},${data?.startLatitude ?? ''}'),
                _buildText(
                    "巡河终点",
                    data?.endLatitude == null || data?.endLongitude == null
                        ? '暂无'
                        : '${data?.endLatitude ?? ''},${data?.endLongitude ?? ''}'),
                _buildText("巡河内容", data?.content ?? '暂无'),
              ],
            ),
          ),
          Positioned(
              right: 20,
              top: 10,
              child: Image.asset(
                  width: 60, "assets/images/${uploadStatus["assetImage"]}"))
        ],
      ),
      onTap: () {
        if (!isCard) return;
        if (data?.patrolId == null) return;
        data?.uploadStatus == 2
            ? NavigationUtil.toPatrolIngPage(id: data!.patrolId!)
            : NavigationUtil.toPatrolInfoPage(id: data!.patrolId!);
      },
    );
  }

  Map initData() {
    switch (data?.taskType ?? 0) {
      case 1:
        switch (data?.uploadStatus ?? 0) {
          case 1:
            return {"color": AppColor.gray, "assetImage": "patrol_waiting.png"};
          case 2:
            return {
              "color": AppColor.yellow,
              "assetImage": "patrol_running.png"
            };
          case 3:
            return {"color": AppColor.green, "assetImage": "patrol_finish.png"};
          default:
            return {"color": AppColor.green, "assetImage": "img_default.png"};
        }
      case 2:
        return {"color": AppColor.red, "assetImage": "patrol_urgent.png"};
      case 3:
        return {
          "color": AppColor.mainColor,
          "assetImage": "patrol_special.png"
        };
      default:
        return {"color": AppColor.green, "assetImage": "img_default.png"};
    }
  }

  _buildText(first, last) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 80, child: Text(first, style: AppTextStyle.primary_14)),
        Expanded(
          child: Text(last,
              maxLines: 1,
              style: AppTextStyle.secondary_14,
              overflow: TextOverflow.ellipsis),
        )
      ],
    ).paddingSymmetric(vertical: 5, horizontal: 15);
  }
}

Widget buildText(
  first,
  last, {
  double? verticalPadding,
  double? horizontalPadding,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 80,
        child: Text(
          first,
          style: AppTextStyle.primary_14,
        ),
      ),
      Expanded(
          child: Text(
        last,
        style: AppTextStyle.secondary_14,
      ))
    ],
  ).paddingSymmetric(vertical: verticalPadding ?? 5, horizontal: 15);
}

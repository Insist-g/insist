import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/complain.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/complain/info/view.dart';
import 'package:get/get.dart';

class ComPlainItem extends StatelessWidget {
  final ComplainBean? data;

  const ComPlainItem({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data?.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryText,
                  ),
                )
              ],
            ),
            Text(
              data?.content ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.secondaryText,
              ),
            ).marginSymmetric(vertical: 5),
            if ((data?.attachFiles ?? []).length > 0)
              EasyRefresh(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (data?.attachFiles ?? []).map((e) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child:
                            netImageCached(e.url ?? "", height: 80, width: 100),
                      );
                    }).toList(),
                  ),
                ).marginSymmetric(vertical: 10),
              ),
            // Text(
            //   stampTimeLineFormat(date?.createTime),
            //   style: TextStyle(
            //     fontSize: 14,
            //     color: AppColor.secondaryText,
            //   ),
            // ).marginSymmetric(vertical: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data?.riverName ?? "",
                    style: AppTextStyle.primary_14,
                  ),
                ),
                Text(
                    DictStore.to.findLabel(
                        type: DictKeys.INFRA_API_ERROR_LOG_PROCESS_STATUS,
                        value: data?.status.toString()),
                    style: AppTextStyle.secondary_12.copyWith(
                      color: data?.status == 0
                          ? AppColor.primaryText
                          : AppColor.green,
                    ))
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Get.to(() => ComplainInfoPage(data: data));
      },
    );
  }
}

String buildStateText(int? state) {
  switch (state) {
    case 0:
      return '举报未处理';
    case 1:
      return '已确认待分派';
    case 2:
      return '处理中';
    case 3:
      return '处理完成';
    default:
      return '暂无';
  }
}

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:get/get.dart';

import 'logic.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(VideoLogic());
    return GetBuilder<VideoLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(title: Text("视频监控")),
        body: logic.obx(
          (state) {
            return EasyRefresh(
              onRefresh: () => logic.onRefresh(),
              onLoad: () => logic.onLoading(),
              controller: logic.refreshController,
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if ((state?.list?.length ?? 0) > 0)
                          GestureDetector(
                            child: _imageWidget(
                              height: 200,
                              width: double.infinity,
                              url: '',
                              title: state?.list?[0].deviceName,
                            ).marginSymmetric(vertical: 10),
                            onTap: () {
                              logic.toVideoInfo(state?.list?[0].interfaceUrl);
                            },
                          ),
                        if ((state?.list?.length ?? 0) > 1)
                          Wrap(
                              direction: Axis.horizontal,
                              spacing: 10,
                              runSpacing: 10,
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              textDirection: TextDirection.ltr,
                              children: (state?.list ?? []).sublist(1).map((e) {
                                return GestureDetector(
                                  child: SizedBox(
                                    width: (Get.width - 30) / 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _imageWidget(
                                          height: (Get.width - 30) / 2,
                                          width: (Get.width - 30) / 2,
                                          url: '',
                                        ),
                                        Text(
                                          e.deviceName ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    logic.toVideoInfo(e.interfaceUrl);
                                  },
                                );
                              }).toList())
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          onEmpty: StateWidget.empty(),
          onError: (err) => StateWidget.error(),
          onLoading: StateWidget.loading(),
        ),
      );
    });
  }

  Widget _imageWidget(
      {required double height,
      required double width,
      required String url,
      String? title}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColor.dividerColor)),
      height: height,
      width: width,
      child: Stack(
        children: [
          netImageCached(
              width: width,
              height: height,
              url,
              overlay: true,
              type: netImageCachedType.avatar),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_circle_outline,
              color: AppColor.white,
              size: 40,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Text(
              title ?? '',
              style: AppTextStyle.secondary_14.copyWith(
                color: AppColor.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

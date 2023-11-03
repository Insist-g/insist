import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:flutter_ducafecat_news_getx/pages/map/widget/fl_map.dart';
import 'package:get/get.dart';

import 'logic.dart';

class RiverInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(RiverInfoLogic());
    return GetBuilder<RiverInfoLogic>(builder: (logic) {
      return logic.obx((state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 300,
                child: FLMap(
                  initCenter: LatLng(
                    double.parse(state?.riverLat ?? '0'),
                    double.parse(state?.riverLng ?? '0'),
                  ),
                  lines: [
                    [
                      LatLng(
                        double.parse(state?.riverLat ?? '0'),
                        double.parse(state?.riverLng ?? '0'),
                      ),
                      LatLng(
                        double.parse(state?.estuaryLat ?? '0'),
                        double.parse(state?.estuaryLng ?? '0'),
                      )
                    ]
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  dividerVertical(),
                  Text(
                    "巡河名称：${state?.riverName ?? ""}",
                    style: AppTextStyle.primary_16_w500,
                  )
                ],
              ),
              Column(
                children: logic.columnData
                    .map((element) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 100,
                                    child: Text(element["title"] as String)),
                                Expanded(
                                    child: Text(
                                  "${element["value"]}",
                                  textAlign: TextAlign.end,
                                  style: AppTextStyle.secondary_14,
                                ))
                              ],
                            ).paddingSymmetric(vertical: 10),
                            dividerSolid1Px(indent: 0)
                          ],
                        ))
                    .toList(),
              ).paddingSymmetric(vertical: 10, horizontal: 20),
              Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  child: CarouselSlider(
                    options: CarouselOptions().copyWith(
                      height: double.infinity,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                    ),
                    items: [state?.path ?? ""]
                        .map((item) => netImageCached(
                              item,
                              width: double.infinity,
                              height: double.infinity,
                              radius: 5,
                            ))
                        .toList(),
                  ))
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 5),
        );
      },
        onEmpty: StateWidget.empty(),
        onError: (err) => StateWidget.error(),
        onLoading: StateWidget.loading(),);
    });
  }
}

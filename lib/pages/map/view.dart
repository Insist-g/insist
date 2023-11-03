import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/pages/map/logic.dart';
import 'package:get/get.dart';
import 'widget/fl_map.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MapLogic());
    return GetBuilder<MapLogic>(builder: (logic) {
      return Scaffold(
        key: logic.scaffoldKey,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.auto_awesome_motion,
                  color: logic.mapIs3D ? AppColor.white : AppColor.black),
              onPressed: () {
                if (logic.scaffoldKey.currentState != null) {
                  logic.scaffoldKey.currentState!.openEndDrawer();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.filter,
                  color: logic.mapIs3D ? AppColor.white : AppColor.black),
              onPressed: () {
                logic.switchMap();
              },
            ),
            IconButton(
              icon: Icon(Icons.my_location,
                  color: logic.mapIs3D ? AppColor.white : AppColor.black),
              onPressed: () {
                logic.move();
              },
            ),
          ],
        ),
        endDrawer: Drawer(
          width: Get.width - 100,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: logic.drawPointsData.map((e) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: AppColor.dividerColor,
                            child: Text("${e.title}"),
                          ),
                          Column(
                            children: (e.pointsInfo ?? [])
                                .map((info) => ListTile(
                                      title: Text(info.name ?? ""),
                                      leading:
                                          Icon(Icons.account_balance_outlined),
                                      trailing: Switch(
                                        value: info.select ?? false,
                                        onChanged: (value) {
                                          logic.onChange(value, info);
                                        },
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  Column(
                    children: logic.drawLinesData.map((e) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: AppColor.dividerColor,
                            child: Text("${e.title}"),
                          ),
                          Column(
                            children: (e.linesInfo ?? [])
                                .map((info) => ListTile(
                                      title: Text(info.name ?? ""),
                                      leading:
                                          Icon(Icons.account_balance_outlined),
                                      trailing: Switch(
                                        value: info.select ?? false,
                                        onChanged: (value) {
                                          logic.onChange(value, info);
                                        },
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: FLMap(
          controller: logic.mapController,
          points: logic.getPointsList(),
          lines: logic.getLinesList(),
          is3D: logic.mapIs3D,
        ),
      );
    });
  }
}

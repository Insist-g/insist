import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/store/user.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:get/get.dart';
import 'logic.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MineLogic());
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg_mine.png",
            height: Get.height / 2,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              AppBar(
                title: Text("个人中心"),
                backgroundColor: Colors.transparent,
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.only(bottom: 40),
                  child: Obx(() {
                    return Row(
                      children: [
                        netImageCached(
                          width: 80,
                          height: 80,
                          type: netImageCachedType.avatar,
                          UserStore.to.profile.avatar ?? "",
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                UserStore.to.profile.nickname ?? "",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                UserStore.to.profile.postName ?? "",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 30,
                          color: AppColor.white,
                        )
                      ],
                    );
                  }),
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.MineInfo);
                },
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: logic.menuList.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              e["title"].toString(),
                              style: AppTextStyle.primary_14,
                            ),
                            onTap: () {
                              Get.toNamed(e["route"].toString());
                            },
                          ),
                          Divider(
                            height: 1,
                            indent: 20,
                            endIndent: 20,
                            color: AppColor.borderColor,
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}

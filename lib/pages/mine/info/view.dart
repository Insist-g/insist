import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image.dart';
import 'package:get/get.dart';
import 'logic.dart';

class MineInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MineInfoLogic());
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "assets/images/bg_mine.png",
            height: Get.height / 3,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          AppBar(
            title: Text("个人资料"),
            backgroundColor: Colors.transparent,
          ),
          Positioned(
            top: Get.height / 4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    GestureDetector(
                      child: SizedBox(
                        width: Get.width / 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Obx(() {
                                return Text(
                                  UserStore.to.profile.nickname ?? "",
                                  style: AppTextStyle.primary_18_w500,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                );
                              }),
                            ),
                            Icon(
                              Icons.edit_note,
                              size: 20,
                              color: AppColor.mainColor,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.EditInfo,
                          arguments: {
                            "title": "姓名",
                            "trailing": UserStore.to.profile.nickname,
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text("职务"),
                      leading: Icon(
                        Icons.person_pin,
                        color: AppColor.green,
                      ),
                      trailing: Obx(() {
                        return Text(UserStore.to.profile.postName ?? "");
                      }),
                    ),
                    ListTile(
                      title: Text("电话"),
                      leading: Icon(
                        Icons.phone_android,
                        color: AppColor.yellow,
                      ),
                      trailing: Obx(() {
                        return Text(UserStore.to.profile.mobile ?? "");
                      }),
                    ),
                    ListTile(
                      title: Text("责任河段"),
                      leading: Icon(
                        Icons.recommend_outlined,
                        color: AppColor.pinkColor,
                      ),
                      trailing: Obx(() {
                        return Text(UserStore.to.profile.reachNames ?? "");
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height / 4 - 40,
            child: GestureDetector(
              child: Obx(() {
                return netImageCached(
                  UserStore.to.profile.avatar ?? "",
                  width: 80,
                  height: 80,
                  type: netImageCachedType.avatar,
                );
              }),
              onTap: () {
                logic.onChangePhoto(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/channel/hi_channel.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/routes.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/web.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/location.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/overlay_window.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/td_map.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
              title: Text("推出登陆"),
              onTap: () => Get.offAllNamed(AppRoutes.SIGN_IN)),
          ListTile(
            title: Text("高德地图"),
            onTap: () => Get.to(GDLocation()),
          ),
          ListTile(
            title: Text("flutter_map加载天地图"),
            onTap: () => Get.to(FLMap()),
          ),
          ListTile(
            title: Text("js加载天地图"),
            onTap: () => Get.to(CurrentPositionPage()),
          ),
          ListTile(
            title: Text("桌面小窗口案例"),
            onTap: () => Get.to(WinPage()),
          ),
          ListTile(
            title: Text("toast"),
            onTap: () {
              HIChannel.overlayAuth();
            },
          )
        ],
      ),
    );
  }
}

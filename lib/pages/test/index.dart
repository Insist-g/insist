import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/routes.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/location.dart';
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
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/channel/hi_channel.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/routes.dart';
import 'package:flutter_ducafecat_news_getx/common/store/web_socket.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/date_picker.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/overlay_window.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/search_edit.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/td_map.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/test_upload.dart';
import 'package:get/get.dart';
import '../map/widget/fl_map.dart';
import 'down_button2.dart';
import 'open_file.dart';

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
              onTap: () => Get.offAllNamed(AppRoutes.Login)),
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
          ),
          ListTile(
            title: Text("picker"),
            onTap: () {
              Get.to(MyApp());
            },
          ),
          ListTile(
            title: Text("FLMap"),
            onTap: () {
              Get.to(Scaffold(
                body: FLMap(),
              ));
            },
          ),
          ListTile(
            title: Text("GeolocatorSettingsExample"),
            onTap: () {
              Get.to(() => GeolocatorSettingsExample());
            },
          ),
          ListTile(
            title: Text("UploadPage"),
            onTap: () {
              Get.to(() => UploadPage());
            },
          ),
          ListTile(
            title: Text("video player"),
            onTap: () {
              Get.to(() => VideoView(
                    url:
                        "http://58.56.253.82:7086/live/cameraid/1000005%248/substream/2.m3u8",
                    isCover: false,
                  ));
            },
          ),
          ListTile(
            title: Text("search"),
            onTap: () {
              Get.to(() => MySearchPage());
            },
          ),
          ListTile(
            title: Text("web socket send message"),
            onTap: () {
              WebSocketStore.to.sendMessage("message");
            },
          ),
          ListTile(
            title: Text("open file"),
            onTap: () {
              Get.to(() => OpenFilePage());
            },
          ),
          ListTile(
            title: Text("openPDF"),
            onTap: () {
              Utils.toPdfPage(path: "https://pdfkit.org/docs/guide.pdf", title: "adsa");
            },
          ),
        ],
      ),
    );
  }
}

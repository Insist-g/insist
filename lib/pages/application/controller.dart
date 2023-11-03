import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/entities.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/store/position.dart';
import 'package:flutter_ducafecat_news_getx/common/store/user.dart';
import 'package:flutter_ducafecat_news_getx/common/store/web_socket.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/jpush.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/overlay.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/view.dart';
import 'package:get/get.dart';
import 'index.dart';

class ApplicationController extends GetxController with WidgetsBindingObserver {
  ApplicationController();

  final state = ApplicationState();
  late final List tabTitles;

  void handlePageChanged(int page) {
    state.page = page;
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    tabTitles = [
      {'title': '工作台', 'icon': Icons.home, 'page': HomePage()},
      // {'title': '一张图', 'icon': Icons.interests},
      {'title': '我的', 'icon': Icons.person, 'page': MinePage()}
    ];
  }

  @override
  void onReady() {
    super.onReady();
    checkToken();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (PositionStore.to.isRunning) OverLayUtil().dismiss();
    } else if (state == AppLifecycleState.paused) {
      if (PositionStore.to.isRunning) OverLayUtil().show();
    }
  }

  Future checkToken() async {
    // ResponseEntity rsp = await UserAPI.checkToken();
    // if (rsp.code == RSP_OK) {
    //   final expiresTime = LoginResult.fromJson(rsp.data).expiresTime;
    final expiresTime = UserStore.to.user?.expiresTime;
    if (expiresTime != null) {
      Duration difference = DateTime.fromMillisecondsSinceEpoch(expiresTime)
          .difference(DateTime.now());
      //token有效期24小时内并且大于0
      if (difference.inHours < 24 && difference.inSeconds > 0) {
        await UserStore.to.refreshToken();
      } else {
        UserStore.to.onLogout();
      }
    }
  } // }
}

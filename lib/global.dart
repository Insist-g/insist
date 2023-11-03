import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ducafecat_news_getx/common/services/services.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:get/get.dart';

import 'common/store/position.dart';

/// 全局静态数据
class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    setSystemUi();
    Loading();
    defaultEasyRefreshBuilder();

    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
    Get.put<DictStore>(DictStore());
    Get.put<PositionStore>(PositionStore());
  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  static void defaultEasyRefreshBuilder() {
    // 全局设置
    EasyRefresh.defaultHeaderBuilder = () => ClassicHeader(
          dragText: "下拉刷新",
          armedText: "松开刷新",
          readyText: "刷新中...",
          processingText: "刷新中...",
          processedText: "刷新成功",
          failedText: "刷新失败",
          noMoreText: "没有更多数据~",
          messageText: "更新于 %T",
        );
    EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
          dragText: "拉动加载",
          armedText: "释放加载",
          readyText: "加载中...",
          processingText: "加载中...",
          processedText: "加载成功",
          failedText: "加载失败",
          noMoreText: "没有更多数据~",
          messageText: "更新于 %T",
        );
  }
}

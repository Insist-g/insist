import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/middlewares/middlewares.dart';
import 'package:flutter_ducafecat_news_getx/pages/application/index.dart';
import 'package:flutter_ducafecat_news_getx/pages/application/login/index.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/about/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/editpass/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/feedback/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/info/edit/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/readme/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/setting/view.dart';
import 'package:get/get.dart';

import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    // 需要登录
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.MineInfo,
      page: () => MineInfoPage(),
    ),
    GetPage(
      name: AppRoutes.EditPass,
      page: () => EditPassPage(),
    ),
    GetPage(
      name: AppRoutes.Feedback,
      page: () => FeedBackPage(),
    ),
    GetPage(
      name: AppRoutes.About,
      page: () => AboutPage(),
    ),
    GetPage(
      name: AppRoutes.Setting,
      page: () => SettingPage(),
    ),
    GetPage(
      name: AppRoutes.Readme,
      page: () => ReadmePage(),
    ),
    GetPage(
      name: AppRoutes.EditInfo,
      page: () => EditInfoPage(),
    ),
  ];

// static final unknownRoute = GetPage(
//   name: AppRoutes.NotFound,
//   page: () => NotfoundView(),
// );
}

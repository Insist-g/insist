import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/middlewares/middlewares.dart';
import 'package:flutter_ducafecat_news_getx/pages/application/index.dart';
import 'package:flutter_ducafecat_news_getx/pages/application/login/index.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/complain/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/complain/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/add/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/list/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/leader/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/leader/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/message/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/message/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/history/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/patroling/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/river/index/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/river/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/statistics/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/video/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/video/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/about/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/editpass/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/feedback/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/info/edit/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/info/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/readme/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/mine/setting/view.dart';
import 'package:flutter_ducafecat_news_getx/pages/test/index.dart';
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
      name: AppRoutes.Message,
      page: () => MessagePage(),
    ),
    GetPage(
      name: AppRoutes.EventList,
      page: () => EventListPage(),
    ),
    GetPage(
      name: AppRoutes.EventAdd,
      page: () => EventAddPage(),
    ),
    GetPage(
      name: AppRoutes.EventInfo,
      page: () => EventInfoPage(),
    ),
    GetPage(
      name: AppRoutes.PatrolIndex,
      page: () => PatrolIndexPage(),
    ),
    GetPage(
      name: AppRoutes.FileIndex,
      page: () => FileIndexPage(),
    ),
    GetPage(
      name: AppRoutes.PatrolInfo,
      page: () => PatrolInfoPage(),
    ),
    GetPage(
      name: AppRoutes.PatrolIng,
      page: () => PatrolIngPage(),
    ),
    GetPage(
      name: AppRoutes.LeaderIndex,
      page: () => LeaderIndexPage(),
    ),
    GetPage(
      name: AppRoutes.LeaderInfo,
      page: () => LeaderInfoPage(),
    ),
    GetPage(
      name: AppRoutes.ComplainIndex,
      page: () => ComplainIndexPage(),
    ),
    GetPage(
      name: AppRoutes.River,
      page: () => RiverPage(),
    ),
    GetPage(
      name: AppRoutes.RiverIndex,
      page: () => RiverIndexPage(),
    ),
    GetPage(
      name: AppRoutes.Video,
      page: () => VideoPage(),
    ),
    GetPage(
      name: AppRoutes.VideoInfo,
      page: () => VideoInfoPage(),
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
      name: AppRoutes.StatisticsIndex,
      page: () => StatisticsIndexPage(),
    ),
    GetPage(
      name: AppRoutes.PatrolHistory,
      page: () => PatrolHistoryPage(),
    ),
    GetPage(
      name: AppRoutes.Test,
      page: () => TestPage(),
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

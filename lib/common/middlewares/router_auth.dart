import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/routes.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';

import 'package:get/get.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin || route == AppRoutes.Login) {
      return null;
    } else {
      return RouteSettings(name: AppRoutes.Login);
    }
  }
}

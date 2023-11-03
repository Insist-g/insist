import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:get/get.dart';

///跳转页面并传递参数
class NavigationUtil {
  static toRiverIndexPage(
      {required String riverId, required String riverName}) {
    Get.toNamed(AppRoutes.RiverIndex,
        parameters: {"riverId": riverId, "riverName": riverName});
  }

  static toPatrolIngPage({required int id}) {
    Get.toNamed(AppRoutes.PatrolIng, arguments: id);
  }

  static toPatrolInfoPage({required int id}) {
    Get.toNamed(AppRoutes.PatrolInfo, arguments: id);
  }

  static toPatrolHistoryPage({required int id}) {
    Get.toNamed(AppRoutes.PatrolHistory, arguments: id);
  }

  static toPatrolVideoInfoPage({required String url}) {
    Get.toNamed(AppRoutes.VideoInfo, arguments: url);
  }

  static toEventInfoPage({required int id}) {
    Get.toNamed(AppRoutes.EventInfo, arguments: id);
  }

  static toLeaderInfoPage({required int id}) {
    Get.toNamed(AppRoutes.LeaderInfo, arguments: id);
  }
}

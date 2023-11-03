import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/home.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/patrol.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/river.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/message.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/patrol.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/river.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/message/info/view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final List menuList = [
    {
      "icon": "assets/images/menu_event.png",
      "title": ""
          "事件处理",
      "route": AppRoutes.EventList
    },
    {
      "icon": "assets/images/menu_patrol.png",
      "title": "移动巡察",
      "route": AppRoutes.PatrolIndex
    },
    {
      "icon": "assets/images/menu_file.png",
      "title": "资源文件",
      "route": AppRoutes.FileIndex
    },
    {
      "icon": "assets/images/menu_leader.png",
      "title": "河长治名录",
      "route": AppRoutes.LeaderIndex
    },
    {
      "icon": "assets/images/menu_video.png",
      "title": "视频监控",
      "route": AppRoutes.Video
    },
    {
      "icon": "assets/images/menu_complain.png",
      "title": "群众投诉",
      "route": AppRoutes.ComplainIndex
    },
    {
      "icon": "assets/images/menu_message.png",
      "title": "通知公告",
      "route": AppRoutes.Message
    }
  ];
  final EasyRefreshController refreshController =
      EasyRefreshController(controlFinishRefresh: true);

  List<MessageBean> messageList = [];
  List<RiverBean> riverList = [];
  List<PatrolBean> patrolList = [];
  List<MessageBean> newList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  // 数据获取
  Future<void> onRefresh() async {
    Future.wait([
      getMessageList(),
      getRiverList(),
      getPatrolList(),
      getNewsList(),
    ]).then((value) {
      messageList = value[0] as List<MessageBean>;
      riverList = value[1] as List<RiverBean>;
      patrolList = value[2] as List<PatrolBean>;
      newList = value[3] as List<MessageBean>;
      update();
    }).onError<DioException>((error, stackTrace) {
      EasyLoading.showError(error.message ?? "${error.toString()}");
    }).whenComplete(() {
      refreshController.finishRefresh();
    });
  }

  Future<List<MessageBean>> getMessageList() async {
    var res = await HomeApi.getMessageList(pageNo: 1);
    return res.data?.list ?? [];
  }

  Future<List<RiverBean>> getRiverList() async {
    var res = await RiverApi.getRiverList(pageNo: 1, pageSize: 2);
    return res.data?.list ?? [];
  }

  Future<List<PatrolBean>> getPatrolList() async {
    var res = await PatrolApi.getPatrolList(pageNo: 1, pageSize: 1);
    return res.data?.list ?? [];
  }

  Future<List<MessageBean>> getNewsList() async {
    var res = await HomeApi.getNewsList(pageNo: 1);
    return res.data?.list ?? [];
  }

  Future getNewsInfo(int? id) async {
    if (id == null) return;
    EasyLoading.show();
    HomeApi.getNewsInfo(id: id).then((value) {
      Get.to(() => MessageInfoPage(data: value.data));
    }).onError<DioException>((error, stackTrace) {
      EasyLoading.showError(error.message ?? '新闻失踪了..');
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

}

import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/home.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/video.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class VideoLogic extends GetxController with StateMixin<VideoEntity?> {
  int page = 1;
  final size = 10;
  late EasyRefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  onRefresh({String value = ''}) {
    page = 1;
    state?.list?.clear();
    _requestData();
  }

  onLoading() {
    page++;
    _requestData();
  }

  void _requestData() async {
    HomeApi.getVideoList(pageNo: page).then((value) {
      List<VideoBean> list = [];
      for (VideoBean item in value.data?.list ?? []) {
        if ((item.interfaceUrl ?? '').isNotEmpty) {
          list.add(item);
        }
      }
      if (state?.list != null) {
        state?.list?.addAll(list);
      }
      change(
        state ?? VideoEntity(total: value.data?.total, list: list),
        status: value.data?.total == 0 ? RxStatus.empty() : RxStatus.success(),
      );
    }).onError<DioException>((error, stackTrace) {
      change(null, status: RxStatus.error(error.message));
    }).whenComplete(() {
      refreshController.finishRefresh();
      refreshController.finishLoad((state?.list?.length ?? 0) == state?.total
          ? IndicatorResult.noMore
          : IndicatorResult.success);
    });
  }

  void toVideoInfo(String? url) {
    if ((url ?? '').isEmpty) {
      EasyLoading.showInfo("视频不见了TAT");
      return;
    }
    NavigationUtil.toPatrolVideoInfoPage(url: url!);
  }
}

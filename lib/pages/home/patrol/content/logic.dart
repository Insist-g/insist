import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/patrol.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/patrol.dart';
import 'package:get/get.dart';

class PatrolListLogic  extends GetxController
    with StateMixin<PatrolEntity?> {
  final int topicId;
  int page = 1;
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  PatrolListLogic(this.topicId);

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

  onRefresh({String searchText = ''}) {
    page = 1;
    _requestData(searchText: searchText);
  }

  onLoading() {
    page++;
    _requestData();
  }

  void _requestData({String? searchText}) async {
    PatrolApi.getPatrolList(
      uploadStatus: topicId + 1,
      pageNo: page,
    ).then((value) {
      if (state?.list != null) {
        state?.list?.addAll(value.data?.list ?? []);
      }
      change(state ?? value.data,
          status: value.data?.total == 0 ? RxStatus.empty() : RxStatus.success());
    }).onError<DioException>((error, stackTrace) {
      change(null, status: RxStatus.error(error.message));
    }).whenComplete(() {
      refreshController.finishRefresh();
      refreshController.finishLoad((state?.list?.length ?? 0) == state?.total
          ? IndicatorResult.noMore
          : IndicatorResult.success);
    });
  }
}
enum PatrolState { finish, running, waiting, urgent }

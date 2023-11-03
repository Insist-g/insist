import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/home.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/complain.dart';
import 'package:get/get.dart';

class ComplainListLogic extends GetxController
    with StateMixin<ComplainEntity?> {
  final int topicId;
  int page = 1;
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  ComplainListLogic(this.topicId);

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
    HomeApi.getComplainList(
      status: topicId == 0 ? 0 : 3,
      pageNo: page,
    ).then((value) {
      if (state?.list != null) {
        state?.list?.addAll(value.data?.list ?? []);
      }
      change(
        state ?? value.data,
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
}

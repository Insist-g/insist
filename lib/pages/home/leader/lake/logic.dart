import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/leader.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/leader.dart';
import 'package:get/get.dart';

class LakeLeaderLogic extends GetxController with StateMixin<LeaderEntity?> {
  int page = 1;
  String searchText = '';
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
    searchText = value;
    state?.list?.clear();
    _requestData();
  }

  onLoading({String? searchText}) {
    page++;
    _requestData();
  }

  void _requestData() async {
    LeaderAPI.getDriverLakeList(
      pageNo: page,
      name: searchText,
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

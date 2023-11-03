import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/river.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/river.dart';
import 'package:get/get.dart';

class RiverLogic extends GetxController with StateMixin<RiverEntity> {
  int page = 1;
  final size = 10;
  late EasyRefreshController refreshController;
  late TextEditingController searchCtl;

  @override
  void onInit() {
    super.onInit();
    searchCtl = TextEditingController();
    searchCtl.addListener(() {
      onRefresh();
    });
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
    searchCtl.dispose();
  }

  onRefresh() {
    page = 1;
    state?.list?.clear();
    _requestData();
  }

  onLoading({String? searchText}) {
    page++;
    _requestData();
  }

  void _requestData() async {
    RiverApi.getRiverList(
      pageNo: page,
      riverName: searchCtl.text,
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

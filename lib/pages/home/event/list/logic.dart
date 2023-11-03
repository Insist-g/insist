import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/problem.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EventListLogic extends GetxController with StateMixin<ProblemEntity?> {
  int page = 1;
  final size = 10;
  late EasyRefreshController refreshController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //搜索页面信息存储
  List<CheckEntity> eventState = []; //事件状态
  List<CheckEntity> examineState = []; //审核状态
  String? problemStatus; //事件状态
  String? checkStatus; //审核状态
  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final FocusNode startFocusNode = FocusNode();
  final FocusNode endFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    initData();
    searchController.addListener(() => onRefresh());
    startDateController.addListener(() => onRefresh());
    endDateController.addListener(() => onRefresh());
    refreshController = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    onRefresh();
  }

  @override
  void dispose() {
    refreshController.dispose();
    searchController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
    super.dispose();
  }

  void initData() {
    DictStore.to
        .findWithType(type: DictKeys.CTRL_PROBLEM_STATUS)
        .forEach((key, value) {
      eventState.add(CheckEntity.fromJson({"title": value, "id": key}));
    });
    DictStore.to
        .findWithType(type: DictKeys.CTRL_PROBLEM_CHECK_STATUS)
        .forEach((key, value) {
      examineState.add(CheckEntity.fromJson({"title": value, "id": key}));
    });
  }

  void closeDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.closeEndDrawer();
    }
  }

  onRefresh() {
    page = 1;
    state?.list?.clear();
    _requestData(isRefresh: true);
  }

  onLoading() {
    page++;
    _requestData();
  }

  void _requestData({bool isRefresh = false}) async {
    ProblemAPI.getProblemList(
      pageNo: page,
      title: searchController.text,
      starTime: startDateController.text,
      endTime: endDateController.text,
      status: problemStatus ?? '',
      checkStatus: checkStatus ?? '',
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

  void problemUpdate({required int id}) {
    EasyLoading.show();
    ProblemAPI.problemUpdate(id: id, status: 2).then((value) {
      if (value.data == true) onRefresh();
    }).onError<DioException>((error, stackTrace) {
      EasyLoading.showInfo(error.message ?? '操作失败');
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }
}

class CheckEntity {
  String? title;
  bool? select;
  String? id;

  CheckEntity({this.title, this.select, this.id});

  factory CheckEntity.fromJson(Map<String, dynamic> json) => CheckEntity(
        title: json["title"] ?? "",
        id: json["id"] ?? "",
        select: json["select"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "select": select,
        "id": id,
      };
}

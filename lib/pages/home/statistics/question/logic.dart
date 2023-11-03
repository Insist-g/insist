import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/problem.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/statistics.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:get/get.dart';

class StatisticsQuestionLogic extends GetxController
    with StateMixin<ChartProblemEntity?> {
  PieChartBean? pieChartData;
  int page = 1;
  late EasyRefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    getPatrolUserNumber();
    onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  onRefresh({String? searchText}) {
    page = 1;
    _requestData();
  }

  onLoading({String? searchText}) {
    page++;
    _requestData();
  }

  void _requestData() async {
    ProblemAPI.getPatrolInfoPage(
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

  Future getPatrolUserNumber() async {
    ProblemAPI.problemChart().then((value) {
      pieChartData = PieChartBean(count: value.data['count'], data: [
        {
          'num': value.data['undistributedCount'],
          'title': '未分配:${value.data['undistributedCount']}',
          'color': AppColor.gray
        },
        {
          'num': value.data['assignedCount'],
          'title': '已分配:${value.data['assignedCount']}',
          'color': AppColor.mainColor
        },
        {
          'num': value.data['undisposedCount'],
          'title': '未处理:${value.data['undisposedCount']}',
          'color': AppColor.pinkColor
        },
        {
          'num': value.data['processedCount'],
          'title': '已处理:${value.data['processedCount']}',
          'color': AppColor.green
        },
      ]);
    }).onError((error, stackTrace) {});
  }
}

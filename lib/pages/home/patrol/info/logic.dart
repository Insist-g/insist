import 'package:dio/dio.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/patrol.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/patrol.dart';
import 'package:flutter_ducafecat_news_getx/common/store/position.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/navigation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class PatrolInfoLogic extends GetxController with StateMixin<PatrolBean?> {
  @override
  void onReady() {
    super.onReady();
    initData();
  }

  void initData() {
    final _id = Get.arguments;
    PatrolApi.getPatrolInfo(
      id: _id,
    ).then((value) {
      change(value.data,
          status: value.data == null ? RxStatus.empty() : RxStatus.success());
    }).onError<DioException>((error, stackTrace) {
      change(null, status: RxStatus.error(error.message));
    });
  }

  Future startPatrol() async {
    if (PositionStore.to.isRunning) {
      EasyLoading.showInfo("已有巡察任务正在进行中");
      return;
    }
    if (state?.patrolId == null) return;
    NavigationUtil.toPatrolIngPage(id: state!.patrolId!);
  }
}

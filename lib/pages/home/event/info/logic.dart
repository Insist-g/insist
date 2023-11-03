import 'package:dio/dio.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/problem.dart';
import 'package:get/get.dart';

class EventInfoLogic extends GetxController with StateMixin<ProblemInfoEntity> {
  late int _id;

  @override
  void onInit() {
    super.onInit();
    _id = Get.arguments;
    _requestData();
  }

  void _requestData() async {
    ProblemAPI.problemInfo(_id).then((value) {
      change(value.data,
          status: value.data == null ? RxStatus.empty() : RxStatus.success());
    }).onError<DioException>((error, stackTrace) {
      change(null, status: RxStatus.error(error.message));
    }).whenComplete(() {});
  }

}

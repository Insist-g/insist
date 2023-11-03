import 'package:dio/dio.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/leader.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/leader.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderInfoLogic extends GetxController
    with StateMixin<LeaderDetailEntity> {
  late int _id;

  @override
  void onInit() {
    super.onInit();
    _id = Get.arguments;
    _requestData();
  }

  void _requestData() async {
    LeaderAPI.getLeaderDetails(_id).then((value) {
      change(value.data,
          status: value.data == null ? RxStatus.empty() : RxStatus.success());
    }).onError<DioException>((error, stackTrace) {
      change(null, status: RxStatus.error(error.message));
    }).whenComplete(() {});
  }

  void launchPhone(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

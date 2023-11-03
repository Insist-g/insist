import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IssueUploadLogic extends GetxController {

  final TextEditingController controller = TextEditingController();

  final bottomSheetData = [
    {
      "title":"水闸是否正常",
      "value":true
    },
    {
      "title":"水闸前是否有垃圾堆积",
      "value":true
    },
    {
      "title":"点位摄像头是否损坏",
      "value":true
    },
    {
      "title":"点位传感器是否损坏",
      "value":true
    },
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void commit(){
    Get.back();
  }
}

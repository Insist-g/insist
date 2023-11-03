import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/problem.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/upload.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/upload.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/permission.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/list/logic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EventAddLogic extends GetxController {
  final TextEditingController titleCon = TextEditingController(); //标题
  final TextEditingController contentCon = TextEditingController(); //内容
  final TextEditingController opinionCon = TextEditingController(); //意见

  String? riverId;
  String? reachId;
  int eventLevel = 1;
  bool selfProcess = true;
  Position? currentPosition;
  List<AssetEntity> imagesPath = [];

  @override
  void onReady() {
    super.onReady();
    getCurrentPosition(showLoading: false);
  }

  @override
  void onClose() {
    super.onClose();
    titleCon.dispose();
    contentCon.dispose();
    opinionCon.dispose();
  }

  bool onVerify() {
    if (titleCon.text.trim().isEmpty) {
      EasyLoading.showInfo("请输入标题");
      return false;
    }
    if (contentCon.text.trim().isEmpty) {
      EasyLoading.showInfo("请输入详细内容");
      return false;
    }
    return true;
  }

  Future onSubmit() async {
    if (!onVerify()) return;
    var fileList = await upLoadFile();
    ResponseEntity response = await ProblemAPI.problemCreate({
      "creator":UserStore.to.user?.userId,
      "title": titleCon.text,
      "content": contentCon.text,
      "comment": opinionCon.text,
      "riverId": riverId, //所属河流,示例值(8424)
      "reachId": reachId, //所属河段,示例值(5741)
      "level": eventLevel,
      "lng": currentPosition?.longitude,
      "lat": currentPosition?.latitude,
      "selfProcess": selfProcess ? 1 : 0,
      "attachFiles": fileList
    });
    if (response.code != RSP_OK) {
      EasyLoading.showError(response.message ?? "操作失败");
      return;
    }
    EasyLoading.showSuccess("操作成功");
    if (Get.isRegistered<EventListLogic>()){
      Get.find<EventListLogic>().onRefresh();
    }
    Future.delayed(Duration(milliseconds: 100), () => Get.back());
  }

  Future<List<Map>> upLoadFile() async {
    List<String> images = [];
    for (AssetEntity asset in imagesPath) {
      File? _file = await asset.originFile;
      if (_file != null) images.add(_file.path);
    }
    var res =
        await UploadAPI.upLoadFileList(images, uploadType: UploadType.event);
    return res
        .map((e) => FileEntity(fileId: e.id, name: e.name, url: e.url).toJson())
        .toList();
  }

  void getCurrentPosition({showLoading = true}) {
    LocationUtil.getCurrentLocation(showLoading: showLoading).then((value) {
      if (value == null) return;
      currentPosition = value;
      EasyLoading.dismiss();
      update();
    });
  }

}

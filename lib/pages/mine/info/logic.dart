import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/store/user.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image_wrap.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MineInfoLogic extends GetxController {
  Future onChangePhoto(BuildContext context) async {
    SelectedImageUtil.showSelectedSheet(context).then((value) async {
      List? _photoList = value;
      if (_photoList != null && _photoList.length > 0) {
        File? _file = await _photoList.first.originFile;
        if (_file == null) return;
        var res = await UserAPI.updateAvatar(_file.path);
        if (res.data != null) EasyLoading.showSuccess("操作成功");
        await UserStore.to.getProfile();
      }
    });
  }
}

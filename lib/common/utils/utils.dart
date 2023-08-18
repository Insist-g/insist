library utils;

export 'validator.dart';
export 'http.dart';
export 'security.dart';
export 'iconfont.dart';
export 'date.dart';
export 'logger.dart';
export 'loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/pdf.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/photo.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:get/get.dart';

class Utils {
  ///查看大图
  ///image 图片列表
  ///index 需要查看图片的下表
  static showViewBigPhoto(
      {required List images, required index, required heroTag}) {
    Get.to(PhotoViewGalleryScreen(
      images: images,
      heroTag: heroTag,
      index: index,
    ));
  }

  ///查看pdf
  ///path 可以是本地路径 也可以是url
  ///title 页面标题
  static Future toPdfPage({String path = "", String title = ""}) async {
    String _path = "";
    if (path.isEmpty) {
      toastInfo(msg: "pdf 路径不能为空!");
      return;
    } else if (path.startsWith("http")) {
      var res = await createFileOfPdfUrl(path);
      _path = res.path;
    } else {
      var res =
          await fromAsset(path, path.substring(path.lastIndexOf("/") + 1));
      _path = res.path;
    }
    if (_path.isNotEmpty)
      Get.to(PDFPage(
        path: _path,
        title: title,
      ));
  }

  ///隐藏软键盘
  ///[context] 上下文
  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

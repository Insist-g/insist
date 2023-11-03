import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'local.dart';

class JPushUtil {
  static const String TAG = '极光推送';
  static final JPush jPush = JPush();

  static Future initJPush() async {
    jPushConfig();
    Future.delayed(Duration(seconds: 10), () => _setAlias());
  }

  static void _setAlias() async {
    var alias = await customAlias();
    var res = await jPush.setAlias(alias).onError(
        (error, stackTrace) => Log().d("setAlias error:$error", tag: TAG));
    if (!kReleaseMode) Get.snackbar("极光推送", res.toString());
    Log().d("极光推送:$res", tag: TAG);
  }

  static void jPushConfig() {
    jPush.addEventHandler(
        onReceiveNotification: _onReceiveNotification,
        onOpenNotification: _onOpenNotification,
        onReceiveMessage: (value) {
          Log().d(value.toString(), tag: '__onReceiveMessage');
          return Future.value();
        },
        onReceiveNotificationAuthorization: (value) {
          Log()
              .d(value.toString(), tag: '__onReceiveNotificationAuthorization');
          return Future.value();
        },
        onConnected: (value) {
          Log().d(value.toString(), tag: '__onConnected');
          return Future.value();
        });
    jPush.setAuth(enable: true);
    jPush.setup(
        appKey: 'e1f43ba01643b4a3d44d59f0',
        channel: "developer-default",
        production: true);
    jPush.applyPushAuthority();
    jPush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
    });
  }

  static Future _onOpenNotification(Map<String, dynamic> message) {
    return Future.value();
  }

  static Future _onReceiveNotification(Map<String, dynamic> message) {
    return Future.value();
  }

  static void resetBadge({int num = 0}) {
    jPush.setBadge(num < 0 ? 0 : num);
  }

  static void deleteAlias() async {
    await jPush.deleteAlias().then((value) async {
      Log().d('删除Alias成功', tag: TAG);
    }).catchError((e) {
      Log().d('删除Alias失败' + e.toString(), tag: TAG);
    });
  }

  static Future<String> customAlias() async {
    var res = await LocalInfo.to.info;
    String alias = "${res["DeviceId"] ?? ''}${UserStore.to.user?.userId ?? ''}";
    var content = new Utf8Encoder().convert(alias);
    var digest = md5.convert(content).toString();
    return digest;
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';

class HIChannel {
  static const MethodChannel _channel =
      const MethodChannel('handle_intent_channel');

  static void openApp() {
    _channel.invokeMethod('openApp').catchError((e) {
      Log().d(e.toString());
    });
  }

  static void showToast() {
    _channel.invokeMethod('showToast').catchError((e) {
      Log().d(e.toString());
    });
  }

  ///跳转 展示在其他应用上层页面
  static void overlayAuth() {
    _channel.invokeMethod('overlayAuth').catchError((e) {
      Log().d(e.toString());
    });
  }
}

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/channel/hi_channel.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

class OverLayUtil {
  static OverLayUtil _instance = OverLayUtil._internal();
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';

  factory OverLayUtil() => _instance;

  SendPort? _homePort;
  String? latestMessageFromOverlay;
  final _receivePort = ReceivePort();

  OverLayUtil._internal() {
    if (_homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameHome,
    );
    Log().d("initOverLay :$res");
    _receivePort.listen((message) {
      if (message == 'openApp') {
        HIChannel.openApp();
      }
    });
  }

  Future<bool?> dismiss() async {
    var res = await FlutterOverlayWindow.closeOverlay();
    return res;
  }

  Future<bool> show() async {
    var res = await FlutterOverlayWindow.isPermissionGranted();
    if (res) {
      await FlutterOverlayWindow.showOverlay(
        enableDrag: false,
        overlayTitle: "X-SLAYER",
        overlayContent: 'Overlay Enabled',
        flag: OverlayFlag.focusPointer,
        visibility: NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.auto,
        alignment: OverlayAlignment.centerRight,
        height: 130,
        width: 130,
      );
    }
    return res;
  }

  Future getPermission() async {
    bool res = await FlutterOverlayWindow.isPermissionGranted();
    if (!res) _showBottomSheet();
  }

  void _showBottomSheet() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("覆盖在其他应用上层权限未开启！"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("取消")),
              ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    FlutterOverlayWindow.requestPermission();
                  },
                  child: Text("打开"))
            ],
          )
        ],
      ),
    ));
  }

  void _sendHomePort(String jsonString) {
    _homePort ??= IsolateNameServer.lookupPortByName(
      _kPortNameOverlay,
    );
    _homePort?.send(jsonString);
  }
}

import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/channel/hi_channel.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/map.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

class CurrentPositionPage extends StatefulWidget {
  const CurrentPositionPage({super.key});

  @override
  State<CurrentPositionPage> createState() => _CurrentPositionPageState();
}

class _CurrentPositionPageState extends State<CurrentPositionPage>
    with WidgetsBindingObserver {
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? latestMessageFromOverlay;

  @override
  void initState() {
    super.initState();
    _initOverLay();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    FlutterOverlayWindow.closeOverlay()
        .then((value) => Log().d('STOPPED: alue: $value'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TDMap(type: TDType.LOCATION, handleMessage: _sendHomePort),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        // 应用程序不可见，但仍然在前台运行
        break;
      case AppLifecycleState.paused:
        // 应用程序进入后台
        // 在这里可以执行一些应用程序进入后台时的操作
        if (!await FlutterOverlayWindow.isPermissionGranted()) return;
        if (await FlutterOverlayWindow.isActive()) return;
        await FlutterOverlayWindow.showOverlay(
          enableDrag: false,
          overlayTitle: "X-SLAYER",
          overlayContent: 'Overlay Enabled',
          flag: OverlayFlag.focusPointer,
          visibility: NotificationVisibility.visibilityPublic,
          positionGravity: PositionGravity.auto,
          alignment: OverlayAlignment.centerRight,
          height: 100,
          width: 100,
        );
        break;
      case AppLifecycleState.resumed:
        // 应用程序从后台返回前台
        // 在这里可以执行一些应用程序返回前台时的操作
        FlutterOverlayWindow.closeOverlay()
            .then((value) => Log().d('STOPPED: alue: $value'));
        break;
      case AppLifecycleState.detached:
        // 应用程序被暂时分离，可能会被销毁
        break;
    }
  }

  _initOverLay() {
    WidgetsBinding.instance.addObserver(this);
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameHome,
    );
    Log().d("$res: OVERLAY");
    _receivePort.listen((message) {
      if (message == 'openApp') HIChannel.openApp();
      Log().d("message from OVERLAY: $message");
    });

    FlutterOverlayWindow.isPermissionGranted().then((value) {
      if (!value) {
        _showBottomSheet();
      }
    });
  }

  _sendHomePort(String jsonString) {
    homePort ??= IsolateNameServer.lookupPortByName(
      _kPortNameOverlay,
    );
    homePort?.send(jsonString);
  }

  _showBottomSheet() {
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
                  onPressed: () {
                    FlutterOverlayWindow.requestPermission().then((value) {
                      if (!(value ?? false))
                        Get.snackbar("Tip:权限提示", "覆盖在其他应用上层权限未开启, 请手动开启");
                    });
                  },
                  child: Text("打开"))
            ],
          )
        ],
      ),
    ));
  }
}

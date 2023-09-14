import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
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
        if (await FlutterOverlayWindow.isActive()) return;
        await FlutterOverlayWindow.showOverlay(
          enableDrag: true,
          overlayTitle: "X-SLAYER",
          overlayContent: 'Overlay Enabled',
          flag: OverlayFlag.defaultFlag,
          visibility: NotificationVisibility.visibilityPublic,
          positionGravity: PositionGravity.auto,
          height: 500,
          width: WindowSize.matchParent,
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
      Log().d("message from OVERLAY: $message");
      setState(() {
        latestMessageFromOverlay = 'Latest Message From Overlay: $message';
      });
    });

    FlutterOverlayWindow.isPermissionGranted().then((value) {
      if (!value) {
        FlutterOverlayWindow.requestPermission().then((value) {
          if (!(value ?? false))
            Get.snackbar("Tip:权限提示", "覆盖在其他应用上层权限未开启, 请手动开启");
        });
      }
    });
  }

  _sendHomePort(String jsonString) {
    homePort ??= IsolateNameServer.lookupPortByName(
      _kPortNameOverlay,
    );
    homePort?.send('Date: ${DateTime.now()} $jsonString');
  }
}

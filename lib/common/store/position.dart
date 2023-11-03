import 'dart:async';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class PositionStore extends GetxController {
  final _path = <LatLng>[].obs;
  final _isRunning = false.obs;

  bool get isRunning => _isRunning.value;

  List<LatLng> get getPath => _path.value;

  static PositionStore get to => Get.find();
  StreamSubscription<Position>? _positionStream;

  @override
  void onClose() {
    finish();
    super.onClose();
  }

  void start() {
    _isRunning.value = true;
    _positionStream = Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 50,
          //距离过滤器
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 30),
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText: "应用程序将继续接收你的位置",
            notificationTitle: "正在后台运行",
            enableWakeLock: true,
          )),
    ).listen((event) {
      Log().d(event.toJson().toString(), tag: 'PositionStore listen👌');
      getPath.add(LatLng(event.latitude, event.longitude));
    });
  }

  void finish() {
    this._path.value = [];
    _isRunning.value = false;
    _positionStream?.cancel();
    _positionStream = null;
  }

}

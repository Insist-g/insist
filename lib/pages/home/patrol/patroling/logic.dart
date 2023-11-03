import 'package:flutter_ducafecat_news_getx/common/store/position.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/overlay.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/permission.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/content/logic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class PatrolIngLogic extends GetxController {
  PatrolState? state;
  final MapController mapController = MapController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }

  void initData() {
    OverLayUtil().getPermission();
    final _patrolState = Get.arguments;
    if (_patrolState is PatrolState) {
      switch (_patrolState) {
        case PatrolState.running:
          break;
        case PatrolState.waiting:
          break;
        case PatrolState.urgent:
          break;
        case PatrolState.finish:
          // TODO: Handle this case.
          break;
      }
      state = _patrolState;
      update();
    }
  }

  void move() {
    if (PositionStore.to.getPath.length > 0) {
      mapController.move(PositionStore.to.getPath.last, 15);
    } else {
      LocationUtil.getCurrentLocation().then((value) {
        if (value == null) return;
        mapController.move(LatLng(value.latitude, value.longitude), 15);
      });
    }
  }

  void startPatrol() {
    LocationUtil.getLocationStatus().then((value) {
      if (!value) {
        EasyLoading.showInfo("没有打开位置权限,请手动开启");
        return;
      }
      PositionStore.to.start();
      state = PatrolState.running;
      update();
    });
  }

  void finishPatrol() {
    PositionStore.to.finish();
    OverLayUtil().dismiss();
    Future.delayed(Duration.zero, () => Get.back());
  }
}

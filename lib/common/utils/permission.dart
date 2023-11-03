import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationUtil {
  /// 获取用户定位权限
  static Future<bool> getLocationStatus() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    return statuses[Permission.location]?.isGranted ?? false;
  }

  static Future<Position?> getCurrentLocation({bool showLoading = true}) async {
    if (showLoading)
      EasyLoading.show(status: "正在获取位置信息,请稍后", dismissOnTap: true);
    if (await getLocationStatus()) {
      try {
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if (showLoading) EasyLoading.dismiss();
        return position;
      } catch (error) {
        EasyLoading.showInfo('位置获取失败,请稍后再试');
      }
    } else {
      EasyLoading.showInfo("没有打开位置权限,请手动开启");
    }
    return null;
  }
}

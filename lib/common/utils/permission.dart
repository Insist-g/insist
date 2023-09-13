import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  /// 获取用户定位权限
  static Future<bool> getLocationStatus() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();

    return statuses[Permission.location]?.isGranted ?? false;
  }
}

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LocalInfo {
  LocalInfo._();

  static LocalInfo? _instance;

  static LocalInfo get to {
    if (_instance == null) {
      _instance = LocalInfo._();
    }
    return _instance!;
  }

  PackageInfo? _packageInfo;
  AndroidDeviceInfo? _androidDeviceInfo;

  Future<Map> get info async {
    if (_packageInfo == null) _packageInfo = await PackageInfo.fromPlatform();
    if (_androidDeviceInfo == null)
      _androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    return {
      'localVersion': '${_packageInfo?.version}',
      'systemName': 'Android',
      'systemVersion': '${(_androidDeviceInfo?.version.release)}',
      'board': '${_androidDeviceInfo?.board}',
      'hardware': '${_androidDeviceInfo?.hardware}',
      'manufacturer': '${(_androidDeviceInfo?.manufacturer)}',
      'tags': '${_androidDeviceInfo?.tags}',
      'id': '${_androidDeviceInfo?.id}',
      'brand': '${(_androidDeviceInfo?.brand)}',
      'Model': '${(_androidDeviceInfo?.model)}',
      'DeviceId': '${(_androidDeviceInfo?.id)}',
      'type': '${_androidDeviceInfo?.type}',
      'bootloader': '${_androidDeviceInfo?.bootloader}'
    };
  }
}

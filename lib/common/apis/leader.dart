import 'package:flutter_ducafecat_news_getx/common/entities/leader.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class LeaderAPI {
  static const String _LEADER_LIST = '/app-api/ctrl/user-ext/page';
  static const String _LEADER_DETAIL = '/app-api/ctrl/user-ext/details';
  static const String _DRIVER_LAKE_LIST = '/app-api/ctrl/user-ext/list';

  static Future<ResponseEntity<LeaderEntity>> getLeaderList(
      {required int pageNo, String? name}) async {
    var response = await HttpUtil().get(
      _LEADER_LIST,
      queryParameters: {"pageNo": pageNo, "pageSize": 10, "name": name},
    );
    return ResponseEntity<LeaderEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? LeaderEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<LeaderEntity>> getDriverLakeList(
      {required int pageNo, String? name}) async {
    var response = await HttpUtil().get(
      _DRIVER_LAKE_LIST,
      queryParameters: {"pageNo": pageNo, "pageSize": 20, "name": name},
    );
    return ResponseEntity<LeaderEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? LeaderEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<LeaderDetailEntity>> getLeaderDetails(
      int id) async {
    var response = await HttpUtil().get(
      _LEADER_DETAIL,
      queryParameters: {"id": id},
    );
    return ResponseEntity<LeaderDetailEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? LeaderDetailEntity.fromJson(response['data'])
          : null,
    );
  }
}

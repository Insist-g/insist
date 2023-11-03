import 'package:flutter_ducafecat_news_getx/common/entities/patrol.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class PatrolApi {
  static const String _PATROL_LIST = '/app-api/ctrl/patrol-record/page';
  static const String _PATROL_INFO = '/app-api/ctrl/patrol-record/get';

  static Future<ResponseEntity<PatrolEntity>> getPatrolList(
      {required int pageNo,
      String? name,
      int uploadStatus = 1,
      pageSize = 10}) async {
    var response = await HttpUtil().get(
      _PATROL_LIST,
      queryParameters: {
        "pageNo": pageNo,
        "pageSize": pageSize,
        "uploadStatus": uploadStatus
      },
    );
    return ResponseEntity<PatrolEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? PatrolEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<PatrolBean>> getPatrolInfo(
      {required int id}) async {
    var response =
        await HttpUtil().get(_PATROL_INFO, queryParameters: {"id": id});
    return ResponseEntity<PatrolBean>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? PatrolBean.fromJson(response['data'])
          : null,
    );
  }
}

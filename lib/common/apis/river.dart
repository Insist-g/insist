import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/river.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/search.dart';

class RiverApi {
  static const String _getRiverListUrl = '/app-api/ctrl/river/page';
  static const String _getRiverDetail = '/app-api/ctrl/river/get';
  static const String _getReachSimple = '/app-api/ctrl/reach/listsimple';
  static const String _getRiverSimple = '/app-api/ctrl/river/getsimple';

  static Future<ResponseEntity<RiverEntity>> getRiverList(
      {required int pageNo, String? riverName, int pageSize = 10}) async {
    var response = await HttpUtil().get(
      _getRiverListUrl,
      queryParameters: {
        "pageNo": pageNo,
        "pageSize": pageSize,
        "riverName": riverName
      },
    );
    return ResponseEntity<RiverEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? RiverEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<RiverBean>> getRiverDetail(
      String riverId) async {
    var response = await HttpUtil().get(
      _getRiverDetail,
      queryParameters: {
        "id": riverId,
      },
    );
    return ResponseEntity<RiverBean>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? RiverBean.fromJson(response['data'])
          : null,
    );
  }

  static Future<List<SearchEditItemEntity>?> getReachSimple({String? reachName}) async {
    var response = await HttpUtil()
        .get(_getReachSimple, queryParameters: {'reachName': reachName});
    return response['code'] == RSP_OK
        ? response["data"] == null
            ? null
            : (response["data"] as List)
                .map((e) => SearchEditItemEntity.fromJsonAsReach(e))
                .toList()
        : null;
  }

  static Future<List<SearchEditItemEntity>?> getRiverSimple({String? riverName}) async {
    var response = await HttpUtil()
        .get(_getRiverSimple, queryParameters: {"riverName": riverName});
    return response['code'] == RSP_OK
        ? response["data"] == null
            ? null
            : (response["data"] as List)
                .map((e) => SearchEditItemEntity.fromJsonAsRiver(e))
                .toList()
        : null;
  }
}

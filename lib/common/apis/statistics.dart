import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/statistics.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

//统计
class StatisticsApi {
  static const String _getPatrolUserNumber =
      '/app-api/ctrl/patrol-record/getPatrolUserNumber';
  static const String _getPatrolDataCount =
      '/app-api/ctrl/patrol-record/getPatrolDataCount';

  static Future<ResponseEntity<dynamic>> getPatrolUserNumber(
      {required int quarter}) async {
    var response = await HttpUtil().get(
      _getPatrolUserNumber,
      queryParameters: {"quarter": quarter},
    );
    return ResponseEntity<dynamic>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? response['data']
          : null,
    );
  }

  static Future<ResponseEntity<List<BarChartBean>>> getPatrolDataCount(
      {required int timeRange}) async {
    var response = await HttpUtil().get(
      _getPatrolDataCount,
      queryParameters: {"timeRange": timeRange},
    );
    return ResponseEntity<List<BarChartBean>>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? response['data'] == null
              ? null
              : (response["data"] as List)
                  .map((e) => BarChartBean.fromJson(e))
                  .toList()
          : null,
    );
  }
}

import 'package:flutter_ducafecat_news_getx/common/entities/problem.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class ProblemAPI {
  static const String _PROBLEM_CREATE = '/app-api/ctrl/problem/create';
  static const String _PROBLEM_LIST = '/app-api/ctrl/problem/page';
  static const String _PROBLEM_INFO = '/app-api/ctrl/problem/get';
  static const String _PROBLEM_CHART = '/app-api/ctrl/patrol-problem/getCount';
  static const String _PROBLEM_INFO_PAGE = '/app-api/ctrl/patrol-problem/page';
  static const String _PROBLEM_UPDATE = '/app-api/ctrl/problem/update';

  static Future<ResponseEntity> problemCreate(data) async {
    var response = await HttpUtil().post(
      _PROBLEM_CREATE,
      data: data,
    );
    return ResponseEntity(
      code: response['code'],
      message: response['msg'],
      data: response['data'],
    );
  }

  static Future<ResponseEntity<ProblemInfoEntity>> problemInfo(id) async {
    var response =
        await HttpUtil().get(_PROBLEM_INFO, queryParameters: {'id': id});
    return ResponseEntity<ProblemInfoEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? ProblemInfoEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<ProblemEntity>> getProblemList(
      {required int pageNo,
      String? checkStatus,
      String? status,
      String? title,
      String? starTime,
      String? endTime}) async {
    var response = await HttpUtil().get(
      _PROBLEM_LIST,
      queryParameters: {
        "pageNo": pageNo,
        "pageSize": 10,
        "checkStatus": checkStatus,
        "status": status,
        "starTime": starTime,
        "endTime": endTime,
        "title": title,
      },
    );
    return ResponseEntity<ProblemEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? ProblemEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<ChartProblemEntity>> getPatrolInfoPage(
      {required int pageNo}) async {
    var response = await HttpUtil().get(
      _PROBLEM_INFO_PAGE,
      queryParameters: {
        "pageNo": pageNo,
        "pageSize": 10,
      },
    );
    return ResponseEntity<ChartProblemEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? response['data'] == null
              ? null
              : ChartProblemEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<dynamic>> problemChart() async {
    var response = await HttpUtil().get(_PROBLEM_CHART);
    return ResponseEntity<dynamic>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK ? response['data'] : null,
    );
  }

  static Future<ResponseEntity<bool?>> problemUpdate(
      {required int id, required int status}) async {
    var response = await HttpUtil().put(_PROBLEM_UPDATE, data: {
      "status": status,
      "id": id,
      "updater": UserStore.to.user?.userId
    });
    return ResponseEntity<bool?>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK ? response['data'] : null,
    );
  }
}

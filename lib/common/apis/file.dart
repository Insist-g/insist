import 'package:flutter_ducafecat_news_getx/common/entities/file.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/services/services.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class FileAPI {
  static const String _RIVER_FILE = '/app-api/ctrl/policy/page';
  static const String _MAN_DOCS_LIST = '/app-api/ctrl/man-docs/list';
  static const String _FILE_LIST = '/app-api/ctrl/notice/file/page';

  static Future<ResponseEntity<RiverFileEntity>> getRiverFileList(
      {required int pageNo, String? riverName}) async {
    var response = await HttpUtil().get(
      _RIVER_FILE,
      queryParameters: {
        "pageNo": pageNo,
        "pageSize": 10,
        "riverName": riverName
      },
    );
    return ResponseEntity<RiverFileEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? RiverFileEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<LawFileEntity>> getLawFileList(
      {required int pageNo, String? name}) async {
    var response = await HttpUtil().get(
      _MAN_DOCS_LIST,
      queryParameters: {
        "pageNo": pageNo,
        "pageSize": 10,
        "name": name
      },
    );
    return ResponseEntity<LawFileEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? LawFileEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<FileEntity>> getFileList(
      {required int pageNo, String? title}) async {
    var response = await HttpUtil().get(
      _FILE_LIST,
      queryParameters: {"pageNo": pageNo, "pageSize": 10, "title": title},
    );
    return ResponseEntity<FileEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? FileEntity.fromJson(response['data'])
          : null,
    );
  }

}

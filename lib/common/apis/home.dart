import 'package:flutter_ducafecat_news_getx/common/entities/complain.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/message.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/video.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class HomeApi {
  //APP - 获得群众投诉分页
  static const String _COMPLAIN_LIST = '/app-api/ctrl/claim/page';

  //获取通知公告列表
  static const String _MESSAGE_LIST = '/app-api/ctrl/notice/page';

  //获得视频监控分页
  static const String _VIDEO_LIST = '/app-api/ctrl/monitor-device/page';

  //获得新闻动态分页
  static const String _NEWS_LIST = '/app-api/ctrl/news/page';

  static const String _NEWS_INFO = '/app-api/ctrl/news/get';

  static Future<ResponseEntity<ComplainEntity>> getComplainList(
      {required int pageNo, int? status}) async {
    var response = await HttpUtil().get(
      _COMPLAIN_LIST,
      queryParameters: {"pageNo": pageNo, "pageSize": 10, "status": status},
    );
    return ResponseEntity<ComplainEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? ComplainEntity.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<MessageEntity>> getMessageList(
      {required int pageNo, String? name}) async {
    var response = await HttpUtil().get(
      _MESSAGE_LIST,
      queryParameters: {"pageNo": pageNo, "pageSize": 10},
    );
    return ResponseEntity<MessageEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? MessageEntity.fromMessageJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<VideoEntity>> getVideoList(
      {required int pageNo, String? title}) async {
    var response = await HttpUtil().get(
      _VIDEO_LIST,
      queryParameters: {"pageNo": pageNo, "pageSize": 10},
    );
    return ResponseEntity<VideoEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? VideoEntity.fromJson(response['data'])
          : null,
    );
  }


  static Future<ResponseEntity<MessageEntity>> getNewsList(
      {required int pageNo, String? title}) async {
    var response = await HttpUtil().get(
      _NEWS_LIST,
      queryParameters: {"pageNo": pageNo, "pageSize": 10},
    );
    return ResponseEntity<MessageEntity>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? MessageEntity.fromNewsJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<MessageBean>> getNewsInfo(
      {required int id}) async {
    var response = await HttpUtil().get(
      _NEWS_INFO,
      queryParameters: {"id": id},
    );
    return ResponseEntity<MessageBean>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? MessageBean.fromNewsJson(response['data'])
          : null,
    );
  }
}

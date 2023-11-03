import 'package:dio/dio.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/entities.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class UserAPI {
  static const String _AUTH_LOGIN = '/app-api/member/auth/login';
  static const String _SMS_LOGIN = '/app-api/member/auth/sms-login';
  static const String _LOG_OUT = '/app-api/member/auth/logout';
  static const String _GET_PROFILE = '/app-api/member/user/get';
  static const String _SEND_SMS_CODE =
      '/app-api/member/auth/send-sms-code';
  static const String _REFRESH_TOKEN =
      '/app-api/member/auth/refresh-token';
  static const String _CHECK_TOKEN =
      '/app-api/system/auth/check-token';
  static const String _UPDATE_NIKE_NAME =
      '/app-api/member/user/update-nickname';
  static const String _UPDATE_AVATAR =
      '/app-api/member/user/update-avatar';
  static const String _UPDATE_MOBILE =
      '/app-api/member/user/update-mobile';

  static Future<ResponseEntity<LoginResult>> login(
    String mobile,
    String password,
  ) async {
    var response = await HttpUtil().post(
      _AUTH_LOGIN,
      data: {"mobile": mobile, "password": password},
    );
    return ResponseEntity<LoginResult>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? LoginResult.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity<LoginResult>> smsLogin(
    String mobile,
    String code,
  ) async {
    var response = await HttpUtil().post(
      _SMS_LOGIN,
      data: {"mobile": mobile, "code": code},
    );
    return ResponseEntity<LoginResult>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? LoginResult.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity> sendSmsCode(
    String mobile,
  ) async {
    var result = await HttpUtil().post(
      _SEND_SMS_CODE,
      data: {"mobile": mobile, "scene": 1},
    );
    return ResponseEntity(
      code: result['code'],
      message: result['message'],
      data: result['code'] == RSP_OK ? result['data'] : null,
    );
  }

  static Future<ResponseEntity> logOut() async {
    var result = await HttpUtil().post(_LOG_OUT);
    return ResponseEntity(
      code: result['code'],
      message: result['message'],
      data: result['data'],
    );
  }

  static Future<ResponseEntity> refreshToken() async {
    var result = await HttpUtil().post(
      _REFRESH_TOKEN,
      queryParameters: {"refreshToken": UserStore.to.user?.refreshToken},
    );
    return ResponseEntity(
      code: result['code'],
      message: result['message'],
      data: result['data'],
    );
  }

  static Future<ResponseEntity> checkToken() async {
    var result = await HttpUtil().post(
      _CHECK_TOKEN,
      queryParameters: {"token": UserStore.to.user?.accessToken},
    );
    return ResponseEntity(
      code: result['code'],
      message: result['message'],
      data: result['data'],
    );
  }

  static Future<ResponseEntity<UserProfile>> getProfile() async {
    var response = await HttpUtil().get(_GET_PROFILE);
    return ResponseEntity<UserProfile>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? UserProfile.fromJson(response['data'])
          : null,
    );
  }

  static Future<ResponseEntity> updateAvatar(String filePath) async {
    String fileName = filePath.split('.').last;
    Map<String, dynamic> map = {
      "avatarFile": await MultipartFile.fromFile(filePath,
          filename: "${DateTime.now().toString()}.$fileName")
    };
    FormData formData = FormData.fromMap(map);
    var response = await HttpUtil().post(_UPDATE_AVATAR, data: formData);
    return ResponseEntity(
      code: response['code'],
      message: response['msg'],
      data: response['data'],
    );
  }

  static Future<bool?> updateNickname(String nickName) async {
    var response = await HttpUtil()
        .put(_UPDATE_NIKE_NAME, queryParameters: {"nickname": nickName});
    return response['code'] == RSP_OK ? response['data'] : null;
  }

  static Future<bool> updateMobile({
    required String code,
    required String mobile,
    required String oldCode,
    required String oldMobile,
  }) async {
    var response = await HttpUtil().post(_UPDATE_MOBILE, data: {
      "code": code,
      "mobile": mobile,
      "oldCode": oldCode,
      "oldMobile": oldMobile,
    });
    return response['code'] == RSP_OK ? response['data'] : null;
  }
}

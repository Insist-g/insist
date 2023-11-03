import 'dart:convert';
import 'package:flutter_ducafecat_news_getx/common/apis/apis.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/entities.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/services/services.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/jpush.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'web_socket.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  LoginResult? user;

  // 用户 profile
  final _profile = UserProfile().obs;

  bool get isLogin => _isLogin.value;

  UserProfile get profile => _profile.value;

  bool get hasToken => (user?.accessToken ?? "").isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    var _u = StorageService.to.getString(STORAGE_USER_KEY);
    if (_u.isNotEmpty) {
      user = LoginResult.fromJson(jsonDecode(_u));
      _isLogin.value = true;
    }

    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _profile(UserProfile.fromJson(jsonDecode(profileOffline)));
    }
  }

  // 保存 登录信息
  Future<void> saveUser(LoginResult value) async {
    await _toSaveUser(value);
    await JPushUtil.initJPush();
  }

  // 保存 登录信息
  Future<void> _toSaveUser(LoginResult value) async {
    await StorageService.to
        .setString(STORAGE_USER_KEY, jsonEncode(value.toJson()));
    _isLogin.value = true;
    user = value;
  }


  // 获取 profile
  Future<void> getProfile() async {
    if ((user?.accessToken ?? "").isEmpty) return;
    var result = await UserAPI.getProfile();
    if (result.data == null) {
      EasyLoading.showError(result.message ?? "获取个人信息失败");
      return;
    }
    if (result.data != null) {
      _profile(result.data);
      await saveProfile(result.data!);
    }
  }

  // 保存 profile
  Future<void> saveProfile(UserProfile profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
  }

  // 注销
  Future<void> onLogout() async {
    await StorageService.to.remove(STORAGE_USER_KEY);
    user = null;
    _isLogin.value = false;
    JPushUtil.deleteAlias();
    await Get.delete<WebSocketStore>();
    await Get.offAllNamed(AppRoutes.Application);
  }

  // 刷新token
  Future refreshToken() async {
    ResponseEntity rsp = await UserAPI.refreshToken();
    if (rsp.code == RSP_OK) {
      if (rsp.data != null) {
        await _toSaveUser(LoginResult.fromJson(rsp.data));
        Get.put(WebSocketStore());
        JPushUtil.jPushConfig();
      } else {
        onLogout();
      }
    }
  }

}

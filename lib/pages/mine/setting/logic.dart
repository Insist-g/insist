import 'package:flutter_ducafecat_news_getx/common/apis/user.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/store/user.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';
import 'package:get/get.dart';

class SettingLogic extends GetxController {

  Future logOut() async{
    if (UserStore.to.isLogin) {
      ResponseEntity rsp = await UserAPI.logOut();
      if (rsp.code == RSP_OK) {
        UserStore.to.onLogout();
      }
    }

  }
}

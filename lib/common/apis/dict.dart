import 'package:flutter_ducafecat_news_getx/common/entities/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/response_entity.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class DictApi {
  static const String _DICT_LIST = '/app-api/system/dict-data/list-all-simple';

  static Future<ResponseEntity<List<DictBean>>?> getDictList() async {
    var response = await HttpUtil().get(_DICT_LIST);
    return ResponseEntity<List<DictBean>>(
      code: response['code'],
      message: response['msg'],
      data: response['code'] == RSP_OK
          ? response['data'] == null
              ? null
              : (response["data"] as List)
                  .map((e) => DictBean.fromJson(e))
                  .toList()
          : null,
    );
  }
}

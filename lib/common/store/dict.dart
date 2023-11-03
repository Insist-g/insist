import 'package:dio/dio.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:get/get.dart';

class DictStore extends GetxController {
  static DictStore get to => Get.find();

  Map<String, Map<String, String>> _diceData = {};

  @override
  void onInit() {
    super.onInit();
    _getDiceData();
  }

  Future _getDiceData() async {
    DictApi.getDictList().then((value) {
      for (var element in value?.data ?? []) {
        String typeKey = element.dictType!;
        var hasKey = _diceData.containsKey(typeKey);
        if (hasKey) {
          _diceData[typeKey]!.addAll({element.value!: element.label ?? '暂无'});
        } else {
          _diceData.addAll({
            typeKey: {element.value!: element.label ?? '暂无'}
          });
        }
      }
    }).onError<DioException>((error, stackTrace) {
      Log().d(error.message??'', tag: "DictStore");
    });
  }

  String findLabel({String? type, String? value}) {
    if ((type ?? '').isEmpty || (value ?? '').isEmpty) return '';
    return _diceData[type]?[value] ?? '';
  }

  Map findWithType({String? type}) {
    if ((type ?? '').isEmpty) return {};
    return _diceData[type] ?? {};
  }
}

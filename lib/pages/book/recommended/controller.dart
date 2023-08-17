import 'dart:convert';

import 'package:flutter_ducafecat_news_getx/common/entities/book.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class RecommendedController extends GetxController {
  List<GuiderWord> _list = [];
  List<GuiderWord> get guiderWords => _list;

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  _initData() async {
    var jsonData = await rootBundle.loadString('assets/json/yaoyou.json');
    _list = (await jsonDecode(jsonData) as List)
        .map((e) => GuiderWord.fromJson(e))
        .toList();
    update(["recommended"]);
  }
}

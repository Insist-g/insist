import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeedBackLogic extends GetxController {
  final TextEditingController _inputController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _inputController.dispose();
  }
}

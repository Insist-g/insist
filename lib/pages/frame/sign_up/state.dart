import 'package:get/get.dart';

class SignUpState {
  final _enable = false.obs;

  set enable(value) => this._enable.value = value;

  get enable => this._enable.value;
}

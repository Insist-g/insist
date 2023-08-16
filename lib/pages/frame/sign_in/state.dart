import 'package:get/get.dart';

class SignInState {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  // SignInState() {}

  final _enable = false.obs;

  set enable(value) => this._enable.value = value;

  get enable => this._enable.value;
}

import 'package:get/get.dart';

class LoginState {

  final _enable = false.obs;
  set enable(value) => this._enable.value = value;
  get enable => this._enable.value;

  final _loginType = true.obs;
  set loginType(value) => this._loginType.value = value;
  get loginType => this._loginType.value;
}

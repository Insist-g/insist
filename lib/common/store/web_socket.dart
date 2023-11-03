import 'package:flutter/foundation.dart';
import 'package:flutter_ducafecat_news_getx/common/store/store.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketStore extends GetxController {
  static WebSocketStore get to => Get.find();

  final wsUrl =
      'wss://digitriver.ctrlhealth.com.cn/prod-api/websocket/message?userId=';
  late IOWebSocketChannel _channel;

  RxString _message = RxString('');

  String get getMessage => _message.value;

  @override
  void onInit() {
    super.onInit();
    final String userId = (UserStore.to.user?.userId ?? "").toString();
    final String token = UserStore.to.user?.accessToken ?? "";
    if (userId.isEmpty || token.isEmpty) return;
    connectWebSocket(wsUrl + '$userId&token=$token');
  }

  @override
  void onClose() {
    _channel.sink.close();
    super.onClose();
  }

  void connectWebSocket(url) async {
    _channel = IOWebSocketChannel.connect(Uri.parse(url));
    await _channel.ready;
    _channel.stream.listen((data) {
      _message.value = data;
      if (!kReleaseMode) Get.snackbar("WebSocket", "$data");
      Log().d("WebSocket$data");
    }, onDone: () {
      Log().d('WebSocket connection closed', tag: "WebSocketStore");
    }, onError: (error) {
      Log().d('WebSocket error: $error', tag: "WebSocketStore");
    });
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }
}

import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';

class VideoInfoLogic extends GetxController {
  String videoUrl =
      "http://58.56.253.82:7086/live/cameraid/1000005%248/substream/2.m3u8";
  final FijkPlayer player = FijkPlayer();

  @override
  void onInit() {
    super.onInit();
    videoUrl = Get.arguments;
    setPlayer().then((value) => startPlay());
  }

  @override
  void onClose() async {
    player.dispose();
    super.onClose();
  }

  Future setPlayer() async {
    if (videoUrl.contains("rtsp")) {
      //rtsp视频关键配置
      await player.setOption(FijkOption.formatCategory, "rtsp_transport", "tcp");
      await player.setOption(FijkOption.formatCategory, "auth_type", "basic");
      await player.setOption(FijkOption.formatCategory, "rtsp_flags", "prefer_tcp");
      // fijkPlayer 初始化不启用缓冲，避免画面卡死不动
      await player.setOption(FijkOption.playerCategory, 'packet-buffering', 0);
      await player.setOption(FijkOption.playerCategory, 'framedrop', 1);
    } else if (videoUrl.contains('m3u8')) {
      await player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
      await player.setOption(
          FijkOption.playerCategory, "mediacodec-all-videos", 1);
    }
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player.setDataSource(videoUrl, autoPlay: true).catchError((e) {
      print("setDataSource error: $e");
    });
  }
}
